<%@ Page Title="Daily Safety Patrol Result" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default4.aspx.cs" Inherits="EHS_Construction_Management_System.Default4" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

            <asp:Panel ID="pnlPatrol" runat="server" CssClass="form-container" Width="98%">
                <%--<h2>Daily Safety Patrol Result</h2>--%>
                <div style="overflow-x: auto; width: 100%;">
                    <asp:GridView ID="GridPatrol" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        GridLines="Both" Width="100%" OnRowCreated="GridPatrol_RowCreated" OnRowDataBound="GridPatrol_RowDataBound" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" ForeColor="Black">
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

                            <%-- 2. Date with Calendar Extension Popup --%>
                            <asp:TemplateField HeaderText="Date">
                                <ItemStyle Width="130px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDate" runat="server" Width="90%" TextMode="Date" Text='<%# Bind("PATROL_DATE") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 3. Work Area --%>
                            <asp:TemplateField HeaderText="Work Area">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtWorkArea" runat="server" Width="92%" TextMode="MultiLine" Rows="2" Text='<%# Bind("WORK_AREA") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 4. Company Searchable DropDownList --%>
                            <asp:TemplateField HeaderText="Company">
                                <ItemStyle Width="250px" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlGridCompany" runat="server" CssClass="searchable-company"></asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 5. SDIEM PIC --%>
                            <asp:TemplateField HeaderText="SDIEM PIC">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSdiemPic" runat="server" Width="90%" Text='<%# Bind("SDIEM_PIC") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 6. Group PIC --%>
                            <asp:TemplateField HeaderText="Group PIC">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtGroupPic" runat="server" Width="85%" Text='<%# Bind("GROUP_PIC") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 7. Job --%>
                            <asp:TemplateField HeaderText="Job">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtJob" runat="server" Width="92%" TextMode="MultiLine" Rows="2" Text='<%# Bind("JOB_DESC") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 8. PTW Checkbox --%>
                            <asp:TemplateField HeaderText="PTW">
                                <ItemStyle Width="40px" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPtw" runat="server" Checked='<%# Eval("CH_PTW").ToString() == "Y" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 9. DRI Checkbox --%>
                            <asp:TemplateField HeaderText="DRI">
                                <ItemStyle Width="40px" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDri" runat="server" Checked='<%# Eval("CH_DRI").ToString() == "Y" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 10. JSA Checkbox --%>
                            <asp:TemplateField HeaderText="JSA">
                                <ItemStyle Width="40px" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkJsa" runat="server" Checked='<%# Eval("CH_JSA").ToString() == "Y" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 11. SWI Checkbox --%>
                            <asp:TemplateField HeaderText="SWI">
                                <ItemStyle Width="40px" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSwi" runat="server" Checked='<%# Eval("CH_SWI").ToString() == "Y" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 12. PPE OK RadioButton --%>
                            <asp:TemplateField HeaderText="OK">
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:RadioButton ID="rbPpeOk" runat="server" GroupName='<%# "PpeGroup_" + Container.DataItemIndex %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 13. PPE NG RadioButton --%>
                            <asp:TemplateField HeaderText="NG">
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:RadioButton ID="rbPpeNg" runat="server" GroupName='<%# "PpeGroup_" + Container.DataItemIndex %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 14. Equipment OK RadioButton --%>
                            <asp:TemplateField HeaderText="OK">
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:RadioButton ID="rbEqOk" runat="server" GroupName='<%# "EqGroup_" + Container.DataItemIndex %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 15. Equipment NG RadioButton --%>
                            <asp:TemplateField HeaderText="NG">
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:RadioButton ID="rbEqNg" runat="server" GroupName='<%# "EqGroup_" + Container.DataItemIndex %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <br />
                <asp:Button ID="btnAddNewRow" runat="server" Text="+ Add New Row" OnClick="btnAddNewRow_Click" Font-Bold="True" Height="40px" Width="150px" BackColor="#2980B9" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px; margin-right: 15px;" />
                <asp:Button ID="btnSavePatrol" runat="server" Text="Save Patrol Records" OnClick="btnSavePatrol_Click" Font-Bold="True" Height="40px" Width="220px" BackColor="#27AE60" ForeColor="White" BorderStyle="None" Style="cursor: pointer; border-radius: 4px;" />
                <!-- Error Validation Message Banner -->
                <br />
                <br />
                <asp:Label ID="lblValidationError" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="Large"></asp:Label>

                <hr style="margin: 40px 0; border: 1px solid #ccc;" />

                <!-- Bottom Results Section -->
                <asp:Panel ID="pnlHistory" runat="server" Width="100%">
                    <h3>Saved Patrol Results Log</h3>

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
                            <RowStyle Height="35px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <Columns>
                                <%-- 1. No --%>
                            <asp:TemplateField HeaderText="No">
                                <ItemStyle Width="40px" Font-Bold="true" />
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" Visible="false"  />
                                <asp:BoundField DataField="PATROL_DATE" HeaderText="DATE" />
                                <asp:BoundField DataField="WORK_AREA" HeaderText="WORK AREA" />
                                <asp:BoundField DataField="COMPANY" HeaderText="COMPANY" />
                                <asp:BoundField DataField="SDIEM_PIC" HeaderText="SDIEM PIC" />
                                <asp:BoundField DataField="GROUP_PIC" HeaderText="GROUP PIC" />
                                <asp:BoundField DataField="JOB_DESC" HeaderText="JOB DESCRIPTION" />
                                <asp:BoundField DataField="CH_PTW" HeaderText="PTW" />
                                <asp:BoundField DataField="CH_DRI" HeaderText="DRI" />
                                <asp:BoundField DataField="CH_JSA" HeaderText="JSA" />
                                <asp:BoundField DataField="CH_SWI" HeaderText="SWI" />
                                <asp:BoundField DataField="PPE_OK" HeaderText="OK" />
                                <asp:BoundField DataField="PPE_NG" HeaderText="NG" />
                                <asp:BoundField DataField="EQ_OK" HeaderText="OK" />
                                <asp:BoundField DataField="EQ_NG" HeaderText="NG" />
                                <%--<asp:BoundField DataField="DEL_FLAG" HeaderText="FLAG" />--%>
                                <asp:TemplateField HeaderText="ACTIONS">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" BackColor="#C0392B" ForeColor="White" BorderStyle="None" Height="25px" Width="60px" OnClientClick="return confirm('Are you sure want to DELETE?');" />
                                        <asp:Button ID="btnRestore" runat="server" CommandName="RestoreRecord" Text="Restore" CommandArgument='<%# Eval("ID") %>' BackColor="#27AE60" ForeColor="White" BorderStyle="None" Height="25px" Width="60px" OnClientClick="return confirm('Are you sure want to RESTORE?');"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </asp:Panel>

</asp:Content>