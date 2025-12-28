

# JSP + JDBC 学生信息管理系统 (CRUD)

这是一个基于 **JSP** 和 **JDBC** 实现的简单 Web 应用程序，展示了对 MySQL 数据库进行基本的 **增 (Create)**、**删 (Delete)**、**改 (Update)**、**查 (Read)** 操作。

## 🛠 开发环境

* **语言**: Java (JSP)
* **服务器**: Apache Tomcat (建议 9.0+)
* **数据库**: MySQL (建议 8.0+)
* **驱动**: `mysql-connector-java-8.x.jar`

## 🗄 数据库准备

在运行项目之前，请在 MySQL 中创建数据库 `schooldb` 以及表 `classes`：

```sql
CREATE DATABASE schooldb;

USE schooldb;

CREATE TABLE classes (
    uid INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

```

---

## 📂 项目结构与功能说明

| 文件名 | 功能描述 |
| --- | --- |
| `list.jsp` | **主页/查询**：展示所有用户信息，包含删除和修改的入口。 |
| `insert.jsp` | **添加页**：提供输入用户信息的表单。 |
| `doinsert.jsp` | **添加逻辑**：处理表单提交，将数据插入数据库并重定向。 |
| `update.jsp` | **修改页**：根据 `uid` 查询原数据并回显在表单中。 |
| `doupdate.jsp` | **修改逻辑**：接收修改后的数据并更新数据库。 |
| `delete.jsp` | **删除逻辑**：根据 `uid` 删除指定记录。 |

---

## 🚀 关键配置注意事项

### 1. 数据库连接配置

在所有的 `*.jsp` 处理文件中，请务必修改以下配置信息以符合你的本地环境：

```java
// 修改为你本地 MySQL 的真实密码
String pwd = "你的数据库密码"; 

// 数据库连接 URL (MySQL 8.0 必须包含 serverTimezone)
String url = "jdbc:mysql://localhost:3306/schooldb?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=UTF-8";

```

### 2. 安全性说明

本项目为了演示基础逻辑，使用了 JSP 直接编写 Java 代码。在实际开发中：

* **PreparedStatement**: 建议始终使用 `PreparedStatement` 替代 `Statement` 以防止 SQL 注入攻击。
* **MVC 模式**: 建议将业务逻辑放入 Servlet，将数据访问放入 DAO 类。

---

## 📸 功能演示

1. **查询**: 打开 `list.jsp` 即可看到当前数据库中的所有数据。
2. **增加**: 点击“添加纪录”，填写表单后提交，页面将自动跳回列表。
3. **删除**: 点击列表后方的“删除”，对应记录将从数据库移除。
4. **修改**: 点击“修改”，在弹出的页面更新信息并保存。

---

### 如何贡献

如果你有任何改进建议，欢迎提交 Pull Request 或开 Issue 讨论。

