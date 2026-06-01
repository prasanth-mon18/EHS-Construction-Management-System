using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;

namespace EHS_Construction_Management_System
{
    public partial class ScissorLift : System.Web.UI.Page
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
            DataTable dt = CreateScissorStructure();

            DataRow dr = dt.NewRow();
            SetDefaultRowFlags(dr);
            dt.Rows.Add(dr);

            ViewState["CurrentScissorData"] = dt;
            BindGridData();
        }

        private DataTable CreateScissorStructure()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PMA");
            dt.Columns.Add("SWL");
            dt.Columns.Add("COMPANY_VENDOR");
            dt.Columns.Add("NO_OF_OPERATOR");
            dt.Columns.Add("SDIEM_PIC");
            dt.Columns.Add("GROUP_PIC");
            dt.Columns.Add("VALID_UNTIL");
            string[] flags = {
                "BC_PLATFORM_CTRL", "BC_HANDRAIL_CAGE", "BC_PLATFORM_ASSY", "BC_GATE_COND", "BC_HARNESS_HELMET",
                "EA_HYDRAULIC_LVL", "EA_MOTOR_PUMP", "EA_TILT_SWITCH", "EA_WHEELS_BRAKE", "EA_GROUND_CTRL",
                "WD_REV_ALARM", "WD_HORN", "WD_BEACON", "WD_LIGHTS",
                "SF_LIFT_CYLINDER", "SF_LIMIT_SWITCH", "SF_SCISSOR_ARM", "SF_MANUAL_DECENT", "SF_COMPARTMENT"
            };
            foreach (string flag in flags) { dt.Columns.Add(flag); }
            return dt;
        }

        private void SetDefaultRowFlags(DataRow dr)
        {
            string[] flags = {
                "BC_PLATFORM_CTRL", "BC_HANDRAIL_CAGE", "BC_PLATFORM_ASSY", "BC_GATE_COND", "BC_HARNESS_HELMET",
                "EA_HYDRAULIC_LVL", "EA_MOTOR_PUMP", "EA_TILT_SWITCH", "EA_WHEELS_BRAKE", "EA_GROUND_CTRL",
                "WD_REV_ALARM", "WD_HORN", "WD_BEACON", "WD_LIGHTS",
                "SF_LIFT_CYLINDER", "SF_LIMIT_SWITCH", "SF_SCISSOR_ARM", "SF_MANUAL_DECENT", "SF_COMPARTMENT"
            };
            foreach (string flag in flags) { dr[flag] = ""; }
        }

        private void BindGridData()
        {
            DataTable dt = (DataTable)ViewState["CurrentScissorData"];
            GridScissor.DataSource = dt;
            GridScissor.DataBind();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "initSelect2Scissor", "initSearchableDropdowns();", true);
        }

        // Trigger when user clicks "+ Add New Row"
        protected void btnAddNewRow_Click(object sender, EventArgs e)
        {
            DataTable dt = CreateScissorStructure();

            // First, User entries already typed into the existing rows aren't lost
            foreach (GridViewRow row in GridScissor.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["PMA"] = ((TextBox)row.FindControl("txtPma")).Text;
                    dr["SWL"] = ((TextBox)row.FindControl("txtSwl")).Text;
                    dr["COMPANY_VENDOR"] = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    dr["NO_OF_OPERATOR"] = ((TextBox)row.FindControl("txtNoOperator")).Text;
                    dr["SDIEM_PIC"] = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    dr["GROUP_PIC"] = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    dr["VALID_UNTIL"] = ((TextBox)row.FindControl("txtValidUntil")).Text;

                    string[] prefix = { "PlatCtrl", "Handrail", "PlatAssy", "GateCond", "Harness", "Hydraulic", "MotorPump", "Tilt", "Wheels", "Ground", "RevAlarm", "Horn", "Beacon", "Lights", "LiftCyl", "LimitSw", "ScissorArm", "ManualDecent", "Compartment" };
                    string[] dbFields = { "BC_PLATFORM_CTRL", "BC_HANDRAIL_CAGE", "BC_PLATFORM_ASSY", "BC_GATE_COND", "BC_HARNESS_HELMET", "EA_HYDRAULIC_LVL", "EA_MOTOR_PUMP", "EA_TILT_SWITCH", "EA_WHEELS_BRAKE", "EA_GROUND_CTRL", "WD_REV_ALARM", "WD_HORN", "WD_BEACON", "WD_LIGHTS", "SF_LIFT_CYLINDER", "SF_LIMIT_SWITCH", "SF_SCISSOR_ARM", "SF_MANUAL_DECENT", "SF_COMPARTMENT" };

                    for (int i = 0; i < prefix.Length; i++)
                    {
                        RadioButton rbOk = (RadioButton)row.FindControl("rb" + prefix[i] + "Ok");
                        RadioButton rbNg = (RadioButton)row.FindControl("rb" + prefix[i] + "Ng");

                        if (rbOk != null && rbOk.Checked)
                        {
                            dr[dbFields[i]] = "Y";
                        }
                        else if (rbNg != null && rbNg.Checked)
                        {
                            dr[dbFields[i]] = "N";
                        }
                        else
                        {
                            dr[dbFields[i]] = ""; // keeps it empty if user hasn't selected either option
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }

            // blank row at the end of grid
            DataRow drNew = dt.NewRow();
            SetDefaultRowFlags(drNew);
            dt.Rows.Add(drNew);

            ViewState["CurrentScissorData"] = dt;
            BindGridData();
        }

        protected void GridScissor_RowDataBound(object sender, GridViewRowEventArgs e)
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
            string[] prefix = { "PlatCtrl", "Handrail", "PlatAssy", "GateCond", "Harness", "Hydraulic", "MotorPump", "Tilt", "Wheels", "Ground", "RevAlarm", "Horn", "Beacon", "Lights", "LiftCyl", "LimitSw", "ScissorArm", "ManualDecent", "Compartment" };
            string[] dbFields = { "BC_PLATFORM_CTRL", "BC_HANDRAIL_CAGE", "BC_PLATFORM_ASSY", "BC_GATE_COND", "BC_HARNESS_HELMET", "EA_HYDRAULIC_LVL", "EA_MOTOR_PUMP", "EA_TILT_SWITCH", "EA_WHEELS_BRAKE", "EA_GROUND_CTRL", "WD_REV_ALARM", "WD_HORN", "WD_BEACON", "WD_LIGHTS", "SF_LIFT_CYLINDER", "SF_LIMIT_SWITCH", "SF_SCISSOR_ARM", "SF_MANUAL_DECENT", "SF_COMPARTMENT" };

            for (int i = 0; i < prefix.Length; i++)
            {
                RadioButton rbOk = (RadioButton)row.FindControl("rb" + prefix[i] + "Ok");
                RadioButton rbNg = (RadioButton)row.FindControl("rb" + prefix[i] + "Ng");

                string dbValue = drv[dbFields[i]].ToString().Trim();

                if (rbOk != null && rbNg != null)
                {
                    // Reset both buttons initially to prevent automatic ticking
                    rbOk.Checked = false;
                    rbNg.Checked = false;

                    // Explicitly evaluate string criteria fields from state memory caches
                    if (dbValue == "Y")
                    {
                        rbOk.Checked = true;
                    }
                    else if (dbValue == "N")
                    {
                        rbNg.Checked = true;
                    }
                    // If dbValue is blank "", both buttons remain completely clean and unticked
                }
            }
        }

        protected void GridScissor_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;

                // Ensure the grid has a valid underlying table structure container
                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];

                    // ==========================================
                    // ROW 0: TOP MERGED GROUPS (Work Details, Bucket, Engine, etc.)
                    // ==========================================
                    GridViewRow rowGroup = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    // Machinery Details Spacer -> Spans over No, PMA, SWL, Company, Operator, PIC, Valid (7 columns)
                    TableCell cellMach = new TableCell { Text = "Machinery Details", ColumnSpan = 8, RowSpan = 2, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                    cellMach.Font.Bold = true;
                    rowGroup.Cells.Add(cellMach);

                    // Checklist Items Categories
                    string[] groupNames = { "Bucket Condition/ Platform", "Engine Appearance Condition", "Warning Devices", "Safety Features" };
                    int[] groupSpans = { 10, 10, 8, 10 };

                    for (int i = 0; i < groupNames.Length; i++)
                    {
                        TableCell cellGrp = new TableCell { Text = groupNames[i], ColumnSpan = groupSpans[i], HorizontalAlign = HorizontalAlign.Center };
                        cellGrp.Font.Bold = true;
                        rowGroup.Cells.Add(cellGrp);
                    }
                    innerTable.Rows.AddAt(0, rowGroup);

                    // ==========================================
                    // ROW 1: MIDDLE SPECIFIC CHECKLIST ITEMS TEXT DESCRIPTIONS (Vertical Labels)
                    // ==========================================
                    GridViewRow rowItems = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    // Array of your exact 19 checklist parameter descriptions from your paper form image
                    string[] itemDescriptions = {
                "Platform controls", "Handrail/ Cage Installation", "Platform Assembly", "Gate Condition", "Full body harness & Safety Helmet",
                "Hydraulic Level", "Motor/ Pump unit", "Tilt switch", "Wheels, Tire, Brake & Parking Brake", "Ground Controls",
                "Reversing alarm functioning", "Horn functioning", "Beacon functioning", "Operational lights functioning",
                "Lift cylinder", "Limit switch", "Scissor arm & Sliding wear pad", "Manual decent cable and pull handle", "Compartment cover & linkage"
            };

                    foreach (string desc in itemDescriptions)
                    {
                        // Each item label column spans 2 cells to sit perfectly over its own OK and NG buttons below
                        TableCell cellDesc = new TableCell { Text = desc, ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                        cellDesc.Font.Bold = true;

                        // Optional CSS styling class hook to apply vertical text direction layout if desired
                        //cellDesc.Style.Add("writing-mode", "vertical-rl");
                        //cellDesc.Style.Add("transform", "rotate(180deg)");
                        //cellDesc.Style.Add("padding", "10px 4px");

                        rowItems.Cells.Add(cellDesc);
                    }
                    innerTable.Rows.AddAt(1, rowItems);

                    // ==========================================
                    // ROW 2: BOTTOM LEVEL SUB-HEADERS ("OK" and "NG" Label Matrix)
                    // ==========================================
                    // The original native grid header row is automatically pushed here.
                    // We loop through the last 38 cells (19 items * 2 cells) and alternate their text labels.
                    e.Row.Cells[0].Text = "No";
                    e.Row.Cells[1].Text = "PMA";
                    e.Row.Cells[2].Text = "SWL";
                    e.Row.Cells[3].Text = "Company Vendor";
                    e.Row.Cells[4].Text = "No. of Operator";
                    e.Row.Cells[5].Text = "SDIEM PIC";
                    e.Row.Cells[6].Text = "Group PIC";
                    e.Row.Cells[7].Text = "Valid until";

                    for (int k = 8; k < e.Row.Cells.Count; k++)
                    {
                        e.Row.Cells[k].Text = (k % 2 == 1) ? "NG" : "OK";

                        e.Row.Cells[k].Font.Size = FontUnit.Small;
                        e.Row.Cells[k].Font.Bold = true;
                        //e.Row.Cells[k].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2");
                        e.Row.Cells[k].Width = Unit.Pixel(30);
                    }
                }
            }
        }

        protected void btnSaveScissor_Click(object sender, EventArgs e)
        {
            lblValidationError.Text = "";
            bool hasValidData = false;

            // Validation Loop
            foreach (GridViewRow row in GridScissor.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string pma = ((TextBox)row.FindControl("txtPma")).Text;
                    string swl = ((TextBox)row.FindControl("txtSwl")).Text;
                    string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    string noOper = ((TextBox)row.FindControl("txtNoOperator")).Text;
                    string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text;

                    if (!string.IsNullOrEmpty(pma) || !string.IsNullOrEmpty(swl) || !string.IsNullOrEmpty(comp))
                    {
                        if (string.IsNullOrEmpty(pma)) { lblValidationError.Text = "Error: 'PMA' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(swl)) { lblValidationError.Text = "Error: 'SWL' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(comp)) { lblValidationError.Text = "Error: Please select a valid Company Vendor."; return; }
                        if (string.IsNullOrEmpty(noOper)) { lblValidationError.Text = "Error: 'No. of Operator' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(cPic)) { lblValidationError.Text = "Error: 'SDIEM PIC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(gPic)) { lblValidationError.Text = "Error: 'Group PIC' cannot be left empty."; return; }
                        if (string.IsNullOrEmpty(vDate)) { lblValidationError.Text = "Error: 'Valid until' date is missing."; return; }
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
                foreach (GridViewRow row in GridScissor.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        string pma = ((TextBox)row.FindControl("txtPma")).Text;
                        string swl = ((TextBox)row.FindControl("txtSwl")).Text;
                        string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                        string noOper = ((TextBox)row.FindControl("txtNoOperator")).Text;
                        string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                        string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text;
                        string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text;
                        if (string.IsNullOrEmpty(pma) && string.IsNullOrEmpty(comp)) continue;

                        string insertQuery = @"INSERT INTO VENDOR_SCISSOR_LIFT_RESULTS (
                            PMA, SWL, COMPANY_VENDOR, NO_OF_OPERATOR, SDIEM_PIC, GROUP_PIC, VALID_UNTIL,
                            BC_PLATFORM_CTRL, BC_HANDRAIL_CAGE, BC_PLATFORM_ASSY, BC_GATE_COND, BC_HARNESS_HELMET,
                            EA_HYDRAULIC_LVL, EA_MOTOR_PUMP, EA_TILT_SWITCH, EA_WHEELS_BRAKE, EA_GROUND_CTRL,
                            WD_REV_ALARM, WD_HORN, WD_BEACON, WD_LIGHTS,
                            SF_LIFT_CYLINDER, SF_LIMIT_SWITCH, SF_SCISSOR_ARM, SF_MANUAL_DECENT, SF_COMPARTMENT
                        ) VALUES (
                            :pma, :swl, :comp, :noOper, :cPic, :gPic, :vDate,
                            :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :f9, :f10, :f11, :f12, :f13, :f14, :f15, :f16, :f17, :f18, :f19
                        )";

                        using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("pma", pma);
                            cmd.Parameters.AddWithValue("swl", swl);
                            cmd.Parameters.AddWithValue("comp", comp);
                            cmd.Parameters.AddWithValue("noOper", noOper);
                            cmd.Parameters.AddWithValue("cPic", cPic);
                            cmd.Parameters.AddWithValue("gPic", gPic);
                            cmd.Parameters.AddWithValue("vDate", vDate);

                            string[] fields = { "PlatCtrl", "Handrail", "PlatAssy", "GateCond", "Harness", "Hydraulic", "MotorPump", "Tilt", "Wheels", "Ground", "RevAlarm", "Horn", "Beacon", "Lights", "LiftCyl", "LimitSw", "ScissorArm", "ManualDecent", "Compartment" };
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

                string query = @"SELECT * FROM VENDOR_SCISSOR_LIFT_RESULTS" + conditionClause + " ORDER BY ID DESC";

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
            GridHistory.PageIndex = 0;
            BindHistoryLog();
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

                // Machinery Details -> Spans over No, PMA, SWL, Company Vendor, No. of Operator, SDIEM PIC, Group PIC, Valid until (8 columns)
                TableCell cellMach = new TableCell { Text = "Machinery Details", ColumnSpan = 8, RowSpan = 1, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                cellMach.Font.Bold = true; cellMach.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellMach.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellMach);

                // Checklist Items Categories span
                string[] groupNames = { "Bucket Condition/ Platform", "Engine Appearance Condition", "Warning Devices", "Safety Features" };
                int[] groupSpans = { 5, 5, 4, 5 };

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
                for (int i = 0; i <= 28; i++)
                {
                    e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); //#F2F2F2    #BFD3E5
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 9; i <= 27; i++)
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
                    for (int i = 0; i <= 27; i++)
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
                string sql = "UPDATE VENDOR_SCISSOR_LIFT_RESULTS SET DEL_FLAG = 'Y', UPDATED_DATE = SYSDATE WHERE ID = :id";
                using (OracleCommand cmd = new OracleCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("id", targetID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
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
                    string sql = "UPDATE VENDOR_SCISSOR_LIFT_RESULTS SET DEL_FLAG = 'N', UPDATED_DATE = SYSDATE WHERE ID = :id";
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
            Response.AddHeader("content-disposition", "attachment;filename=Scissor_Lift_Report_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Disable pagination to export all rows across all pages
                GridHistory.AllowPaging = false;
                BindHistoryLog();

                // Hide columns
                GridHistory.Columns[28].Visible = false;

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
                    for (int i = 0; i < 28; i++) { GridHistory.HeaderRow.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); }
                }

                foreach (GridViewRow row in GridHistory.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        for (int j = 0; j < 28; j++)
                        {
                            if (row.Cells.Count > j) { row.Cells[j].Attributes.Add("align", "center"); row.Cells[j].Attributes.Add("valign", "middle"); }
                        }
                    }
                }

                // Apply border styles
                GridHistory.Attributes.Add("border", "1");
                GridHistory.GridLines = GridLines.Both;

                // Render the merged data grid matrix
                GridHistory.RenderControl(hw);

                Response.Write(sw.ToString());

                // Restore column visibility
                GridHistory.Columns[28].Visible = true;
                GridHistory.AllowPaging = true;
                BindHistoryLog();

                Response.End();
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* */
        }
    }
}