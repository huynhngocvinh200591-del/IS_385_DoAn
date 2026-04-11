using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["DuLieuKhachHang"].ConnectionString;

        public class Product
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Brand { get; set; }
            public string Category { get; set; }
            public decimal Price { get; set; }
            public decimal? OldPrice { get; set; }
            public string ImageUrl { get; set; }
            public string Discount { get; set; }
            public int Reviews { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeDatabase();
                LoadData();
            }
        }

        private void InitializeDatabase()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string checkSql = "SELECT COUNT(*) FROM Products";
                    SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count == 0)
                    {
                        InsertMockProductsToDB();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi khởi tạo DB: " + ex.Message);
            }
        }

        private void InsertMockProductsToDB()
        {
            var products = GetMockProducts();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                foreach (var p in products)
                {
                    string sql = @"INSERT INTO Products (Name, Brand, Category, Price, OldPrice, ImageUrl, Discount, Reviews)
                                   VALUES (@Name, @Brand, @Category, @Price, @OldPrice, @ImageUrl, @Discount, @Reviews)";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = p.Name;
                        cmd.Parameters.Add("@Brand", SqlDbType.NVarChar).Value = p.Brand;
                        cmd.Parameters.Add("@Category", SqlDbType.NVarChar).Value = p.Category;
                        cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = p.Price;
                        cmd.Parameters.Add("@OldPrice", SqlDbType.Decimal).Value = (object)p.OldPrice ?? DBNull.Value;
                        cmd.Parameters.Add("@ImageUrl", SqlDbType.NVarChar).Value = (object)p.ImageUrl ?? "";
                        cmd.Parameters.Add("@Discount", SqlDbType.NVarChar).Value = (object)p.Discount ?? "";
                        cmd.Parameters.Add("@Reviews", SqlDbType.Int).Value = p.Reviews;

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        private List<Product> GetProductsFromDB()
        {
            var list = new List<Product>();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT Id, Name, Brand, Category, Price, OldPrice, ImageUrl, Discount, Reviews FROM Products";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Product
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.IsDBNull(1) ? "" : reader.GetString(1),
                            Brand = reader.IsDBNull(2) ? "" : reader.GetString(2),
                            Category = reader.IsDBNull(3) ? "" : reader.GetString(3),
                            Price = reader.GetDecimal(4),
                            OldPrice = reader.IsDBNull(5) ? null : (decimal?)reader.GetDecimal(5),
                            ImageUrl = reader.IsDBNull(6) ? "" : reader.GetString(6),
                            Discount = reader.IsDBNull(7) ? "" : reader.GetString(7),
                            Reviews = reader.IsDBNull(8) ? 0 : reader.GetInt32(8)
                        });
                    }
                }
            }
            return list;
        }

        protected void LoadData()
        {
            var products = GetProductsFromDB();

            // Tìm kiếm
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                string keyword = txtSearch.Text.Trim().ToLower();
                products = products.Where(p => p.Name.ToLower().Contains(keyword) || p.Brand.ToLower().Contains(keyword)).ToList();
            }

            // Lọc danh mục
            var selectedCategories = GetSelectedItems(chkSkincare, chkMakeup, chkBody, chkHair, chkPerfume);
            if (selectedCategories.Any())
                products = products.Where(p => selectedCategories.Contains(p.Category)).ToList();

            // Lọc thương hiệu
            var selectedBrands = GetSelectedItems(chkLRP, chkCetaphil, chkInnisfree, chkOrdinary, chkCocoon);
            if (selectedBrands.Any())
                products = products.Where(p => selectedBrands.Contains(p.Brand)).ToList();

            // Lọc giá
            if (decimal.TryParse(hfMaxPrice.Value, out decimal maxPrice))
                products = products.Where(p => p.Price <= maxPrice).ToList();

            rptProducts.DataSource = products;
            rptProducts.DataBind();
            lblCount.Text = products.Count.ToString();
        }

        private List<string> GetSelectedItems(params CheckBox[] checkBoxes)
        {
            return checkBoxes.Where(cb => cb != null && cb.Checked).Select(cb => cb.Text).ToList();
        }

        protected void Filter_Changed(object sender, EventArgs e) => LoadData();

        protected void lnkReset_Click(object sender, EventArgs e)
        {
            var allCheckBoxes = new[] { chkSkincare, chkMakeup, chkBody, chkHair, chkPerfume,
                                        chkLRP, chkCetaphil, chkInnisfree, chkOrdinary, chkCocoon };
            foreach (var cb in allCheckBoxes) if (cb != null) cb.Checked = false;

            hfMaxPrice.Value = "1000000";
            LoadData();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                string productId = e.CommandArgument.ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Đã thêm sản phẩm vào giỏ hàng thành công!');", true);
            }
        }

        protected void btnSliderTrigger_Click(object sender, EventArgs e) => LoadData();

        private List<Product> GetMockProducts()
        {
            return new List<Product>
            {
                new Product { Name="Kem chống nắng SPF50+ PA++++", Brand="La Roche-Posay", Category="Chăm sóc da mặt", Price=385000, OldPrice=450000, Discount="-14%", Reviews=1234, ImageUrl="img/lrp_kcn.jpg" },
                new Product { Name="Sữa rửa mặt dịu nhẹ cho da nhạy cảm", Brand="Cetaphil", Category="Chăm sóc da mặt", Price=225000, OldPrice=280000, Discount="-20%", Reviews=892, ImageUrl="img/cetaphil_srm.jpg" },
                new Product { Name="Mặt nạ giấy dưỡng ẩm trà xanh", Brand="Innisfree", Category="Chăm sóc da mặt", Price=320000, OldPrice=null, Discount="", Reviews=2341, ImageUrl="img/inni_mask.jpg" },
                new Product { Name="Tẩy da chết toàn thân cà phê Đắk Lắk", Brand="Cocoon", Category="Chăm sóc cơ thể", Price=115000, OldPrice=145000, Discount="-20%", Reviews=980, ImageUrl="img/cocoon_scrub.jpg" }
            };
        }
    }
}