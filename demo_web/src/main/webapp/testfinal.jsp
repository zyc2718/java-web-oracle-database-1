<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>最终连接测试</title>
</head>
<body>
<h2>MySQL连接最终测试</h2>
<%
Connection conn = null;
try {
    // 测试配置1：使用mysql_native_password
    out.println("<h3>测试配置1：标准连接</h3>");
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=Asia/Shanghai";
    conn = DriverManager.getConnection(url, "root", "196911Enter.");
    out.println("<p style='color:green;font-weight:bold'>✓ 连接成功！</p>");
    
    // 显示数据库信息
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT VERSION() as version, USER() as user, DATABASE() as db");
    if(rs.next()) {
        out.println("MySQL版本: " + rs.getString("version") + "<br>");
        out.println("当前用户: " + rs.getString("user") + "<br>");
        out.println("当前数据库: " + rs.getString("db") + "<br>");
    }
    
    // 检查classes表是否存在
    out.println("<h3>检查表结构</h3>");
    rs = stmt.executeQuery("SHOW TABLES");
    out.println("数据库中的表：<br>");
    boolean hasClassesTable = false;
    while(rs.next()) {
        String table = rs.getString(1);
        out.println("- " + table + "<br>");
        if("classes".equalsIgnoreCase(table)) {
            hasClassesTable = true;
        }
    }
    
    if(hasClassesTable) {
        out.println("<p style='color:green'>✓ 找到classes表</p>");
        // 显示表结构
        rs = stmt.executeQuery("DESC classes");
        out.println("<table border='1' cellpadding='5'>");
        out.println("<tr><th>字段名</th><th>类型</th><th>允许NULL</th><th>键</th><th>默认值</th><th>额外</th></tr>");
        while(rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("Field") + "</td>");
            out.println("<td>" + rs.getString("Type") + "</td>");
            out.println("<td>" + rs.getString("Null") + "</td>");
            out.println("<td>" + rs.getString("Key") + "</td>");
            out.println("<td>" + rs.getString("Default") + "</td>");
            out.println("<td>" + rs.getString("Extra") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } else {
        out.println("<p style='color:orange'>⚠ classes表不存在</p>");
    }
    
    conn.close();
    
} catch(Exception e) {
    out.println("<p style='color:red'>✗ 连接失败: " + e.getMessage() + "</p>");
    e.printStackTrace(new java.io.PrintWriter(out));
}
%>

<hr>
<h3>测试表单</h3>
<form action="doinsert.jsp" method="post" style="background:#f5f5f5;padding:20px;">
    <div>用户名: <input type="text" name="username" value="testuser"></div>
    <div>密码: <input type="text" name="password" value="testpass"></div>
    <div><input type="submit" value="测试插入"></div>
</form>
</body>
</html>