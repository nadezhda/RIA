<%@ Page Language="VB" Inherits="Table" MasterPageFile="~/Master.master" Title="Group Schedule" CodeFile="Table.aspx.vb" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>



<asp:Content ID="contentHome" ContentPlaceHolderID="Main" runat="server">
    <div class="body">
        <div class="container-fluid">
            <h4>Select a time slot to create a meeting</h4>
            <div class="table-responsive span5 offset1">

                <div>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [eventTable]"></asp:SqlDataSource>

                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <script type="text/javascript">
                        function SetValue() {


                            document.getElementById('<%=HiddenField1.ClientID%>').value = "test";
                        $('#CreateMeetingModalBox').modal('toggle');
                    }
                    </script>
                    <DayPilot:DayPilotCalendar ID="DayPilotCalendar2" EventCorners="Rounded" EventArrangement="Full" HeightSpec="Fixed" HeaderDateFormat="m" CellDuration="60" ColumnWidthSpec="Fixed" ClientObjectName="dpm" CellBorderColor="Green" CellHeight="50" EventHeaderHeight="50" Days="5" runat="server" EventClickHandling="CallBack" TimeRangeSelectedHandling="JavaScript" OnEventAdd="DayPilotCalendar2_EventAdd" DurationBarVisible="false" CrosshairOpacity="20" HeaderHeightAutoFit="True" HeaderHeight="50" ColumnWidth="50" HideFreeCells="False" Crosshair="Header">
                    </DayPilot:DayPilotCalendar>
                    <asp:GridView ID="GridView1" Visible="false" runat="server"></asp:GridView>
                    <asp:GridView ID="GridView2" Visible="false" runat="server"></asp:GridView>
                </div>
            </div>

            <!--     <table id="schedule" class="table">
                <tr>
                    <th></th>
                    <th>7-8</th>
                    <th>8-9</th>
                    <th>9-10</th>
                    <th>10-11</th>
                    <th>11-12</th>
                    <th>12-13</th>
                    <th>13-14</th>
                    <th>14-15</th>
                    <th>15-16</th>
                    <th>16-17</th>
                    <th>17-18</th>
                    <th>18-19</th>
                    <th>19-20</th>
                    <th>20-21</th>
                    <th>21-22</th>
                    <th>22-23</th>
                    <th>23-24</th>
                </tr>

                <tr id="mon">
                    <td class="day">Monday</td>
                    <td class="unavailable" id="mon-7"></td>
                    <td class="unavailable" id="mon-8"></td>
                    <td class="available" id="mon-9"></td>
                    <td class="available" id="mon-10"></td>
                    <td class="unavailable" id="mon-11"></td>
                    <td class="unavailable" id="mon-12"></td>
                    <td class="unavailable" id="mon-13"></td>
                    <td class="unavailable" id="mon-14"></td>
                    <td class="unavailable" id="mon-15"></td>
                    <td class="unavailable" id="mon-16"></td>
                    <td class="unavailable" id="mon-17"></td>
                    <td class="available" id="mon-18"></td>
                    <td class="available" id="mon-19"></td>
                    <td class="available" id="mon-20"></td>
                    <td class="available" id="mon-21"></td>
                    <td class="available" id="mon-22"></td>
                    <td class="available" id="mon-23"></td>
                </tr>
                <tr>
                    <td class="day">Tuesday</td>
                    <td class="unavailable" id="tues-7"></td>
                    <td class="unavailable" id="tues-8"></td>
                    <td class="unavailable" id="tues-9"></td>
                    <td class="unavailable" id="tues-10"></td>
                    <td class="unavailable" id="tues-11"></td>
                    <td class="unavailable" id="tues-12"></td>
                    <td class="unavailable" id="tues-13"></td>
                    <td class="selected" id="tues-14"></td>
                    <td class="unavailable" id="tues-15"></td>
                    <td class="unavailable" id="tues-16"></td>
                    <td class="available" id="tues-17"></td>
                    <td class="available" id="tues-18"></td>
                    <td class="unavailable" id="tues-19"></td>
                    <td class="available" id="tues-20"></td>
                    <td class="available" id="tues-21"></td>
                    <td class="available" id="tues-22"></td>
                    <td class="available" id="tues-23"></td>
                </tr>
                <tr>
                    <td class="day">Wednesday</td>
                    <td class="unavailable" id="wed-7"></td>
                    <td class="unavailable" id="wed-8"></td>
                    <td class="unavailable" id="wed-9"></td>
                    <td class="unavailable" id="wed-10"></td>
                    <td class="unavailable" id="wed-11"></td>
                    <td class="unavailable" id="wed-12"></td>
                    <td class="unavailable" id="wed-13"></td>
                    <td class="unavailable" id="wed-14"></td>
                    <td class="unavailable" id="wed-15"></td>
                    <td class="unavailable" id="wed-16"></td>
                    <td class="unavailable" id="wed-17"></td>
                    <td class="available" id="wed-18"></td>
                    <td class="available" id="wed-19"></td>
                    <td class="available" id="wed-20"></td>
                    <td class="available" id="wed-21"></td>
                    <td class="available" id="wed-22"></td>
                    <td class="available" id="wed-23"></td>
                </tr>
                <tr>
                    <td class="day">Thursday</td>
                    <td class="unavailable" id="thur-7"></td>
                    <td class="unavailable" id="thur-8"></td>
                    <td class="unavailable" id="thur-9"></td>
                    <td class="unavailable" id="thur-10"></td>
                    <td class="unavailable" id="thur-11"></td>
                    <td class="unavailable" id="thur-12"></td>
                    <td class="unavailable" id="thur-13"></td>
                    <td class="unavailable" id="thur-14"></td>
                    <td class="unavailable" id="thur-15"></td>
                    <td class="available" id="thur-16"></td>
                    <td class="available" id="thur-17"></td>
                    <td class="unavailable" id="thur-18"></td>
                    <td class="unavailable" id="thur-19"></td>
                    <td class="unavailable" id="thur-20"></td>
                    <td class="unavailable" id="thur-21"></td>
                    <td class="unavailable" id="thur-22"></td>
                    <td class="unavailable" id="thur-23"></td>
                </tr>
                <tr>
                    <td class="day">Friday</td>
                    <td class="unavailable" id="fri-7"></td>
                    <td class="unavailable" id="fri-8"></td>
                    <td class="unavailable" id="fri-9"></td>
                    <td class="unavailable" id="fri-10"></td>
                    <td class="unavailable" id="fri-11"></td>
                    <td class="unavailable" id="fri-12"></td>
                    <td class="unavailable" id="fri-13"></td>
                    <td class="unavailable" id="fri-14"></td>
                    <td class="available" id="fri-15"></td>
                    <td class="available" id="fri-16"></td>
                    <td class="available" id="fri-17"></td>
                    <td class="available" id="fri-18"></td>
                    <td class="available" id="fri-19"></td>
                    <td class="unavailable" id="fri-20"></td>
                    <td class="unavailable" id="fri-21"></td>
                    <td class="unavailable" id="fri-22"></td>
                    <td class="unavailable" id="fri-23"></td>
                </tr>
                <tr>
                    <td class="day">Saturday</td>
                    <td class="available" id="sat-7"></td>
                    <td class="available" id="sat-8"></td>
                    <td class="available" id="sat-9"></td>
                    <td class="available" id="sat-10"></td>
                    <td class="available" id="sat-11"></td>
                    <td class="available" id="sat-12"></td>
                    <td class="available" id="sat-13"></td>
                    <td class="available" id="sat-14"></td>
                    <td class="available" id="sat-15"></td>
                    <td class="available" id="sat-16"></td>
                    <td class="available" id="sat-17"></td>
                    <td class="available" id="sat-18"></td>
                    <td class="available" id="sat-19"></td>
                    <td class="available" id="sat-20"></td>
                    <td class="available" id="sat-21"></td>
                    <td class="available" id="sat-22"></td>
                    <td class="available" id="sat-23"></td>
                </tr>
                <tr>
                    <td class="day">Sunday</td>
                    <td class="available" id="sun-7"></td>
                    <td class="available" id="sun-8"></td>
                    <td class="available" id="sun-9"></td>
                    <td class="available" id="sun-10"></td>
                    <td class="available" id="sun-11"></td>
                    <td class="available" id="sun-12"></td>
                    <td class="available" id="sun-13"></td>
                    <td class="available" id="sun-14"></td>
                    <td class="available" id="sun-15"></td>
                    <td class="available" id="sun-16"></td>
                    <td class="available" id="sun-17"></td>
                    <td class="available" id="sun-18"></td>
                    <td class="available" id="sun-19"></td>
                    <td class="available" id="sun-20"></td>
                    <td class="available" id="sun-21"></td>
                    <td class="available" id="sun-22"></td>
                    <td class="available" id="sun-23"></td>
                </tr>
            </table> -->
                <div class="span3">
                        <form class="form-horizontal">
                            <label class="control-label checkbox">
                                <input type="checkbox" name="auto-location" id="closest-loc" />
                                Sort By Closest Location
                            </label>
                            <br />
                            <label class="control-label" id="campus">Campuses : </label>
                            <br />
                            <select class="campus-list" name="campus"></select>
                            <label class="control-label" id="building">Buildings : </label>
                            <br />
                            <select class="build-box" name="building" size="19"></select>

                        </form>
                    </div>
                    <div class="span3">
                        <form class="form-horizontal">
                            <label class="control-label" id="room">Rooms : </label>
                            <br />
                            <select class="room-box" name="room" size="10"></select>
                            <label class="control-label" id="equipment">Equipment : </label>
                            <br />
                            <select class="equip-box" name="equipment" size="10"></select>
                        </form>
                    </div>
                

                <!--
            <button id="btnCreatePlace" type="button" class="btn btn-success" runat="server" data-toggle="modal" data-target="#AddMeetingPlaceModal">
                Add place</button>
           <br /> <div><h4>Meeting Confirmation:</h4><p>Your Meeting Details:</p><p>Meeting Date: Tuesday, 13/05/2014</p><p>Meeting Time: 17:00 to 18:00</p><p>
                             <button id="Button1" type="button" class="btn btn-success" runat="server" data-toggle="modal" data-target="#AddMeetingPlaceModal">Confirm and Send Email</button></p></div> -->
            <div class="table-responsive span5 offset1">
                <asp:Panel runat="server" ID="LocationPanel" Visible="false">
                    <form class="form-horizontal">
                        <div class="filter">
                            <div class="control-group">
                                <label class="control-label checkbox">
                                    <input type="checkbox" />
                                    Sort By Closest Location
                                </label>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Campus : </label>
                                <div class="controls">
                                    <select>
                                        <option>Highfield </option>
                                        <option>Avenue </option>
                                        <option>National Oceanography Centre </option>

                                    </select>

                                </div>
                            </div>
                        </div>


                        02a / 2077 (L/T J), Building 2 Annexe<br />
                        27 / 2003 (L/R 2), Chemistry<br />
                        27/1133 (w/c 1 July - w/e 18 Aug) then 58/1039 (w/c 19 Aug - w/e 15 Sep), Chemistry<br />
                        Seminar Room, Chemistry<br />
                        Boardroom, Chemistry<br />
                        Lecture Theatre 1, Chemistry<br />
                        Lecture Theatre, David Kiddle<br />
                        Lecture Theatre, David Kiddle<br />
                        Lecture Theatre, EEE Building<br />
                        32 / 3077, EEE Building<br />
                        <asp:Button ID="cmdCreateMeeting" runat="server" Text="Create Meeting" />
                    </form>
                </asp:Panel>
            </div>
            <div id="AddMeetingPlaceModal" class="modal hide fade" tabindex="-1">
                <div class="modal-header">
                    <h3>Add Meeting Place</h3>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="filter">
                            <div class="control-group">
                                <label class="control-label checkbox">
                                    <input type="checkbox" />
                                    Sort By Closest Location
                                </label>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Campus : </label>
                                <div class="controls">
                                    <select>
                                        <option>Highfield </option>
                                        <option>Avenue </option>
                                        <option>National Oceanography Centre </option>

                                    </select>

                                </div>
                            </div>
                        </div>


                        02a / 2077 (L/T J), Building 2 Annexe<br />
                        27 / 2003 (L/R 2), Chemistry<br />
                        27/1133 (w/c 1 July - w/e 18 Aug) then 58/1039 (w/c 19 Aug - w/e 15 Sep), Chemistry<br />
                        Seminar Room, Chemistry<br />
                        Boardroom, Chemistry<br />
                        Lecture Theatre 1, Chemistry<br />
                        Lecture Theatre, David Kiddle<br />
                        Lecture Theatre, David Kiddle<br />
                        Lecture Theatre, EEE Building<br />
                        32 / 3077, EEE Building<br />
                    </form>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button2" CssClass="btn btn-success" runat="server" Text="Save Settings" />
                    <button id="Button3" data-dismiss="modal" class="btn ">Close</button>
                </div>
            </div>

            <div id="CreateMeetingModalBox" class="modal hide fade" tabindex="-1">
                <div class="modal-header">
                    <h3>Create Meeting</h3>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <!-- <script>start.tostring()</script> -->

                        <p>You Selected The Meeting Time. Now Press <b>Create Meeting</b> To Send It To Group Members.</p>
                    </form>
                </div>
                <div class="modal-footer">

                    <button id="Button4" data-dismiss="modal" class="btn ">Close</button>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <script src="js/csv.js"></script>
    </footer>
</asp:Content>
