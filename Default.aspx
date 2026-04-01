<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IS_385_DoAn.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Beauty Shop</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        /* Fix checkbox ASP.NET - override inline style của UpdatePanel */
        .filter-group span[style] {
            display: flex !important;
            flex-direction: row !important;
            align-items: center !important;
            gap: 10px !important;
            width: 100% !important;
            margin-bottom: 4px !important;
        }

        .filter-group input[type="checkbox"] {
    appearance: none !important;
    -webkit-appearance: none !important;
    width: 18px !important;
    height: 18px !important;
    min-width: 18px !important;
    border: 2px solid #bbb !important;
    border-radius: 30% !important;  /* ← đổi thành hình tròn */
    cursor: pointer !important;
    margin: 0 !important;
    padding: 0 !important;
    background-color: #fff !important;
    position: relative !important;
    flex-shrink: 0 !important;
    transition: background-color 0.2s, border-color 0.2s !important;
}

.filter-group input[type="checkbox"]:checked {
    background-color: #e6007e !important;
    border-color: #e6007e !important;
}

.filter-group input[type="checkbox"]:checked::after {
    content: '\2714' !important;
    font-size: 11px !important;
    color: white !important;
    position: absolute !important;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%) !important;
}

        .filter-group label {
            font-size: 14px !important;
            color: #444 !important;
            cursor: pointer !important;
            font-weight: 600 !important;
            margin: 0 !important;
            padding: 0 !important;
            line-height: 18px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="header">
            <div class="logo">Beauty<span>Shop</span></div>
            <div class="menu">
                <asp:LinkButton ID="lnkHome" runat="server" CssClass="active">Trang chủ</asp:LinkButton>
                <asp:LinkButton ID="lnkProduct" runat="server">Sản phẩm</asp:LinkButton>
                <asp:LinkButton ID="lnkBrand" runat="server">Thương hiệu</asp:LinkButton>
                <asp:LinkButton ID="lnkSale" runat="server">Khuyến mãi</asp:LinkButton>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm kiếm sản phẩm..."></asp:TextBox>
                </div>
                <div class="header-icons">
                    <a href="#"><i class="far fa-heart"></i></a>
                    <a href="#"><i class="far fa-user"></i></a>
                    <a href="#"><i class="fas fa-shopping-cart"></i></a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="sidebar">
                <asp:UpdatePanel ID="upFilters" runat="server">
                    <ContentTemplate>
                        <div class="filter-header">
                            <h3>Bộ lọc</h3>
                            <asp:LinkButton ID="lnkReset" runat="server" CssClass="reset-filter" OnClick="lnkReset_Click">Đặt lại</asp:LinkButton>
                        </div>

                      <h4>Danh mục</h4>
<div class="filter-group">

    <asp:CheckBox ID="chkSkincare" runat="server" CssClass="cb-item"
        Text="Chăm sóc da mặt" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkMakeup" runat="server" CssClass="cb-item"
        Text="Trang điểm" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkBody" runat="server" CssClass="cb-item"
        Text="Chăm sóc cơ thể" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkHair" runat="server" CssClass="cb-item"
        Text="Chăm sóc tóc" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkPerfume" runat="server" CssClass="cb-item"
        Text="Nước hoa" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

</div>

<h4>Thương hiệu</h4>
<div class="filter-group">

    <asp:CheckBox ID="chkLRP" runat="server" CssClass="cb-item"
        Text="La Roche-Posay" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkCetaphil" runat="server" CssClass="cb-item"
        Text="Cetaphil" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkInnisfree" runat="server" CssClass="cb-item"
        Text="Innisfree" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkOrdinary" runat="server" CssClass="cb-item"
        Text="The Ordinary" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />

    <asp:CheckBox ID="chkCocoon" runat="server" CssClass="cb-item"
        Text="Cocoon" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />






</div>

                        <h4>Khoảng giá</h4>
                        <div class="price-slider-container">
                            <asp:HiddenField ID="hfMaxPrice" runat="server" Value="1000000" />

                            <input type="range" id="priceSlider"
                                   min="0" max="1000000" step="50000" value="1000000"
                                   oninput="updatePriceLabel(this.value)"
                                   onchange="syncSliderAndPostBack(this.value)" />

                            <div class="price-labels">
                                <span>0đ</span>
                                <span id="lblCurrentPrice">1.000.000đ</span>
                            </div>

                            <asp:Button ID="btnSliderTrigger" runat="server"
                                Style="display:none"
                                OnClick="btnSliderTrigger_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="main-content">
                <asp:UpdatePanel ID="upProducts" runat="server">
                    <ContentTemplate>
                        <div class="product-header">
                            <h2>Sản phẩm (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h2>
                        </div>
                        <div class="products">
                            <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                                <ItemTemplate>
                                    <div class="card">
                                        <div class="discount-badge" runat="server" visible='<%# Eval("Discount").ToString() != "" %>'><%# Eval("Discount") %></div>
                                        <div class="img-wrapper">
                                            <img src='<%# Eval("ImageUrl") %>' class="product-img" alt="Sản phẩm"
                                                onerror="this.src='https://via.placeholder.com/250x250?text=BeautyShop'" />
                                        </div>
                                        <div class="card-body">
                                            <p class="brand"><%# Eval("Brand") %></p>
                                            <h4 class="product-name"><%# Eval("Name") %></h4>
                                            <div class="rating">
                                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                                                <span>(<%# Eval("Reviews") %>)</span>
                                            </div>
                                            <p class="price">
                                                <span class="current"><%# String.Format("{0:N0}đ", Eval("Price")).Replace(",", ".") %></span>
                                                <span class="old" runat="server" visible='<%# Eval("OldPrice") != null %>'>
                                                    <%# Eval("OldPrice") != null ? String.Format("{0:N0}đ", Eval("OldPrice")).Replace(",", ".") : "" %>
                                                </span>
                                            </p>
                                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn-add-cart"
                                                CommandArgument='<%# Eval("Id") %>'>
                                                <i class="fas fa-shopping-cart"></i> Thêm vào giỏ
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <script type="text/javascript">
            function updatePriceLabel(val) {
                var formatted = new Intl.NumberFormat('vi-VN').format(val) + 'đ';
                document.getElementById('lblCurrentPrice').innerText = formatted;
            }

            function syncSliderAndPostBack(val) {
                updatePriceLabel(val);
                document.getElementById('<%= hfMaxPrice.ClientID %>').value = val;
                document.getElementById('<%= btnSliderTrigger.ClientID %>').click();
            }

            if (typeof Sys !== 'undefined') {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    var hf = document.getElementById('<%= hfMaxPrice.ClientID %>');
                    var slider = document.getElementById('priceSlider');
                    if (hf && slider) {
                        slider.value = hf.value;
                        updatePriceLabel(hf.value);
                    }
                });
            }
        </script>
    </form>
</body>
</html>