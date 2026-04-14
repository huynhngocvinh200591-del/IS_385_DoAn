<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProduct.aspx.cs" Inherits="IS_385_DoAn.addProduct" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Product - Cosmetics</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="addProduct.css" rel="stylesheet" />
    <style>
        .img-preview { width: 120px; height: 120px; border: 2px dashed #ddd; border-radius: 8px; display: none; object-fit: cover; margin-bottom: 10px; }
        .product-form__label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
        .product-form__field { margin-bottom: 15px; }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="product-form active_forrm--product">
            <div class="product-form__header">
                <div class="product-form__title-group">
                    <h2 class="product-form__title">Add New Product</h2>
                    <p class="product-form__subtitle">Tạo mục mới trong danh mục mỹ phẩm</p>
                </div>
                <div class="product-form__close">
                    <asp:LinkButton ID="btnClose" runat="server" OnClick="btnClose_Click" CausesValidation="false" style="text-decoration:none; color: #333; font-weight:bold; font-size: 20px;">×</asp:LinkButton>
                </div>
            </div>

            <div class="product-form__body">
                <div class="product-form__field">
                    <span class="product-form__label">Product Image</span>
                    <img id="imgPreview" class="img-preview" />
                    <asp:FileUpload ID="fuImage" runat="server" onchange="previewImage(this);" />
                </div>

                <div class="product-form__field">
                    <span class="product-form__label">Tên sản phẩm</span>
                    <asp:TextBox ID="txtName" runat="server" CssClass="product-form__input product-form__input--width" placeholder="Nhập tên sản phẩm"></asp:TextBox>
                </div>

                <div class="product-form__row" style="display: flex; gap: 20px;">
                    <div class="product-form__field" style="flex: 1;">
                        <span class="product-form__label">Loại sản phẩm</span>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="product-form__select product-form__input">
                           <asp:ListItem Text="-- Chọn loại sản phẩm --" Value="" />
        <asp:ListItem Text="Skincare (Chăm sóc da)" Value="Skincare" />
        <asp:ListItem Text="Makeup (Trang điểm)" Value="Makeup" />
        <asp:ListItem Text="Fragrance (Nước hoa)" Value="Fragrance" />
        <asp:ListItem Text="Haircare (Chăm sóc tóc)" Value="Haircare" />
        <asp:ListItem Text="Bodycare (Dưỡng thể)" Value="Bodycare" />
        <asp:ListItem Text="Sunscreen (Chống nắng)" Value="Sunscreen" />
        <asp:ListItem Text="Tools (Dụng cụ làm đẹp)" Value="Tools" />
                        </asp:DropDownList>
                    </div>
                    <div class="product-form__field" style="flex: 1;">
                        <span class="product-form__label">Price (VNĐ)</span>
                     <asp:TextBox ID="txtPrice" runat="server" CssClass="product-form__input" placeholder="0" oninput="formatVNMoney(this)"></asp:TextBox>
                    </div>
                </div>

                <div class="product-form__row" style="display: flex; gap: 20px;">
                    <div class="product-form__field" style="flex: 1;">
                        <span class="product-form__label">Số lượng tồn kho</span>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="product-form__input" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="product-form__field" style="flex: 1;">
                        <span class="product-form__label">Mã SKU </span>
                       <asp:TextBox ID="txtSKU" runat="server" CssClass="product-form__input" 
        placeholder="Nhập mã hoặc để trống để tự tạo"></asp:TextBox>
                    </div>
                </div>

                <div class="product-form__field">
                    <span class="product-form__label">Mô tả chi tiết</span>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="product-form__textarea product-form__input--width" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <div style="text-align:center; padding: 10px;">
                    <asp:Label ID="lblStatus" runat="server" Font-Bold="true"></asp:Label>
                </div>

                <div class="product-form__footer">
                    <asp:Button ID="btnCancel" runat="server" Text="Cancle" CssClass="product-form__button product-form__button--secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                    <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="product-form__button product-form__button--primary" OnClick="btnSave_Click" />
                </div>
            </div>
        </div>
    </form>

<script type="text/javascript">
    function formatVNMoney(obj) {
        // 1. Chỉ lấy chữ số
        let val = obj.value.replace(/\D/g, "");
        if (val === "") {
            obj.value = "";
            return;
        }

        // 2. Chặn việc tự nhân đôi số: Nếu độ dài số quá lớn (ví dụ hơn 15 chữ số) thì cắt bớt
        // (Ngân hàng cũng chỉ đến tầm này thôi)
        if (val.length > 15) val = val.substring(0, 15);

        // 3. Định dạng dấu phẩy chuẩn
        let formatted = val.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        // 4. Gán giá trị có kèm VND
        obj.value = formatted + " VND";

        // 5. Quan trọng: Đẩy con trỏ về trước chữ " VND"
        // Việc này giúp bạn gõ số tiếp theo mà không bị nhảy số hay chèn sai chỗ
        let pos = obj.value.length - 4;
        obj.setSelectionRange(pos, pos);
    }
</script>
</body>
</html>