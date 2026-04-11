<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProduct.aspx.cs" Inherits="IS_385_DoAn.addProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>add product</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="addProduct.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
                <!-- FORM ADD PRODUCT -->
        <div class="product-form active_forrm--product">

            <!-- HEADER -->
            <div class="product-form__header">
                <div class="product-form__title-group">
                    <h2 class="product-form__title">Add New Product</h2>
                    <p class="product-form__subtitle">
                        Create a new entry in your catalog
                    </p>
                </div>

                <div class="product-form__close">
                    <asp:Button ID="btnClose" runat="server" Text="X" OnClick="btnClose_Click" />
                </div>
            </div>

            <!-- BODY -->
            <div class="product-form__body">

                <!-- IMAGE -->
                <div class="product-form__field">
                    <label class="product-form__label">Product Image</label>

                    <asp:FileUpload ID="fuImage" runat="server" CssClass="product-form__upload-input" />

                    <asp:Label ID="lblImageMsg" runat="server" CssClass="product-form__message"></asp:Label>
                </div>

                <!-- NAME -->
                <div class="product-form__field">
                    <label class="product-form__label">Product Name</label>

                    <asp:TextBox ID="txtName" runat="server"
                        CssClass="product-form__input product-form__input--width"
                        Placeholder="Product name"></asp:TextBox>

                    <asp:Label ID="lblNameMsg" runat="server" CssClass="product-form__message"></asp:Label>
                </div>

                <!-- CATEGORY + PRICE -->
                <div class="product-form__row">

                    <div class="product-form__field">
                        <label class="product-form__label">Category</label>

                        <asp:DropDownList ID="ddlCategory" runat="server"
                            CssClass="product-form__select product-form__input">

                            <asp:ListItem Text="Select Category" Value="" />
                            <asp:ListItem Text="Skincare" Value="Skincare" />
                            <asp:ListItem Text="Makeup" Value="Makeup" />
                            <asp:ListItem Text="Haircare" Value="Haircare" />

                        </asp:DropDownList>
                    </div>

                    <div class="product-form__field">
                        <label class="product-form__label">Price</label>

                        <asp:TextBox ID="txtPrice" runat="server"
                            CssClass="product-form__input"
                            TextMode="Number"></asp:TextBox>
                    </div>

                </div>

                <!-- STOCK + SKU -->
                <div class="product-form__row">

                    <div class="product-form__field">
                        <label class="product-form__label">Inventory</label>

                        <asp:TextBox ID="txtStock" runat="server"
                            CssClass="product-form__input"
                            TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="product-form__field">
                        <label class="product-form__label">SKU</label>

                        <asp:TextBox ID="txtSKU" runat="server"
                            CssClass="product-form__input"
                            Enabled="false"></asp:TextBox>
                    </div>

                </div>

                <!-- DESCRIPTION -->
                <div class="product-form__field">
                    <label class="product-form__label">Description</label>

                    <asp:TextBox ID="txtDescription" runat="server"
                        CssClass="product-form__textarea product-form__input--width"
                        TextMode="MultiLine" Rows="4"></asp:TextBox>
                </div>

                <!-- FOOTER -->
                <div class="product-form__footer">

                    <asp:Button ID="btnCancel" runat="server"
                        Text="Cancel"
                        CssClass="product-form__button product-form__button--secondary"
                        OnClick="btnCancel_Click" />

                    <asp:Button ID="btnSave" runat="server"
                        Text="Save Product"
                        CssClass="product-form__button product-form__button--primary"
                        OnClick="btnSave_Click" />

                </div>

            </div>

        </div>

    </form>
</body>
</html>
