using System;
using System.Collections.Generic;
using System.Linq;

namespace IS_385_DoAn
{
    public partial class Default : System.Web.UI.Page
    {
        // Class Product định nghĩa cấu trúc dữ liệu
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

        // Tạo dữ liệu ảo (Mock Data) - Đã xóa tạm đường dẫn ảnh
        private List<Product> GetMockProducts()
        {
            return new List<Product>
            {
                new Product { Id=1, Name="Kem chống nắng SPF50+ PA++++", Brand="La Roche-Posay", Category="Chăm sóc da mặt", Price=385000, OldPrice=450000, ImageUrl="", Discount="-14%", Reviews=1234 },
                new Product { Id=2, Name="Sữa rửa mặt dịu nhẹ cho da nhạy cảm", Brand="Cetaphil", Category="Chăm sóc da mặt", Price=225000, OldPrice=280000, ImageUrl="", Discount="-20%", Reviews=892 },
                new Product { Id=3, Name="Mặt nạ giấy dưỡng ẩm chiết xuất trà xanh", Brand="Innisfree", Category="Chăm sóc da mặt", Price=320000, OldPrice=null, ImageUrl="", Discount="", Reviews=2341 },
                new Product { Id=4, Name="Serum Niacinamide 10% + Zinc 1%", Brand="The Ordinary", Category="Chăm sóc da mặt", Price=250000, OldPrice=280000, ImageUrl="", Discount="-10%", Reviews=5412 },
                new Product { Id=5, Name="Tẩy da chết toàn thân cà phê Đắk Lắk", Brand="Cocoon", Category="Chăm sóc cơ thể", Price=115000, OldPrice=145000, ImageUrl="", Discount="-20%", Reviews=980 },
                new Product { Id=6, Name="Kem dưỡng phục hồi da B5 Baume", Brand="La Roche-Posay", Category="Chăm sóc da mặt", Price=320000, OldPrice=350000, ImageUrl="", Discount="-8%", Reviews=3120 },
                new Product { Id=7, Name="Sữa tắm dịu nhẹ không xà phòng", Brand="Cetaphil", Category="Chăm sóc cơ thể", Price=310000, OldPrice=350000, ImageUrl="", Discount="-11%", Reviews=450 },
                new Product { Id=8, Name="Sữa rửa mặt tro núi lửa Jeju", Brand="Innisfree", Category="Chăm sóc da mặt", Price=190000, OldPrice=220000, ImageUrl="", Discount="-13%", Reviews=1120 },
                new Product { Id=9, Name="AHA 30% + BHA 2% Peeling Solution", Brand="The Ordinary", Category="Chăm sóc da mặt", Price=290000, OldPrice=null, ImageUrl="", Discount="", Reviews=8900 },
                new Product { Id=10, Name="Nước hoa hồng cấp ẩm thuần chay", Brand="Cocoon", Category="Chăm sóc da mặt", Price=175000, OldPrice=195000, ImageUrl="", Discount="-10%", Reviews=670 },
                new Product { Id=11, Name="Kem trị mụn Effaclar Duo+", Brand="La Roche-Posay", Category="Chăm sóc da mặt", Price=410000, OldPrice=460000, ImageUrl="", Discount="-10%", Reviews=4530 },
                new Product { Id=12, Name="Kem dưỡng ẩm Daily Advance", Brand="Cetaphil", Category="Chăm sóc cơ thể", Price=280000, OldPrice=320000, ImageUrl="", Discount="-12%", Reviews=321 },
                new Product { Id=13, Name="Kem dưỡng sáng da Cherry Blossom", Brand="Innisfree", Category="Chăm sóc da mặt", Price=450000, OldPrice=500000, ImageUrl="", Discount="-10%", Reviews=1890 },
                new Product { Id=14, Name="Serum Hyaluronic Acid 2% + B5", Brand="The Ordinary", Category="Chăm sóc da mặt", Price=260000, OldPrice=null, ImageUrl="", Discount="", Reviews=3420 },
                new Product { Id=15, Name="Dầu gội bưởi giảm rụng tóc", Brand="Cocoon", Category="Chăm sóc tóc", Price=225000, OldPrice=250000, ImageUrl="", Discount="-10%", Reviews=1560 },
                new Product { Id=16, Name="Nước tẩy trang Micellar Water", Brand="La Roche-Posay", Category="Chăm sóc da mặt", Price=360000, OldPrice=400000, ImageUrl="", Discount="-10%", Reviews=5100 },
                new Product { Id=17, Name="Kem chống nắng Sun Gel SPF50", Brand="Cetaphil", Category="Chăm sóc da mặt", Price=390000, OldPrice=450000, ImageUrl="", Discount="-13%", Reviews=760 },
                new Product { Id=18, Name="Phấn phủ kiềm dầu No Sebum", Brand="Innisfree", Category="Trang điểm", Price=140000, OldPrice=160000, ImageUrl="", Discount="-12%", Reviews=6500 },
                new Product { Id=19, Name="Nước hoa hồng Glycolic Acid 7%", Brand="The Ordinary", Category="Chăm sóc da mặt", Price=350000, OldPrice=null, ImageUrl="", Discount="", Reviews=2100 },
                new Product { Id=20, Name="Nước dưỡng tóc tinh dầu bưởi", Brand="Cocoon", Category="Chăm sóc tóc", Price=145000, OldPrice=165000, ImageUrl="", Discount="-12%", Reviews=2300 }
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void lnkReset_Click(object sender, EventArgs e)
        {
            // Reset các Checkbox
            chkSkincare.Checked = chkMakeup.Checked = chkBody.Checked =
            chkHair.Checked = chkPerfume.Checked = false;

            chkLRP.Checked = chkCetaphil.Checked = chkInnisfree.Checked =
            chkOrdinary.Checked = chkCocoon.Checked = false;

            // Reset khoảng giá về tối đa
            hfMaxPrice.Value = "1000000";

            LoadData();
        }

        private void LoadData()
        {
            var products = GetMockProducts();

            // 1. Lọc theo Danh mục
            var selectedCategories = new List<string>();
            if (chkSkincare.Checked) selectedCategories.Add("Chăm sóc da mặt");
            if (chkMakeup.Checked) selectedCategories.Add("Trang điểm");
            if (chkBody.Checked) selectedCategories.Add("Chăm sóc cơ thể");
            if (chkHair.Checked) selectedCategories.Add("Chăm sóc tóc");
            if (chkPerfume.Checked) selectedCategories.Add("Nước hoa");

            if (selectedCategories.Any())
            {
                products = products.Where(p => selectedCategories.Contains(p.Category)).ToList();
            }

            // 2. Lọc theo Thương hiệu
            var selectedBrands = new List<string>();
            if (chkLRP.Checked) selectedBrands.Add("La Roche-Posay");
            if (chkCetaphil.Checked) selectedBrands.Add("Cetaphil");
            if (chkInnisfree.Checked) selectedBrands.Add("Innisfree");
            if (chkOrdinary.Checked) selectedBrands.Add("The Ordinary");
            if (chkCocoon.Checked) selectedBrands.Add("Cocoon");

            if (selectedBrands.Any())
            {
                products = products.Where(p => selectedBrands.Contains(p.Brand)).ToList();
            }

            // 3. Lọc theo Giá
            decimal maxPrice = 1000000;
            if (decimal.TryParse(hfMaxPrice.Value, out maxPrice))
            {
                products = products.Where(p => p.Price <= maxPrice).ToList();
            }

            // Đổ dữ liệu ra màn hình
            rptProducts.DataSource = products;
            rptProducts.DataBind();
            lblCount.Text = products.Count.ToString();
        }

        protected void rptProducts_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            // Xử lý sự kiện khi bấm nút "Thêm vào giỏ" ở đây sau
        }

        protected void btnSliderTrigger_Click(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}