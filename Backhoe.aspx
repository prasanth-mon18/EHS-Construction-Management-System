<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Backhoe.aspx.cs" Inherits="EHS_Construction_Management_System.Backhoe" %>

<asp:Content ID="Backhoe" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .sub-bar {
            background: #F4F6F9;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 5px solid #27AE60;
            font-size: 16px;
        }

        .dropdown-machinery {
            padding: 6px;
            font-size: 15px;
            font-weight: bold;
            width: 280px;
            margin-left: 10px;
            border: 1px solid #BDC3C7;
            border-radius: 4px;
        }

        .metadata-table {
            width: 100%;
            max-width: 500px;
            margin-bottom: 20px;
            border-collapse: collapse;
        }

            .metadata-table td {
                padding: 6px;
                font-size: 15px;
            }

        .input-date {
            padding: 4px;
            font-size: 14px;
            width: 150px;
        }

        .action-banner {
            margin: 20px 0 10px 0;
        }

        .btn-action {
            font-weight: bold;
            height: 40px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="BackhoeMain" ContentPlaceHolderID="MainContent" runat="server">
    <!-- MAIN GRID -->
    <asp:Panel ID="pnlMachineryForm" runat="server">
        <%--<h2>High Risk Machinery & Equipment List</h2>--%>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="GridBackhoe" runat="server" AutoGenerateColumns="False" CellPadding="4"
                GridLines="Both" Width="100%" OnRowCreated="GridBackhoe_RowCreated" OnRowDataBound="GridBackhoe_RowDataBound" BackColor="White" ForeColor="Black">
                <HeaderStyle BackColor="#F2F2F2" ForeColor="Black" Font-Bold="True" HorizontalAlign="Center" Height="35px" Font-Size="Small" />
                <RowStyle Height="45px" HorizontalAlign="Center" />
                <Columns>
                    <%-- 1. No --%>
                    <asp:TemplateField HeaderText="No">
                        <ItemStyle Width="40px" Font-Bold="true" />
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 2. Company Vendor --%>
                    <asp:TemplateField HeaderText="Company Vendor">
                        <ItemStyle Width="160px" />
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGridCompany" runat="server" CssClass="searchable-company" Width="95%"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 5. Driving License (OK/NG) --%>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:TextBox ID="txtLicense" runat="server" Width="85px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 6. SDIEM PIC --%>
                    <asp:TemplateField HeaderText="SDIEM PIC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSdiemPic" runat="server" Width="90px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 7. Group PIC --%>
                    <asp:TemplateField HeaderText="Group PIC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtGroupPic" runat="server" Width="85px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 8. Date with Calendar Extension Popup --%>
                    <asp:TemplateField HeaderText="Valid until">
                        <ItemTemplate>
                            <asp:TextBox ID="txtValidUntil" runat="server" Width="110px" TextMode="Date"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 9. Cab --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabCleanOk" runat="server" GroupName='<%# "CabClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabCleanNg" runat="server" GroupName='<%# "CabClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabSeatOk" runat="server" GroupName='<%# "CabSeat_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabSeatNg" runat="server" GroupName='<%# "CabSeat_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabPedalOk" runat="server" GroupName='<%# "CabPedal_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabPedalNg" runat="server" GroupName='<%# "CabPedal_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabWiperOk" runat="server" GroupName='<%# "CabWiper_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabWiperNg" runat="server" GroupName='<%# "CabWiper_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabLeversOk" runat="server" GroupName='<%# "CabLevers_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabLeversNg" runat="server" GroupName='<%# "CabLevers_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 10. Other Specifications --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecRollOk" runat="server" GroupName='<%# "SpecRoll_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecRollNg" runat="server" GroupName='<%# "SpecRoll_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecMirrorsOk" runat="server" GroupName='<%# "SpecMirrors_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecMirrorsNg" runat="server" GroupName='<%# "SpecMirrors_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHandrailsOk" runat="server" GroupName='<%# "SpecHandrails_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHandrailsNg" runat="server" GroupName='<%# "SpecHandrails_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecFanOk" runat="server" GroupName='<%# "SpecFan_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecFanNg" runat="server" GroupName='<%# "SpecFan_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecLoaderOk" runat="server" GroupName='<%# "SpecLoader_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecLoaderNg" runat="server" GroupName='<%# "SpecLoader_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecBucketOk" runat="server" GroupName='<%# "SpecBucket_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecBucketNg" runat="server" GroupName='<%# "SpecBucket_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHitchOk" runat="server" GroupName='<%# "SpecHitch_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHitchNg" runat="server" GroupName='<%# "SpecHitch_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecOutriggersOk" runat="server" GroupName='<%# "SpecOutriggers_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecOutriggersNg" runat="server" GroupName='<%# "SpecOutriggers_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHosesOk" runat="server" GroupName='<%# "SpecHoses_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecHosesNg" runat="server" GroupName='<%# "SpecHoses_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecConnectionOk" runat="server" GroupName='<%# "SpecConnection_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecConnectionNg" runat="server" GroupName='<%# "SpecConnection_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecEngineOk" runat="server" GroupName='<%# "SpecEngine_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecEngineNg" runat="server" GroupName='<%# "SpecEngine_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecWheelOk" runat="server" GroupName='<%# "SpecWheel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecWheelNg" runat="server" GroupName='<%# "SpecWheel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecOilOk" runat="server" GroupName='<%# "SpecOil_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSpecOilNg" runat="server" GroupName='<%# "SpecOil_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 11. Warning Devices --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdMotionOk" runat="server" GroupName='<%# "WdMotion_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdMotionNg" runat="server" GroupName='<%# "WdMotion_" + Container.DataItemIndex %>' />
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdBeaconOk" runat="server" GroupName='<%# "WdBeacon_" + Container.DataItemIndex %>' /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdBeaconNg" runat="server" GroupName='<%# "WdBeacon_" + Container.DataItemIndex %>' /></ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdHornOk" runat="server" GroupName='<%# "WdHorn_" + Container.DataItemIndex %>' /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWdHornNg" runat="server" GroupName='<%# "WdHorn_" + Container.DataItemIndex %>' /></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" CssClass="btn-action" Width="140px" BackColor="#2980B9" Style="margin-right: 15px;" />
        <asp:Button ID="btnSaveBackhoe" runat="server" Text="Save Backhoe Records" OnClick="btnSaveBackhoe_Click" CssClass="btn-action" Width="240px" BackColor="#27AE60" />
        <!-- Error Validation Message Banner -->
        <br />
        <br />
        <asp:Label ID="lblValidationError" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="Large"></asp:Label>

        <hr style="margin: 40px 0; border: 1px solid #ccc;" />

        <!-- Bottom Results Section -->
        <asp:Panel ID="pnlHistory" runat="server" Width="100%">
            <h3>Saved Results Log</h3>

            <div style="width: 100%; display: inline-block; margin-bottom: 15px;">
                <!-- Excel Export Button -->
                <div style="float: left; width: 40%;">
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel (.xls)" OnClick="btnExportExcel_Click" Font-Bold="True" Height="35px" Width="200px" BackColor="#E67E22" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px;" />
                </div>

                <!-- Delete Flag Filter -->
                <div style="float: right; width: 50%; text-align: right; font-weight: bold; font-size: 16px; padding-top: 8px;">
                    <span style="margin-right: 15px; color: #2C3E50;">Delete Flag :</span>
                    <asp:RadioButton ID="rbFilterN" runat="server" GroupName="FilterGroup" Text="Use" AutoPostBack="True" OnCheckedChanged="FilterRadio_CheckedChanged" Checked="True" Style="margin-right: 15px;" />
                    <asp:RadioButton ID="rbFilterY" runat="server" GroupName="FilterGroup" Text="Not Use" AutoPostBack="True" OnCheckedChanged="FilterRadio_CheckedChanged" Style="margin-right: 15px;" />
                    <asp:RadioButton ID="rbFilterAll" runat="server" GroupName="FilterGroup" Text="All" AutoPostBack="True" OnCheckedChanged="FilterRadio_CheckedChanged" />
                </div>
            </div>

            <div style="overflow-x: auto; width: 100%; clear: both;">
                <asp:GridView ID="GridHistory" runat="server" AutoGenerateColumns="False" CellPadding="4" GridLines="Both" Width="100%" BackColor="White" BorderColor="#989898" BorderStyle="None" BorderWidth="1px" ForeColor="Black"
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="GridHistory_PageIndexChanging" OnRowDeleting="GridHistory_RowDeleting" OnRowCommand="GridHistory_RowCommand" OnRowDataBound="GridHistory_RowDataBound" OnRowCreated="GridHistory_RowCreated" DataKeyNames="ID">
                    <HeaderStyle ForeColor="Black" Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" Height="35px" />
                    <RowStyle Height="35px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <%-- 1. No --%>
                        <asp:TemplateField HeaderText="No">
                            <ItemStyle Width="40px" Font-Bold="true" />
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- 1. Machinery Details --%>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" Visible="false" />
                        <asp:BoundField DataField="COMPANY_VENDOR" HeaderText="Company Vendor" />
                        <asp:BoundField DataField="DRIVING_LICENSE" HeaderText="Driving License (OK/NG)" />
                        <asp:BoundField DataField="SDIEM_PIC" HeaderText="SDIEM PIC" />
                        <asp:BoundField DataField="GROUP_PIC" HeaderText="Group PIC" />
                        <asp:BoundField DataField="VALID_UNTIL" HeaderText="Valid until" />
                        <%-- 2. Cab --%>
                        <asp:BoundField DataField="CAB_CLEAN" HeaderText="Cleanliness of cab" />
                        <asp:BoundField DataField="CAB_SEAT_COND" HeaderText="Seat condition" />
                        <asp:BoundField DataField="CAB_PEDAL_COND" HeaderText="Pedal condition" />
                        <asp:BoundField DataField="CAB_WINDOW_WIPER" HeaderText="Window/wipers/washer" />
                        <asp:BoundField DataField="CAB_LEVERS_CTRL" HeaderText="Levers/ Controls operational" />
                        <%-- 3. Other specification --%>
                        <asp:BoundField DataField="SPEC_ROLL_ROPES" HeaderText="Rollover protection system (ropes)" />
                        <asp:BoundField DataField="SPEC_REAR_MIRRORS" HeaderText="Rear view mirrors" />
                        <asp:BoundField DataField="SPEC_HANDRAILS" HeaderText="Handrails/ steps" />
                        <asp:BoundField DataField="SPEC_FAN" HeaderText="Ventilation fan covered (if any)" />
                        <asp:BoundField DataField="SPEC_LOADER_BUCKET" HeaderText="Loader bucket" />
                        <asp:BoundField DataField="SPEC_BUCKET_COND" HeaderText="Bucket condition" />
                        <asp:BoundField DataField="SPEC_HITCH_PIN" HeaderText="Quick hitch/ safety pin fitted perfectly" />
                        <asp:BoundField DataField="SPEC_OUTRIGGERS_COND" HeaderText="Outriggers condition" />
                        <asp:BoundField DataField="SPEC_HYD_HOSES" HeaderText="Hydraulic hoses" />
                        <asp:BoundField DataField="SPEC_CONNECTION_FIT" HeaderText="Connection fitted properly" />
                        <asp:BoundField DataField="SPEC_ENGINE_GUARD" HeaderText="Engine guarding" />
                        <asp:BoundField DataField="SPEC_WHEEL_COND" HeaderText="Tires/Wheel condition" />
                        <asp:BoundField DataField="SPEC_OIL_LEAK" HeaderText="No oil leak trace" />
                        <%-- 4. WD --%>
                        <asp:BoundField DataField="WD_MOTION_ALARM" HeaderText="Motion alarm" />
                        <asp:BoundField DataField="WD_AMBER_BEACON" HeaderText="Amber flashing beacon" />
                        <asp:BoundField DataField="WD_HORN" HeaderText="Horn" />

                        <asp:BoundField DataField="DEL_FLAG" HeaderText="FLAG" Visible="false" />
                        <asp:TemplateField HeaderText="ACTIONS">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" BackColor="#C0392B" ForeColor="White" BorderStyle="None" Height="25px" Width="60px" OnClientClick="return confirm('Are you sure want to DELETE?');" />
                                <asp:Button ID="btnRestore" runat="server" CommandName="RestoreRecord" Text="Restore" CommandArgument='<%# Eval("ID") %>' BackColor="#27AE60" ForeColor="White" BorderStyle="None" Height="25px" Width="60px" OnClientClick="return confirm('Are you sure want to RESTORE?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle BackColor="#F7F7F7" ForeColor="Black" HorizontalAlign="Right" />
                </asp:GridView>
            </div>
        </asp:Panel>
    </asp:Panel>

</asp:Content>
