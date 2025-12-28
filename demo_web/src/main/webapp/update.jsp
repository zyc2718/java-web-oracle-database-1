<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改用户</title>
</head>
<body>
<%
    String uidStr = request.getParameter("uid");
    String username = "";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai";
        String user = "root";
        String pwd = "196911Enter."; // 记得改这里！
        Connection conn = DriverManager.getConnection(url, user, pwd);

        // 查询当前选中的用户信息
        String sql = "SELECT * FROM classes WHERE uid = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(uidStr));
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            username = rs.getString("username");
            password = rs.getString("password");
        }
        rs.close();
        ps.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

<h2>修改用户信息</h2>
<form action="doupdate.jsp" method="post">
    <input type="hidden" name="uid" value="<%=uidStr%>">
    
    用户名：<input type="text" name="username" value="<%=username%>"><br><br>
    密码：<input type="text" name="password" value="<%=password%>"><br><br>
    <input type="submit" value="保存修改">
    <input type="button" value="返回" onclick="location.href='list.jsp'">
</form>
</body>
</html>