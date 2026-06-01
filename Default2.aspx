<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default2.aspx.cs" Inherits="EHS_Construction_Management_System.Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SDIEM Vendor Master Data</title>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style type="text/css">
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
            color: #ffff;
            background-color: #008080;
            display: none;
        }
        /* CSS to change the GridLines color */
        .Grid, .Grid th, .Grid td {
            border: 1px solid #000000;
            display: none;
        }

        .container {
            margin: 200px auto;
            background: #fff;
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

        .transparent-style {
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

        body {
            background-color: #C1FFFF;
        }

        .blink2 {
            animation: blinker 1.5s linear infinite;
            color: red;
            font-family: sans-serif;
        }

        @keyframes blinker {
            50% {
                opacity: 0;
            }
        }

        .blink {
            animation: blinker 1s step-start infinite;
            text-decoration:blink;
        }

        @keyframes blinker {
            50% {
                opacity: 0;
            }
        }
    </style>
    <style>
        #Blink1 {
            font-size: 20px;
            font-weight: bold;
            color: #2d38be;
            transition: 0.5s;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" runat="server" Width="100%" Height="115px" HorizontalAlign="center" CssClass="inlineBlock" Font-Bold="True" ForeColor="Black" Wrap="False" BackColor="#C1FFFF">
                <asp:Label ID="Label1" runat="server" Text="Construction Vendor Master Data" Font-Bold="True" Font-Italic="False" Font-Size="100px" Height="100px" Style="text-align: center; text-shadow: 2px 2px 4px #ffffff" Width="99%" Font-Names="Arial" Font-Overline="False" ForeColor="Black" BorderStyle="Groove" Font-Strikeout="False" BackColor="#CCCFFF" BorderColor="#CCCFFF"></asp:Label>
            </asp:Panel>
        </div>
        <div style="width: 49%" class="inlineBlock">
            <asp:Label ID="Label2" runat="server" Text="Register New Vendor" Font-Bold="True" Font-Italic="False" Font-Size="50px" Height="100px" Style="text-align: left; text-shadow: 2px 2px 4px #ffffff" Width="100%" Font-Names="Arial" Font-Overline="False" ForeColor="Black" BorderStyle="None" Font-Strikeout="False"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Name : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="emp_name2" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="IC/Passport : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="ic_no2" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" Text="Company : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="V1" DataValueField="V1" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" AutoPostBack="True">
                <asp:ListItem Selected="True" Value="0">COMPANY LIST</asp:ListItem>
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnGMS %>" ProviderName="<%$ ConnectionStrings:OracleConnGMS.ProviderName %>" SelectCommand="SELECT &quot;V1&quot; FROM &quot;GA_MASTER&quot; WHERE (&quot;TABLE_NAME&quot; = :TABLE_NAME) ORDER BY &quot;V1&quot;">
                <SelectParameters>
                    <asp:Parameter DefaultValue="VENDOR_ATT_MST" Name="TABLE_NAME" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:CheckBox ID="CheckBox3" runat="server" Checked="false" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" OnCheckedChanged="CheckBox3_CheckedChanged" Text="New Company" AutoPostBack="True" />
            <asp:TextBox ID="TextBox9" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="330px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Work Pass Details" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="500px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label10" runat="server" Text="Exp. Date : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="Exp_Date" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="330px" ReadOnly="True"></asp:TextBox>
            <asp:ImageButton ID="ImageButton3" runat="server" Height="50px" ImageUrl="~/Images/calendar.png" Width="50px" OnClick="ImageButton3_Click" TabIndex="-1" />
            <asp:Calendar ID="Calendar2" runat="server" OnSelectionChanged="Calendar2_SelectionChanged" Visible="false" DayNameFormat="FirstTwoLetters" CssClass="floatRight" Style="z-index: 1">
                <OtherMonthDayStyle ForeColor="#CCCCCC" />
                <SelectedDayStyle Font-Bold="False" />
                <TodayDayStyle BackColor="White" Font-Bold="True" />
            </asp:Calendar>
            <br />
            <br />
            <asp:CheckBox ID="CheckBox1" runat="server" Checked="false" Font-Bold="True" Font-Names="Calibri" OnCheckedChanged="CheckBox1_CheckedChanged" Text="Don't have CIDB ? (Tick if YES)" AutoPostBack="True" />
            <br />
            <asp:Label ID="Label8" runat="server" Text="CIDB : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="CIDB" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="330px" ReadOnly="True"></asp:TextBox>
            <asp:ImageButton ID="ImageButton4" runat="server" Height="50px" ImageUrl="~/Images/calendar.png" Width="50px" OnClick="ImageButton4_Click1" TabIndex="-1" />
            <asp:Calendar ID="Calendar3" runat="server" OnSelectionChanged="Calendar3_SelectionChanged" Visible="false" DayNameFormat="FirstTwoLetters" CssClass="floatRight" Style="z-index: 1">
                <OtherMonthDayStyle ForeColor="#CCCCCC" />
                <SelectedDayStyle Font-Bold="False" />
                <TodayDayStyle BackColor="White" Font-Bold="True" />
            </asp:Calendar>
            <br />
            <asp:Label ID="Label19" runat="server" Text="CIDB Competency : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:DropDownList ID="DropDownList3" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" AutoPostBack="True" DataSourceID="SqlDataSource2" DataValueField="V1" DataTextField="V1"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnGMS %>" ProviderName="<%$ ConnectionStrings:OracleConnGMS.ProviderName %>" SelectCommand="SELECT &quot;V1&quot; FROM &quot;GA_MASTER&quot; WHERE (&quot;TABLE_NAME&quot; = :TABLE_NAME) ORDER BY &quot;V1&quot;">
                <SelectParameters>
                    <asp:Parameter DefaultValue="CIDB" Name="TABLE_NAME" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Enter" CssClass="button" BackColor="#6600CC" BorderStyle="Groove" Font-Bold="True" Height="50px" Width="100px" Font-Names="Arial Black" Font-Size="10" ForeColor="White" />
            &nbsp
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Reset" CssClass="button" BackColor="#6600CC" BorderStyle="Groove" Font-Bold="True" Height="50px" Width="100px" Font-Names="Arial Black" Font-Size="10" ForeColor="White" />
            <br />
            <br />
        </div>
        <div style="width: 49%" class="inlineBlock">
            <asp:Label ID="Label6" runat="server" Text="Work Pass Renewal" Font-Bold="True" Font-Italic="False" Font-Size="50px" Height="100px" Style="text-align: left; text-shadow: 2px 2px 4px #ffffff" Width="100%" Font-Names="Arial" Font-Overline="False" ForeColor="Black" BorderStyle="None" Font-Strikeout="False"></asp:Label>
            <asp:Label ID="Label12" runat="server" Text="IC/Passport : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" OnTextChanged="TextBox3_TextChanged" AutoPostBack="True"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="Name : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" ReadOnly="true"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label13" runat="server" Text="Company : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox6" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" ReadOnly="true"></asp:TextBox>
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="V1" DataValueField="V1" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" AutoPostBack="True">
                <asp:ListItem Selected="True" Value="0">COMPANY LIST</asp:ListItem>
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <asp:CheckBox ID="CheckBox4" runat="server" Checked="false" Font-Bold="True" Font-Names="Arial Black" OnCheckedChanged="CheckBox4_CheckedChanged" Text="Change" AutoPostBack="true" Font-Size="Large" ForeColor="Black" />
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" Text="W_Pass Exp : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox7" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" ReadOnly="true"></asp:TextBox>
            <asp:Label ID="Blink1" CssClass="blink" runat="server" Text="Renew !!!" Font-Bold="True" Font-Names="Arial Black" Font-Size="X-Large" ForeColor="Red" Visible="False"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label17" runat="server" Text="CIDB Exp : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox8" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" ReadOnly="true" onkeydown="return (event.keyCode!=13)"></asp:TextBox>
            <asp:Label ID="Blink2" CssClass="blink" runat="server" Text="Renew !!!" Font-Bold="True" Font-Names="Arial Black" Font-Size="X-Large" ForeColor="Red" Visible="False"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Exp. Date : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="330px" ReadOnly="True"></asp:TextBox>
            <asp:ImageButton ID="ImageButton6" runat="server" Height="50px" ImageUrl="~/Images/calendar.png" Width="50px" OnClick="ImageButton6_Click1" />
            <asp:Calendar ID="Calendar5" runat="server" OnSelectionChanged="Calendar5_SelectionChanged" Visible="false" DayNameFormat="FirstTwoLetters" CssClass="floatRight">
                <OtherMonthDayStyle ForeColor="#CCCCCC" />
                <SelectedDayStyle Font-Bold="False" />
                <TodayDayStyle BackColor="White" Font-Bold="True" />
            </asp:Calendar>
            <br />
            <br />
            <asp:CheckBox ID="CheckBox2" runat="server" Checked="false" Font-Bold="True" Font-Names="Calibri" OnCheckedChanged="CheckBox2_CheckedChanged" Text="Don't have CIDB ? (Tick if YES)" AutoPostBack="True" />
            <br />
            <asp:Label ID="Label16" runat="server" Text="CIDB : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:TextBox ID="TextBox5" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="330px" ReadOnly="True"></asp:TextBox>
            <asp:ImageButton ID="ImageButton5" runat="server" Height="50px" ImageUrl="~/Images/calendar.png" Width="50px" OnClick="ImageButton5_Click1" />
            <asp:Calendar ID="Calendar4" runat="server" OnSelectionChanged="Calendar4_SelectionChanged" Visible="false" DayNameFormat="FirstTwoLetters" CssClass="floatRight">
                <OtherMonthDayStyle ForeColor="#CCCCCC" />
                <SelectedDayStyle Font-Bold="False" />
                <TodayDayStyle BackColor="White" Font-Bold="True" />
            </asp:Calendar>
            <br />
            <asp:Label ID="Label20" runat="server" Text="CIDB Competency : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
            <asp:DropDownList ID="DropDownList4" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="500px" AutoPostBack="True" DataSourceID="SqlDataSource2" DataValueField="V1" DataTextField="V1"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnGMS %>" ProviderName="<%$ ConnectionStrings:OracleConnGMS.ProviderName %>" SelectCommand="SELECT &quot;V1&quot; FROM &quot;GA_MASTER&quot; WHERE (&quot;TABLE_NAME&quot; = :TABLE_NAME) ORDER BY &quot;V1&quot;">
                <SelectParameters>
                    <asp:Parameter DefaultValue="CIDB" Name="TABLE_NAME" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Enter" CssClass="button" BackColor="#6600CC" BorderStyle="Groove" Font-Bold="True" Height="50px" Width="100px" Font-Names="Arial Black" Font-Size="10" ForeColor="White" />
            &nbsp
                <asp:Button ID="Button5" runat="server" OnClick="Button3_Click" Text="Reset" CssClass="button" BackColor="#6600CC" BorderStyle="Groove" Font-Bold="True" Height="50px" Width="100px" Font-Names="Arial Black" Font-Size="10" ForeColor="White" />

            <br />
        </div>
        <div>
            <asp:Panel ID="Panel3" runat="server" Visible="true">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageAlign="Left" OnClick="ImageButton1_Click" Height="50px" ImageUrl="~/Images/xls.png" Width="50px" />
                <asp:ImageButton ID="ImageButton7" runat="server" ImageAlign="Left" OnClick="ImageButton7_Click" Height="50px" ImageUrl="~/Images/calendar.png" Width="50px" />
                <asp:Label ID="Label4" runat="server" BorderStyle="None" Font-Bold="True" Font-Italic="False" Font-Names="Arial" Font-Overline="False" Font-Size="30px" Font-Strikeout="False" ForeColor="Black" Height="50px" Style="text-align: left; text-shadow: 2px 2px 4px #ffffff" Text="Attendance Download" Width="50%"></asp:Label>
                <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Visible="false" DayNameFormat="FirstTwoLetters">
                    <OtherMonthDayStyle ForeColor="#CCCCCC" />
                    <SelectedDayStyle Font-Bold="False" />
                    <TodayDayStyle BackColor="White" Font-Bold="True" />
                </asp:Calendar>
                <br />
                <asp:ImageButton ID="ImageButton8" runat="server" ImageAlign="Left" OnClick="ImageButton8_Click" Height="50px" ImageUrl="~/Images/xls.png" Width="50px" />
                <asp:Label ID="Label18" runat="server" BorderStyle="None" Font-Bold="True" Font-Italic="False" Font-Names="Arial" Font-Overline="False" Font-Size="30px" Font-Strikeout="False" ForeColor="Black" Height="50px" Style="text-align: left; text-shadow: 2px 2px 4px #ffffff" Text="Vendor Master Data" Width="50%"></asp:Label>
                <br />

                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="false" CssClass="Grid" Font-Names="Calibri" Font-Size="Large" HorizontalAlign="Center" OnPageIndexChanging="OnPageIndexChanging" PageSize="20">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                No.
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ATT_DATE" HeaderText="DATE" />
                        <asp:BoundField DataField="DATE_TIME_IN" HeaderText="TIME IN" />
                        <asp:BoundField DataField="CMF_1" HeaderText="TIME OUT" />
                        <asp:BoundField DataField="EMP_NAME" HeaderText="NAME" />
                        <asp:BoundField DataField="IC_NO" HeaderText="IC/PASSPORT" />
                        <asp:BoundField DataField="COMP_NAME" HeaderText="COMPANY" />
                        <asp:BoundField DataField="WORK_WEEK" HeaderText="WEEK" />
                    </Columns>
                </asp:GridView>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" Font-Names="Calibri" Font-Size="Large" HorizontalAlign="Center" OnPageIndexChanging="OnPageIndexChanging" PageSize="20">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                No.
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IC_NO" HeaderText="IC/PASSPORT" />
                        <asp:BoundField DataField="COMP_NAME" HeaderText="COMPANY" />
                        <asp:BoundField DataField="EMP_NAME" HeaderText="NAME" />
                        <asp:BoundField DataField="CMF_1" HeaderText="STATUS" />
                        <asp:BoundField DataField="CMF_2" HeaderText="GREEN CARD" />
                        <asp:BoundField DataField="CMF_3" HeaderText="CIDB" />
                        <asp:BoundField DataField="CMF_4" HeaderText="CIDB Competency" />
                    </Columns>
                </asp:GridView>
                <asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
                <asp:ImageButton ID="ImageButton2" runat="server" CssClass="floatRight" Height="20px" Width="20px" OnClick="ImageButton2_Click" ImageUrl="~/Images/filing.png" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>