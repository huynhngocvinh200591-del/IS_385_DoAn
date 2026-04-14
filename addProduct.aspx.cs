using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class addProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            // Tạm thời chuyển về trang khác (hoặc để trống cũng được)
            Response.Redirect("admin.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Reset form đơn giản (không bắt buộc)
            txtName.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtDescription.Text = "";
            ddlCategory.SelectedIndex = 0;

            lblImageMsg.Text = "";
            lblNameMsg.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Không xử lý logic, chỉ hiển thị thông báo test
            lblNameMsg.Text = "Saved (demo only)";
        }
    }
}