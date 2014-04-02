<%@ Page Language="VB" Inherits="Login" MasterPageFile="~/Master.master" Title="Login" CodeFile="Login.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <div class="body container-fluid ">
        <div class="row middle">
            <div class="well col-md-4 col-md-offset-4 vertical-middle">
                <form id="form1" class="form-horizontal">
                    <div>
                        <div class="alert">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                        </div>
                        <div class="form-group">
                            <div class="col-md-8 col-md-offset-2 txtUsername">
                                <div class="input-group input-group-lg">
                                    <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                                    <asp:TextBox ID="txtUsername" class="form-control input-lg" placeholder="Username" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="Please enter your username" ControlToValidate="txtUsername"><i class="fa red">&#xf069</i></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8 col-md-offset-2 txtUsername">
                                 <div class="input-group input-group-lg">
                                    <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" class="form-control col-xs-3 input-lg" placeholder="Password"></asp:TextBox>
                                     </div>
                            </div>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="Please enter your password" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="The password is invalid"><i class="fa red">&#xf069</i></asp:CustomValidator>
                        </div>
                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-4">
                                <asp:Button ID="cmdLogin" runat="server" Text="Login" class="btn btn-warning btn-lg btn-block " />
                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>

    </div>


</asp:Content>
