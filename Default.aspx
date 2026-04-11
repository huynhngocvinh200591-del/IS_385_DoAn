<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IS_385_DoAn.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Beauty Shop</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        /* Bật hiệu ứng cuộn trang mượt mà */
        html {
            scroll-behavior: smooth !important;
        }

        /* --- CSS CHO PHẦN BANNER --- */
        .hero-banner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 60px 8%;
            background-color: #fcf4f8; /* Màu nền hồng nhạt */
            min-height: 50vh;
        }

        .hero-text {
            flex: 1;
            padding-right: 40px;
        }

        .hero-text h1 {
            font-size: 3rem;
            color: #111;
            line-height: 1.3;
            margin-bottom: 20px;
        }

        .hero-text h1 span {
            color: #e6007e; /* Chữ màu hồng */
        }

        .hero-text p {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 30px;
            max-width: 90%;
            line-height: 1.6;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        .hero-buttons a {
            text-decoration: none;
            padding: 12px 30px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #e6007e;
            color: white;
            border: 2px solid #e6007e;
        }

        .btn-primary:hover {
            background-color: #c4006a;
            border-color: #c4006a;
        }

        .btn-secondary {
            background-color: white;
            color: #333;
            border: 1px solid #ddd;
        }

        .btn-secondary:hover {
            border-color: #e6007e;
            color: #e6007e;
        }

        .hero-image {
            flex: 1;
            text-align: right;
        }

        .hero-image img {
            max-width: 100%;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        #product-section {
            scroll-margin-top: 80px; 
        }

        .sidebar {
            position: sticky !important;
            top: 100px !important; /* Cách mép trên 100px để không bị đè vào Header */
            align-self: flex-start !important; /* Giúp sidebar không bị giãn dài xuống tận đáy */
            height: fit-content !important; 
            max-height: calc(100vh - 120px) !important; /* Giới hạn chiều cao */
            overflow-y: auto !important; /* Hiện thanh cuộn nếu màn hình nhỏ */
        }

        /* Tút tát lại thanh cuộn của sidebar cho đẹp */
        .sidebar::-webkit-scrollbar {
            width: 5px;
        }
        .sidebar::-webkit-scrollbar-thumb {
            background-color: #f1c4d9;
            border-radius: 10px;
        }

        /* Căn chỉnh checkbox ASP.NET cho thẳng hàng và đẹp mắt */
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
            border-radius: 30% !important;
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

        <div class="hero-banner">
            <div class="hero-text">
                <h1>Làm đẹp tự nhiên<br /><span>Tỏa sáng mọi ngày</span></h1>
                <p>Khám phá bộ sưu tập mỹ phẩm chất lượng cao từ các thương hiệu hàng đầu thế giới</p>
                <div class="hero-buttons">
                    <a href="#product-section" class="btn-primary">Mua ngay</a>
                    <a href="#product-section" class="btn-secondary">Xem thêm</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="https://images.unsplash.com/photo-1596462502278-27bfdc403348?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Bộ sưu tập mỹ phẩm" />
            </div>
        </div>

        <div class="container" id="product-section">
            
            <div class="sidebar">
                <asp:UpdatePanel ID="upFilters" runat="server">
                    <ContentTemplate>
                        <div class="filter-header">
                            <h3>Bộ lọc</h3>
                            <asp:LinkButton ID="lnkReset" runat="server" CssClass="reset-filter" OnClick="lnkReset_Click">Đặt lại</asp:LinkButton>
                        </div>

                        <h4>Danh mục</h4>
                        <div class="filter-group">
                            <asp:CheckBox ID="chkSkincare" runat="server" CssClass="cb-item" Text="Chăm sóc da mặt" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkMakeup" runat="server" CssClass="cb-item" Text="Trang điểm" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkBody" runat="server" CssClass="cb-item" Text="Chăm sóc cơ thể" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkHair" runat="server" CssClass="cb-item" Text="Chăm sóc tóc" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkPerfume" runat="server" CssClass="cb-item" Text="Nước hoa" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                        </div>

                        <h4>Thương hiệu</h4>
                        <div class="filter-group">
                            <asp:CheckBox ID="chkLRP" runat="server" CssClass="cb-item" Text="La Roche-Posay" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkCetaphil" runat="server" CssClass="cb-item" Text="Cetaphil" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkInnisfree" runat="server" CssClass="cb-item" Text="Innisfree" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkOrdinary" runat="server" CssClass="cb-item" Text="The Ordinary" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
                            <asp:CheckBox ID="chkCocoon" runat="server" CssClass="cb-item" Text="Cocoon" AutoPostBack="true" OnCheckedChanged="Filter_Changed" />
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
                                            <img src='<%# Eval("ImageUrl") %>' class="product-img" alt="Sản phẩm" />
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
                                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn-add-cart" CommandArgument='<%# Eval("Id") %>'>
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
            // Cập nhật nhãn giá tiền hiển thị ngay khi đang kéo thanh trượt
            function updatePriceLabel(val) {
                var formatted = new Intl.NumberFormat('vi-VN').format(val) + 'đ';
                document.getElementById('lblCurrentPrice').innerText = formatted;
            }

            // Gắn giá trị vào HiddenField và tự động click nút ẩn để báo về Server
            function syncSliderAndPostBack(val) {
                updatePriceLabel(val);
                document.getElementById('<%= hfMaxPrice.ClientID %>').value = val;
                document.getElementById('<%= btnSliderTrigger.ClientID %>').click();
            }

            // Giữ nguyên giá trị của thanh kéo sau khi UpdatePanel tải lại
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