//Author : Prasanth Sagivan
//Date : 26-04-2022

using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.OracleClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Drawing;

namespace EHS_Construction_Management_System
{
    public partial class Default2 : System.Web.UI.Page
    {
        OracleConnection conn = new OracleConnection(System.Configuration.ConfigurationManager.ConnectionStrings["OracleConnGMS"].ConnectionString);
        OracleDataAdapter adapt = new OracleDataAdapter();

        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        DataTable dt2 = new DataTable();

        protected void Clear()
        {
            emp_name2.Text = "";
            ic_no2.Text = "";
            Exp_Date.Text = "";
            CIDB.Text = "";
            this.Calendar1.Visible = false;
            this.Calendar2.Visible = false;
            this.Calendar3.Visible = false;
            TextBox2.Text = "";
            TextBox3.Text = "";
            TextBox4.Text = "";
            TextBox5.Text = "";
            TextBox6.Text = "";
            TextBox7.Text = "";
            TextBox8.Text = "";
            this.Calendar4.Visible = false;
            this.Calendar5.Visible = false;

            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            this.TextBox9.Visible = false;
            this.TextBox6.Visible = true;

            this.Label7.Visible = true;
            this.DropDownList1.Visible = true;
            this.DropDownList1.DataBind();
            this.DropDownList2.Visible = false;
            this.DropDownList2.DataBind();
            this.TextBox6.Visible = true;
            this.DropDownList3.Visible = true;
            this.DropDownList3.DataBind();
            this.DropDownList4.Visible = true;
            this.DropDownList4.DataBind();

            this.Blink1.Visible = false;
            this.Blink2.Visible = false;

        }
        protected void BindData()
        {
            String dateNow;
            dateNow = this.Calendar1.SelectedDate.ToString("yyyyMMdd");

            //OracleCommand grid = new OracleCommand("", conn);
            OracleCommand grid1 = new OracleCommand("SELECT ATT_DATE,DATE_TIME_IN,CMF_1,EMP_NAME,IC_NO,COMP_NAME,WORK_WEEK FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY IN ('PJ5C','PJ5E') ORDER BY DATE_TIME_IN DESC", conn);
            OracleCommand grid2 = new OracleCommand("SELECT * FROM VENDOR_ATT_MST WHERE TRIM(FACTORY) IS NULL", conn);
            adapt.SelectCommand = grid1;
            adapt.Fill(dt1);
            adapt.SelectCommand = grid2;
            adapt.Fill(dt2);

            conn.Open();
            GridView1.DataSource = dt1;
            GridView1.DataBind();
            conn.Close();
            conn.Open();
            GridView2.DataSource = dt2;
            GridView2.DataBind();
            conn.Close();

            //this.GridView2.Visible = false;
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Default3.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Clear();
            if (!IsPostBack)
            {
                this.BindData();
                Clear();
            }
        }
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            //this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.TextBox1.Text = this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.Calendar1.Visible = false;
        }
        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            //this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.Exp_Date.Text = this.Calendar2.SelectedDate.ToString("yyyyMMdd");
            this.Calendar2.Visible = false;
        }
        protected void Calendar3_SelectionChanged(object sender, EventArgs e)
        {
            //this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.CIDB.Text = this.Calendar3.SelectedDate.ToString("yyyyMMdd");
            this.Calendar3.Visible = false;
        }
        protected void Calendar4_SelectionChanged(object sender, EventArgs e)
        {
            //this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.TextBox5.Text = this.Calendar4.SelectedDate.ToString("yyyyMMdd");
            this.Calendar4.Visible = false;
        }
        protected void Calendar5_SelectionChanged(object sender, EventArgs e)
        {
            //this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            this.TextBox4.Text = this.Calendar5.SelectedDate.ToString("yyyyMMdd");
            this.Calendar5.Visible = false;
        }

        protected void ImageButton7_Click(object sender, EventArgs e)
        {
            this.Calendar1.Visible = true;
        }
        protected void ImageButton3_Click(object sender, EventArgs e)
        {
            this.Calendar2.Visible = true;
        }
        protected void ImageButton4_Click1(object sender, EventArgs e)
        {
            this.Calendar3.Visible = true;
        }
        protected void ImageButton5_Click1(object sender, EventArgs e)
        {
            this.Calendar4.Visible = true;
        }
        protected void ImageButton6_Click1(object sender, EventArgs e)
        {
            this.Calendar5.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Today;
            CultureInfo ci = CultureInfo.CurrentCulture;
            int weekNum = ci.Calendar.GetWeekOfYear(dt, CalendarWeekRule.FirstFullWeek, DayOfWeek.Monday);
            weekNum = weekNum / 12;
            string weekday = dt.DayOfWeek.ToString();

            String dateNow;
            DateTime aDate = DateTime.Now;
            dateNow = aDate.ToString("yyyyMMdd");

            String datetimeNow;
            DateTime aDatetime = DateTime.Now;
            datetimeNow = aDatetime.ToString("HH:mm:ss");

            String CARD_status = "NEW";
            String CARD_status2 = "RENEWAL";


            if (emp_name2.Text == "")
            {
                string script = "alert(\"Please fill-up Employee Name !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            if (ic_no2.Text == "")
            {
                string script = "alert(\"Please fill-up IC number !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            if (Exp_Date.Text == "")
            {
                string script = "alert(\"Please fill-up Green Card Expiry Number !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            if (CIDB.Text == "")
            {
                string script = "alert(\"Please fill-up CIDB Expiry Number !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            else
            {
                int countIC = 0;

                OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + ic_no2.Text + "'", conn);
                conn.Open();
                checkIC.ExecuteScalar();
                countIC = int.Parse(checkIC.ExecuteScalar().ToString());
                conn.Close();

                if (countIC == 1)
                {
                    string script = "alert(\"IC No already Exist !!!\");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    Clear();
                    return;
                }
                else
                {
                    if (CheckBox3.Checked == false)
                    {

                        OracleCommand insert_mstData = new OracleCommand("INSERT INTO VENDOR_ATT_MST (REG_TIME,IC_NO,COMP_NAME,EMP_NAME,CMF_1,CMF_2,CMF_3,CMF_4) VALUES(TO_CHAR(SYSDATE, 'YYYYMMDD'),'" + ic_no2.Text + "','" + DropDownList1.SelectedValue + "','" + emp_name2.Text + "','" + CARD_status + "','" + Exp_Date.Text + "','" + CIDB.Text + "','" + DropDownList3.SelectedValue + "')", conn);
                        conn.Open();
                        insert_mstData.ExecuteNonQuery();
                        conn.Close();
                        string script = "alert(\"Success !!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        //Clear();
                        return;
                    }
                    if (CheckBox3.Checked == true)
                    {
                        int countComp = 0;

                        OracleCommand checkComp = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE COMP_NAME = '" + TextBox9.Text + "'", conn);
                        conn.Open();
                        checkComp.ExecuteScalar();
                        countComp = int.Parse(checkComp.ExecuteScalar().ToString());
                        conn.Close();

                        if (countComp == 1)
                        {
                            string script = "alert(\"Company Name already Exist !!!\");";
                            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                            Clear();
                            return;
                        }
                        else
                        {
                            OracleCommand insertNew = new OracleCommand("INSERT INTO VENDOR_ATT_MST (REG_TIME,IC_NO,COMP_NAME,EMP_NAME,CMF_1,CMF_2,CMF_3,CMF_4) VALUES(TO_CHAR(SYSDATE, 'YYYYMMDD'),'" + ic_no2.Text + "','" + TextBox9.Text + "','" + emp_name2.Text + "','" + CARD_status + "','" + Exp_Date.Text + "','" + CIDB.Text + "','" + DropDownList3.SelectedValue + "')", conn);
                            OracleCommand New_comp = new OracleCommand("INSERT INTO GA_MASTER (TABLE_NAME,V1) VALUES ('VENDOR_ATT_MST','" + TextBox9.Text + "')", conn);
                            conn.Open();
                            insertNew.ExecuteNonQuery();
                            New_comp.ExecuteNonQuery();
                            conn.Close();
                            string script = "alert(\"Success !!!\");";
                            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                            //Clear();
                            return;
                        }
                    }
                }
            }

        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Today;
            CultureInfo ci = CultureInfo.CurrentCulture;
            int weekNum = ci.Calendar.GetWeekOfYear(dt, CalendarWeekRule.FirstFullWeek, DayOfWeek.Monday);
            weekNum = weekNum / 12;
            string weekday = dt.DayOfWeek.ToString();

            String dateNow;
            DateTime aDate = DateTime.Now;
            dateNow = aDate.ToString("yyyyMMdd");

            String datetimeNow;
            DateTime aDatetime = DateTime.Now;
            datetimeNow = aDatetime.ToString("HH:mm:ss");

            String CARD_status = "NEW";
            String CARD_status2 = "RENEWAL";

            if (TextBox4.Text == "")
            {
                string script = "alert(\"Please fill-up Green Card Expiry Number !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            if (TextBox5.Text == "")
            {
                string script = "alert(\"Please fill-up CIDB Expiry Number !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            else
            {
                if (CheckBox4.Checked == true)
                {
                    int countIC = 0;

                    OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                    conn.Open();
                    checkIC.ExecuteScalar();
                    countIC = int.Parse(checkIC.ExecuteScalar().ToString());
                    conn.Close();

                    if (countIC == 1)
                    {
                        OracleCommand update_gcrad = new OracleCommand("UPDATE VENDOR_ATT_MST SET COMP_NAME = '" + DropDownList2.SelectedValue + "',CMF_1 = '" + CARD_status + "',CMF_2 = '" + TextBox4.Text + "',CMF_3 = '" + TextBox5.Text + "',CMF_4 = '" + DropDownList4.SelectedValue + "' WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                        conn.Open();
                        update_gcrad.ExecuteNonQuery();
                        conn.Close();
                        string script = "alert(\"Success !!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        //Clear();
                        return;
                    }
                    else
                    {
                        string script = "alert(\"IC No Not Exist !!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        Clear();
                        return;
                    }
                }
                else
                {
                    int countIC = 0;

                    OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                    conn.Open();
                    checkIC.ExecuteScalar();
                    countIC = int.Parse(checkIC.ExecuteScalar().ToString());
                    conn.Close();

                    if (countIC == 1)
                    {
                        OracleCommand update_gcrad = new OracleCommand("UPDATE VENDOR_ATT_MST SET CMF_1 = '" + CARD_status + "',CMF_2 = '" + TextBox4.Text + "',CMF_3 = '" + TextBox5.Text + "',CMF_4 = '" + DropDownList4.SelectedValue + "' WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                        conn.Open();
                        update_gcrad.ExecuteNonQuery();
                        conn.Close();
                        string script = "alert(\"Success !!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        //Clear();
                        return;
                    }
                    else
                    {
                        string script = "alert(\"IC No Not Exist !!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        Clear();
                        return;
                    }
                }
            }

        }

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView2.PageIndex = e.NewPageIndex;
            this.BindData();
        }

        private void ExportGridToExcel()
        {
            //this.TextBox1.Text = this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            String dateNow;
            //DateTime aDate = DateTime.Now;
            //dateNow = aDate.ToString("yyyyMMdd");
            dateNow = this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            //this.TextBox1.Text = this.Calendar1.SelectedDate.ToString("yyyyMMdd");

            if (Calendar1.SelectedDate.Date == null)
            {
                string script = "alert(\"Please select a date !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            if (TextBox1.Text == "")
            {
                string script = "alert(\"Please select a date !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                return;
            }
            else
            {
                /*Response.Clear();
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "";
                string FileName = "Vendor_Daily_Attendance " + DateTime.Now + ".xls";
                StringWriter strwritter = new StringWriter();
                HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
                GridView1.GridLines = GridLines.Both;
                GridView1.HeaderStyle.Font.Bold = true;
                GridView1.RenderControl(htmltextwrtter);
                Response.Write(strwritter.ToString());
                Response.End();*/

                Response.Clear();
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.AddHeader("content-disposition", "attachment;filename=Vendor_Daily_Att_" + dateNow + ".xls");//"Vendor_Daily_Attendance " + DateTime.Now + ".xls"  // "attachment;filename=Vendor_Daily_Attendance .xls");
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/vnd.ms-excel";

                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);

                    //To Export all pages
                    GridView1.AllowPaging = false;
                    this.BindData();

                    GridView1.HeaderRow.BackColor = Color.White;
                    //GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
                    //Applying stlye to gridview header cells
                    for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
                    {
                        GridView1.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
                    }
                    int j = 1;

                    foreach (TableCell cell in GridView1.HeaderRow.Cells)
                    {
                        cell.BackColor = GridView1.HeaderStyle.BackColor;
                    }
                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        row.BackColor = Color.White;
                        foreach (TableCell cell in row.Cells)
                        {
                            if (row.RowIndex % 2 == 0)
                            {
                                cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                            }
                            else
                            {
                                cell.BackColor = GridView1.RowStyle.BackColor;
                            }
                            //cell.CssClass = "textmode";
                        }
                    }

                    GridView1.RenderControl(hw);



                    //style to format numbers to string
                    string style = @"<style> TD { mso-number-format:\@; } </style>";
                    //string style = @"<style> .textmode { } </style>";
                    Response.Write(style);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();



                }
            }


        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //required to avoid the runtime error "  
            //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel();
        }

        protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
        {
            String dateNow;
            DateTime aDate = DateTime.Now;
            dateNow = aDate.ToString("yyyyMMdd");
            //dateNow = this.Calendar1.SelectedDate.ToString("yyyyMMdd");
            //grid2
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.AddHeader("content-disposition", "attachment;filename=Vendor_Master_Data" + dateNow + ".xls");//"Vendor_Daily_Attendance " + DateTime.Now + ".xls"  // "attachment;filename=Vendor_Daily_Attendance .xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView2.AllowPaging = false;
                this.BindData();

                GridView2.HeaderRow.BackColor = Color.White;
                //GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
                //Applying stlye to gridview header cells
                for (int i = 0; i < GridView2.HeaderRow.Cells.Count; i++)
                {
                    GridView2.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
                }
                int j = 1;

                foreach (TableCell cell in GridView2.HeaderRow.Cells)
                {
                    cell.BackColor = GridView2.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView2.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView2.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView2.RowStyle.BackColor;
                        }
                        //cell.CssClass = "textmode";
                    }
                }

                GridView2.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> TD { mso-number-format:\@; } </style>";
                //string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked == true)
            {
                CIDB.Text = "#N/A";
            }
            else
            {
                CIDB.Text = "";
            }
        }
        protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox2.Checked == true)
            {
                TextBox5.Text = "#N/A";
            }
            else
            {
                TextBox5.Text = "";
            }
        }
        protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox3.Checked == true)
            {
                this.TextBox9.Visible = true;
                TextBox9.Text = "";
                this.Label7.Visible = false;
                this.DropDownList1.Visible = false;
            }
            else
            {
                this.TextBox9.Visible = false;
                this.Label7.Visible = true;
                this.DropDownList1.Visible = true;
            }
        }
        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

            String dateNow;
            String status = "";
            DateTime aDate = DateTime.Now;
            dateNow = aDate.ToString("yyyyMMdd");

            int countIC = 0;

            OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
            conn.Open();
            checkIC.ExecuteScalar();
            countIC = int.Parse(checkIC.ExecuteScalar().ToString());
            conn.Close();

            if (countIC == 0)
            {
                string script = "alert(\"IC No Does not Exist !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                Clear();
                return;
            }
            else
            {
                OracleCommand empname = new OracleCommand("SELECT EMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                empname.ExecuteScalar();
                TextBox2.Text = empname.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand compname = new OracleCommand("SELECT COMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                compname.ExecuteScalar();
                TextBox6.Text = compname.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand gcard = new OracleCommand("SELECT CMF_2 FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                gcard.ExecuteScalar();
                TextBox7.Text = gcard.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand cidb = new OracleCommand("SELECT CMF_3 FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                cidb.ExecuteScalar();
                TextBox8.Text = cidb.ExecuteScalar().ToString();
                conn.Close();

                OracleCommand blink = new OracleCommand("SELECT CMF_1 FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                blink.ExecuteScalar();
                status = blink.ExecuteScalar().ToString();
                conn.Close();

                if (status == "RENEWAL")
                {
                    Blink1.Visible = true;
                    Blink1.CssClass = "blink";
                }
                else
                {
                    Blink1.Visible = false;
                }

                OracleCommand CC = new OracleCommand("SELECT CMF_4 FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox3.Text + "'", conn);
                conn.Open();
                CC.ExecuteScalar();
                DropDownList4.SelectedValue = CC.ExecuteScalar().ToString();
                conn.Close();

            }

        }
        protected void CheckBox4_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox4.Checked == true)
            {
                this.TextBox6.Visible = false;
                this.DropDownList2.Visible = true;
            }
            else
            {
                this.TextBox6.Visible = true;
                this.DropDownList2.Visible = false;
            }
        }
    }
}