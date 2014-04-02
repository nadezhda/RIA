<%@ Page Language="VB" Inherits="Login" MasterPageFile="~/Master.master" Title="Login" CodeFile="Login.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <div class="body container ">
        <div class="row ">
            <div class= "well span5 offset3">
                <form id="form1" class="form-horizontal">
                    <div>
                        <div class="alert">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                        </div>
                        <div class="control-group padd">
                            
                                <div class="input-prepend">
                                    <span class="add-on"><i class="fa fa-user fa-fw"></i></span>
                                    <input id="txtUsername" class="input-xlarge" type="text" placeholder="Username" runat="server"/>
                                </div>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="Please enter your username" ControlToValidate="txtUsername"><i class="fa red">&#xf069</i></asp:RequiredFieldValidator>
                        </div>
                        <div class="control-group padd">
                            
                                 <div class="input-prepend">
                                    <span class="add-on"><i class="fa fa-key fa-fw"></i></span>
                                <input id="txtPassword" runat="server" class="input-xlarge" type="Password" placeholder="Password"/>
                                     </div>
                            

                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="Please enter your password" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="The password is invalid"><i class="fa red">&#xf069</i></asp:CustomValidator>
                        </div>
                        <div class="control-group">
                            <div class="span4 offset1 paddbutton">
                                <asp:Button ID="cmdLogin" runat="server" Text="Login" class="btn btn-warning" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>

    </div>


</asp:Content>
