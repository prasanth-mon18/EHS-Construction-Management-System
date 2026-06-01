using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;

namespace EHS_Construction_Management_System
{
    public partial class MobileCrane : System.Web.UI.Page
    {
        string connString = System.Configuration.ConfigurationManager.ConnectionStrings["OracleConnGMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeEmptyRows();
                BindHistoryLog();
            }
        }

        private void InitializeEmptyRows()
        {
            DataTable dt = CreateMobileCraneStructure();

            // Generate 1 clean, completely empty default row layout
            DataRow dr = dt.NewRow();
            SetDefaultRowFlags(dr);
            dt.Rows.Add(dr);

            ViewState["CurrentMobileCraneData"] = dt;
            BindGridData();
        }

        private DataTable CreateMobileCraneStructure()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PMA");
            dt.Columns.Add("COMPANY_VENDOR");
            dt.Columns.Add("OPERATOR_NAME");
            dt.Columns.Add("OPERATOR_IC");
            dt.Columns.Add("SDIEM_PIC");
            dt.Columns.Add("GROUP_PIC");
            dt.Columns.Add("SIGNALMAN_NAME");
            dt.Columns.Add("SIGNALMAN_IC");
            dt.Columns.Add("VALID_UNTIL");

            string[] flags = {
                "CYC_CABIN_CLEAN", "CYC_CTRL_PANEL", "CYC_LOAD_INDICATOR", "CYC_LOAD_CHART", 
                "BS_BOOM_STICK", "BS_HYDRAU_CYL", "BS_FORCES_LIFT", "BS_BOOM_ANGEL", "BS_BIG_BLOCK", "BS_SMALL_BLOCK", "BS_SAFETY_PIN", "BS_HOIST_LIMIT", "BS_ANTI_BLOCK", "BS_WIRE_ROPE", "BS_OUTTRG_COND", "BS_WHEEL_COND", "BS_BASE_PLATE", "BS_WALKIE_TALKIE", "BS_BUZZER_NOISE", "BS_AMBER_ALARM", "BS_CENTER_GRAVITY", 
                "OS_TAG_LINES", "OS_SLINGING", "OS_WIRE_ROPE", "OS_BARRICADE", "OS_INFO_BOARD", "DEL_FLAG", "CREATED_DATE", "UPDATED_DATE"
            };
            foreach (string flag in flags) { dt.Columns.Add(flag); }
            return dt;
        }

        private void SetDefaultRowFlags(DataRow dr)
        {
            string[] flags = {
                "CYC_CABIN_CLEAN", "CYC_CTRL_PANEL", "CYC_LOAD_INDICATOR", "CYC_LOAD_CHART",
                "BS_BOOM_STICK", "BS_HYDRAU_CYL", "BS_FORCES_LIFT", "BS_BOOM_ANGEL", "BS_BIG_BLOCK", "BS_SMALL_BLOCK", "BS_SAFETY_PIN", "BS_HOIST_LIMIT", "BS_ANTI_BLOCK", "BS_WIRE_ROPE", "BS_OUTTRG_COND", "BS_WHEEL_COND", "BS_BASE_PLATE", "BS_WALKIE_TALKIE", "BS_BUZZER_NOISE", "BS_AMBER_ALARM", "BS_CENTER_GRAVITY",
                "OS_TAG_LINES", "OS_SLINGING", "OS_WIRE_ROPE", "OS_BARRICADE", "OS_INFO_BOARD", "DEL_FLAG", "CREATED_DATE", "UPDATED_DATE"
            };

            foreach (string flag in flags) { dr[flag] = ""; }
        }

        private void BindGridData()
        {
            DataTable dt = (DataTable)ViewState["CurrentMobileCraneData"];
            GridMobileCrane.DataSource = dt;
            GridMobileCrane.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "initSelect2MobileCrane", "initSearchableDropdowns();", true);
        }

        protected void btnAddNewRow_Click(object sender, EventArgs e)
        {
            DataTable dt = CreateMobileCraneStructure();

            // Harvest text and radio entry values from the existing screen rows
            foreach (GridViewRow row in GridMobileCrane.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["PMA"] = ((TextBox)row.FindControl("txtPma")).Text;
                    dr["COMPANY_VENDOR"] = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    dr["OPERATOR_NAME"] = ((TextBox)row.FindControl("txtOperatorName")).Text;
                    dr["OPERATOR_IC"] = ((TextBox)row.FindControl("txtOperatorIc")).Text;
                    dr["SDIEM_PIC"] = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    dr["GROUP_PIC"] = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    dr["SIGNALMAN_NAME"] = ((TextBox)row.FindControl("txtSignalmanName")).Text;
                    dr["SIGNALMAN_IC"] = ((TextBox)row.FindControl("txtSignalmanIc")).Text;
                    dr["VALID_UNTIL"] = ((TextBox)row.FindControl("txtValidUntil")).Text;

                    HarvestRowRadios(row, dr);
                    dt.Rows.Add(dr);
                }
            }

            // Append a fresh blank row onto the end of the collection
            DataRow drNew = dt.NewRow();
            SetDefaultRowFlags(drNew);
            dt.Rows.Add(drNew);

            ViewState["CurrentMobileCraneData"] = dt;
            BindGridData();
        }

        private void HarvestRowRadios(GridViewRow row, DataRow dr)
        {
            string[] prefix = {
                "CabinClean", "CtrlPanel", "LoadIndicator", "LoadChart",
                "BoomStick", "HydrauCyl", "ForcesLift", "BoomAngel", "BigBlock", "SmallBlock", "SafetyPin", "HoistLimit", "AntiBlock", "WireRope", "OuttrgCond", "WheelCond", "BasePlate", "WalkieTalkie", "BuzzerNoise", "AmberAlarm", "CenterGravity",
                "TagLines", "Slinging", "WireRopeOs", "Barricade", "InfoBoard"
            };
            string[] dbFields = {
                "CYC_CABIN_CLEAN", "CYC_CTRL_PANEL", "CYC_LOAD_INDICATOR", "CYC_LOAD_CHART",
                "BS_BOOM_STICK", "BS_HYDRAU_CYL", "BS_FORCES_LIFT", "BS_BOOM_ANGEL", "BS_BIG_BLOCK", "BS_SMALL_BLOCK", "BS_SAFETY_PIN", "BS_HOIST_LIMIT", "BS_ANTI_BLOCK", "BS_WIRE_ROPE", "BS_OUTTRG_COND", "BS_WHEEL_COND", "BS_BASE_PLATE", "BS_WALKIE_TALKIE", "BS_BUZZER_NOISE","BS_AMBER_ALARM", "BS_CENTER_GRAVITY",
                "OS_TAG_LINES", "OS_SLINGING", "OS_WIRE_ROPE", "OS_BARRICADE", "OS_INFO_BOARD", "DEL_FLAG", "CREATED_DATE", "UPDATED_DATE"
            };

            for (int i = 0; i < prefix.Length; i++)
            {
                RadioButton rbOk = (RadioButton)row.FindControl("rb" + prefix[i] + "Ok");
                RadioButton rbNg = (RadioButton)row.FindControl("rb" + prefix[i] + "Ng");

                if (rbOk != null && rbOk.Checked) dr[dbFields[i]] = "Y";
                else if (rbNg != null && rbNg.Checked) dr[dbFields[i]] = "N";
                else dr[dbFields[i]] = "";
            }
        }

        protected void GridMobileCrane_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlGridCompany");
                if (ddl != null)
                {
                    using (OracleConnection conn = new OracleConnection(connString))
                    {
                        string query = "SELECT DISTINCT COMP_NAME FROM VENDOR_ATT_MST WHERE COMP_NAME IS NOT NULL ORDER BY COMP_NAME ASC";
                        using (OracleDataAdapter da = new OracleDataAdapter(query, conn))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            ddl.DataSource = dt;
                            ddl.DataTextField = "COMP_NAME";
                            ddl.DataValueField = "COMP_NAME";
                            ddl.DataBind();
                            ddl.Items.Insert(0, new ListItem("", ""));
                        }
                    }

                    DataRowView drv = (DataRowView)e.Row.DataItem;
                    if (drv != null && !string.IsNullOrEmpty(drv["COMPANY_VENDOR"].ToString()))
                    {
                        ddl.SelectedValue = drv["COMPANY_VENDOR"].ToString();
                    }
                }

                DataRowView drvFlags = (DataRowView)e.Row.DataItem;
                if (drvFlags != null) { RestoreRowRadios(e.Row, drvFlags); }
            }
        }

        private void RestoreRowRadios(GridViewRow row, DataRowView drv)
        {
            string[] prefix = {
                "CabinClean", "CtrlPanel", "LoadIndicator", "LoadChart",
                "BoomStick", "HydrauCyl", "ForcesLift", "BoomAngel", "BigBlock", "SmallBlock", "SafetyPin", "HoistLimit", "AntiBlock", "WireRope", "OuttrgCond", "WheelCond", "BasePlate", "WalkieTalkie", "BuzzerNoise", "AmberAlarm", "CenterGravity",
                "TagLines", "Slinging", "WireRopeOs", "Barricade", "InfoBoard"
            };
            string[] dbFields = {
                "CYC_CABIN_CLEAN", "CYC_CTRL_PANEL", "CYC_LOAD_INDICATOR", "CYC_LOAD_CHART",
                "BS_BOOM_STICK", "BS_HYDRAU_CYL", "BS_FORCES_LIFT", "BS_BOOM_ANGEL", "BS_BIG_BLOCK", "BS_SMALL_BLOCK", "BS_SAFETY_PIN", "BS_HOIST_LIMIT", "BS_ANTI_BLOCK", "BS_WIRE_ROPE", "BS_OUTTRG_COND", "BS_WHEEL_COND", "BS_BASE_PLATE", "BS_WALKIE_TALKIE", "BS_BUZZER_NOISE","BS_AMBER_ALARM", "BS_CENTER_GRAVITY",
                "OS_TAG_LINES", "OS_SLINGING", "OS_WIRE_ROPE", "OS_BARRICADE", "OS_INFO_BOARD", "DEL_FLAG", "CREATED_DATE", "UPDATED_DATE"
            };

            for (int i = 0; i < prefix.Length; i++)
            {
                RadioButton rbOk = (RadioButton)row.FindControl("rb" + prefix[i] + "Ok");
                RadioButton rbNg = (RadioButton)row.FindControl("rb" + prefix[i] + "Ng");

                string dbValue = drv[dbFields[i]].ToString().Trim();

                if (rbOk != null && rbNg != null)
                {
                    rbOk.Checked = false;
                    rbNg.Checked = false;

                    if (dbValue == "Y") rbOk.Checked = true;
                    else if (dbValue == "N") rbNg.Checked = true;
                }
            }
        }

        protected void GridMobileCrane_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;
                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];

                    // ROW : TOP LEVEL HEADER GROUPINGS (ColumnSpan Calculations)
                    GridViewRow rowGroup = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    TableCell cellMach = new TableCell { Text = "Machinery Details", ColumnSpan = 10, RowSpan = 2, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                    cellMach.Font.Bold = true;
                    rowGroup.Cells.Add(cellMach);

                    string[] groupNames = { "Crane Operating Cabin", "Body Structure", "Other specifications" };
                    int[] groupSpans = { 8, 34, 10 }; // Items count multiplied by 2 (for OK and NG cells)

                    for (int i = 0; i < groupNames.Length; i++)
                    {
                        TableCell cellGrp = new TableCell { Text = groupNames[i], ColumnSpan = groupSpans[i], HorizontalAlign = HorizontalAlign.Center };
                        cellGrp.Font.Bold = true;
                        rowGroup.Cells.Add(cellGrp);
                    }
                    innerTable.Rows.AddAt(0, rowGroup);
                    // ROW : MIDDLE CHECKLIST SPECIFIC PARAMETER DESCRIPTIONS
                    GridViewRow rowItems = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    string[] itemDescriptions = {
                        "Cabin Cleanliness", "Control panel", "Load moment indicator", "Load chart provided", 
                        "Boom stick", "Hydraulics cylinder", "Forces lift", "Boom angle indicator", "Big block & hook", "Small block & hook", "Safety pin for hook", "Hoist limit switch", "Anti 2 block", "Wire rope termination", "Outriggers condition", "Wheels condition", "Base plate condition", "Walkie-talkie condition", "Buzzer noise function", "Amber flashing beacon / alarm", "Center of gravity", 
                        "Tag lines provided", "Slinging ", "Wire rope", "Barricade", "Information Board"
                    };

                    foreach (string desc in itemDescriptions)
                    {
                        TableCell cellDesc = new TableCell
                        {
                            Text = desc,
                            ColumnSpan = 2,
                            HorizontalAlign = HorizontalAlign.Center,
                            VerticalAlign = VerticalAlign.Middle
                        };
                        cellDesc.Font.Bold = true;

                        // Optional CSS styling
                        //cellDesc.BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2");
                        //cellDesc.Style.Add("writing-mode", "vertical-rl");
                        //cellDesc.Style.Add("transform", "rotate(180deg)");
                        //cellDesc.Style.Add("padding", "10px 4px");

                        rowItems.Cells.Add(cellDesc);
                    }
                    innerTable.Rows.AddAt(1, rowItems);

                    // ROW : "OK" and "NG"
                    e.Row.Cells[0].Text = "No";
                    e.Row.Cells[1].Text = "PMA";
                    e.Row.Cells[2].Text = "Company Vendor";
                    e.Row.Cells[3].Text = "Operator Name";
                    e.Row.Cells[4].Text = "Operator IC";
                    e.Row.Cells[5].Text = "SDIEM PIC";
                    e.Row.Cells[6].Text = "Group PIC";
                    e.Row.Cells[7].Text = "Signalman Name";
                    e.Row.Cells[8].Text = "Signalman IC";
                    e.Row.Cells[9].Text = "Valid until";

                    for (int k = 10; k < e.Row.Cells.Count; k++)
                    {
                        //e.Row.Cells[k].Text = (k % 2 != 0) ? "NG" : "OK";
                        
                        e.Row.Cells[k].Font.Size = FontUnit.Small;
                        e.Row.Cells[k].Font.Bold = true;
                        e.Row.Cells[k].Width = Unit.Pixel(30);
                    }
                }
            }
        }

        protected void btnSaveMobileCrane_Click(object sender, EventArgs e)
        {
            lblValidationError.Text = "";
            bool hasValidData = false;

            // Validation Loop
            foreach (GridViewRow row in GridMobileCrane.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string pma = ((TextBox)row.FindControl("txtPma")).Text.Trim();
                    string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    string opName = ((TextBox)row.FindControl("txtOperatorName")).Text.Trim();
                    string opIc = ((TextBox)row.FindControl("txtOperatorIc")).Text.Trim();
                    string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text.Trim();
                    string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text.Trim();
                    string sigName = ((TextBox)row.FindControl("txtSignalmanName")).Text.Trim();
                    string sigIc = ((TextBox)row.FindControl("txtSignalmanIc")).Text.Trim();
                    string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text.Trim();

                    if (!string.IsNullOrEmpty(pma) || !string.IsNullOrEmpty(comp))
                    {
                        if (string.IsNullOrEmpty(pma)) { lblValidationError.Text = "Error: 'PMA' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(comp)) { lblValidationError.Text = "Error: Please select a valid Company Vendor from the list."; return; }
                        if (string.IsNullOrEmpty(opName)) { lblValidationError.Text = "Error: 'Operator Name' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(opIc)) { lblValidationError.Text = "Error: 'Operator IC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(cPic)) { lblValidationError.Text = "Error: 'SDIEM PIC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(gPic)) { lblValidationError.Text = "Error: 'Group PIC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(sigName)) { lblValidationError.Text = "Error: 'Signalman Name' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(sigIc)) { lblValidationError.Text = "Error: 'Signalman IC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(vDate)) { lblValidationError.Text = "Error: 'Valid until' verification target date is missing."; return; }
                        hasValidData = true;
                    }
                }
            }
            if (!hasValidData)
            {
                lblValidationError.Text = "Error: Cannot save an empty form. Please fill out at least one row.";
                return;
            }

            using (OracleConnection conn = new OracleConnection(connString))
            {
                conn.Open();
                foreach (GridViewRow row in GridMobileCrane.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        string pma = ((TextBox)row.FindControl("txtPma")).Text.Trim();
                        string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                        string opName = ((TextBox)row.FindControl("txtOperatorName")).Text.Trim();
                        string opIc = ((TextBox)row.FindControl("txtOperatorIc")).Text.Trim();
                        string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text.Trim();
                        string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text.Trim();
                        string sigName = ((TextBox)row.FindControl("txtSignalmanName")).Text.Trim();
                        string sigIc = ((TextBox)row.FindControl("txtSignalmanIc")).Text.Trim();
                        string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text.Trim();

                        if (string.IsNullOrEmpty(pma) && string.IsNullOrEmpty(comp)) continue;

                        string insertQuery = @"INSERT INTO VENDOR_MOBILE_CRANE_RESULTS (
                            PMA,COMPANY_VENDOR,OPERATOR_NAME,OPERATOR_IC,SDIEM_PIC,GROUP_PIC,SIGNALMAN_NAME,SIGNALMAN_IC,VALID_UNTIL,
                            CYC_CABIN_CLEAN,CYC_CTRL_PANEL,CYC_LOAD_INDICATOR,CYC_LOAD_CHART,
                            BS_BOOM_STICK,BS_HYDRAU_CYL,BS_FORCES_LIFT,BS_BOOM_ANGEL,
                            BS_BIG_BLOCK,BS_SMALL_BLOCK,BS_SAFETY_PIN,BS_HOIST_LIMIT,BS_ANTI_BLOCK,BS_WIRE_ROPE,BS_OUTTRG_COND,BS_WHEEL_COND,BS_BASE_PLATE,BS_WALKIE_TALKIE,BS_BUZZER_NOISE,BS_AMBER_ALARM,BS_CENTER_GRAVITY,
                            OS_TAG_LINES,OS_SLINGING,OS_WIRE_ROPE,OS_BARRICADE,OS_INFO_BOARD
                        ) VALUES (
                            :pma, :comp, :opName, :opIc, :cPic, :gPic, :sigName, :sigIc, :vDate,
                            :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :f9, :f10, :f11, :f12, :f13, :f14, :f15, :f16, :f17, :f18, :f19, :f20, :f21, :f22, :f23, :f24, :f25, :f26
                        )";

                        using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("pma", pma);
                            cmd.Parameters.AddWithValue("comp", comp);
                            cmd.Parameters.AddWithValue("opName", opName);
                            cmd.Parameters.AddWithValue("opIc", opIc);
                            cmd.Parameters.AddWithValue("cPic", cPic);
                            cmd.Parameters.AddWithValue("gPic", gPic);
                            cmd.Parameters.AddWithValue("sigName", sigName);
                            cmd.Parameters.AddWithValue("sigIc", sigIc);
                            cmd.Parameters.AddWithValue("vDate", vDate);

                            string[] fields = {
                                "CabinClean", "CtrlPanel", "LoadIndicator", "LoadChart",
                                "BoomStick", "HydrauCyl", "ForcesLift", "BoomAngel", "BigBlock", "SmallBlock", "SafetyPin", "HoistLimit", "AntiBlock", "WireRope", "OuttrgCond", "WheelCond", "BasePlate", "WalkieTalkie", "BuzzerNoise", "AmberAlarm", "CenterGravity",
                                "TagLines", "Slinging", "WireRopeOs", "Barricade", "InfoBoard"
                            };
                            for (int i = 0; i < fields.Length; i++)
                            {
                                RadioButton rbOk = (RadioButton)row.FindControl("rb" + fields[i] + "Ok");
                                string val = (rbOk != null && rbOk.Checked) ? "Y" : "N";

                                cmd.Parameters.AddWithValue("f" + (i + 1), val);
                            }
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            InitializeEmptyRows();
            BindHistoryLog();
        }

        private void BindHistoryLog()
        {
            using (OracleConnection conn = new OracleConnection(connString))
            {
                // Dynamic SQL configuration
                string conditionClause = " WHERE DEL_FLAG = 'N' OR DEL_FLAG IS NULL"; //Retrieve N rows

                if (rbFilterY.Checked)
                {
                    conditionClause = " WHERE DEL_FLAG = 'Y'"; //Retrieve Y rows
                }
                else if (rbFilterAll.Checked)
                {
                    conditionClause = ""; // Retrieve ALL rows
                }

                string query = @"SELECT * FROM VENDOR_MOBILE_CRANE_RESULTS" + conditionClause + " ORDER BY ID DESC";

                using (OracleDataAdapter da = new OracleDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridHistory.DataSource = dt;
                    GridHistory.DataBind();
                }
            }
        }

        protected void FilterRadio_CheckedChanged(object sender, EventArgs e)
        {
            GridHistory.PageIndex = 0; BindHistoryLog();
        }

        protected void GridHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridHistory.PageIndex = e.NewPageIndex;
            BindHistoryLog();
        }

        protected void GridHistory_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;
                GridViewRow extraHeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                // Machinery Details -> Spans over No, Type, SWL, Company Vendor, Driving License (OK/NG), SDIEM PIC, Group PIC, Valid until (8 columns)
                TableCell cellMach = new TableCell { Text = "Machinery Details", ColumnSpan = 10, RowSpan = 1, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                cellMach.Font.Bold = true; cellMach.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellMach.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellMach);

                // Checklist Items Categories span
                string[] groupNames = { "Crane Operating Cabin", "Body Structure", "Other specifications" };
                int[] groupSpans = { 4, 17, 5 };

                for (int i = 0; i < groupNames.Length; i++)
                {
                    TableCell cellGrp = new TableCell { Text = groupNames[i], ColumnSpan = groupSpans[i], HorizontalAlign = HorizontalAlign.Center };
                    cellGrp.Font.Bold = true; cellGrp.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellGrp.ForeColor = System.Drawing.Color.Black;
                    extraHeaderRow.Cells.Add(cellGrp);
                    // Optional CSS styling class hook to apply vertical text direction layout if desired
                    //cellGrp.Style.Add("writing-mode", "vertical-rl");
                    //cellGrp.Style.Add("transform", "rotate(180deg)");
                    //cellGrp.Style.Add("padding", "10px 4px");
                }

                TableCell cellSpacer = new TableCell { Text = "System Log Info", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellSpacer.Font.Bold = true; cellSpacer.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellSpacer.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellSpacer);

                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];
                    innerTable.Rows.AddAt(0, extraHeaderRow);
                }
            }
        }

        protected void GridHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i <= 36; i++)
                {
                    e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); //#F2F2F2    #BFD3E5
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 11; i <= 36; i++)
                {
                    string value = e.Row.Cells[i].Text.Trim();

                    if (value == "Y")
                    {
                        e.Row.Cells[i].Text = "&#10003";//"✓";
                        e.Row.Cells[i].Attributes["style"] = "font-weight:bold; color:blue; text-align:center; vertical-align:middle;";
                    }
                    else if (value == "N")
                    {
                        e.Row.Cells[i].Text = "&#10008";//"✘";
                        e.Row.Cells[i].Attributes["style"] = "font-weight:bold; color:red; text-align:center; vertical-align:middle;";
                    }
                    else
                    {
                        //e.Row.Cells[i].Text = "";
                    }
                }

                string currentFlag = DataBinder.Eval(e.Row.DataItem, "DEL_FLAG").ToString();//e.Row.Cells[9].Text.Trim();

                Button btnDelete = (Button)e.Row.FindControl("btnDelete");
                Button btnRestore = (Button)e.Row.FindControl("btnRestore");

                if (currentFlag == "Y")
                {
                    //show Delete button and hide Restore button
                    if (btnDelete != null) btnDelete.Visible = false;
                    if (btnRestore != null) btnRestore.Visible = true;
                    for (int i = 0; i <= 36; i++)
                    {
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#FDEDEC");
                    }
                }
                else
                {
                    //hide Delete button and show Restore button
                    if (btnDelete != null) btnDelete.Visible = true;
                    if (btnRestore != null) btnRestore.Visible = false;
                }
            }
        }

        protected void GridHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string targetID = GridHistory.DataKeys[e.RowIndex].Value.ToString();
            using (OracleConnection conn = new OracleConnection(connString))
            {
                string sql = "UPDATE VENDOR_MOBILE_CRANE_RESULTS SET DEL_FLAG = 'Y', UPDATED_DATE = SYSDATE WHERE ID = :id";
                using (OracleCommand cmd = new OracleCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("id", targetID);
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }
            BindHistoryLog();
        }

        protected void GridHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RestoreRecord")
            {
                using (OracleConnection conn = new OracleConnection(connString))
                {
                    string sql = "UPDATE VENDOR_MOBILE_CRANE_RESULTS SET DEL_FLAG = 'N', UPDATED_DATE = SYSDATE WHERE ID = :id";
                    using (OracleCommand cmd = new OracleCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("id", e.CommandArgument.ToString());
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindHistoryLog();
            }
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=MobileCrane_Report_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
            Response.Charset = ""; Response.ContentType = "application/vnd.ms-excel";
            
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Disable pagination to export all rows across all pages
                GridHistory.AllowPaging = false;
                BindHistoryLog();

                // Hide last Action Button columns total index i+2
                GridHistory.Columns[38].Visible = false;

                if (GridHistory.Controls.Count > 0 && GridHistory.Controls[0] is Table)
                {
                    Table innerTable = (Table)GridHistory.Controls[0];
                    if (innerTable.Rows.Count > 0 && ((GridViewRow)innerTable.Rows[0]).Cells.Count > 5)
                    {
                        ((GridViewRow)innerTable.Rows[0]).Cells.RemoveAt(5);
                    }
                }

                if (GridHistory.HeaderRow != null)
                {
                    for (int i = 0; i <= 36; i++)
                    {
                        GridHistory.HeaderRow.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#DFE9F2");
                    }
                }
                
                foreach (GridViewRow row in GridHistory.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        for (int j = 0; j <= 36; j++)
                        {
                            if (row.Cells.Count > j)
                            {
                                row.Cells[j].Attributes.Add("align", "center");
                                row.Cells[j].Attributes.Add("valign", "middle");

                                if (j == 5 || j == 9)
                                {
                                    row.Cells[j].Attributes.Add("style", "mso-number-format:\\@;");
                                }
                            }
                        }
                    }
                }

                // Apply border styles
                GridHistory.Attributes.Add("border", "1");
                GridHistory.GridLines = GridLines.Both;

                // Render the merged data grid matrix
                GridHistory.RenderControl(hw);

                Response.Write(sw.ToString());

                GridHistory.AllowPaging = true;
                BindHistoryLog();

                Response.End();
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        { /* Keep compilation validation quiet */
        }


    }
}