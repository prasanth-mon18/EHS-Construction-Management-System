<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EHS_Construction_Management_System.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MF1 Vendor TBM Daily Attendance</title>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        body {
            background-color: #DDFFFF;
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
            color: #ffffff;
            background-color: #008080;
        }
        /* CSS to change the GridLines color */
        .Grid, .Grid th, .Grid td {
            border: 1px solid #000000;
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

            .transparent-style{
  background-color: lightgray;
  opacity: 0.3;
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

    </style>
</head>
<body>
    <form id="form1" runat="server" style="overflow: auto">
        <div>
            <asp:Panel ID="Panel1" runat="server" Width="100%" Height="200px" HorizontalAlign="center" CssClass="inlineBlock" Font-Bold="True" ForeColor="Black" Wrap="False" BackColor="#B3FFFF">
                <asp:Label ID="Label1" runat="server" Text="Construction Vendor Daily Attendance" Font-Bold="True" Font-Italic="False" Font-Size="99px" Height="100px" Style="text-align: center; text-shadow: 2px 2px 4px #ffffff" Width="100%" Font-Names="Arial" Font-Overline="False" ForeColor="Black" BorderStyle="None" Font-Strikeout="False"></asp:Label>
                <br />
                <br />
                <asp:TextBox ID="ScanHere" Style="text-align: center" CssClass="transparent-style" runat="server" BorderStyle="None" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" Height="45px" Width="29%" OnTextChanged="ScanHere_TextChanged">Scan HERE !!!!</asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Scan IN !!!!" OnClick="Button1_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="TextBox2" Style="text-align: center" CssClass="transparent-style" runat="server" BorderStyle="None" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" Height="45px" Width="29%" OnTextChanged="TextBox2_TextChanged">Scan HERE !!!!</asp:TextBox>
                <asp:Button ID="Button2" runat="server" Text="Scan OUT !!!!" OnClick="Button2_Click" />
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server" HorizontalAlign="left" Width="69%" Height="250px" CssClass="floatLeft" Font-Bold="True" ForeColor="Black" Wrap="False">
                <br />
                <asp:Label ID="Label3" runat="server" Text="Name : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
                <asp:TextBox ID="emp_name" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="1000px" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" Text="IC/Passport : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
                <asp:TextBox ID="ic_no" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="1000px" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" Text="Company : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="50px" Width="250px"></asp:Label>
                <asp:TextBox ID="comp_name" runat="server" Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="1000px" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
            </asp:Panel>
            <asp:Panel ID="Panel3" runat="server" CssClass="floatRight" HorizontalAlign="Center" Width="29%" Font-Bold="True" ForeColor="Black" Wrap="False">
                <asp:Label ID="Label2" runat="server" Text="Plant : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="100px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True" Text="MF1"></asp:TextBox>

                <br />
                <br />
                <asp:Label ID="Label10" runat="server" Text="Total Company : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black"></asp:Label>
                <asp:TextBox ID="total_comp" runat="server" Style="text-align: center" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="100px" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label12" runat="server" Text="Total Headcount : " Style="text-align: left" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black"></asp:Label>
                <asp:TextBox ID="total_hc" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="XX-Large" ForeColor="Black" Height="45px" Width="100px" Style="text-align: center" BorderStyle="None" AutoPostBack="True" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
            </asp:Panel>
            <asp:Panel ID="Panel4" runat="server" CssClass="floatLeft" HorizontalAlign="center" Width="99%" Direction="LeftToRight" ScrollBars="Auto">
                <asp:GridView ID="GridView1" runat="server" CssClass="Grid" HorizontalAlign="Center" AutoGenerateColumns="False" CellPadding="4" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="20" OnRowDataBound="GridView1_RowDataBound">
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
                        <asp:BoundField DataField="DATE_TIME_IN" HeaderText="IN" />
                        <asp:BoundField DataField="CMF_1" HeaderText="OUT" />
                        <asp:BoundField DataField="EMP_NAME" HeaderText="NAME" />
                        <asp:BoundField DataField="IC_NO" HeaderText="IC/PASSPORT" />
                        <asp:BoundField DataField="COMP_NAME" HeaderText="COMPANY" />
                        <asp:BoundField DataField="CMF_4" HeaderText="CIDB COMPETENCY" />
                        <asp:BoundField DataField="STATUS" HeaderText="WORK PASS STATUS" />
                        <asp:BoundField DataField="WORK_WEEK" HeaderText="WEEK" />
                        <asp:BoundField DataField="WRKSTS" HeaderText="STATUS"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <br />
                <br />
            <asp:ImageButton ID="ImageButton2" runat="server" CssClass="floatRight" Height="20px" Width="20px" OnClick="ImageButton2_Click" ImageUrl="~/Images/filing.png" />
        </div>
    </form>
</body>
</html>
