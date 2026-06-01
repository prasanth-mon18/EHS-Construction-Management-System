<%@ Page Title="High Risk Machinery & Equipment List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MobileCrane.aspx.cs" Inherits="EHS_Construction_Management_System.MobileCrane" EnableEventValidation="false" %>

<asp:Content ID="MobileCrane" ContentPlaceHolderID="HeadContent" runat="server">
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

<asp:Content ID="MobileCraneMain" ContentPlaceHolderID="MainContent" runat="server">

    <!-- MAIN GRID -->
    <asp:Panel ID="pnlMachineryForm" runat="server">
        <%--<h2>High Risk Machinery & Equipment List</h2>--%>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="GridMobileCrane" runat="server" AutoGenerateColumns="False" CellPadding="4"
                GridLines="Both" Width="100%" OnRowCreated="GridMobileCrane_RowCreated" OnRowDataBound="GridMobileCrane_RowDataBound" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" ForeColor="Black">
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

                    <%-- 3. Company Vendor --%>
                    <asp:TemplateField HeaderText="Company Vendor">
                        <ItemStyle Width="160px" />
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGridCompany" runat="server" CssClass="searchable-company" Width="95%"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 4. Operator Name --%>
                    <asp:TemplateField HeaderText="Operator Name">
                        <ItemTemplate>
                            <asp:TextBox ID="txtOperatorName" runat="server" Width="40px" Text='<%# Bind("OPERATOR_NAME") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 5. Operator IC --%>
                    <asp:TemplateField HeaderText="Operator IC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtOperatorIc" runat="server" Width="40px" Text='<%# Bind("OPERATOR_IC") %>'></asp:TextBox>
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

                    <%-- 8. Signalman Name --%>
                    <asp:TemplateField HeaderText="Signalman Name">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSignalmanName" runat="server" Width="40px" Text='<%# Bind("SIGNALMAN_NAME") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 9. Signalman IC --%>
                    <asp:TemplateField HeaderText="Signalman IC">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSignalmanIc" runat="server" Width="40px" Text='<%# Bind("SIGNALMAN_IC") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 10. Date with Calendar Extension Popup --%>
                    <asp:TemplateField HeaderText="Valid until">
                        <ItemTemplate>
                            <asp:TextBox ID="txtValidUntil" runat="server" Width="110px" TextMode="Date" Text='<%# Bind("VALID_UNTIL") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 11. Crane Operating Cabin --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabinCleanOk" runat="server" GroupName='<%# "CabinClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCabinCleanNg" runat="server" GroupName='<%# "CabinClean_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCtrlPanelOk" runat="server" GroupName='<%# "CtrlPanel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCtrlPanelNg" runat="server" GroupName='<%# "CtrlPanel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLoadIndicatorOk" runat="server" GroupName='<%# "LoadIndicator_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                        <asp:RadioButton ID="rbLoadIndicatorNg" runat="server" GroupName='<%# "LoadIndicator_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLoadChartOk" runat="server" GroupName='<%# "LoadChart_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbLoadChartNg" runat="server" GroupName='<%# "LoadChart_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- 12. Body Structure --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBoomStickOk" runat="server" GroupName='<%# "BoomStick_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBoomStickNg" runat="server" GroupName='<%# "BoomStick_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydrauCylOk" runat="server" GroupName='<%# "HydrauCyl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHydrauCylNg" runat="server" GroupName='<%# "HydrauCyl_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForcesLiftOk" runat="server" GroupName='<%# "ForcesLift_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbForcesLiftNg" runat="server" GroupName='<%# "ForcesLift_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBoomAngelOk" runat="server" GroupName='<%# "BoomAngel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBoomAngelNg" runat="server" GroupName='<%# "BoomAngel_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBigBlockOk" runat="server" GroupName='<%# "BigBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBigBlockNg" runat="server" GroupName='<%# "BigBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSmallBlockOk" runat="server" GroupName='<%# "SmallBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSmallBlockNg" runat="server" GroupName='<%# "SmallBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSafetyPinOk" runat="server" GroupName='<%# "SafetyPin_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSafetyPinNg" runat="server" GroupName='<%# "SafetyPin_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHoistLimitOk" runat="server" GroupName='<%# "HoistLimit_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbHoistLimitNg" runat="server" GroupName='<%# "HoistLimit_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAntiBlockOk" runat="server" GroupName='<%# "AntiBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbAntiBlockNg" runat="server" GroupName='<%# "AntiBlock_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWireRopeOk" runat="server" GroupName='<%# "WireRope_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWireRopeNg" runat="server" GroupName='<%# "WireRope_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOuttrgCondOk" runat="server" GroupName='<%# "OuttrgCond_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOuttrgCondNg" runat="server" GroupName='<%# "OuttrgCond_" + Container.DataItemIndex %>' />
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
                            <asp:RadioButton ID="rbBasePlateOk" runat="server" GroupName='<%# "BasePlate_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBasePlateNg" runat="server" GroupName='<%# "BasePlate_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWalkieTalkieOk" runat="server" GroupName='<%# "WalkieTalkie_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbWalkieTalkieNg" runat="server" GroupName='<%# "WalkieTalkie_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

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
                            <asp:RadioButton ID="rbCenterGravityOk" runat="server" GroupName='<%# "CenterGravity_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbCenterGravityNg" runat="server" GroupName='<%# "CenterGravity_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                     <%-- 13. Other specifications --%>
                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTagLinesOk" runat="server" GroupName='<%# "TagLines_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbTagLinesNg" runat="server" GroupName='<%# "TagLines_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSlingingOk" runat="server" GroupName='<%# "Slinging_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbSlingingNg" runat="server" GroupName='<%# "Slinging_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOsWireRopeOk" runat="server" GroupName='<%# "OsWireRope_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbOsWireRopeNg" runat="server" GroupName='<%# "OsWireRope_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBarricadeOk" runat="server" GroupName='<%# "Barricade_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbBarricadeNg" runat="server" GroupName='<%# "Barricade_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="OK">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbInfoBoardOk" runat="server" GroupName='<%# "InfoBoard_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NG">
                        <ItemStyle Width="40px" />
                        <ItemTemplate>
                            <asp:RadioButton ID="rbInfoBoardNg" runat="server" GroupName='<%# "InfoBoard_" + Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" Font-Bold="True" Height="40px" Width="150px" BackColor="#2980B9" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px; margin-right: 15px;" />
        <asp:Button ID="btnSaveMobileCrane" runat="server" Text="Save Machinery Records" OnClick="btnSaveMobileCrane_Click" Font-Bold="True" Height="40px" Width="220px" BackColor="#27AE60" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px;" />
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
                        <asp:BoundField DataField="COMPANY_VENDOR" HeaderText="Company Vendor" />
                        <asp:BoundField DataField="OPERATOR_NAME" HeaderText="Operator Name" />
                        <asp:BoundField DataField="OPERATOR_IC" HeaderText="Operator IC" />
                        <asp:BoundField DataField="SDIEM_PIC" HeaderText="SDIEM PIC" />
                        <asp:BoundField DataField="GROUP_PIC" HeaderText="Group PIC" />
                        <asp:BoundField DataField="SIGNALMAN_NAME" HeaderText="Signalman Name" />
                        <asp:BoundField DataField="SIGNALMAN_IC" HeaderText="Signalman IC" />
                        <asp:BoundField DataField="VALID_UNTIL" HeaderText="Valid until" />


                        <%-- 2. Crane Operating Cabin --%>
                        <asp:BoundField DataField="CYC_CABIN_CLEAN" HeaderText="Cabin Cleanliness" />
                        <asp:BoundField DataField="CYC_CTRL_PANEL" HeaderText="Control panel" />
                        <asp:BoundField DataField="CYC_LOAD_INDICATOR" HeaderText="Load moment indicator" />
                        <asp:BoundField DataField="CYC_LOAD_CHART" HeaderText="Load chart provided" />

                        <%-- 3. Body Structure --%>
                        <asp:BoundField DataField="BS_BOOM_STICK" HeaderText="Boom stick" />
                        <asp:BoundField DataField="BS_HYDRAU_CYL" HeaderText="Hydraulics cylinder" />
                        <asp:BoundField DataField="BS_FORCES_LIFT" HeaderText="Forces lift" />
                        <asp:BoundField DataField="BS_BOOM_ANGEL" HeaderText="Boom angle indicator" />
                        <asp:BoundField DataField="BS_BIG_BLOCK" HeaderText="Big block & hook" />
                        <asp:BoundField DataField="BS_SMALL_BLOCK" HeaderText="Small block & hook" />
                        <asp:BoundField DataField="BS_SAFETY_PIN" HeaderText="Safety pin for hook" />
                        <asp:BoundField DataField="BS_HOIST_LIMIT" HeaderText="Hoist limit switch" />
                        <asp:BoundField DataField="BS_ANTI_BLOCK" HeaderText="Anti 2 block" />
                        <asp:BoundField DataField="BS_WIRE_ROPE" HeaderText="Wire rope termination" />
                        <asp:BoundField DataField="BS_OUTTRG_COND" HeaderText="Outriggers condition" />
                        <asp:BoundField DataField="BS_WHEEL_COND" HeaderText="Wheels condition" />
                        <asp:BoundField DataField="BS_BASE_PLATE" HeaderText="Base plate condition" />
                        <asp:BoundField DataField="BS_WALKIE_TALKIE" HeaderText="Walkie-talkie condition" />
                        <asp:BoundField DataField="BS_BUZZER_NOISE" HeaderText="Buzzer noise function" />
                        <asp:BoundField DataField="BS_AMBER_ALARM" HeaderText="Amber flashing beacon / alarm" />
                        <asp:BoundField DataField="BS_CENTER_GRAVITY" HeaderText="Center of gravity" />

                        <%-- 4. Other specifications --%>
                        <asp:BoundField DataField="OS_TAG_LINES" HeaderText="Tag lines provided" />
                        <asp:BoundField DataField="OS_SLINGING" HeaderText="Slinging" />
                        <asp:BoundField DataField="OS_WIRE_ROPE" HeaderText="Wire rope" />
                        <asp:BoundField DataField="OS_BARRICADE" HeaderText="Barricade" />
                        <asp:BoundField DataField="OS_INFO_BOARD" HeaderText="Information Board" />

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