<?php
    echo "print for GET test<br/>";
    if (count($_GET))
        foreach ($_GET as $key => $elem)
            echo $key."=".$elem."<br/>";
?>

<!DOCTYPE html>
<html>
<head>
    <title>httpd.sh demo</title>
</head>
<body style="background: url(background.jpg)">
    <h1 style="text-align: center;">httpd.sh demo</h1>
    <hr/>
    <ol>
        <li>
            <a href="phpinfo.php">phpinfo</a>
        </li>
        <li>
            <a href="index.php?a1=hello&a2=world">GET test</a>
        </li>
        <li>
            <a href="hotel_california.mp3">hotel california.mp3</a>
        </li>
        <li>
            <a href="hotel_california.jpg">hotel california.jpg</a>
        </li>
        <li>
            <a href="LICENSE">LICENSE</a>
        </li>
        <li>
            <a href="http://www.github.com/yinyuepingguo/httpd.sh">github</a>
        </li>
    </ol>
    <hr/>
</body>
</html>
