using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;

namespace EHS_Construction_Management_System
{
    public partial class Default4 : System.Web.UI.Page
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
            DataTable dt = CreatePatrolStructure();

            DataRow dr = dt.NewRow();
            SetDefaultRowValues(dr);
            dt.Rows.Add(dr);

            ViewState["CurrentPatrolData"] = dt;
            BindGridWithCompanies();
        }

        private DataTable CreatePatrolStructure()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PATROL_DATE");
            dt.Columns.Add("WORK_AREA");
            dt.Columns.Add("COMPANY");
            dt.Columns.Add("SDIEM_PIC");
            dt.Columns.Add("GROUP_PIC");
            dt.Columns.Add("JOB_DESC");
            dt.Columns.Add("CH_PTW");
            dt.Columns.Add("CH_DRI");
            dt.Columns.Add("CH_JSA");
            dt.Columns.Add("CH_SWI");
            dt.Columns.Add("PPE_OK");
            dt.Columns.Add("PPE_NG");
            dt.Columns.Add("EQ_OK");
            dt.Columns.Add("EQ_NG");
            return dt;
        }

        private void SetDefaultRowValues(DataRow dr)
        {
            dr["CH_PTW"] = "N";
            dr["CH_DRI"] = "N";
            dr["CH_JSA"] = "N";
            dr["CH_SWI"] = "N";

            dr["PPE_OK"] = "N"; dr["PPE_NG"] = "N";
            dr["EQ_OK"] = "N";  dr["EQ_NG"] = "N";
        }

        private void BindGridWithCompanies()
        {
            DataTable dt = (DataTable)ViewState["CurrentPatrolData"];
            GridPatrol.DataSource = dt;
            GridPatrol.DataBind();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "initSelect2", "initSearchableDropdowns();", true);
        }

        // Trigger when user clicks "+ Add New Row"
        protected void btnAddNewRow_Click(object sender, EventArgs e)
        {
            DataTable dt = CreatePatrolStructure();

            // First, User entries already typed into the existing rows aren't lost
            foreach (GridViewRow row in GridPatrol.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    DataRow drExisting = dt.NewRow();
                    drExisting["PATROL_DATE"] = ((TextBox)row.FindControl("txtDate")).Text;
                    drExisting["WORK_AREA"] = ((TextBox)row.FindControl("txtWorkArea")).Text;
                    drExisting["COMPANY"] = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    drExisting["SDIEM_PIC"] = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    drExisting["GROUP_PIC"] = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    drExisting["JOB_DESC"] = ((TextBox)row.FindControl("txtJob")).Text;

                    drExisting["CH_PTW"] = ((CheckBox)row.FindControl("chkPtw")).Checked ? "Y" : "N";
                    drExisting["CH_DRI"] = ((CheckBox)row.FindControl("chkDri")).Checked ? "Y" : "N";
                    drExisting["CH_JSA"] = ((CheckBox)row.FindControl("chkJsa")).Checked ? "Y" : "N";
                    drExisting["CH_SWI"] = ((CheckBox)row.FindControl("chkSwi")).Checked ? "Y" : "N";

                    drExisting["PPE_OK"] = ((RadioButton)row.FindControl("rbPpeOk")).Checked ? "Y" : "N";
                    drExisting["PPE_NG"] = ((RadioButton)row.FindControl("rbPpeNg")).Checked ? "Y" : "N";
                    drExisting["EQ_OK"] = ((RadioButton)row.FindControl("rbEqOk")).Checked ? "Y" : "N";
                    drExisting["EQ_NG"] = ((RadioButton)row.FindControl("rbEqNg")).Checked ? "Y" : "N";

                    dt.Rows.Add(drExisting);
                }
            }

            // blank row at the end of grid
            DataRow drNew = dt.NewRow();
            SetDefaultRowValues(drNew);
            dt.Rows.Add(drNew);

            ViewState["CurrentPatrolData"] = dt;
            BindGridWithCompanies();
        }

        protected void GridPatrol_RowDataBound(object sender, GridViewRowEventArgs e)
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
                            DataTable dtCompanies = new DataTable();
                            da.Fill(dtCompanies);
                            ddl.DataSource = dtCompanies;
                            ddl.DataTextField = "COMP_NAME";
                            ddl.DataValueField = "COMP_NAME";
                            ddl.DataBind();
                            ddl.Items.Insert(0, new ListItem("", ""));
                        }
                    }

                    DataRowView drv = (DataRowView)e.Row.DataItem;
                    if (drv != null && !string.IsNullOrEmpty(drv["COMPANY"].ToString()))
                    {
                        ddl.SelectedValue = drv["COMPANY"].ToString();

                        RadioButton rbPpeOk = (RadioButton)e.Row.FindControl("rbPpeOk");
                        RadioButton rbPpeNg = (RadioButton)e.Row.FindControl("rbPpeNg");
                        RadioButton rbEqOk = (RadioButton)e.Row.FindControl("rbEqOk");
                        RadioButton rbEqNg = (RadioButton)e.Row.FindControl("rbEqNg");

                        if (rbPpeOk != null && drv["PPE_OK"] != DBNull.Value) rbPpeOk.Checked = (drv["PPE_OK"].ToString() == "Y");
                        if (rbPpeNg != null && drv["PPE_NG"] != DBNull.Value) rbPpeNg.Checked = (drv["PPE_NG"].ToString() == "Y");
                        if (rbEqOk != null && drv["EQ_OK"] != DBNull.Value) rbEqOk.Checked = (drv["EQ_OK"].ToString() == "Y");
                        if (rbEqNg != null && drv["EQ_NG"] != DBNull.Value) rbEqNg.Checked = (drv["EQ_NG"].ToString() == "Y");
                    }
                }
            }
        }

        protected void FilterRadio_CheckedChanged(object sender, EventArgs e)
        {
            GridHistory.PageIndex = 0; // Reset to page 1
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

                string query = @"SELECT * FROM VENDOR_SAFETY_PATROL_RESULTS" + conditionClause + " ORDER BY ID DESC";

                using (OracleDataAdapter da = new OracleDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridHistory.DataSource = dt;
                    GridHistory.DataBind();
                }
            }
        }

        protected void GridHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i <= 16; i++)
                {
                    e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2"); //#F2F2F2    #BFD3E5
                }
            }
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 8; i <= 15; i++)
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
                        e.Row.Cells[i].Text = "";
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
                    for (int i = 0; i <= 16; i++)
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

        protected void GridHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RestoreRecord")
            {
                string recordID = e.CommandArgument.ToString();

                using (OracleConnection conn = new OracleConnection(connString))
                {
                    // Restores delete record
                    string restoreSql = @"UPDATE VENDOR_SAFETY_PATROL_RESULTS 
                                  SET DEL_FLAG = 'N', 
                                      UPDATED_DATE = SYSDATE 
                                  WHERE ID = :id";

                    using (OracleCommand cmd = new OracleCommand(restoreSql, conn))
                    {
                        cmd.Parameters.AddWithValue("id", recordID);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                BindHistoryLog();
            }
        }

        protected void GridHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridHistory.PageIndex = e.NewPageIndex;
            this.BindHistoryLog();
        }

        protected void GridPatrol_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;
                GridViewRow extraHeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                TableCell cellWorkDetails = new TableCell { Text = "Work Details", ColumnSpan = 7, HorizontalAlign = HorizontalAlign.Center };
                cellWorkDetails.Font.Bold = true; extraHeaderRow.Cells.Add(cellWorkDetails);

                TableCell cellSafetyDoc = new TableCell { Text = "Safety document check item", ColumnSpan = 4, HorizontalAlign = HorizontalAlign.Center };
                cellSafetyDoc.Font.Bold = true; extraHeaderRow.Cells.Add(cellSafetyDoc);

                TableCell cellPpe = new TableCell { Text = "PPE", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellPpe.Font.Bold = true; extraHeaderRow.Cells.Add(cellPpe);

                TableCell cellEquip = new TableCell { Text = "Equipment Status", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellEquip.Font.Bold = true; extraHeaderRow.Cells.Add(cellEquip);

                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];
                    innerTable.Rows.AddAt(0, extraHeaderRow);
                }
            }
        }

        protected void GridHistory_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView grid = (GridView)sender;
                GridViewRow extraHeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

                TableCell cellWork = new TableCell { Text = "Work Details", ColumnSpan = 7, HorizontalAlign = HorizontalAlign.Center };
                cellWork.Font.Bold = true; cellWork.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellWork.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellWork);

                TableCell cellDoc = new TableCell { Text = "Safety document check item", ColumnSpan = 4, HorizontalAlign = HorizontalAlign.Center };
                cellDoc.Font.Bold = true; cellDoc.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellDoc.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellDoc);

                TableCell cellPpe = new TableCell { Text = "PPE", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellPpe.Font.Bold = true; cellPpe.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellPpe.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellPpe);

                TableCell cellEq = new TableCell { Text = "Equipment Status", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellEq.Font.Bold = true; cellEq.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellEq.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellEq);

                TableCell cellSpacer = new TableCell { Text = "System Log Info", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                cellSpacer.Font.Bold = true; cellSpacer.BackColor = System.Drawing.Color.FromName("#F2F2F2"); cellSpacer.ForeColor = System.Drawing.Color.Black;
                extraHeaderRow.Cells.Add(cellSpacer);

                //if (!isExcelExport)
                //{
                //    TableCell cellSpacer = new TableCell { Text = "System Log Info", ColumnSpan = 2, HorizontalAlign = HorizontalAlign.Center };
                //    cellSpacer.Font.Bold = true; cellSpacer.BackColor = System.Drawing.ColorTranslator.FromHtml("#BFD3E5");
                //    extraHeaderRow.Cells.Add(cellSpacer);
                //}

                if (grid.Controls.Count > 0 && grid.Controls[0] is Table)
                {
                    Table innerTable = (Table)grid.Controls[0];
                    innerTable.Rows.AddAt(0, extraHeaderRow);
                }
            }
        }

        protected void GridHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string targetID = GridHistory.DataKeys[e.RowIndex].Value.ToString();

            using (OracleConnection conn = new OracleConnection(connString))
            {
                //Delete row permanently
                //string deleteSql = "DELETE FROM VENDOR_SAFETY_PATROL_RESULTS WHERE ID = :id";

                //Update delete flag
                string deleteSql = "UPDATE VENDOR_SAFETY_PATROL_RESULTS SET DEL_FLAG = 'Y', UPDATED_DATE = SYSDATE WHERE ID = :id";

                using (OracleCommand cmd = new OracleCommand(deleteSql, conn))
                {
                    cmd.Parameters.AddWithValue("id", targetID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindHistoryLog(); // Reload bottom grid
        }

        protected void btnSavePatrol_Click(object sender, EventArgs e)
        {
            lblValidationError.Text = "";
            bool hasValidData = false;

            //Validation Loop
            foreach (GridViewRow row in GridPatrol.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string pDate = ((TextBox)row.FindControl("txtDate")).Text;
                    string wArea = ((TextBox)row.FindControl("txtWorkArea")).Text;
                    string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                    string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                    string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text;
                    string pJob = ((TextBox)row.FindControl("txtJob")).Text;

                    CheckBox ptw = (CheckBox)row.FindControl("chkPtw");
                    CheckBox dri = (CheckBox)row.FindControl("chkDri");
                    CheckBox jsa = (CheckBox)row.FindControl("chkJsa");
                    CheckBox swi = (CheckBox)row.FindControl("chkSwi");

                    RadioButton ppeOk = (RadioButton)row.FindControl("rbPpeOk");
                    RadioButton ppeNg = (RadioButton)row.FindControl("rbPpeNg");
                    RadioButton eqOk = (RadioButton)row.FindControl("rbEqOk");
                    RadioButton eqNg = (RadioButton)row.FindControl("rbEqNg");

                    if (!string.IsNullOrEmpty(wArea) || !string.IsNullOrEmpty(comp) || !string.IsNullOrEmpty(pDate))
                    {
                        if (string.IsNullOrEmpty(pDate))
                        {
                            lblValidationError.Text = "Error: Please select a valid Date for all active rows.";
                            return;
                        }
                        if (string.IsNullOrEmpty(wArea))
                        {
                            lblValidationError.Text = "Error: 'Work Area' cannot be left empty.";
                            return;
                        }
                        if (string.IsNullOrEmpty(comp))
                        {
                            lblValidationError.Text = "Error: Please select a valid Company from the searchable dropdown list.";
                            return;
                        }
                        if (string.IsNullOrEmpty(cPic))
                        {
                            lblValidationError.Text = "Error: 'SDIEM PIC' cannot be left empty.";
                            return;
                        }
                        if (string.IsNullOrEmpty(gPic))
                        {
                            lblValidationError.Text = "Error: 'Group PIC' cannot be left empty.";
                            return;
                        }
                        if (string.IsNullOrEmpty(pJob))
                        {
                            lblValidationError.Text = "Error: 'Job' cannot be left empty.";
                            return;
                        }
                        if (!ptw.Checked && !dri.Checked && !jsa.Checked && !swi.Checked)
                        {
                            lblValidationError.Text = "Error: 'Safety document check item' cannot be left empty, please check atleast one item.";
                            return;
                        }
                        if (!ppeOk.Checked && !ppeNg.Checked)
                        {
                            lblValidationError.Text = "Error: 'PPE' cannot be left empty, please select OK or NG.";
                            return;
                        }
                        if (!eqOk.Checked && !eqNg.Checked)
                        {
                            lblValidationError.Text = "Error: 'Equipment Status' cannot be left empty, please select OK or NG.";
                            return;
                        }
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
                foreach (GridViewRow row in GridPatrol.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        string pDate = ((TextBox)row.FindControl("txtDate")).Text;
                        string wArea = ((TextBox)row.FindControl("txtWorkArea")).Text;
                        string comp = ((DropDownList)row.FindControl("ddlGridCompany")).SelectedValue;
                        string cPic = ((TextBox)row.FindControl("txtSdiemPic")).Text;
                        string gPic = ((TextBox)row.FindControl("txtGroupPic")).Text;
                        string pJob = ((TextBox)row.FindControl("txtJob")).Text;

                        string ptw = ((CheckBox)row.FindControl("chkPtw")).Checked ? "Y" : "N";
                        string dri = ((CheckBox)row.FindControl("chkDri")).Checked ? "Y" : "N";
                        string jsa = ((CheckBox)row.FindControl("chkJsa")).Checked ? "Y" : "N";
                        string swi = ((CheckBox)row.FindControl("chkSwi")).Checked ? "Y" : "N";

                        string ppeOk = ((RadioButton)row.FindControl("rbPpeOk")).Checked ? "Y" : "N";
                        string ppeNg = ((RadioButton)row.FindControl("rbPpeNg")).Checked ? "Y" : "N";
                        string eqOk = ((RadioButton)row.FindControl("rbEqOk")).Checked ? "Y" : "N";
                        string eqNg = ((RadioButton)row.FindControl("rbEqNg")).Checked ? "Y" : "N";

                        if (string.IsNullOrEmpty(wArea) && string.IsNullOrEmpty(comp)) continue;

                        string insertQuery = @"INSERT INTO VENDOR_SAFETY_PATROL_RESULTS 
                            (PATROL_DATE, WORK_AREA, COMPANY, SDIEM_PIC, GROUP_PIC, JOB_DESC, CH_PTW, CH_DRI, CH_JSA, CH_SWI, PPE_OK, PPE_NG, EQ_OK, EQ_NG) 
                            VALUES (:pDate, :wArea, :comp, :cPic, :gPic, :pJob, :ptw, :dri, :jsa, :swi, :ppeOk, :ppeNg, :eqOk, :eqNg)";

                        using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("pDate", pDate);
                            cmd.Parameters.AddWithValue("wArea", wArea);
                            cmd.Parameters.AddWithValue("comp", comp);
                            cmd.Parameters.AddWithValue("cPic", cPic);
                            cmd.Parameters.AddWithValue("gPic", gPic);
                            cmd.Parameters.AddWithValue("pJob", pJob);
                            cmd.Parameters.AddWithValue("ptw", ptw);
                            cmd.Parameters.AddWithValue("dri", dri);
                            cmd.Parameters.AddWithValue("jsa", jsa);
                            cmd.Parameters.AddWithValue("swi", swi);
                            cmd.Parameters.AddWithValue("ppeOk", ppeOk);
                            cmd.Parameters.AddWithValue("ppeNg", ppeNg);
                            cmd.Parameters.AddWithValue("eqOk", eqOk);
                            cmd.Parameters.AddWithValue("eqNg", eqNg);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            InitializeEmptyRows();
            BindHistoryLog();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Safety_Patrol_Report_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Disable pagination to export all rows across all pages
                GridHistory.AllowPaging = false;
                BindHistoryLog();

                // Hide columns
                GridHistory.Columns[16].Visible = false;

                if (GridHistory.Controls.Count > 0 && GridHistory.Controls[0] is Table)
                {
                    Table innerTable = (Table)GridHistory.Controls[0];

                    if (innerTable.Rows.Count > 0)
                    {
                        GridViewRow topHeaderRow = (GridViewRow)innerTable.Rows[0];

                        // Remove "System Log Info" Row 5 (Index 4)
                        if (topHeaderRow.Cells.Count > 4)
                        {
                            topHeaderRow.Cells.RemoveAt(4);
                            topHeaderRow.Attributes.Add("style", "text-align:center; vertical-align:middle;");
                            topHeaderRow.BackColor = System.Drawing.Color.White;
                        }
                    }
                }

                if (GridHistory.HeaderRow != null)
                {
                    for (int i = 0; i < 15; i++)
                    {
                        GridHistory.HeaderRow.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F2F2F2");
                        GridHistory.HeaderRow.Cells[i].ForeColor = System.Drawing.Color.Black;
                    }
                }

                foreach (GridViewRow row in GridHistory.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        for (int j = 0; j < 8; j++)
                        {
                            if (row.Cells.Count > j)
                            {
                                row.Cells[j].Attributes.Add("style", "text-align:center; vertical-align:middle;");
                            }
                        }
                        for (int i = 8; i < 15; i++)
                        {
                            string value = row.Cells[i].Text.Trim();

                            if (value == "Y")
                            {
                                row.Cells[i].Text = "&#10003";  //"✓";
                                row.Cells[i].Attributes["style"] = "font-weight:bold; color:blue; text-align:center; vertical-align:middle;";
                            }
                            else if (value == "N")
                            {
                                row.Cells[i].Text = "";
                            }
                            else
                            {
                                //
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

                // Restore column visibility
                GridHistory.Columns[16].Visible = true;
                GridHistory.AllowPaging = true;
                BindHistoryLog();

                Response.End();
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            //
        }
    }
}