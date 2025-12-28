<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 获取从 list.jsp 传过来的 uid
    String uidStr = request.getParameter("uid");
    
    if(uidStr != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai";
            String user = "root";
            String pwd = "196911Enter."; // 记得改这里！

            Connection conn = DriverManager.getConnection(url, user, pwd);
            
            // 2. 编写删除 SQL
            String sql = "DELETE FROM classes WHERE uid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(uidStr));
            
            ps.executeUpdate();
            
            ps.close();
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    // 3. 删除后跳转回列表页
    response.sendRedirect("list.jsp");
%>