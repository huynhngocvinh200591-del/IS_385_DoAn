using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class admin : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["BeautyShopDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RefreshGrid();
                UpdateDashboard();
            }
        }

        // ===== HÀM CẬP NHẬT GIAO DIỆN TỪ SQL =====
        private void RefreshGrid(string searchKeyword = "")
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Dùng câu lệnh JOIN để lấy Tên Danh Mục (CategoryName) thay vì số ID
                string query = @"
                    SELECT p.ProductId, p.Name AS ProductName, c.CategoryName AS Category, p.Price, p.Stock 
                    FROM Products p
                    INNER JOIN Categories c ON p.CategoryId = c.CategoryId
                    WHERE p.Name LIKE @Search";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                }
            }
        }

        private void UpdateDashboard()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // 1. Tổng số SKU (Sản phẩm)
                SqlCommand cmdSKU = new SqlCommand("SELECT COUNT(*) FROM Products", conn);
                lblSKU.Text = cmdSKU.ExecuteScalar().ToString();

                // 2. Sản phẩm sắp hết (Tồn kho < 30)
                SqlCommand cmdLowStock = new SqlCommand("SELECT COUNT(*) FROM Products WHERE Stock < 30", conn);
                lblLowStock.Text = cmdLowStock.ExecuteScalar().ToString();

                // 3. Doanh thu ước tính (Tổng Giá * Tồn kho)
                SqlCommand cmdRevenue = new SqlCommand("SELECT ISNULL(SUM(Price * Stock), 0) FROM Products", conn);
                decimal totalRevenue = Convert.ToDecimal(cmdRevenue.ExecuteScalar());
                lblRevenue.Text = totalRevenue.ToString("N0") + "đ";

                // 4. Số đơn hàng (Tạm thời lấy đếm từ bảng Orders)
                SqlCommand cmdOrders = new SqlCommand("SELECT COUNT(*) FROM Orders", conn);
                lblOrders.Text = cmdOrders.ExecuteScalar().ToString();
            }
        }

        // ===== XỬ LÝ NÚT BẤM GIAO DIỆN =====

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Reset form
            hfProductId.Value = "";
            txtProductName.Text = "";
            txtCategory.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";

            lblFormTitle.Text = "Thêm Sản Phẩm Mới";

            // Ẩn bảng, Hiện Form
            gvProducts.Visible = false;
            pnlForm.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Ẩn Form, Hiện bảng
            pnlForm.Visible = false;
            gvProducts.Visible = true;
        }

        // ===== XỬ LÝ LƯU (INSERT / UPDATE) VÀO SQL =====
        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                // Chuẩn bị dữ liệu an toàn chống SQL Injection
                cmd.Parameters.AddWithValue("@Name", txtProductName.Text);
                cmd.Parameters.AddWithValue("@Price", string.IsNullOrEmpty(txtPrice.Text) ? 0 : Convert.ToDecimal(txtPrice.Text));
                cmd.Parameters.AddWithValue("@Stock", string.IsNullOrEmpty(txtStock.Text) ? 0 : Convert.ToInt32(txtStock.Text));

                // Tạm thời gán cứng CategoryId = 1 và BrandId = 1 (Vì giao diện hiện tại txtCategory đang là nhập chữ, không map được vào ID chuẩn)
                cmd.Parameters.AddWithValue("@CategoryId", 1);
                cmd.Parameters.AddWithValue("@BrandId", 1);

                if (string.IsNullOrEmpty(hfProductId.Value))
                {
                    // TRƯỜNG HỢP: THÊM MỚI (INSERT)
                    cmd.CommandText = "INSERT INTO Products (Name, CategoryId, BrandId, Price, Stock) VALUES (@Name, @CategoryId, @BrandId, @Price, @Stock)";
                }
                else
                {
                    // TRƯỜNG HỢP: CẬP NHẬT (UPDATE)
                    cmd.CommandText = "UPDATE Products SET Name=@Name, Price=@Price, Stock=@Stock WHERE ProductId=@Id";
                    cmd.Parameters.AddWithValue("@Id", hfProductId.Value);
                }

                cmd.ExecuteNonQuery(); // Chạy lệnh thực thi
            }

            // Load lại bảng và Dashboard
            RefreshGrid();
            UpdateDashboard();

            // Ẩn Form, Hiện lại bảng
            pnlForm.Visible = false;
            gvProducts.Visible = true;
        }

        // ===== XỬ LÝ SỬA / XÓA TỪ GRIDVIEW =====
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "EditProduct")
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"
                        SELECT p.Name, p.Price, p.Stock, c.CategoryName 
                        FROM Products p 
                        INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                        WHERE p.ProductId = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Đẩy dữ liệu cũ từ SQL vào Form
                                hfProductId.Value = id;
                                txtProductName.Text = reader["Name"].ToString();
                                txtCategory.Text = reader["CategoryName"].ToString();

                                // Ép kiểu bỏ phần thập phân .0000 đi cho đẹp
                                decimal price = Convert.ToDecimal(reader["Price"]);
                                txtPrice.Text = Math.Round(price, 0).ToString();

                                txtStock.Text = reader["Stock"].ToString();

                                lblFormTitle.Text = "Chỉnh sửa Sản phẩm #" + id;

                                // Ẩn Bảng, Hiện Form
                                gvProducts.Visible = false;
                                pnlForm.Visible = true;
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteProduct")
            {
                // Xóa sản phẩm khỏi SQL
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "DELETE FROM Products WHERE ProductId = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                RefreshGrid();
                UpdateDashboard();
            }
        }

        // ===== CÁC TÍNH NĂNG KHÁC =====
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            RefreshGrid(keyword); // Truyền từ khóa vào hàm RefreshGrid để tìm trong DB
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registry_Login.aspx");
        }
    }
}