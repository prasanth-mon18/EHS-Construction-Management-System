<%@ Page Title="High Risk Machinery & Equipment List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forklift.aspx.cs" Inherits="EHS_Construction_Management_System.Forklift" EnableEventValidation="false" %>

<asp:Content ID="Forklift" ContentPlaceHolderID="HeadContent" runat="server">
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

<asp:Content ID="ForkliftMain" ContentPlaceHolderID="MainContent" runat="server">

    <!-- MAIN GRID -->
    <asp:Panel ID="pnlMachineryForm" runat="server">
        <%--<h2>High Risk Machinery & Equipment List</h2>--%>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="GridForklift" runat="server" AutoGenerateColumns="False" CellPadding="4"
                GridLines="Both" Width="100%" OnRowCreated="GridForklift_RowCreated" OnRowDataBound="GridForklift_RowDataBound" BackColor="White" ForeColor="Black">
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

                    <%-- 2. Type --%>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <asp:TextBox ID="txtForkliftType" runat="server" Width="100px" placeholder="e.g. Diesel/Battery"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 3. SWL --%>
                    <asp:TemplateField HeaderText="SWL">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSwl" runat="server" Width="50px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 4. Company Vendor --%>
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

                    <%-- 9. Fork and hydraulics --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLiftTiltOk" runat="server" GroupName='<%# "LiftTilt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLiftTiltNg" runat="server" GroupName='<%# "LiftTilt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbChainCondOk" runat="server" GroupName='<%# "ChainCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbChainCondNg" runat="server" GroupName='<%# "ChainCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForksMastOk" runat="server" GroupName='<%# "ForksMast_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForksMastNg" runat="server" GroupName='<%# "ForksMast_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBodyStructureOk" runat="server" GroupName='<%# "BodyStructure_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBodyStructureNg" runat="server" GroupName='<%# "BodyStructure_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydHosesLeakOk" runat="server" GroupName='<%# "HydHosesLeak_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydHosesLeakNg" runat="server" GroupName='<%# "HydHosesLeak_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 10. Warning Devices Functioning --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBuzzerNoiseOk" runat="server" GroupName='<%# "BuzzerNoise_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBuzzerNoiseNg" runat="server" GroupName='<%# "BuzzerNoise_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAmberAlarmOk" runat="server" GroupName='<%# "AmberAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAmberAlarmNg" runat="server" GroupName='<%# "AmberAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornOk" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornNg" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbReverseAlarmOk" runat="server" GroupName='<%# "ReverseAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbReverseAlarmNg" runat="server" GroupName='<%# "ReverseAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSignalLightOk" runat="server" GroupName='<%# "SignalLight_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSignalLightNg" runat="server" GroupName='<%# "SignalLight_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 11. Specifications --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBrakePedalOk" runat="server" GroupName='<%# "BrakePedal_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBrakePedalNg" runat="server" GroupName='<%# "BrakePedal_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSteeringSysOk" runat="server" GroupName='<%# "SteeringSys_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSteeringSysNg" runat="server" GroupName='<%# "SteeringSys_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSideMirrorOk" runat="server" GroupName='<%# "SideMirror_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSideMirrorNg" runat="server" GroupName='<%# "SideMirror_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbFrontLampOk" runat="server" GroupName='<%# "FrontLamp_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbFrontLampNg" runat="server" GroupName='<%# "FrontLamp_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOverheadGuardOk" runat="server" GroupName='<%# "OverheadGuard_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOverheadGuardNg" runat="server" GroupName='<%# "OverheadGuard_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBonnetLockOk" runat="server" GroupName='<%# "BonnetLock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBonnetLockNg" runat="server" GroupName='<%# "BonnetLock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbNamePlateOk" runat="server" GroupName='<%# "NamePlate_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbNamePlateNg" runat="server" GroupName='<%# "NamePlate_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSeatCleanOk" runat="server" GroupName='<%# "SeatClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSeatCleanNg" runat="server" GroupName='<%# "SeatClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSeatbeltOk" runat="server" GroupName='<%# "Seatbelt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSeatbeltNg" runat="server" GroupName='<%# "Seatbelt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 12. Others --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbEngineCondOk" runat="server" GroupName='<%# "EngineCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbEngineCondNg" runat="server" GroupName='<%# "EngineCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMaintChecklistOk" runat="server" GroupName='<%# "MaintChecklist_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMaintChecklistNg" runat="server" GroupName='<%# "MaintChecklist_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTiresWheelsOk" runat="server" GroupName='<%# "TiresWheels_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="35px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTiresWheelsNg" runat="server" GroupName='<%# "TiresWheels_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" CssClass="btn-action" Width="140px" BackColor="#2980B9" Style="margin-right: 15px;" />
        <asp:Button ID="btnSaveForklift" runat="server" Text="Save Forklift Records" OnClick="btnSaveForklift_Click" CssClass="btn-action" Width="240px" BackColor="#27AE60" />
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
                        <asp:BoundField DataField="FORKLIFT_TYPE" HeaderText="Type" />
                        <asp:BoundField DataField="SWL" HeaderText="SWL" />
                        <asp:BoundField DataField="COMPANY_VENDOR" HeaderText="Company Vendor" />
                        <asp:BoundField DataField="DRIVING_LICENSE" HeaderText="Driving License (OK/NG)" />
                        <asp:BoundField DataField="SDIEM_PIC" HeaderText="SDIEM PIC" />
                        <asp:BoundField DataField="GROUP_PIC" HeaderText="Group PIC" />
                        <asp:BoundField DataField="VALID_UNTIL" HeaderText="Valid until" />
                        
                        <%-- 2. Fork and hydraulics --%>
                        <asp:BoundField DataField="ML_LIFT_TILT_LEVER" HeaderText="Lift & tilt lever" />
                        <asp:BoundField DataField="ML_CHAIN_COND" HeaderText="Chain in good condition" />
                        <asp:BoundField DataField="ML_FORKS_MAST" HeaderText="Forks, lift mast, backrest" />
                        <asp:BoundField DataField="ML_BODY_STRUCTURE" HeaderText="Good body structure" />
                        <asp:BoundField DataField="ML_HYD_HOSES_LEAK" HeaderText="Hydraulic hoses no leak" />
                        
                        <%-- 3. Warning Devices Functioning --%>
                        <asp:BoundField DataField="WD_BUZZER_NOISE" HeaderText="Buzzer noise" />
                        <asp:BoundField DataField="WD_AMBER_ALARM" HeaderText="Amber beacon alarm" />
                        <asp:BoundField DataField="WD_HORN" HeaderText="Horn" />
                        <asp:BoundField DataField="WD_REVERSE_ALARM" HeaderText="Reversing alarm" />
                        <asp:BoundField DataField="WD_SIGNAL_LIGHT" HeaderText="Signal" />

                        <%-- 4. Specifications --%>
                        <asp:BoundField DataField="WD_BRAKE_PEDAL" HeaderText="Brake & brake pedal function" />
                        <asp:BoundField DataField="WD_STEERING_SYS" HeaderText="Steering pedals in good condition" />
                        <asp:BoundField DataField="WD_SIDE_MIRROR" HeaderText="Side mirror in good condition" />
                        <asp:BoundField DataField="WD_FRONT_LAMP" HeaderText="Front lamp functioning" />
                        <asp:BoundField DataField="CS_OVERHEAD_GUARD" HeaderText="Overhead guard" />
                        <asp:BoundField DataField="CS_BONNET_LOCK" HeaderText="Engine hood secured" />
                        <asp:BoundField DataField="CS_NAME_PLATE" HeaderText="Name plate" />
                        <asp:BoundField DataField="CS_SEAT_CLEAN" HeaderText="Seat cleanliness" />
                        <asp:BoundField DataField="CS_SEATBELT" HeaderText="Seatbelt" />
                        
                        <%-- 5. Others --%>
                        <asp:BoundField DataField="EO_ENGINE_COND" HeaderText="Engine condition" />
                        <asp:BoundField DataField="EO_MAINT_CHECKLIST" HeaderText="Maintenance checklist" />
                        <asp:BoundField DataField="EO_TIRES_WHEELS" HeaderText="Tires & wheels condition" />

                        <asp:BoundField DataField="DEL_FLAG" HeaderText="FLAG" Visible="false"/>
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
