<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>数据列表</title>
</head>
<body>
<h2>用户列表</h2>
<table border="1" width="500">
    <tr>
        <th>UID</th>
        <th>用户名</th>
        <th>密码</th>
        <th>操作</th>
    </tr>
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai";
    String uid = "root";
    
    // ==========================================
    // ↓↓↓↓↓↓ 这里必须改成你真正的 MySQL 密码 ↓↓↓↓↓↓
    String pwd = "196911Enter."; 
    // ==========================================

    Connection conn = DriverManager.getConnection(url, uid ,pwd);
    Statement st = conn.createStatement();
    
    String sql = "SELECT * FROM classes";
    ResultSet rs = st.executeQuery(sql);
    
    while(rs.next()){
%>
    <tr>
        <td><%= rs.getInt("uid") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("password") %></td>
        <td>
            <a href="delete.jsp?uid=<%= rs.getInt("uid") %>">删除</a> | 
            <a href="update.jsp?uid=<%= rs.getInt("uid") %>">修改</a>
        </td>
    </tr>
<%
    }
    rs.close();
    st.close();
    conn.close();
}catch(Exception e){
    out.println("<tr><td colspan='4'>数据库连接错误：" + e.getMessage() + "</td></tr>");
    e.printStackTrace();
}
%> 
</table>
<br/>
<a href="insert.jsp">添加新用户</a>
</body>
</html>