using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IS_385_DoAn
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void lnkProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("Products.aspx");
        }

        protected void lnkBrand_Click(object sender, EventArgs e)
        {
            Response.Redirect("Brands.aspx");
        }
        protected void lnkSale_Click(object sender, EventArgs e)
        {
            Response.Redirect("Brands.aspx");
        }
    }
}