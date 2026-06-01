//Author : Prasanth Sagivan
//Date : 26-04-2022

using System;
using System.Collections.Generic;
//using System.Linq;
//using System.Xml.Linq;
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
//using System.Web.Extensions;

namespace EHS_Construction_Management_System
{
    public partial class Default1 : System.Web.UI.Page
    {
        OracleConnection conn = new OracleConnection(System.Configuration.ConfigurationManager.ConnectionStrings["OracleConnGMS"].ConnectionString);
        OracleDataAdapter adapt = new OracleDataAdapter();

        DataTable dt1 = new DataTable();
        DataTable dt2 = new DataTable();

        protected void Clear()
        {
            ScanHere.Text = "";
            TextBox2.Text = "";
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            //String dateNow;
            //DateTime aDate = DateTime.Now;
            //dateNow = aDate.ToString("yyyyMMdd");

            //OracleCommand update_card = new OracleCommand("UPDATE VENDOR_ATT_MST SET CMF_1 = 'RENEWAL' WHERE CMF_2 <= '" + dateNow + "'", conn);
            //conn.Open();
            //update_card.ExecuteNonQuery();
            //conn.Close();

            Response.Redirect("Default2.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ScanHere.Focus();
            if (!IsPostBack)
            {
                this.BindData();
                //BindData();
                Clear();
            }

            //String dateNow;
            //DateTime aDate = DateTime.Now;
            //dateNow = aDate.ToString("yyyyMMdd");

            //OracleCommand update_card = new OracleCommand("UPDATE VENDOR_ATT_MST SET CMF_1 = 'RENEWAL' WHERE CMF_2 <= '" + dateNow + "'", conn);
            //conn.Open();
            //update_card.ExecuteNonQuery();
            //conn.Close();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //required to avoid the runtime error "  
            //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
        }

        protected void BindData()
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

            //OracleCommand grid = new OracleCommand("", conn);
            OracleCommand grid1 = new OracleCommand("SELECT B.ATT_DATE,B.DATE_TIME_IN,B.CMF_1,B.EMP_NAME,TRIM(REPLACE(B.IC_NO,'-','')) AS IC_NO,A.COMP_NAME,A.CMF_4,SUBSTR(A.CMF_2,7,2)||'/'||SUBSTR(A.CMF_2,5,2)||'/'||SUBSTR(A.CMF_2,0,4) AS STATUS,B.WORK_WEEK,A.CMF_1 AS WRKSTS FROM VENDOR_ATT_MST A,VENDOR_ATT_DATA B WHERE B.IC_NO = A.IC_NO AND B.ATT_DATE = '" + dateNow + "' AND B.FACTORY = 'PJ5E' ORDER BY DATE_TIME_IN DESC", conn);
            //OracleCommand grid1 = new OracleCommand("SELECT ATT_DATE,DATE_TIME_IN,CMF_1,EMP_NAME,TRIM(replace(IC_NO, '-', '')) AS IC_NO,COMP_NAME,WORK_WEEK FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' ORDER BY DATE_TIME_IN DESC", conn);
            //OracleCommand grid2 = new OracleCommand("SELECT COMP_NAME,COUNT(IC_NO) AS HEADCOUNT FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' GROUP BY COMP_NAME ORDER BY COUNT(IC_NO) DESC", conn);

            adapt.SelectCommand = grid1;
            adapt.Fill(dt1);
            //adapt.SelectCommand = grid2;
            //adapt.Fill(dt2);

            conn.Open();
            GridView1.DataSource = dt1;
            GridView1.DataBind();
            //GridView2.DataSource = dt2;
            //GridView2.DataBind();
            conn.Close();

            OracleCommand ttl_comp = new OracleCommand("SELECT COUNT (DISTINCT COMP_NAME) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5E'", conn);
            conn.Open();
            ttl_comp.ExecuteScalar();
            total_comp.Text = ttl_comp.ExecuteScalar().ToString();
            conn.Close();

            OracleCommand ttl_hc = new OracleCommand("SELECT COUNT (*) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5E'", conn);
            conn.Open();
            ttl_hc.ExecuteScalar();
            total_hc.Text = ttl_hc.ExecuteScalar().ToString();
            conn.Close();

        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.Cells[10].Text) == "RENEWAL")
                {
                    e.Row.Cells[8].BackColor = System.Drawing.Color.Crimson;
                    e.Row.Cells[10].BackColor = System.Drawing.Color.Crimson;
                }
            }
        }

        protected void ScanHere_TextChanged(object sender, EventArgs e)
        {
            int countIC = 0;

            OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "'", conn);
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
                OracleCommand empname = new OracleCommand("SELECT EMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "'", conn);
                conn.Open();
                empname.ExecuteScalar();
                emp_name.Text = empname.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand icno = new OracleCommand("SELECT IC_NO FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "'", conn);
                conn.Open();
                icno.ExecuteScalar();
                ic_no.Text = icno.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand compname = new OracleCommand("SELECT COMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "'", conn);
                conn.Open();
                compname.ExecuteScalar();
                comp_name.Text = compname.ExecuteScalar().ToString();
                conn.Close();
            }

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            int countIC = 0;

            OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox2.Text + "'", conn);
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
                OracleCommand empname = new OracleCommand("SELECT EMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox2.Text + "'", conn);
                conn.Open();
                empname.ExecuteScalar();
                emp_name.Text = empname.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand icno = new OracleCommand("SELECT IC_NO FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox2.Text + "'", conn);
                conn.Open();
                icno.ExecuteScalar();
                ic_no.Text = icno.ExecuteScalar().ToString();
                conn.Close();
                OracleCommand compname = new OracleCommand("SELECT COMP_NAME FROM VENDOR_ATT_MST WHERE IC_NO = '" + TextBox2.Text + "'", conn);
                conn.Open();
                compname.ExecuteScalar();
                comp_name.Text = compname.ExecuteScalar().ToString();
                conn.Close();
            }
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

            String space = " ";
            int countIC = 0;

            OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "'", conn);
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
                int countIC2 = 0;
                OracleCommand checkIC2 = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' and IC_NO = '" + ScanHere.Text + "'", conn);
                conn.Open();
                checkIC2.ExecuteScalar();
                countIC2 = int.Parse(checkIC2.ExecuteScalar().ToString());
                conn.Close();

                if (countIC2 == 0)
                {
                    //int countRTK;
                    //OracleCommand checkRTK = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_DATA WHERE IC_NO = '" + ScanHere.Text + "' AND WORK_WEEK = (TO_CHAR(SYSDATE, 'YYYYIW')) ", conn);
                    //conn.Open();
                    //checkRTK.ExecuteScalar();
                    //countRTK = int.Parse(checkRTK.ExecuteScalar().ToString());
                    //conn.Close();

                    //if (weekday == "Monday")
                    //{
                    //    //string script = "alert(\"already do RTk !!!\");";
                    //    //ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    //}
                    //else
                    //{
                    //    if (countRTK == 0)
                    //    {
                    //        //string script = "alert(\"Please do RTk !!!\");";
                    //        //ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    //    }
                    //    else
                    //    {
                    //        //string script = "alert(\"Success !!!\");";
                    //        //ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    //    }
                    //}

                    OracleCommand insert_Data = new OracleCommand("INSERT INTO VENDOR_ATT_DATA (ATT_DATE,WORK_WEEK,IC_NO,DATE_TIME_IN,CMF_1,COMP_NAME,EMP_NAME,FACTORY)" +
                    "VALUES('" + dateNow + "',(TO_CHAR(SYSDATE, 'YYYYIW')),(select IC_NO from VENDOR_ATT_MST where IC_NO = '" + ScanHere.Text + "')," +
                    "'" + datetimeNow + "','" + space + "',(select COMP_NAME from VENDOR_ATT_MST where IC_NO = '" + ScanHere.Text + "'),(select EMP_NAME from VENDOR_ATT_MST where IC_NO = '" + ScanHere.Text + "'),'PJ5E')", conn);
                    conn.Open();
                    insert_Data.ExecuteNonQuery();
                    conn.Close();
                    //string script = "alert(\"Success !!!\");";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    OracleCommand update_card = new OracleCommand("UPDATE VENDOR_ATT_MST SET CMF_1 = 'RENEWAL' WHERE IC_NO = '" + ScanHere.Text + "' AND CMF_2 <= '" + dateNow + "'", conn);
                    conn.Open();
                    update_card.ExecuteNonQuery();
                    conn.Close();

                    int countsts;
                    OracleCommand wrkpasssts = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_MST WHERE IC_NO = '" + ScanHere.Text + "' AND CMF_1 = 'RENEWAL'", conn);
                    conn.Open();
                    wrkpasssts.ExecuteNonQuery();
                    countsts = int.Parse(wrkpasssts.ExecuteScalar().ToString());
                    conn.Close();

                    if (countsts == 0)
                    {
                        //
                    }
                    else
                    {
                        string script = "alert(\"Work Pass Expired!!!! Please UPDATE!!!!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    }

                    BindData();
                    Clear();
                    return;
                }
                else
                {
                    string script = "alert(\"IC already Exist !!!\");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    Clear();
                    return;
                }



            }
        }

        protected void Button2_Click(object sender, EventArgs e)
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

            int countIC = 0;

            OracleCommand checkIC = new OracleCommand("SELECT COUNT(*) FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND IC_NO = '" + TextBox2.Text + "'", conn);
            conn.Open();
            checkIC.ExecuteScalar();
            countIC = int.Parse(checkIC.ExecuteScalar().ToString());
            conn.Close();

            if (countIC == 0)
            {
                string script = "alert(\"Employee TIME IN data does not exist !!!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                Clear();
                return;
            }
            else
            {
                OracleCommand Update_Data = new OracleCommand("UPDATE VENDOR_ATT_DATA SET CMF_1 = '" + datetimeNow + "' WHERE ATT_DATE = '" + dateNow + "' AND IC_NO = '" + TextBox2.Text + "'", conn);
                conn.Open();
                Update_Data.ExecuteNonQuery();
                conn.Close();
                //string script = "alert(\"Success !!!\");";
                //ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                BindData();
                Clear();
                return;
            }
        }

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindData();
        }

        private void ExportGridToExcel()
        {
            String dateNow;
            DateTime aDate = DateTime.Now;
            dateNow = aDate.ToString("yyyyMMdd");

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
            Response.AddHeader("content-disposition", "attachment;filename=Vendor_Daily_Att_" + dateNow + ".xls");//"Vendor_Daily_Attendance " + DateTime.Now + ".xls"  // "attachment;filename=Vendor_Daily_Attendance .xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;
                this.BindData();

                GridView1.HeaderRow.BackColor = Color.White;
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
                        cell.CssClass = "textmode";
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

        //protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        //{
        //    ExportGridToExcel();
        //}
    }
}