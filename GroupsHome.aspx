<%@ Page Title="" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="GroupsHome.aspx.vb" Inherits="GroupsHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <div class="container-fluid body">
        <div class="col-md-6">
            <div class="row col-md-offset-1">

                <h3>Group Name : </h3>
                <asp:Button ID="cmdCreateGroup" runat="server" Text="Add New Group" class="btn btn-lg pull-right btn-dark" />

            </div>
            <div class="row col-md-offset-1">
                <div class="well darkwell">
                    <h4>Social Networks : </h4>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn meeting-confirm btn-lg">
                                <label class="pull-left">Wednesday 11:00 AM </label>
                                <label class="pull-right">Confirmed</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn meeting-conflict btn-lg">
                                <label class="pull-left">Friday 15:00 PM </label>
                                <label class="pull-right">Conflict </label>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-3 pull-right">
            ghjgh
            
        </div>




    </div>










    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <div id="main">
        <input type="button" id="btAdd" value="Add Element" class="bt" />
        <input type="button" id="btRemove" value="Remove Element" class="bt" />
        <input type="button" id="btRemoveAll" value="Remove All" class="bt" /><br />
    </div>
    <script>
        $(document).ready(function () {
            var iCnt = 0;
            // CREATE A "DIV" ELEMENT AND DESIGN IT USING JQUERY ".css()" CLASS.
            var container = $(document.createElement('div')).css({
                padding: '5px', margin: '20px', width: '170px', border: '1px dashed',
                borderTopColor: '#999', borderBottomColor: '#999',
                borderLeftColor: '#999', borderRightColor: '#999'
            });
            $('#btAdd').click(function () {
                if (iCnt <= 19) {
                    iCnt = iCnt + 1;
                    // ADD TEXTBOX.
                    $(container).append('<input type=text class="input" id=tb' + iCnt + '  value="Text Element ' + iCnt + '" />');

                    if (iCnt == 1) {        // SHOW SUBMIT BUTTON IF ATLEAST "1" ELEMENT HAS BEEN CREATED.
                        var divSubmit = $(document.createElement('div'));
                        $(divSubmit).append('<input type=button class="bt" onclick="GetTextValue()" id=btSubmit value=Submit />');
                    }
                    $('#main').after(container, divSubmit);   // ADD BOTH THE DIV ELEMENTS TO THE "main" CONTAINER.
                }
                else {      // AFTER REACHING THE SPECIFIED LIMIT, DISABLE THE "ADD" BUTTON. (20 IS THE LIMIT WE HAVE SET)
                    $(container).append('<label>Reached the limit</label>');
                    $('#btAdd').attr('class', 'bt-disable');
                    $('#btAdd').attr('disabled', 'disabled');
                }
            });
            $('#btRemove').click(function () {   // REMOVE ELEMENTS ONE PER CLICK.
                if (iCnt != 0) { $('#tb' + iCnt).remove(); iCnt = iCnt - 1; }
                if (iCnt == 0) {
                    $(container).empty();
                    $(container).remove();
                    $('#btSubmit').remove();
                    $('#btAdd').removeAttr('disabled');
                    $('#btAdd').attr('class', 'bt')
                }
            });
            $('#btRemoveAll').click(function () {    // REMOVE ALL THE ELEMENTS IN THE CONTAINER.
                $(container).empty();
                $(container).remove();
                $('#btSubmit').remove(); iCnt = 0;
                $('#btAdd').removeAttr('disabled');
                $('#btAdd').attr('class', 'bt');
            });
        });

        // PICK THE VALUES FROM EACH TEXTBOX WHEN "SUBMIT" BUTTON IS CLICKED.
        var divValue, values = '';
        function GetTextValue() {
            $(divValue).empty();
            $(divValue).remove(); values = '';
            $('.input').each(function () {
                divValue = $(document.createElement('div')).css({
                    padding: '5px', width: '200px'
                });
                values += this.value + '<br />'
            });
            $(divValue).append('<p><b>Your selected values</b></p>' + values);
            $('body').append(divValue);
        }
    </script>

</asp:Content>

