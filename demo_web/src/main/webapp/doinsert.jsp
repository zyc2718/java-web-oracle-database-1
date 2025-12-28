<%@page import="java.sql.PreparedStatement"%> <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); // 确保接收中文不乱码

    try{
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 1. 加载 MySQL 8.0 驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. 连接字符串
        String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=UTF-8";
        
        String uid = "root";
        // ==========================================
        // ↓↓↓↓↓↓ 这里必须改成你真正的 MySQL 密码 ↓↓↓↓↓↓
        String pwd = "196911Enter."; 
        // ==========================================
        
        Connection conn = DriverManager.getConnection(url, uid, pwd);
        
        // 3. 使用 PreparedStatement (比 Statement 更安全，防止单引号报错)
        String sql = "INSERT INTO classes (username, password) VALUES(?, ?)";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        
        int c = ps.executeUpdate();
        
        ps.close();
        conn.close();
        
        // 4. 成功后跳转
        response.sendRedirect("list.jsp");
        
    } catch(Exception e){
        out.println("<h3>操作失败：</h3>");
        out.println("<p>错误信息：" + e.getMessage() + "</p>");
        out.println("<p>请检查你的数据库密码是否正确。</p>");
        out.println("<p><a href='insert.jsp'>返回添加页面</a></p>");
        e.printStackTrace(); // 在控制台打印详细报错
    }
%>