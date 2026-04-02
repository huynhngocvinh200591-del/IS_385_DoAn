<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registry_Login.aspx.cs" Inherits="IS_385_DoAn.Registry" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>

    <!-- CSS -->
    <link href="Registry.css" rel="stylesheet" />
    <link href="Login.css" rel="stylesheet" />

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />

</head>
<body>

<form id="form1" runat="server">

    <div class="auth-wrapper">

        <div class="auth-card">

            <div class="remove">
                <i class="remove_icon fa-solid fa-xmark"></i>
            </div>

            <h1>Welcome</h1>

            <!-- Tabs -->
            <div class="tabs">
                <asp:Button ID="btnTabRegister" runat="server"
                    Text="Sign Up"
                    CssClass="tab active"
                    OnClick="btnTabRegister_Click" />

                <asp:Button ID="btnTabLogin" runat="server"
                    Text="Login"
                    CssClass="tab"
                    OnClick="btnTabLogin_Click" />
            </div>

            <!-- REGISTER FORM -->
            <div id="formRegister" runat="server" class="form active_form">

                <div class="form-group">
                    <label>Email</label>
                    <div class="input-box">
                        <asp:TextBox ID="txtRegEmail" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="input-box">
                        <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-box">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
                    </div>
                </div>

                <div class="options">
                    <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me for 30 days" />
                </div>

                <asp:Button ID="btnRegister" runat="server"
                    Text="Register"
                    CssClass="btn-primary"
                    OnClick="btnRegister_Click" />

            </div>

            <!-- LOGIN FORM -->
            <div id="formLogin" runat="server" class="form">

                <div class="form-group">
                    <label>Email</label>
                    <div class="input-box">
                        <asp:TextBox ID="txtEmail" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="input-box">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
                    </div>
                </div>

                <div class="options">
                    <asp:CheckBox ID="chkLoginRemember" runat="server" Text="Remember me for 30 days" />
                </div>

                <asp:Button ID="btnLogin" runat="server"
                    Text="Login"
                    CssClass="btn-primary"
                    OnClick="btnLogin_Click" />

                <br /><br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            </div>

        </div>
    </div>

</form>

</body>
</html>