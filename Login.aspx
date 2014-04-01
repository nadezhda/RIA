<%@ Page Language="VB" Inherits="Login" MasterPageFile="~/Master.master" Title="Login" CodeFile="Login.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <div class="body container-fluid ">
        <div class="row">
            <div class="well col-md-4 col-md-offset-4 vertical-middle">
                <form id="form1" class="form-horizontal">
                    <div>
                        <div>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                        </div>
                        <div class="form-group">
                            <!--  <asp:Label ID="Label1" runat="server" class="form-control" Text="Username: "></asp:Label> -->
                            <%--<input type="email"  id="txtUsername"  />--%>
                            <div class="col-md-8 col-md-offset-2">
                                <asp:TextBox ID="txtUsername" class="form-control input-lg" placeholder="Enter email" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="Please enter your username" ControlToValidate="txtUsername">*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <!-- <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label> -->
                            <div class="col-md-8 col-md-offset-2">
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" class="form-control col-xs-3 input-lg" placeholder="Password"></asp:TextBox>
                            </div>
                            <%--<input type="password"  id="txtPassword" />--%>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="Please enter your password" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="The password is invalid">*</asp:CustomValidator>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3 col-md-offset-5">
                                <asp:Button ID="cmdLogin" runat="server" Text="Login" class="btn btn-warning btn-lg btn-block " />
                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>

    </div>


</asp:Content>
