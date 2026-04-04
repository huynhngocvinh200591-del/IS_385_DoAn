using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class Registry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Không làm gì, chỉ để trang load bình thường
        }

        // ===== LOGIN =====
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Login clicked (demo)";
        }

        // ===== REGISTER =====
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            lblMessage.Text = "Register clicked (demo)";
        }

        // ===== TAB SWITCH (chỉ test UI) =====
        protected void btnTabRegister_Click(object sender, EventArgs e)
        {
            // Hiện form Register
            formRegister.Attributes["class"] = "form active_form";
            formLogin.Attributes["class"] = "form";

            btnTabRegister.CssClass = "tab active";
            btnTabLogin.CssClass = "tab";
        }

        protected void btnTabLogin_Click(object sender, EventArgs e)
        {
            // Hiện form Login
            formRegister.Attributes["class"] = "form";
            formLogin.Attributes["class"] = "form active_form";

            btnTabRegister.CssClass = "tab";
            btnTabLogin.CssClass = "tab active";
        }
    }
}