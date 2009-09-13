#!/bin/sh
#
# mlmmj-webarchiver - Version 0.1
#
# (c) by Sven 'Darkman' Michels
# (c) by Andreas Schneider <mail@cynapses.org>
#
# License: GPLv3 or later
#

MHONARC=/usr/bin/mhonarc

# config for mlmmj-webarchiver
# (can be overwritten with $1)

if [ "$1" ] && [ -r "$1" ]; then
  . $1
else
  . /etc/mlmmj-webarchiver/mlmmj-webarchiver.conf
fi

# allow only one instance of mlmmj-webarchiver
if test -r /var/run/mlmmj-webarchiver.pid; then
  MPID=$(< /var/run/mlmmj-webarchiver.pid)
  echo "PID: $MPID"
  if $(kill -CHLD $MPID >/dev/null 2>&1); then
    test "x${VERBOSE}" = "xyes" && echo "mlmml-webarchiver is already running."
    exit 0
  fi
fi
echo $$ > /var/run/mlmmj-webarchiver.pid

##
## mlmmj-webarchiver functions
##

# function: getmailmonth
# description: uses perl to get the right month from an archived file
# will only be used if no hypermail.rc is used!
getmailmonth () {
local MFILE=$1
local MMONTH=$(perl -e '$mtime = (stat("$ARGV[0]"))[9];
                (undef,undef,undef,undef,$month,$year) = localtime($mtime);
                $year += 1900; $month += 1; $month = sprintf("%02d", $month);
                print "$year-$month";' $MFILE)
echo $MMONTH
}

# function: myseq
# description: sh replacement for seq since its not avaiable on every box.
myseq () {
        local STARTVAL=$1
        local ENDVAL=$2
        if test "$STARTVAL" -le "$ENDVAL" 2>/dev/null; then
                local TESTOP="-le"
                local CALOP="+"
        else
                if test "$STARTVAL" -ge "$ENDVAL" 2>/dev/null; then
                        local TESTOP="-ge"
                        local CALOP="-"
                else
                        return 1
                fi
        fi
        while (test ${STARTVAL} ${TESTOP} ${ENDVAL}); do
                echo ${STARTVAL}
                STARTVAL=$((${STARTVAL}${CALOP}1))
        done
        return 0
}


##
## mlmmj-webarchiver itself
##

# get a list of all mailinglists we need to create a webarchive for
for mlist in $(ls ${MLMMJ_LISTDIR}/*/control/webarchive 2>/dev/null); do
        LIST=$(echo $mlist | sed -e "s%${MLMMJ_LISTDIR}/%%" -e "s%/control/webarchive%%")
        WEBARCHIVED_LISTS="$LIST $WEBARCHIVED_LISTS"
done

# now we have a list to work on, lets work on it!
for wlist in $WEBARCHIVED_LISTS; do

        # set LASTINDEX to 1 (we'll override that later)
        LASTINDEX="1"

        WEBARCHIVE_BAK=${WEBARCHIVE_OUT}
        WEBARCHIVE_TMP=$(< ${MLMMJ_LISTDIR}/${wlist}/control/webarchive)
        if test -n "${WEBARCHIVE_TMP}"; then
                WEBARCHIVE_OUT=${WEBARCHIVE_TMP}
        fi

        test "x${VERBOSE}" = "xyes" && echo "+ working on $wlist..."
        # first we need to get the current index, and if no index
        # exist, skip this list
        if [ -r "${MLMMJ_LISTDIR}/${wlist}/index" ]; then
                CURINDEX=$(cat ${MLMMJ_LISTDIR}/${wlist}/index)
        else
                test "x${VERBOSE}" = "xyes" && echo "- skipping $wlist - no mails yet."
                continue;
        fi

        # then we need to know at which index we last build the webdir
        test -f "${WEBARCHIVE_OUT}/${wlist}/.lastindex" && \
                LASTINDEX=$(cat ${WEBARCHIVE_OUT}/${wlist}/.lastindex) 

        # skip the list if we're already up2date
        if [ "$CURINDEX" = "$LASTINDEX" ] && [ "$LASTINDEX" != "1" ]; then
                test "x${VERBOSE}" = "xyes" && echo "- skipping $wlist - already up2date."
                continue;
        fi

        # clear all list related vars, otherwise we may have some trouble
        unset MLA_LABEL
        unset MHONARC_RC
        LIST_MHONARC_CMDS="$MHONARC_CMDS"

        if [ ! -d "${WEBARCHIVE_OUT}" ]; then
          mkdir -p -m ${DIRMODES} "${WEBARCHIVE_OUT}"
          if [ -n "${SKEL}" ]; then
            cp -r ${SKEL}/* ${WEBARCHIVE_OUT}/
          fi
        fi

        # check if list already has a webarchive directory and create one if not
        # also copy the new index into the dir, if one was given.
        if [ ! -d "${WEBARCHIVE_OUT}/${wlist}" ]; then
          mkdir -p -m ${DIRMODES} "${WEBARCHIVE_OUT}/${wlist}"
          if [ -n "$NEW_LIST_INDEX" ]; then
            cp ${NEW_LIST_INDEX} ${WEBARCHIVE_OUT}/${wlist}/index.php
          fi
        fi

        # if the archive should be protected, we need to create a .htaccess file
        # this is currently only "useable/usefull" for apache and compatible servers.
        # maybe we need a more general way for generating this stuff? FIXME
        if [ -f "${MLMMJ_LISTDIR}/${wlist}/control/webarchiveprotected" ]; then
                test "x${VERBOSE}" = "xyes" && echo "+ protecting webarchive of $wlist."
                echo "AuthType $AUTHTYPE" > "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
                echo "AuthName \"${wlist} archives\"" >> "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
                echo "AuthUserFile ${MLMMJ_LISTDIR}/${wlist}/control/webarchiveprotected" >> "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
                echo "AuthGroupFile /dev/null" >> "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
                echo "require valid-user" >> "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
        else
        # and need to remove it, if no more protection is wanted.
                if [ -f "${WEBARCHIVE_OUT}/${wlist}/.htaccess" ]; then
                        test "x${VERBOSE}" = "xyes" && echo "+ remove protection from webarchive of $wlist."
                        rm "${WEBARCHIVE_OUT}/${wlist}/.htaccess"
                fi
        fi

        # check for hypermail configs and set a list archive name based on
        # the list name if we don't have a specific config for every list
        if [ -r "${MLMMJ_LISTDIR}/${wlist}/mhonarc.rc" ]; then
          MHONARC_RC="${MLMMJ_LISTDIR}/${wlist}/mhonarc.rc"
        else
          if [ -r "${RCFILE}" ]; then
            MHONARC_RC="${RCFILE}"
            MLA_LABEL="${wlist}"
          fi
        fi

        # we don't found a config, so set the label to listname
        if [ -z "$MHONARC_RC" ]; then
                MLA_LABEL="${wlist}"
        fi

        # build cmd line options for hypermail
        if [ "$MLA_LABEL" ]; then
                LIST_MHONARC_CMDS="$LIST_MHONARC_CMDS -title $MLA_LABEL"
        fi

#        if [ -z "$MHONARC_RC" ] && [ ! -z "$MORE_LISTS_URL" ]; then
#          LIST_MHONARC_CMDS="$LIST_MHONARC_CMDS -a $MORE_LISTS_URL"
#        fi

        if [ "$MHONARC_RC" ]; then
          LIST_MHONARC_CMDS="$LIST_MHONARC_CMDS -rcfile $MHONARC_RC"
        fi

        # now we start to create the html archive
        for listmail in $(myseq $LASTINDEX $CURINDEX); do

          # first we need to check if the file we want to include to the archive exists
          if [ ! -r "${MLMMJ_LISTDIR}/${wlist}/archive/${listmail}" ]; then
            continue;
          fi
          # if we have a rcfile, we skip the month detection, this *must* be done by
          # mhonarc then!!!
          #if [ -z "$MHONARC_RC" ]; then
            THISMONTH=$(getmailmonth "${MLMMJ_LISTDIR}/${wlist}/archive/${listmail}")

            if [ "$THISMONTH" != "$LASTMONTH" ]; then
              test "x${VERBOSE}" = "xyes" && echo "+ creating $THISMONTH for $wlist"
              LASTMONTH=$THISMONTH
            fi

            if [ ! -d "${WEBARCHIVE_OUT}/${wlist}/${THISMONTH}" ]; then
              mkdir -m ${DIRMODES} "${WEBARCHIVE_OUT}/${wlist}/${THISMONTH}"
            fi

            $MHONARC $LIST_MHONARC_CMDS -outdir ${WEBARCHIVE_OUT}/${wlist}/${THISMONTH} -add < \
              ${MLMMJ_LISTDIR}/${wlist}/archive/${listmail} > /dev/null
          #else
          #  $MHONARC $LIST_MHONARC_CMDS -outdir ${WEBARCHIVE_OUT}/${wlist} -add < \
          #    ${MLMMJ_LISTDIR}/${wlist}/archive/${listmail} > /dev/null
          #fi

          if [ "$?" = "0" ]; then
            echo ${listmail} > ${WEBARCHIVE_OUT}/${wlist}/.lastindex
          fi
        done

        # create zip of archive if wanted
#       if [ -f "${MLMMJ_LISTDIR}/${wlist}/control/webarchivecreatezip" ]; then
#               zip -9 -q -r -j "${WEBARCHIVE_OUT}/${wlist}/${wlist}-archive.zip" "${MLMMJ_LISTDIR}/${wlist}/archive"
#       fi

        WEBARCHIVE_OUT=${WEBARCHIVE_TMP}
done

rm /var/run/mlmmj-webarchiver.pid 2>/dev/null
