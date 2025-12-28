<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理系统</title>
<style>
    body { font-family: "微软雅黑"; margin: 30px; line-height: 1.6; }
    .stat-box { background-color: #e7f3fe; padding: 10px; border-left: 5px solid #2196F3; margin-bottom: 20px; }
    .search-box { margin-bottom: 20px; }
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
    th { background-color: #f2f2f2; }
    tr:hover { background-color: #f5f5f5; }
    .btn-del { color: red; text-decoration: none; }
    .btn-edit { color: blue; text-decoration: none; }
</style>
</head>
<body>

<h2>学生信息管理系统</h2>

<%
    // 数据库连接配置
    String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=UTF-8";
    String uid = "root";
    String pwd = "196911Enter."; // 已填入你的密码
    
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, uid, pwd);

        // --- 功能 1：调用存储过程获取总人数 ---
        int totalCount = 0;
        try {
            CallableStatement cstmt = conn.prepareCall("{call GetUserCount(?)}");
            cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
            cstmt.execute();
            totalCount = cstmt.getInt(1);
            cstmt.close();
        } catch (Exception e) {
            // 如果你还没在数据库创建存储过程，这里会跳过，不影响页面显示
        }
%>

    <div class="stat-box">
        <strong>系统统计：</strong> 当前共有 <b><%= totalCount %></b> 条学生记录。
    </div>

    <div class="search-box">
        <form action="list.jsp" method="get">
            查询用户名：
            <input type="text" name="keyword" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" placeholder="输入关键字...">
            <input type="submit" value="开始搜索">
            <a href="list.jsp">清除搜索</a>
        </form>
    </div>

    <table>
        <tr>
            <th>UID (编号)</th>
            <th>用户名</th>
            <th>密码</th>
            <th>管理操作</th>
        </tr>
<%
        // --- 功能 3：列表显示与模糊搜索逻辑 ---
        String keyword = request.getParameter("keyword");
        String sql;
        PreparedStatement ps;

        if (keyword != null && !keyword.trim().equals("")) {
            sql = "SELECT * FROM classes WHERE username LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
        } else {
            sql = "SELECT * FROM classes";
            ps = conn.prepareStatement(sql);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("uid") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("password") %></td>
            <td>
                <a class="btn-edit" href="update.jsp?uid=<%= rs.getInt("uid") %>">修改</a> | 
                <a class="btn-del" href="delete.jsp?uid=<%= rs.getInt("uid") %>" onclick="return confirm('确定要永久删除该记录吗？')">删除</a>
            </td>
        </tr>
<%
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        out.println("<p style='color:red;'>数据库连接错误：" + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>
    </table>

    <p><a href="insert.jsp"><b>+ 添加新学生记录</b></a></p>

</body>
</html>