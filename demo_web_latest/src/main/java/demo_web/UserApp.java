package demo_web;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class UserApp extends JFrame {
    private JTextField txtUser = new JTextField(20);
    private JTextField txtPwd = new JTextField(20); 
    private JButton btnAdd = new JButton("立即连接数据库并写入");
    private JTextArea txtLog = new JTextArea(8, 30);

    public UserApp() {
        setTitle("数据库后台连接演示程序");
        setSize(450, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // 关闭窗口就停止程序
        setLayout(new FlowLayout(FlowLayout.CENTER, 10, 20));

        add(new JLabel("学生姓名:"));
        add(txtUser);
        add(new JLabel("设置密码:"));
        add(txtPwd);
        add(btnAdd);
        
        txtLog.setEditable(false);
        txtLog.setBackground(new Color(240, 240, 240));
        add(new JScrollPane(txtLog));

        btnAdd.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                doConnect();
            }
        });

        setLocationRelativeTo(null); 
        setVisible(true);
    }

    private void doConnect() {
        String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai";
        String dbUser = "root";
        String dbPwd = "196911Enter."; 

        try {
            txtLog.append("> 正在发起后台连接...\n");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPwd);
            
            txtLog.append("✅ 成功！已建立会话。\n");

            String sql = "INSERT INTO classes (username, password) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, txtUser.getText());
            ps.setString(2, txtPwd.getText());
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                txtLog.append("🚀 写入成功！\n");
                JOptionPane.showMessageDialog(this, "添加成功！");
            }

            ps.close();
            conn.close();
            txtLog.append("> 连接关闭。\n----------------\n");

        } catch (Exception ex) {
            txtLog.append("❌ 失败: " + ex.getMessage() + "\n");
        }
    }

    public static void main(String[] args) {
        // 确保能正常启动 GUI
        EventQueue.invokeLater(() -> {
            new UserApp();
        });
    }
}