<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registry_Login.aspx.cs" Inherits="IS_385_DoAn.Registry" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chào mừng bạn đến với Mỹ Phẩm HealthTrack</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
    
    <link href="Registry.css" rel="stylesheet" />
    <link href="Login.css" rel="stylesheet" />

    <style>
        /* CSS Nền hồng Mỹ Phẩm & Hiệu ứng Chuyên nghiệp */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .auth-wrapper {
            width: 100%;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Hình nền mỹ phẩm tông hồng pastel */
            background: linear-gradient(rgba(255, 192, 203, 0.4), rgba(255, 182, 193, 0.4)), 
                        url('https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .auth-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            position: relative;
            backdrop-filter: blur(5px);
        }

        .auth-card h1 {
            color: #d81b60;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: bold;
        }

        .tabs {
            display: flex;
            margin-bottom: 25px;
            border-bottom: 2px solid #fce4ec;
        }

        .tab {
            flex: 1;
            padding: 10px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 16px;
            color: #888;
            transition: all 0.3s;
        }

        .tab.active {
            color: #d81b60;
            border-bottom: 3px solid #d81b60;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .input-box {
            position: relative;
        }

        .input-box input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            outline: none;
            transition: 0.3s;
            box-sizing: border-box;
        }

        .input-box input:focus {
            border-color: #f06292;
            box-shadow: 0 0 8px rgba(240, 98, 146, 0.2);
        }

        .btn-primary {
            width: 100%;
            padding: 14px;
            background: linear-gradient(to right, #f06292, #d81b60);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(216, 27, 96, 0.3);
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            color: #777;
            margin-bottom: 20px;
        }

        .message-label {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            min-height: 20px;
        }

        /* Ẩn hiện Form */
        .form { display: none; }
        .form.active_form { display: block; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="remove" style="position: absolute; right: 20px; top: 20px; cursor: pointer; color: #ccc;">
                    <i class="fa-solid fa-xmark"></i>
                </div>

                <h1>HealthTrack</h1>

                <div class="tabs">
                    <asp:Button ID="btnTabLogin" runat="server" Text="Đăng Nhập" 
                        CssClass="tab active" OnClick="btnTabLogin_Click" />
                    <asp:Button ID="btnTabRegister" runat="server" Text="Đăng Ký" 
                        CssClass="tab" OnClick="btnTabRegister_Click" />
                </div>

                <div id="formLogin" runat="server" class="form active_form">
                    <div class="form-group">
                        <label><i class="fa-solid fa-envelope"></i> Email</label>
                        <div class="input-box">
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Nhập email của bạn" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label><i class="fa-solid fa-lock"></i> Mật khẩu</label>
                        <div class="input-box">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="******" />
                        </div>
                    </div>
                    <div class="options">
                        <asp:CheckBox ID="chkLoginRemember" runat="server" Text="Ghi nhớ đăng nhập" />
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP" CssClass="btn-primary" OnClick="btnLogin_Click" />
                </div>

                <div id="formRegister" runat="server" class="form">
                    <div class="form-group">
                        <label>Email</label>
                        <div class="input-box">
                            <asp:TextBox ID="txtRegEmail" runat="server" placeholder="example@gmail.com" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <div class="input-box">
                            <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" placeholder="Tối thiểu 6 ký tự" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Nhập lại mật khẩu</label>
                        <div class="input-box">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Xác nhận lại mật khẩu" />
                        </div>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="ĐĂNG KÝ NGAY" CssClass="btn-primary" OnClick="btnRegister_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>