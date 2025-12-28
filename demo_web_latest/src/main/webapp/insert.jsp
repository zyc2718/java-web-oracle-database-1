<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加用户</title>
</head>
<body>
<h2>添加用户</h2>
<form action="doinsert.jsp" method="post">
    用户名：<input type="text" name="username"><br><br>
    密码：<input type="text" name="password"><br><br>
    <input type="submit" value="添加">
    <input type="button" value="返回" onclick="location.href='list.jsp'">
</form>
</body>
</html>