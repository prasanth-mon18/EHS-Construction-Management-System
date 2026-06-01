<%@ Page Title="High Risk Machinery & Equipment List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BomLift.aspx.cs" Inherits="EHS_Construction_Management_System.BomLift" EnableEventValidation="false" %>

<asp:Content ID="BomLift" ContentPlaceHolderID="HeadContent" runat="server">
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

<asp:Content ID="BomLiftMain" ContentPlaceHolderID="MainContent" runat="server">

    <!-- MAIN GRID -->
    <asp:Panel ID="pnlMachineryForm" runat="server">
        <%--<h2>High Risk Machinery & Equipment List</h2>--%>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="GridBomlift" runat="server" AutoGenerateColumns="False" CellPadding="4" 
                GridLines="Both" Width="100%" OnRowCreated="GridBomlift_RowCreated" OnRowDataBound="GridBomlift_RowDataBound" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" ForeColor="Black">
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

                    <%-- 9. Hydraulic --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCylHydrOk" runat="server" GroupName='<%# "CylHydr_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCylHydr_Ng" runat="server" GroupName='<%# "CylHydr_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForcesFuncOk" runat="server" GroupName='<%# "ForcesFunc_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForcesFuncNg" runat="server" GroupName='<%# "ForcesFunc_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBodyStrucOk" runat="server" GroupName='<%# "BodyStruc_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBodyStrucNg" runat="server" GroupName='<%# "BodyStruc_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 10. Warning Devices --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBuzzerNoiseOk" runat="server" GroupName='<%# "BuzzerNoise_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBuzzerNoiseNg" runat="server" GroupName='<%# "BuzzerNoise_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAmberAlarmOk" runat="server" GroupName='<%# "AmberAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAmberAlarmNg" runat="server" GroupName='<%# "AmberAlarm_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornOk" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHornNg" runat="server" GroupName='<%# "Horn_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 11. Specification --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLockCondOk" runat="server" GroupName='<%# "LockCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLockCondNg" runat="server" GroupName='<%# "LockCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCtrlGearOk" runat="server" GroupName='<%# "CtrlGear_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCtrlGearNg" runat="server" GroupName='<%# "CtrlGear_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbConnectCondOk" runat="server" GroupName='<%# "ConnectCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbConnectCondNg" runat="server" GroupName='<%# "ConnectCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBucketCondOk" runat="server" GroupName='<%# "BucketCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBucketCondNg" runat="server" GroupName='<%# "BucketCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLabelTagOk" runat="server" GroupName='<%# "LabelTag_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLabelTagNg" runat="server" GroupName='<%# "LabelTag_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 12. Engine & Power --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbEngineCondOk" runat="server" GroupName='<%# "EngineCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbEngineCondNg" runat="server" GroupName='<%# "EngineCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMaintCheckOk" runat="server" GroupName='<%# "MaintCheck_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbMaintCheckNg" runat="server" GroupName='<%# "MaintCheck_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbStablzCondOk" runat="server" GroupName='<%# "StablzCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbStablzCondNg" runat="server" GroupName='<%# "StablzCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWheelCondOk" runat="server" GroupName='<%# "WheelCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWheelCondNg" runat="server" GroupName='<%# "WheelCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBrakeFunctOk" runat="server" GroupName='<%# "BrakeFunct_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBrakeFunctNg" runat="server" GroupName='<%# "BrakeFunct_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" Font-Bold="True" Height="40px" Width="150px" BackColor="#2980B9" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px; margin-right: 15px;" />
        <asp:Button ID="btnSaveBomLift" runat="server" Text="Save Machinery Records" OnClick="btnSaveBomLift_Click" Font-Bold="True" Height="40px" Width="220px" BackColor="#27AE60" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px;" />
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

                        <%-- 2. Hydraulic --%>
                        <asp:BoundField DataField="HY_CYLINDER_HYD" HeaderText="Cylinder hydraulic" />
                        <asp:BoundField DataField="HY_FORCES_FUNC" HeaderText="Forces lift/turn/up" />
                        <asp:BoundField DataField="HY_BODY_STRUCTURE" HeaderText="Body structure" />

                        <%-- 3. Warning Devices --%>
                        <asp:BoundField DataField="WD_BUZZER_NOISE" HeaderText="Buzzer noise" />
                        <asp:BoundField DataField="WD_AMBER_ALARM" HeaderText="Amber flashing beacon/ alarm" />
                        <asp:BoundField DataField="WD_HORN" HeaderText="Horn" />

                        <%-- 4. Specification --%>
                        <asp:BoundField DataField="SF_LOCK_COND" HeaderText="Lock in good condition" />
                        <asp:BoundField DataField="SF_CTRL_GEARS" HeaderText="Control panel/ gears" />
                        <asp:BoundField DataField="SF_CONNECTION_COND" HeaderText= "Connection condition" />
                        <asp:BoundField DataField="SF_BUCKET_COND" HeaderText="Bucket condition (Clean)" />
                        <asp:BoundField DataField="SF_LABEL_TAG" HeaderText="Information/ Label/ Safe Tagging" />

                        <%-- 5. Engine & Power --%>
                        <asp:BoundField DataField="EP_ENGINE_COND" HeaderText="Engine condition" />
                        <asp:BoundField DataField="EP_MAINT_CHECK" HeaderText="Maintenance check" />
                        <asp:BoundField DataField="EP_STABILZ_COND" HeaderText="Leg/Stabilisers condition" />
                        <asp:BoundField DataField="EP_TIRES_WHEELS" HeaderText="Tires/wheel condition" />
                        <asp:BoundField DataField="EP_BRAKE_FUNCT" HeaderText="Brake well functioning" />
                        
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