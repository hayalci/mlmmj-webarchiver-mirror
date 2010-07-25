<?php
  $baselistdir = getcwd();
  $mlist = substr(strrchr ($baselistdir, "/"), 1);
  $mlistdir = opendir($baselistdir);
  while($file = readdir($mlistdir)) {
    if(is_dir($baselistdir . "/" . $file) && $file != "." && $file != ".." && $file != "images" && $file != "style") {
      $navlists.= " | <a href=\"$file\">$file listesi</a>";
      $bodylists.= "<h2><a href=\"$file\">$file e-posta listesi</a></h2> ";
    }
  }
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="tr">
<head>
 <title>E-posta Listeleri</title>
 <link rel="stylesheet" type="text/css" media="screen" href="style/screen.css">
</head>
<body>
 <div id="banner">
  <div id="header">
   <div class="banner-left"><img src="images/banner_left.gif" width="17" height="56" border="0" alt="" /></div>
   <div class="banner-text">E-posta Liste Arşivleri</a></div>
   <div class="banner-right"><img src="images/banner_right.gif" width="10" height="56" alt="" /></div>
  </div>
  <div id="topnav">
   <a href="/">Ana Sayfa</a>
<?php echo $navlists; ?>
  </div>
 </div>
 <div id="mailinglists">
  <div id="main">
   <h1>E-posta Listeleri</h1>
<?php echo $bodylists; ?>
  </div>
 </div>
</body>
</html>
