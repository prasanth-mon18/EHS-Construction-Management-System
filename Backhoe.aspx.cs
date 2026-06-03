using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;

namespace EHS_Construction_Management_System
{
    public partial class Backhoe : System.Web.UI.Page
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
            DataTable dt = CreateBackhoeStructure();

            // Generate 1 clean, completely empty default row layout
            DataRow dr = dt.NewRow();
            SetDefaultRowFlags(dr);
            dt.Rows.Add(dr);

            ViewState["CurrentBackhoeData"] = dt;
            BindGridData();
        }

        private DataTable CreateBackhoeStructure()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("COMPANY_VENDOR");
            dt.Columns.Add("DRIVING_LICENSE");
            dt.Columns.Add("SDIEM_PIC");
            dt.Columns.Add("GROUP_PIC");
            dt.Columns.Add("VALID_UNTIL");

            string[] flags = {
                "CAB_CLEAN", "CAB_SEAT_COND", "CAB_PEDAL_COND", "CAB_WINDOW_WIPER", "CAB_LEVERS_CTRL",
                "SPEC_ROLL_ROPES", "SPEC_REAR_MIRRORS", "SPEC_HANDRAILS", "SPEC_FAN", "SPEC_LOADER_BUCKET", "SPEC_BUCKET_COND", "SPEC_HITCH_PIN", "SPEC_OUTRIGGERS_COND", "SPEC_HYD_HOSES", "SPEC_CONNECTION_FIT", "SPEC_ENGINE_GUARD", "SPEC_WHEEL_COND", "SPEC_OIL_LEAK",
                "WD_MOTION_ALARM", "WD_AMBER_BEACON", "WD_HORN"
            };
            foreach (string flag in flags) { dt.Columns.Add(flag); }
            return dt;
        }

        private void SetDefaultRowFlags(DataRow dr)
        {
            string[] flags = {
                "CAB_CLEAN", "CAB_SEAT_COND", "CAB_PEDAL_COND", "CAB_WINDOW_WIPER", "CAB_LEVERS_CTRL",
                "SPEC_ROLL_ROPES", "SPEC_REAR_MIRRORS", "SPEC_HANDRAILS", "SPEC_FAN", "SPEC_LOADER_BUCKET", "SPEC_BUCKET_COND", "SPEC_HITCH_PIN", "SPEC_OUTRIGGERS_COND", "SPEC_HYD_HOSES", "SPEC_CONNECTION_FIT", "SPEC_ENGINE_GUARD", "SPEC_WHEEL_COND", "SPEC_OIL_LEAK",
                "WD_MOTION_ALARM", "WD_AMBER_BEACON", "WD_HORN"
            };

            foreach (string flag in flags) { dr[flag] = ""; }
        }

        private void BindGridData()
        {
            DataTable dt = (DataTable)ViewState["CurrentBackhoeData"];
            GridBackhoe.DataSource = dt;
            GridBackhoe.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "initSelect2Backhoe", "initSearchableDropdowns();", true);
        }

        protected void btnAddNewRow_Click(object sender, EventArgs e)
        {
            DataTable dt = CreateBackhoeStructure();

            // Harvest text and radio entry values from the existing screen rows
            foreach (GridViewRow row in GridBackhoe.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["COMPANY_VENDOR"] = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    dr["DRIVING_LICENSE"] = ((TextBox)row.FindControl("txtLicense")).Text;
                    dr["SDIEM_PIC"] = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    dr["GROUP_PIC"] = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    dr["VALID_UNTIL"] = ((TextBox)row.FindControl("txtValidUntil")).Text;

                    string[] prefix = {
                        "CabClean", "CabSeat", "CabPedal", "CabWiper", "CabLevers",
                        "SpecRoll", "SpecMirrors", "SpecHandrails", "SpecFan", "SpecLoader", "SpecBucket", "SpecHitch", "SpecOutriggers", "SpecHoses", "SpecConnection", "SpecEngine", "SpecWheel", "SpecOil",
                        "WdMotion", "WdBeacon", "WdHorn"
                    };

                    string[] dbFields = {
                        "CAB_CLEAN", "CAB_SEAT_COND", "CAB_PEDAL_COND", "CAB_WINDOW_WIPER", "CAB_LEVERS_CTRL",
                        "SPEC_ROLL_ROPES", "SPEC_REAR_MIRRORS", "SPEC_HANDRAILS", "SPEC_FAN", "SPEC_LOADER_BUCKET", "SPEC_BUCKET_COND", "SPEC_HITCH_PIN", "SPEC_OUTRIGGERS_COND", "SPEC_HYD_HOSES", "SPEC_CONNECTION_FIT", "SPEC_ENGINE_GUARD", "SPEC_WHEEL_COND", "SPEC_OIL_LEAK",
                        "WD_MOTION_ALARM", "WD_AMBER_BEACON", "WD_HORN"
                    };

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

            // Append a fresh blank row onto the end of the collection
            DataRow drNew = dt.NewRow();
            SetDefaultRowFlags(drNew);
            dt.Rows.Add(drNew);

            ViewState["CurrentBackhoeData"] = dt;
            BindGridData();
        }

        protected void GridBackhoe_RowDataBound(object sender, GridViewRowEventArgs e)
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
                "CabClean", "CabSeat", "CabPedal", "CabWiper", "CabLevers",
                "SpecRoll", "SpecMirrors", "SpecHandrails", "SpecFan", "SpecLoader", "SpecBucket", "SpecHitch", "SpecOutriggers", "SpecHoses", "SpecConnection", "SpecEngine", "SpecWheel", "SpecOil",
                "WdMotion", "WdBeacon", "WdHorn"
            };

            string[] dbFields = {
                "CAB_CLEAN", "CAB_SEAT_COND", "CAB_PEDAL_COND", "CAB_WINDOW_WIPER", "CAB_LEVERS_CTRL",
                "SPEC_ROLL_ROPES", "SPEC_REAR_MIRRORS", "SPEC_HANDRAILS", "SPEC_FAN", "SPEC_LOADER_BUCKET", "SPEC_BUCKET_COND", "SPEC_HITCH_PIN", "SPEC_OUTRIGGERS_COND", "SPEC_HYD_HOSES", "SPEC_CONNECTION_FIT", "SPEC_ENGINE_GUARD", "SPEC_WHEEL_COND", "SPEC_OIL_LEAK",
                "WD_MOTION_ALARM", "WD_AMBER_BEACON", "WD_HORN"
            };

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

        protected void GridBackhoe_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;
                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];

                    // ==========================================
                    // ROW 0: CATEGORY GROUPS 
                    // ==========================================
                    GridViewRow rowGroup = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    TableCell cellMach = new TableCell { Text = "Machinery Details", ColumnSpan = 6, RowSpan = 2, HorizontalAlign = HorizontalAlign.Center, VerticalAlign = VerticalAlign.Middle };
                    cellMach.Font.Bold = true;
                    rowGroup.Cells.Add(cellMach);

                    TableCell cellCab = new TableCell { Text = "Cab", ColumnSpan = 10, HorizontalAlign = HorizontalAlign.Center };
                    cellCab.Font.Bold = true;
                    rowGroup.Cells.Add(cellCab);

                    TableCell cellSpec = new TableCell { Text = "Other Specifications", ColumnSpan = 26, HorizontalAlign = HorizontalAlign.Center };
                    cellSpec.Font.Bold = true;
                    rowGroup.Cells.Add(cellSpec);

                    TableCell cellWd = new TableCell { Text = "Warning Devices", ColumnSpan = 6, HorizontalAlign = HorizontalAlign.Center };
                    cellWd.Font.Bold = true;
                    rowGroup.Cells.Add(cellWd);

                    innerTable.Rows.AddAt(0, rowGroup);

                    // ==========================================
                    // ROW 1: MIDDLE TEXT LABELS
                    // ==========================================
                    GridViewRow rowItems = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Normal);

                    string[] itemDescriptions = {
                        "Cleanliness of cab","Seat condition","Pedal condition","Window/wipers/washer","Levers/ Controls operational",
                        "Rollover protection system (ropes)","Rear view mirrors","Handrails/ steps","Ventilation fan covered (if any)","Loader bucket","Bucket condition","Quick hitch/ safety pin fitted perfectly","Outriggers condition",
                        "Hydraulic hoses","Connection fitted properly","Engine guarding","Tires/Wheel condition","No oil leak trace",
                        "Motion alarm","Amber flashing beacon","Horn"
                    };
                    foreach (string desc in itemDescriptions)
                    {
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
                    // ROW 2: SUB-HEADERS LABELS MATRIX ("OK" & "NG" Sizing)
                    // ==========================================
                    e.Row.Cells[0].Text = "No";
                    e.Row.Cells[1].Text = "Company Vendor";
                    e.Row.Cells[2].Text = "Driving License";
                    e.Row.Cells[3].Text = "SDIEM PIC";
                    e.Row.Cells[4].Text = "Group PIC";
                    e.Row.Cells[5].Text = "Valid until";

                    for (int k = 6; k < e.Row.Cells.Count; k++)
                    {
                        //e.Row.Cells[k].Text = (k % 2 == 0) ? "OK" : "NG"; // Index 6 is even (OK), Index 7 is odd (NG)
                        e.Row.Cells[k].Font.Size = FontUnit.Small;
                        e.Row.Cells[k].Font.Bold = true;
                        //e.Row.Cells[k].BackColor = System.Drawing.ColorTranslator.FromHtml(headerBg);
                        e.Row.Cells[k].Width = Unit.Pixel(30);
                    }
                }
            }
        }

        protected void btnSaveBackhoe_Click(object sender, EventArgs e)
        {
            lblValidationError.Text = ""; // Reset validation message banner
            bool hasValidData = false;

            foreach (GridViewRow row in GridBackhoe.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    string license = ((TextBox)row.FindControl("txtDrivingLicense")).Text.Trim();
                    string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text.Trim();
                    string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text.Trim();
                    string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text.Trim();
          
                    if (!string.IsNullOrEmpty(comp) || !string.IsNullOrEmpty(license) || !string.IsNullOrEmpty(cPic))
                    {
                        if (string.IsNullOrEmpty(comp)) { lblValidationError.Text = "Error: Please select a valid Company Vendor."; return; }
                        if (string.IsNullOrEmpty(license)) { lblValidationError.Text = "Error: 'Driving License' cannot be left empty."; return; }
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

            // ========================================================
            // STAGE 2: ORACLE DATABASE SECURE MASS VALUES INSERTION
            // ========================================================
            using (OracleConnection conn = new OracleConnection(connString))
            {
                conn.Open();
                foreach (GridViewRow row in GridBackhoe.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                        string license = ((TextBox)row.FindControl("txtDrivingLicense")).Text.Trim();
                        string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text.Trim();
                        string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text.Trim();
                        string vDate = ((TextBox)row.FindControl("txtValidUntil")).Text.Trim();

                        // Skip processing lines that are entirely unpopulated
                        if (string.IsNullOrEmpty(license) && string.IsNullOrEmpty(comp)) continue;

                        // Built exactly to correspond to parameter ordering constraints requested by your structural DDL
                        string insertQuery = @"INSERT INTO VENDOR_BACKHOE_RESULTS (
                    COMPANY_VENDOR, DRIVING_LICENSE, SDIEM_PIC, GROUP_PIC, VALID_UNTIL,
                    CAB_CLEAN, CAB_SEAT_COND, CAB_PEDAL_COND, CAB_WINDOW_WIPER, CAB_LEVERS_CTRL,
                    SPEC_ROLL_ROPES, SPEC_REAR_MIRRORS, SPEC_HANDRAILS, SPEC_FAN, SPEC_LOADER_BUCKET, SPEC_BUCKET_COND, SPEC_HITCH_PIN, SPEC_OUTRIGGERS_COND, SPEC_HYD_HOSES, SPEC_CONNECTION_FIT, SPEC_ENGINE_GUARD, SPEC_WHEEL_COND, SPEC_OIL_LEAK,
                    WD_MOTION_ALARM, WD_AMBER_BEACON, WD_HORN
                ) VALUES (
                    :comp, :license, :cPic, :gPic, :vDate,
                    :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :f9, :f10, :f11, :f12, :f13, :f14, :f15, :f16, :f17, :f18, :f19, :f20, :f21
                )";

                        using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                        {
                            // Core details parameters map first to match the sequence precisely
                            cmd.Parameters.AddWithValue("comp", comp);
                            cmd.Parameters.AddWithValue("license", license);
                            cmd.Parameters.AddWithValue("cPic", cPic);
                            cmd.Parameters.AddWithValue("gPic", gPic);
                            cmd.Parameters.AddWithValue("vDate", vDate);

                            // Binds radio buttons strings loop ordered exactly matching your SQL VALUES tokens sequence list
                            string[] fields = { "CabClean", "CabSeat", "CabPedal", "CabWiper", "CabLevers", "SpecRoll", "SpecMirrors", "SpecHandrails", "SpecFan", "SpecLoader", "SpecBucket", "SpecHitch", "SpecOutriggers", "SpecHoses", "SpecConnection", "SpecEngine", "SpecWheel", "SpecOil", "WdMotion", "WdBeacon", "WdHorn" };
                            for (int i = 0; i < fields.Length; i++)
                            {
                                RadioButton rbOk = (RadioButton)row.FindControl("rb" + fields[i] + "Ok");
                                string val = (rbOk != null && rbOk.Checked) ? "Y" : "N";

                                // Enforces strict sequential numerical parameter values mapping behind text data fields
                                cmd.Parameters.AddWithValue("f" + (i + 1), val);
                            }
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            // Reset layout page clean after save completed and refresh logging panels
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

                string query = @"SELECT * FROM VENDOR_BACKHOE_RESULTS" + conditionClause + " ORDER BY ID DESC";

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
                string[] groupNames = { "Hydraulic", "Warning Devices", "Specification", "Engine & Power" };
                int[] groupSpans = { 3, 3, 5, 5 };

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
                for (int i = 0; i <= 24; i++)
                {
                    e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); //#F2F2F2    #BFD3E5
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 9; i <= 24; i++)
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
                    for (int i = 0; i <= 24; i++)
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
                string sql = "UPDATE VENDOR_BACKHOE_RESULTS SET DEL_FLAG = 'Y', UPDATED_DATE = SYSDATE WHERE ID = :id";
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
                    string sql = "UPDATE VENDOR_BACKHOE_RESULTS SET DEL_FLAG = 'N', UPDATED_DATE = SYSDATE WHERE ID = :id";
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
            Response.AddHeader("content-disposition", "attachment;filename=Bom_Lift_Report_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Disable pagination to export all rows across all pages
                GridHistory.AllowPaging = false;
                BindHistoryLog();

                // Hide columns
                GridHistory.Columns[26].Visible = false;

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
                    for (int i = 0; i <= 24; i++) { GridHistory.HeaderRow.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); }
                }

                foreach (GridViewRow row in GridHistory.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        for (int j = 0; j <= 24; j++)
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
                //GridHistory.Columns[28].Visible = true;
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