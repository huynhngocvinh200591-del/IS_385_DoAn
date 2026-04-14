using System;
using System.IO;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace IS_385_DoAn
{
    public partial class addProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateNewSKU();
            }
        }

        private void GenerateNewSKU()
        {
            string datePart = DateTime.Now.ToString("yyyyMMdd");
            string randPart = Guid.NewGuid().ToString().Substring(0, 4).ToUpper();
            txtSKU.Text = $"SP-{datePart}-{randPart}";
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtDescription.Text = "";
            ddlCategory.SelectedIndex = 0;
            lblStatus.Text = "";
            GenerateNewSKU();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Kiểm tra dữ liệu đầu vào
                if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtPrice.Text) || string.IsNullOrEmpty(ddlCategory.SelectedValue))
                {
                    lblStatus.Text = "Vui lòng nhập đầy đủ tên, giá và loại!";
                    lblStatus.ForeColor = Color.Red;
                    return;
                }

                // 2. Xử lý giá: Gỡ sạch tất cả dấu chấm để chuyển về dạng số
                string priceClean = txtPrice.Text.Replace(",", "").Replace("VND", "").Trim();

                decimal price = 0;
                if (!string.IsNullOrEmpty(priceClean))
                {
                    // 2. Ép kiểu an toàn nhất
                    decimal.TryParse(priceClean, out price);
                }
                int.TryParse(txtStock.Text, out int stock);

                // 3. Xử lý SKU: Ưu tiên mã thủ công, nếu trống thì dùng mã tự động
                string finalSKU = txtSKU.Text.Trim();
                if (string.IsNullOrEmpty(finalSKU))
                {
                    string datePart = DateTime.Now.ToString("yyyyMMdd");
                    string randPart = Guid.NewGuid().ToString().Substring(0, 4).ToUpper();
                    finalSKU = $"SP-{datePart}-{randPart}";
                }

                // 4. Xử lý đường dẫn ảnh
                string imagePath = "Images/default.png";
                if (fuImage.HasFile)
                {
                    string ext = Path.GetExtension(fuImage.FileName).ToLower();
                    string fileName = "prod_" + DateTime.Now.Ticks + ext;
                    string folder = Server.MapPath("~/Images/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    fuImage.SaveAs(Path.Combine(folder, fileName));
                    imagePath = "Images/" + fileName;
                }

                // 5. Thực thi lưu vào SQL
                string connStr = ConfigurationManager.ConnectionStrings["ShopDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"INSERT INTO Products (Name, Category, Price, Stock, SKU, Description, ImagePath) 
                                   VALUES (@Name, @Cat, @Price, @Stock, @SKU, @Desc, @Img)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Cat", ddlCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Stock", stock);
                        cmd.Parameters.AddWithValue("@SKU", finalSKU);
                        cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Img", imagePath);


                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // 6. Thành công và Reset Form
                lblStatus.Text = "✔ Lưu sản phẩm thành công!";
                lblStatus.ForeColor = Color.Green;

                // Xóa sạch để nhập tiếp
                txtName.Text = "";
                txtPrice.Text = "";
                txtStock.Text = "";
                txtDescription.Text = "";
                ddlCategory.SelectedIndex = 0;
                GenerateNewSKU();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Lỗi hệ thống: " + ex.Message;
                lblStatus.ForeColor = Color.Red;
            }
        }
    }
}