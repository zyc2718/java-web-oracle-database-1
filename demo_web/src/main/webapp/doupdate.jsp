<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String uid = request.getParameter("uid");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai";
        String user = "root";
        String pwd = "196911Enter."; // 记得改这里！
        
        Connection conn = DriverManager.getConnection(url, user, pwd);
        
        // 更新 SQL
        String sql = "UPDATE classes SET username=?, password=? WHERE uid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setInt(3, Integer.parseInt(uid));
        
        ps.executeUpdate();
        
        ps.close();
        conn.close();
        
        response.sendRedirect("list.jsp");
    } catch(Exception e) {
        out.println("修改失败：" + e.getMessage());
    }
%>