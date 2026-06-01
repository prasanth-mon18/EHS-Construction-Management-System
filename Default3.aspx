<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default3.aspx.cs" Inherits="EHS_Construction_Management_System.Default3" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SDIEM VENDOR STATISTIC</title>
        <style type="text/css">
            
            body {
            /*background-color: #FFFFFF;*/
        }
            .inlineBlock {
            display: inline-block;
        }

        .floatLeft {
            float: left;
        }

        .floatRight {
            float: right;
        }

        .Grid th {
            /*color: #000000;
            background-color: #FFFFFFS;*/
        }
        /* CSS to change the GridLines color */
        .Grid, .Grid th, .Grid td {
            border: 1px solid #000000;
        }

        .container {
            margin: 200px auto;
            background: #ffffff;
            height: 30px;
            border-radius: 30px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: 0.8s;
            box-shadow: 0 0 25px 0 rgba(0, 0, 0, 0.4);
        }

            .container:hover .input {
                width: 250px;
            }

            .container .input {
                background: transparent;
                border: none;
                outline: none;
                width: 0px;
                font-weight: 500;
                font-size: 16px;
                transition: 0.8s;
            }

            .container .btn .fas {
                color: #aa00ff;
            }

        .button {
            position: relative;
            /*width: 82px;*/
            text-align: center;
            /*font-size: 20px;*/
            font-family: poppins;
            font-weight: 400;
            text-transform: uppercase;
            letter-spacing: 8px;
            /*padding: 20px;*/
            color: #7CFC00;
            border: 3px solid #7CFC00;
            border-radius: 100px;
            transition: 1.5s;
            top: 0px;
            left: 0px;
            height: 24px;
        }

            .button:hover {
                box-shadow: 0px 5px 40px 0 #7CFC00 inset, 0px 5px 40px 0 #7CFC00, 0px 5px 40px 0 #7CFC00 inset, 0px 5px 40px 0 #7CFC00;
                text-shadow: 0 0 5px #7CFC00,0 0 5px #7CFC00;
            }

        .example_e {
            border: none;
            background-color: none;
            color: #000000;
            /*font-weight: 100;
            padding: 20px;
            text-transform: uppercase;*/
            border-radius: 6px;
            display: inline-block;
            /*transition: all 0.3s ease 0s;
            width: 200px;*/
            cursor: pointer;
        }

            .example_e:hover {
                color: #000000 !important;
                font-weight: 800 !important;
                letter-spacing: 1px;
                background: white !important;
                -webkit-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
                -moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
                transition: all 0.3s ease 0s;
            }

        .buttonstyle {
            float: left;
            border: none;
            /*background-color: none;*/
            color: #006400;
            /*font-weight: 100;
            padding: 20px;
            text-transform: uppercase;*/
            border-radius: 6px;
            display: inline-block;
            /*transition: all 0.3s ease 0s;
            width: 200px;*/
            cursor: pointer;
        }

            .buttonstyle:hover {
                /*color: #000000 !important;*/
                font-weight: 800 !important;
                letter-spacing: 1px;
                /*background: #006400 !important;*/
                -webkit-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.6);
                -moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.6);
                transition: all 0.3s ease 0s;
                /* Start the shake animation and make the animation last for 0.5 seconds */
                animation: shake 0.5s;
                /* When the animation is finished, start again */
                animation-iteration-count: infinite;
            }

            .transparent-style{
  background-color: rgba(255, 255, 255, .4);
}

        @keyframes shake {
            0% {
                transform: translate(1px, 1px) rotate(0deg);
            }

            10% {
                transform: translate(-1px, -2px) rotate(-1deg);
            }

            20% {
                transform: translate(-3px, 0px) rotate(1deg);
            }

            30% {
                transform: translate(3px, 2px) rotate(0deg);
            }

            40% {
                transform: translate(1px, -1px) rotate(1deg);
            }

            50% {
                transform: translate(-1px, 2px) rotate(-1deg);
            }

            60% {
                transform: translate(-3px, 1px) rotate(0deg);
            }

            70% {
                transform: translate(3px, 1px) rotate(-1deg);
            }

            80% {
                transform: translate(-1px, -1px) rotate(1deg);
            }

            90% {
                transform: translate(1px, 2px) rotate(0deg);
            }

            100% {
                transform: translate(1px, -2px) rotate(-1deg);
            }
        }
            .floatRight {}
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" runat="server" Width="100%" Height="110px" HorizontalAlign="center" CssClass="inlineBlock" Font-Bold="True" ForeColor="Black" Wrap="False">
                <asp:Label ID="Label1" runat="server" Text="SDIEM VENDOR STATISTIC" Font-Bold="True" Font-Italic="False" Font-Size="100px" Height="100px" Style="text-align: center; text-shadow: 2px 2px 4px #ffffff" Width="99%" Font-Names="Arial" Font-Overline="False" ForeColor="Black" BorderStyle="Groove" Font-Strikeout="False" BackColor="#E7F5FE" BorderColor="#E7F5FE"></asp:Label>
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server" Width="49%" Height="100%" HorizontalAlign="center" CssClass="floatLeft" Font-Bold="True" ForeColor="Black" Wrap="False">
                <asp:Panel ID="Panel3" runat="server" Width="49%" Height="90%" CssClass="floatLeft">
                    <br />
                    <asp:TextBox ID="TextBox1" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="48px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True">MF1</asp:TextBox>
                    <asp:TextBox ID="TextBox2" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="48px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True">MF2</asp:TextBox>
                    <br />
                    <asp:TextBox ID="total_comp" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="52px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="total_comp2" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="52px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Total Company" Style="text-align: center" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="80px" Width="300px"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="Panel4" runat="server" Width="49%" Height="90%" CssClass="inlineBlock">
                    <br />
                    <asp:TextBox ID="TextBox3" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="48px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True">MF1</asp:TextBox>
                    <asp:TextBox ID="TextBox4" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="48px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True">MF2</asp:TextBox>
                    <br />
                    <asp:TextBox ID="total_hc" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="52px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="total_hc2" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="35" ForeColor="Black" Height="52px" Width="175px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label12" runat="server" Text="Total Headcount" Style="text-align: center" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="80px" Width="300px"></asp:Label>
                </asp:Panel>               
                <asp:Panel ID="Panel5" runat="server" HorizontalAlign="center" CssClass="floatLeft" Font-Bold="True" ForeColor="Black" Wrap="False">
                    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Width="900px" Height="300px" Palette="Pastel" BackImageTransparentColor="221, 255, 255">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="ATT_DATE" YValueMembers="HEAD_COUNT" IsXValueIndexed="True" Font="Arial Rounded MT Bold, 12pt" IsValueShownAsLabel="True" XValueType="Single" YValueType="Single"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY>
                                    <MajorGrid Enabled="False" />
                                </AxisY>
                                <AxisX>
                                    <MajorGrid Enabled="false" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="DAILY ATTENDANCE" Font="Arial Rounded MT Bold, 26pt" Text="DAILY ATTENDANCE"></asp:Title>
                        </Titles>
                    </asp:Chart>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnGMS %>" ProviderName="<%$ ConnectionStrings:OracleConnGMS.ProviderName %>" SelectCommand="SELECT ATT_DATE,COUNT (*) AS HEAD_COUNT from VENDOR_ATT_DATA
WHERE ATT_DATE BETWEEN (SELECT (TO_CHAR (SYSDATE-6,'YYYYMMDD')) FROM DUAL) AND (SELECT (TO_CHAR (SYSDATE,'YYYYMMDD')) FROM DUAL) AND FACTORY IN ('PJ5C','PJ5E')
GROUP BY ATT_DATE
ORDER BY ATT_DATE ASC"></asp:SqlDataSource>
                </asp:Panel>
                <%--<br />--%>
                <asp:Panel ID="Panel7" runat="server" HorizontalAlign="center" CssClass="floatLeft" Font-Bold="True" ForeColor="Black" Wrap="False">
                    <asp:Chart ID="Chart3" runat="server" DataSourceID="SqlDataSource3" Width="900px" Palette="Excel" BackImageTransparentColor="221, 255, 255">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="REG_TIME" YValueMembers="HEAD_COUNT" IsXValueIndexed="True" Font="Arial Rounded MT Bold, 12pt" IsValueShownAsLabel="True" XValueType="Single" YValueType="Single"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY>
                                    <MajorGrid Enabled="False" />
                                </AxisY>
                                <AxisX>
                                    <MajorGrid Enabled="false" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="DAILY SAFETY INDUCTION" Font="Arial Rounded MT Bold, 26pt" Text="DAILY SAFETY INDUCTION"></asp:Title>
                        </Titles>
                    </asp:Chart>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnGMS %>" ProviderName="<%$ ConnectionStrings:OracleConnGMS.ProviderName %>"
                        SelectCommand="SELECT REG_TIME,COUNT (*) AS HEAD_COUNT from VENDOR_ATT_MST
WHERE REG_TIME BETWEEN (SELECT (TO_CHAR (SYSDATE-6,'YYYYMMDD')) FROM DUAL) AND (SELECT (TO_CHAR (SYSDATE,'YYYYMMDD')) FROM DUAL) AND FACTORY IS NULL
GROUP BY REG_TIME
ORDER BY REG_TIME ASC"></asp:SqlDataSource>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="Panel6" runat="server" Width="24%" Height="100%" HorizontalAlign="center" CssClass="floatLeft" Font-Bold="True" ForeColor="Black" Wrap="False">
                <asp:Label ID="Label3" runat="server" Text="MF1 DAILY HEADCOUNT" Font-Bold="True" Style="text-align: left" Font-Names="Arial Black" Font-Size="XX-Large" Height="50px"></asp:Label>
                <br />
                <asp:GridView ID="GridView1" runat="server" CssClass="Grid" HorizontalAlign="left" AutoGenerateColumns="False" CellPadding="4" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large" AllowPaging="True" OnPageIndexChanging="OnPageIndexChanging1" PageSize="17">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                No.
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="COMP_NAME" HeaderText="COMPANY" />
                        <asp:BoundField DataField="HEADCOUNT" HeaderText="HEADCOUNT" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>            
            <asp:Panel ID="Panel8" runat="server" Width="24%" Height="100%" HorizontalAlign="center" CssClass="floatRight" Font-Bold="True" ForeColor="Black" Wrap="False">
                <asp:Label ID="Label4" runat="server" Text="MF2 DAILY HEADCOUNT" Font-Bold="True" Style="text-align: left" Font-Names="Arial Black" Font-Size="XX-Large" Height="50px"></asp:Label>
                <br />
                <asp:GridView ID="GridView2" runat="server" CssClass="Grid" HorizontalAlign="left" AutoGenerateColumns="False" CellPadding="4" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large" AllowPaging="True" OnPageIndexChanging="OnPageIndexChanging2" PageSize="17">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                No.
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="COMP_NAME" HeaderText="COMPANY" />
                        <asp:BoundField DataField="HEADCOUNT" HeaderText="HEADCOUNT" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </div>
    </form>
</body>
</html>