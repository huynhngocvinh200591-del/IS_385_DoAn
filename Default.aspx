<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IS_385_DoAn.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Beauty Shop</title>
</head>
<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <div class="header">
            <div class="logo">BeautyShop</div>

            <div class="menu">
                <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click">Trang chủ</asp:LinkButton>
                <asp:LinkButton ID="lnkProduct" runat="server" OnClick="lnkProduct_Click">Sản phẩm</asp:LinkButton>
                <asp:LinkButton ID="lnkBrand" runat="server" OnClick="lnkBrand_Click">Thương hiệu</asp:LinkButton>
                <asp:LinkButton ID="lnkSale" runat="server" OnClick="lnkSale_Click">Khuyến mãi</asp:LinkButton>
            </div>

            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm kiếm sản phẩm..." />
                <asp:Button ID="btnSearch" runat="server" Text="Tìm" OnClick="btnSearch_Click" />
            </div>
        </div>

        <!-- BANNER -->
        <div class="banner">
            <div class="banner-left">
                <h1>
                    Làm đẹp tự nhiên <br />
                    <span class="highlight">Tỏa sáng mỗi ngày</span>
                </h1>

                <p>Khám phá bộ sưu tập mỹ phẩm chất lượng cao</p>

                <asp:Button ID="btnBuyNow" runat="server" CssClass="btn btn-primary" Text="Mua ngay" OnClick="btnBuyNow_Click" />
                <asp:Button ID="btnViewMore" runat="server" CssClass="btn btn-secondary" Text="Xem thêm" OnClick="btnViewMore_Click" />
            </div>

            <div class="banner-right">
                <asp:Image ID="imgBanner" runat="server" ImageUrl="~/images/banner.jpg" />
            </div>
        </div>

        <!-- MAIN -->
        <div class="container">

            <!-- SIDEBAR -->
            <div class="sidebar">
                <h3>Bộ lọc</h3>

                <h4>Danh mục</h4>
                <asp:CheckBox ID="chkSkinCare" runat="server" Text="Chăm sóc da mặt" />
                <br />
                <asp:CheckBox ID="chkMakeup" runat="server" Text="Trang điểm" />
                <br />
                <asp:CheckBox ID="chkBody" runat="server" Text="Chăm sóc cơ thể" />
                <br />

                <h4>Thương hiệu</h4>
                <asp:CheckBox ID="chkLRP" runat="server" Text="La Roche-Posay" />
                <br />
                <asp:CheckBox ID="chkCetaphil" runat="server" Text="Cetaphil" />
                <br />
                <asp:CheckBox ID="chkInnisfree" runat="server" Text="Innisfree" />
                <br />

                <asp:Button ID="btnFilter" runat="server" Text="Lọc" OnClick="btnFilter_Click" />
            </div>

            <!-- PRODUCTS -->
            <div class="products">

                <!-- PRODUCT 1 -->
                <div class="card">
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/sp1.jpg" Width="100%" />
                    <h4>La Roche-Posay</h4>
                    <p>Kem chống nắng SPF50+</p>
                    <p class="price">385.000đ <span class="old-price">450.000đ</span></p>
                    <asp:Button ID="btnAdd1" runat="server" Text="Thêm vào giỏ" CssClass="btn btn-primary" OnClick="AddToCart_Click" CommandArgument="1" />
                </div>

                <!-- PRODUCT 2 -->
                <div class="card">
                    <asp:Image ID="img2" runat="server" ImageUrl="~/images/sp2.jpg" Width="100%" />
                    <h4>Cetaphil</h4>
                    <p>Sữa rửa mặt</p>
                    <p class="price">225.000đ <span class="old-price">280.000đ</span></p>
                    <asp:Button ID="btnAdd2" runat="server" Text="Thêm vào giỏ" CssClass="btn btn-primary" OnClick="AddToCart_Click" CommandArgument="2" />
                </div>

                <!-- PRODUCT 3 -->
                <div class="card">
                    <asp:Image ID="img3" runat="server" ImageUrl="~/images/sp3.jpg" Width="100%" />
                    <h4>Innisfree</h4>
                    <p>Mặt nạ trà xanh</p>
                    <p class="price">32.000đ</p>
                    <asp:Button ID="btnAdd3" runat="server" Text="Thêm vào giỏ" CssClass="btn btn-primary" OnClick="AddToCart_Click" CommandArgument="3" />
                </div>

            </div>

        </div>

    </form>
</body>
</html>