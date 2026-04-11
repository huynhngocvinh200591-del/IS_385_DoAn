using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFakeData();
            }
        }

        // ===== LOAD DATA DEMO =====
        private void LoadFakeData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductID");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("Category");
            dt.Columns.Add("Price");
            dt.Columns.Add("Stock");

            // Dữ liệu giả
            dt.Rows.Add("1", "iPhone 15", "Phone", "1000", "50");
            dt.Rows.Add("2", "Laptop Dell", "Laptop", "1500", "20");
            dt.Rows.Add("3", "AirPods", "Accessory", "200", "100");

            gvProducts.DataSource = dt;
            gvProducts.DataBind();

            // Dashboard fake
            lblRevenue.Text = "$5000";
            lblOrders.Text = "25";
            lblSKU.Text = "120";
            lblLowStock.Text = "5";
        }

        // ===== SEARCH =====
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Không search thật → chỉ reload lại data
            LoadFakeData();
        }

        // ===== LOGOUT =====
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Demo → chuyển về login
            Response.Redirect("Registry_Login.aspx");
        }

        // ===== ADD PRODUCT =====
        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Demo
            Response.Write("<script>alert('Add Product clicked');</script>");
        }

        // ===== GRIDVIEW ACTION =====
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "EditProduct")
            {
                Response.Write("<script>alert('Edit product ID: " + id + "');</script>");
            }
            else if (e.CommandName == "DeleteProduct")
            {
                Response.Write("<script>alert('Delete product ID: " + id + "');</script>");
            }
        }
    }
}