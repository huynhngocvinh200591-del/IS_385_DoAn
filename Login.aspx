<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IS_385_DoAn.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>login</title>
    <link href="Login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-wrapper auth-wrapper--active">
          <div class="auth-card">

            <h1>Login</h1>

            <!-- Email -->
            <div class="form-group">
              <label>Email</label>
              <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" />
            </div>

            <!-- Password -->
            <div class="form-group">
              <label>Password</label>
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-box" />
            </div>

            <!-- Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary"
                OnClick="btnLogin_Click" />

            <!-- Message -->
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <p>
                Chưa có tài khoản? 
                <a href="Register.aspx">Register</a>
            </p>

          </div>
        </div>

    </form>
</body>
</html>
