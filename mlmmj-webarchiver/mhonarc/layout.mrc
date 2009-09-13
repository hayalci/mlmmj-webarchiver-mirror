<!-- ------------------------------------------------------------------ -->
<!-- MSGPGBEGIN, MSGPGEND:                                              -->
<!--                                                                    -->
<!-- MSGPGBEGIN defines the beginning markup of each message page. It   -->
<!-- allows you to redefine the opening HTML element, HEAD element,     -->
<!-- TITLE element, opening BODY element, etc.                          -->
<!--                                                                    -->
<!-- MSGPGEND defines the ending markup of each message page.           -->
<!--                                                                    -->

<MSGPGBEGIN>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
 <title>$SUBJECTNA$</title>
 <link rel="stylesheet" type="text/css" media="screen" href="../../style/screen.css">
</head>
<body>
 <div id="banner">
  <div id="header">
   <div class="banner-left"><img src="../../images/banner_left.gif" width="17" height="56" border="0" alt="" /></div>
   <div class="banner-text">$IDXTITLE$</div>
   <div class="banner-right"><img src="../../images/banner_right.gif" width="10" height="56" alt="" /></div>
  </div>
  <div id="topnav">
   <a href="/">home</a>
   |
   <a href="..">month and year index</a>
   |
   <a href="$TIDXFNAME$#$MSGNUM$">thread index</a>
   |
   <a href="$IDXFNAME$#$MSGNUM$">date index</a>
  </div>
 </div>
 <div id="mailinglists">
  <div id="main">
</MSGPGBEGIN>

<MSGPGEND>
   <address>Archive administrator: postmaster@lists.cynapses.org</address>
  </div>
 </div>
</body>
</html>
</MSGPGEND>


<!-- ------------------------------------------------------------------ -->
<!-- IDXPGBEGIN, IDXPGEND:                                              -->
<!--                                                                    -->
<!-- The IDXPGBEGIN resource defines the beginning markup for the main  -->
<!-- index page. I.e. You can control the opening <HTML> tag, the HEAD  -->
<!-- element contents, the opening <BODY> tag, etc. Therefore, if you   -->
<!-- are not satisfied with the default behavior of how the TITLE       -->
<!-- resource is used, or have other needs that require control over    -->
<!-- the beginning markup, you can set the IDXPGBEGIN resource to what  -->
<!-- you desire.                                                        -->
<!--                                                                    -->
<!-- The IDXPGEND resource defines the end markup for the main index    -->
<!-- page.                                                              -->

<IDXPGBEGIN>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
 <title>$IDXTITLE$</title>
 <link rel="stylesheet" type="text/css" media="screen" href="../../style/screen.css">
</head>
<body>
</IDXPGBEGIN>

<IDXPGEND>
</body>
</html>
</IDXPGEND>


<!-- ------------------------------------------------------------------ -->
<!-- TIDXPGBEGIN, TIDXPGEND                                             -->
<!--                                                                    -->
<!-- The TIDXPGBEGIN resource defines the beginning markup for the      -->
<!-- thread index pages. I.e. You can control the opening <HTML> tag,   -->
<!-- the HEAD element contents, the opening <BODY> tag, etc. Therefore, -->
<!-- if you are not satisfied with the default behavior of how the      -->
<!-- TTITLE resource is used, or have other needs that require control  -->
<!-- on the beginning markup, you can set the TIDXPGBEGIN resource to   -->
<!-- what you desire.                                                   -->
<!--                                                                    -->
<!-- The TIDXPGEND resource defines the end markup for the thread index -->
<!-- pages.                                                             -->
<!--                                                                    -->

<TIDXPGBEGIN>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
 <title>$TIDXTITLE$</title>
 <link rel="stylesheet" type="text/css" media="screen" href="../../style/screen.css">
</head>
<body>
</TIDXPGBEGIN>

<TIDXPGEND>
</body>
</html>
</TIDXPGEND>

<!-- ------------------------------------------------------------------ -->
<!-- LISTBEGIN, LITEMPLATE, LISTEND:                                    -->
<!--                                                                    -->
<!-- The LISTBEGIN resource specifies the markup to begin the message   -->
<!-- list. This resource works in conjuction with LITEMPLATE and        -->
<!-- LISTEND resources to format the main index page(es).               -->
<!--                                                                    -->
<!-- The LITEMPLATE resource specifies the markup for an entry in the   -->
<!-- main index message list. This resource works in conjuction with    -->
<!-- LITEMPLATE and LISTEND resources to format the main index page(es) -->
<!-- http://www.mhonarc.org/MHonArc/doc/resources/litemplate.html       -->
<!--                                                                    -->
<!-- The LISTEND resource specifies the markup to end the message list  -->
<!-- in the main index. This resource works in conjuction with          -->
<!-- LISTBEGIN and LITEMPLATE resources to format the main index        -->
<!-- page(es).                                                          -->
<!--                                                                    -->

<LISTBEGIN>
 <div id="banner">
  <div id="header">
   <div class="banner-left"><img src="../../images/banner_left.gif" width="17" height="56" border="0" alt="" /></div>
   <div class="banner-text">$IDXTITLE$</div>
   <div class="banner-right"><img src="../../images/banner_right.gif" width="10" height="56" alt="" /></div>
  </div>
  <div id="topnav">
   <a href="/">home</a>
   |
   <a href="..">month and year index</a>
   |
   <a href="$TIDXFNAME$">thread index</a>
   |
   <a href="$IDXFNAME$">date index</a>
  </div>
 </div>
 <div id="mailinglists">
  <div id="main">
<h1>Date Index</h1>
<div id="didx">
<ul>
</LISTBEGIN>

<LITEMPLATE>
<li><strong>$SUBJECT$</strong>
<ul><li><em>From</em>: $FROM$</li></ul>
</li>
</LITEMPLATE>

<LISTEND>
</ul>
</div>
   <address>Archive administrator: postmaster.cynapses.org</address>
  </div>
 </div>
</LISTEND>


<!-- ------------------------------------------------------------------ -->
<!-- THEAD, TFOOT                                                       -->
<!--                                                                    -->
<!-- THEAD defines the header markup of thread index pages. It is also  -->
<!-- responsible for defining the opening markup for the thread         -->
<!-- listings.                                                          -->
<!--                                                                    -->
<!-- TFOOT defines the footer markup of thread index pages. It is also  -->
<!-- responsible for defining the closing markup for the thread listing -->
<!--                                                                    -->

<THEAD>
 <div id="banner">
  <div id="header">
   <div class="banner-left"><img src="../../images/banner_left.gif" width="17" height="56" border="0" alt="" /></div>
   <div class="banner-text">$IDXTITLE$</div>
   <div class="banner-right"><img src="../../images/banner_right.gif" width="10" height="56" alt="" /></div>
  </div>
  <div id="topnav">
   <a href="/">home</a>
   |
   <a href="..">month and year index</a>
   |
   <a href="$TIDXFNAME$">thread index</a>
   |
   <a href="$IDXFNAME$">date index</a>
  </div>
 </div>
 <div id="mailinglists">
  <div id="main">
<h1>Thread Index</h1>
<div id="tidx">
<ul>
</THEAD>

<TFOOT>
</ul> 
</div>
   <address>Archive administrator: postmaster.cynapses.org</address>
  </div>
 </div>
</TFOOT>
 
<!-- ------------------------------------------------------------------ -->
<!-- BOTLINKS                                                           -->
<!--                                                                    -->
<!-- BOTLINKS defines the markup for the links at the bottom of a       -->
<!-- message page. Its usage is analagous to the TOPLINKS resource, but -->
<!-- tends to be more verbose. However, you can define the resource     -->
<!-- anyway you desire.                                                 -->
<!--                                                                    -->

<BOTLINKS>
<!-- No BOTLINKS -->
</BOTLINKS>

<!-- ------------------------------------------------------------------ -->
<!-- FOLUPBEGIN, FOLUPLITXT and FOLUPEND                                -->
<!--                                                                    -->
<!-- FOLUPBEGIN defines the markup to start the explicit follow-up      -->
<!-- links after the message body on a message page.                    -->
<!--                                                                    -->
<!-- FOLUPLITXT defines the markup for an entry in the explicit         -->
<!-- follow-up links list after the message body on a message page.     -->
<!--                                                                    -->
<!-- FOLUPEND defines the ending markup for the the explicit follow-up  -->
<!-- links after the message body on a message page.                    -->
<!--                                                                    -->

<FOLUPBEGIN>
<div id="followups">
<table>
 <caption>Follow-Ups:</caption>
</FOLUPBEGIN>
 
<FOLUPLITXT>
 <tr><td>$SUBJECT$</td><td>$FROM$</td></tr>
</FOLUPLITXT>

<FOLUPEND>
</table>
</div>
</FOLUPEND>

<!-- ------------------------------------------------------------------ -->
<!-- REFSBEGIN, REFSLITXT and REFSEND                                   -->
<!--                                                                    -->
<!-- REFSBEGIN defines the markup to start the explicit reference links -->
<!-- after the message body on a message page.                          -->
<!--                                                                    -->
<!-- REFSLITXT defines the markup for an entry in the explicit          -->
<!-- reference links list after the message body on a message page.     -->
<!--                                                                    -->
<!-- REFSEND defines the ending markup for the the explicit reference   -->
<!-- links after the message body on a message page.                    -->
<!--                                                                    -->

<REFSBEGIN>
<div id="references">
<table>
 <caption>References:</caption>
</REFSBEGIN>
 
<REFSLITXT>
 <tr><td>$SUBJECT$</td><td>$FROM$</td></tr>
</REFSLITXT>

<REFSEND>
</table>
</div>
</REFSEND>

<!-- ------------------------------------------------------------------ -->
<!-- SUBJECTHEADER:                                                     -->
<!--                                                                    -->
<!-- SUBJECTHEADER defines the markup for the main subject line above   -->
<!-- the message header of message pages.                               -->
<!--                                                                    -->
 
<SUBJECTHEADER>
<h1>$SUBJECTNA$</h1>
<div id="toplinks">
 <div id="threadtoplinks">
  $BUTTON(TPREV)$ | $BUTTON(TNEXT)$
 </div>
 <div id="datetoplinks">
  $BUTTON(PREV)$ | $BUTTON(NEXT)$
 </div>
</div>
</SUBJECTHEADER>

