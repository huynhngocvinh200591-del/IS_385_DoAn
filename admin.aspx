<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="IS_385_DoAn.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>admin</title>
    <link href="admin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="layout active__page">

            <!-- SIDEBAR -->
            <div class="sidebar">
                <div class="sidebar__brand">
                    <div class="sidebar__brand-icon">
                        <i class="fa-solid fa-store"></i>
                    </div>
                    <div class="sidebar__brand-text">
                        <h3 class="sidebar__brand-name">Admin STORE</h3>
                        <p class="sidebar__brand-role">Admin Portal</p>
                    </div>
                </div>

                <nav class="sidebar__menu">
                    <a class="sidebar__menu-item">Dashboard</a>
                    <a class="sidebar__menu-item sidebar__menu-item--active">Products</a>
                    <a class="sidebar__menu-item">Orders</a>
                    <a class="sidebar__menu-item">Customers</a>
                </nav>

                <div class="sidebar__logout">
                    <asp:Button ID="btnLogout" runat="server" 
                        Text="Logout" CssClass="sidebar__logout--btn"
                        OnClick="btnLogout_Click" />
                </div>
            </div>

            <!-- MAIN -->
            <div class="layout__main">

                <!-- TOPBAR -->
                <div class="topbar">
                    <h1 class="topbar__title">Product Management</h1>

                    <div class="topbar__actions">
                        <asp:TextBox ID="txtSearch" runat="server" 
                            CssClass="topbar__search"
                            Placeholder="Search products..." />

                        <asp:Button ID="btnSearch" runat="server" 
                            Text="Search" OnClick="btnSearch_Click" />

                        <div class="topbar__user">
                            <img class="topbar__user-avatar" src="https://i.pravatar.cc/40" />
                            <asp:Label ID="lblAdmin" runat="server" 
                                CssClass="topbar__user-name" Text="admin"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- DASHBOARD -->
                <div class="dashboard">
                    <div class="dashboard__header">
                        <h3 class="dashboard__title">Inventory Overview</h3>

                        <asp:Button ID="btnAddProduct" runat="server" 
                            Text="Add New Product" CssClass="dashboard__add"
                            OnClick="btnAddProduct_Click" />
                    </div>

                    <div class="dashboard__items">
                        <div class="dashboard__cards">
                            <p>Total Revenue</p>
                            <asp:Label ID="lblRevenue" runat="server" Text="0"></asp:Label>
                        </div>

                        <div class="dashboard__cards">
                            <p>New Orders</p>
                            <asp:Label ID="lblOrders" runat="server" Text="0"></asp:Label>
                        </div>

                        <div class="dashboard__cards">
                            <p>Active SKU</p>
                            <asp:Label ID="lblSKU" runat="server" Text="0"></asp:Label>
                        </div>

                        <div class="dashboard__cards">
                            <p>Low Stock</p>
                            <asp:Label ID="lblLowStock" runat="server" Text="0"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- PRODUCT TABLE -->
                <div class="product-table">
                    <asp:GridView ID="gvProducts" runat="server" 
                        AutoGenerateColumns="False" 
                        CssClass="table"
                        OnRowCommand="gvProducts_RowCommand">

                        <Columns>
                            <asp:BoundField DataField="ProductName" HeaderText="Product" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:BoundField DataField="Price" HeaderText="Price" />
                            <asp:BoundField DataField="Stock" HeaderText="Inventory" />

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" 
                                        CommandName="EditProduct"
                                        CommandArgument='<%# Eval("ProductID") %>'
                                        Text="Edit" />

                                    <asp:Button ID="btnDelete" runat="server" 
                                        CommandName="DeleteProduct"
                                        CommandArgument='<%# Eval("ProductID") %>'
                                        Text="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>
                </div>

            </div>
        </div>

    </form>
</body>
</html>
