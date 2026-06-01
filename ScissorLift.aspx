<%@ Page Title="High Risk Machinery & Equipment List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScissorLift.aspx.cs" Inherits="EHS_Construction_Management_System.ScissorLift" EnableEventValidation="false" %>

<asp:Content ID="ScissorLift" ContentPlaceHolderID="HeadContent" runat="server">
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

<asp:Content ID="ScissorLiftMain" ContentPlaceHolderID="MainContent" runat="server">

    <!-- MAIN GRID -->
    <asp:Panel ID="pnlMachineryForm" runat="server">
        <%--<h2>High Risk Machinery & Equipment List</h2>--%>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="GridScissor" runat="server" AutoGenerateColumns="False" CellPadding="4"
                GridLines="Both" Width="100%" OnRowCreated="GridScissor_RowCreated" OnRowDataBound="GridScissor_RowDataBound" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" ForeColor="Black">
                <HeaderStyle BackColor="#F2F2F2" ForeColor="Black" Font-Bold="True" HorizontalAlign="Center" Height="35px" Font-Size="Medium" />
                <RowStyle Height="45px" HorizontalAlign="Center" />
                <Columns>
                    <%-- 1. No --%>
                    <asp:TemplateField HeaderText="No">
                        <ItemStyle Width="40px" Font-Bold="true" />
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 2. PMA --%>
                    <asp:TemplateField HeaderText="PMA">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPma" runat="server" Width="85px" Text='<%# Bind("PMA") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 3. SWL --%>
                    <asp:TemplateField HeaderText="SWL">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSwl" runat="server" Width="50px" Text='<%# Bind("SWL") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 4. Company Vendor --%>
                    <asp:TemplateField HeaderText="Company Vendor">
                        <ItemStyle Width="160px" />
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGridCompany" runat="server" CssClass="searchable-company" Width="95%"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 5. No. of Operator --%>
                    <asp:TemplateField HeaderText="No. of Operator">
                        <ItemTemplate>
                            <asp:TextBox ID="txtNoOperator" runat="server" Width="40px" Text='<%# Bind("NO_OF_OPERATOR") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 6. SDIEM PIC --%>
                    <asp:TemplateField HeaderText="SDIEM PIC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSdiemPic" runat="server" Width="90%" Text='<%# Bind("SDIEM_PIC") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 7. Group PIC --%>
                    <asp:TemplateField HeaderText="Group PIC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtGroupPic" runat="server" Width="85%" Text='<%# Bind("GROUP_PIC") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 8. Date with Calendar Extension Popup --%>
                    <asp:TemplateField HeaderText="Valid until">
                        <ItemTemplate>
                            <asp:TextBox ID="txtValidUntil" runat="server" Width="110px" TextMode="Date" Text='<%# Bind("VALID_UNTIL") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 9. Bucket Condition/ Platform --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbPlatCtrlOk" runat="server" GroupName='<%# "PlatCtrl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbPlatCtrlNg" runat="server" GroupName='<%# "PlatCtrl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHandrailOk" runat="server" GroupName='<%# "Handrail_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHandrailNg" runat="server" GroupName='<%# "Handrail_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbPlatAssyOk" runat="server" GroupName='<%# "PlatAssy_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbPlatAssyNg" runat="server" GroupName='<%# "PlatAssy_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbGateCondOk" runat="server" GroupName='<%# "GateCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbGateCondNg" runat="server" GroupName='<%# "GateCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHarnessOk" runat="server" GroupName='<%# "Harness_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHarnessNg" runat="server" GroupName='<%# "Harness_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 10. Engine Appearance Condition --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydraulicOk" runat="server" GroupName='<%# "Hydraulic_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydraulicNg" runat="server" GroupName='<%# "Hydraulic_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMotorPumpOk" runat="server" GroupName='<%# "MotorPump_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMotorPumpNg" runat="server" GroupName='<%# "MotorPump_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTiltOk" runat="server" GroupName='<%# "Tilt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTiltNg" runat="server" GroupName='<%# "Tilt_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWheelsOk" runat="server" GroupName='<%# "Wheels_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWheelsNg" runat="server" GroupName='<%# "Wheels_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbGroundOk" runat="server" GroupName='<%# "Ground_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbGroundNg" runat="server" GroupName='<%# "Ground_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 11. Warning Devices --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbRevAlarmOk" runat="server" GroupName='<%# "RevAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbRevAlarmNg" runat="server" GroupName='<%# "RevAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornOk" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornNg" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBeaconOk" runat="server" GroupName='<%# "Beacon_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBeaconNg" runat="server" GroupName='<%# "Beacon_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLightsOk" runat="server" GroupName='<%# "Lights_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLightsNg" runat="server" GroupName='<%# "Lights_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 12. Safety Features --%>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLiftCylOk" runat="server" GroupName='<%# "LiftCyl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLiftCylNg" runat="server" GroupName='<%# "LiftCyl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLimitSwOk" runat="server" GroupName='<%# "LimitSw_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLimitSwNg" runat="server" GroupName='<%# "LimitSw_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbScissorArmOk" runat="server" GroupName='<%# "ScissorArm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbScissorArmNg" runat="server" GroupName='<%# "ScissorArm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbManualDecentOk" runat="server" GroupName='<%# "ManualDecent_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbManualDecentNg" runat="server" GroupName='<%# "ManualDecent_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCompartmentOk" runat="server" GroupName='<%# "Compartment_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCompartmentNg" runat="server" GroupName='<%# "Compartment_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" Font-Bold="True" Height="40px" Width="150px" BackColor="#2980B9" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px; margin-right: 15px;" />
        <asp:Button ID="btnSaveScissor" runat="server" Text="Save Machinery Records" OnClick="btnSaveScissor_Click" Font-Bold="True" Height="40px" Width="220px" BackColor="#27AE60" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px;" />
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
                        <asp:BoundField DataField="PMA" HeaderText="PMA" />
                        <asp:BoundField DataField="SWL" HeaderText="SWL" />
                        <asp:BoundField DataField="COMPANY_VENDOR" HeaderText="Company Vendor" />
                        <asp:BoundField DataField="NO_OF_OPERATOR" HeaderText="No. of Operator" />
                        <asp:BoundField DataField="SDIEM_PIC" HeaderText="SDIEM PIC" />
                        <asp:BoundField DataField="GROUP_PIC" HeaderText="Group PIC" />
                        <asp:BoundField DataField="VALID_UNTIL" HeaderText="Valid until" />

                        <%-- 2. Bucket Condition/ Platform --%>
                        <asp:BoundField DataField="BC_PLATFORM_CTRL" HeaderText="Platform controls" />
                        <asp:BoundField DataField="BC_HANDRAIL_CAGE" HeaderText="Handrail/ Cage Installation" />
                        <asp:BoundField DataField="BC_PLATFORM_ASSY" HeaderText="Platform Assembly" />
                        <asp:BoundField DataField="BC_GATE_COND" HeaderText="Gate Condition" />
                        <asp:BoundField DataField="BC_HARNESS_HELMET" HeaderText="Full body harness & Safety Helmet" />

                        <%-- 3. Engine Appearance Condition --%>
                        <asp:BoundField DataField="EA_HYDRAULIC_LVL" HeaderText="Hydraulic Level" />
                        <asp:BoundField DataField="EA_MOTOR_PUMP" HeaderText="Motor/ Pump unit" />
                        <asp:BoundField DataField="EA_TILT_SWITCH" HeaderText="Tilt switch" />
                        <asp:BoundField DataField="EA_WHEELS_BRAKE" HeaderText="Wheels, Tire, Brake & Parking Brake" />
                        <asp:BoundField DataField="EA_GROUND_CTRL" HeaderText="Ground Controls" />

                        <%-- 4. Warning Devices --%>
                        <asp:BoundField DataField="WD_REV_ALARM" HeaderText="Reversing alarm functioning" />
                        <asp:BoundField DataField="WD_HORN" HeaderText="Horn functioning" />
                        <asp:BoundField DataField="WD_BEACON" HeaderText="Beacon functioning" />
                        <asp:BoundField DataField="WD_LIGHTS" HeaderText="Operational lights functioning" />

                        <%-- 5. Safety Features --%>
                        <asp:BoundField DataField="SF_LIFT_CYLINDER" HeaderText="Lift cylinder" />
                        <asp:BoundField DataField="SF_LIMIT_SWITCH" HeaderText="Limit switch" />
                        <asp:BoundField DataField="SF_SCISSOR_ARM" HeaderText="Scissor arm & Sliding wear pad" />
                        <asp:BoundField DataField="SF_MANUAL_DECENT" HeaderText="Manual decent cable and pull handle" />
                        <asp:BoundField DataField="SF_COMPARTMENT" HeaderText="Compartment cover & linkage" />
                        <%--<asp:BoundField DataField="DEL_FLAG" HeaderText="FLAG" />--%>
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