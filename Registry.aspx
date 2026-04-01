<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registry.aspx.cs" Inherits="IS_385_DoAn.Registry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link href="Registry.css" rel="stylesheet" />
</head>
<body>

<form id="form1" runat="server">

<div class="auth-wrapper auth-wrapper--active">
  <div class="auth-card">

    <h1>Sign Up</h1>

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

    <!-- Confirm -->
    <div class="form-group">
      <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="input-box" />
    </div>

    <!-- Button -->
    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-primary"
        OnClick="btnRegister_Click" />

    <!-- Message -->
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

    <p>
        Đã có tài khoản? 
        <a href="Login.aspx">Login</a>
    </p>

  </div>
</div>

</form>
</body>
</html>