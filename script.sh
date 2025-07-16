#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo service nginx start
cd /usr/share/nginx/html/
sudo chmod 777 index.html
echo "<!DOCTYPE HTML>
<html>  
<body>

<form action="welcome.php" method="post">
Name: <input type="text" name="name"><br>
E-mail: <input type="text" name="email"><br>
<input type="submit">
</form>

</body>
</html>">index.html

