using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace IS_385_DoAn
{
    public partial class Registry : Page
    {
        // Kết nối database
        string connStr = ConfigurationManager.ConnectionStrings["DuLieuKhachHang"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mặc định mở tab Login
                ViewState["ActiveTab"] = "login";
                ShowTab("login");
            }
        }
        //Hiển thị tab theo lựa chọn

        private void ShowTab(string tab)
        {
            if (tab == "register")
            {
                formRegister.Attributes["class"] = "form active_form";
                formLogin.Attributes["class"] = "form";
                btnTabRegister.CssClass = "tab active";
                btnTabLogin.CssClass = "tab";
            }
            else
            {
                formRegister.Attributes["class"] = "form";
                formLogin.Attributes["class"] = "form active_form";
                btnTabRegister.CssClass = "tab";
                btnTabLogin.CssClass = "tab active";
            }
        }

        protected void btnTabRegister_Click(object sender, EventArgs e)
        {
            ViewState["ActiveTab"] = "register";
            ShowTab("register");
            lblMessage.Text = "";
        }

        protected void btnTabLogin_Click(object sender, EventArgs e)
        {
            ViewState["ActiveTab"] = "login";
            ShowTab("login");
            lblMessage.Text = "";
        }

        // ===== REGISTER =====
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string email = txtRegEmail.Text.Trim();
            string password = txtRegPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ShowTab("register");
                return;
            }

            if (password != confirm)
            {
                lblMessage.Text = "Mật khẩu nhập lại không chính xác!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ShowTab("register");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Kiểm tra email tồn tại
                string checkSql = "SELECT COUNT(*) FROM Users WHERE Email=@Email";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@Email", email);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = "Email này đã được đăng ký!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    ShowTab("register");
                    return;
                }

                // Thêm user mới
                string insertSql = "INSERT INTO Users(Email, Pass) VALUES(@Email, @Pass)";
                SqlCommand cmd = new SqlCommand(insertSql, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Pass", password);
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Đăng ký thành công! Vui lòng đăng nhập.";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            // Xóa trắng form
            txtRegEmail.Text = "";
            txtRegPassword.Text = "";
            txtConfirmPassword.Text = "";

            // Chuyển về tab Login
            ViewState["ActiveTab"] = "login";
            ShowTab("login");
        }

        // ===== LOGIN =====
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Vui lòng nhập email và mật khẩu!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ShowTab("login");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Lấy mật khẩu trong database theo email
                string sql = "SELECT Pass FROM Users WHERE Email=@Email";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    string dbPass = result.ToString();

                    if (dbPass == password)
                    {
                        // Đăng nhập thành công
                        Session["UserEmail"] = email;
                        Response.Redirect("Default.aspx"); // Chuyển sang trang sản phẩm
                    }
                    else
                    {
                        lblMessage.Text = "Sai mật khẩu!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        ShowTab("login");
                    }
                }
                else
                {
                    lblMessage.Text = "Email không tồn tại!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    ShowTab("login");
                }
            }
        }
    }
}