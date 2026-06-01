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
    public partial class Default3 : System.Web.UI.Page
    {
        OracleConnection conn = new OracleConnection(System.Configuration.ConfigurationManager.ConnectionStrings["OracleConnGMS"].ConnectionString);
        OracleDataAdapter adapt = new OracleDataAdapter();

        DataTable dt1 = new DataTable();
        DataTable dt2 = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindData();
                this.BindData();
            }


        }

        protected void OnPageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            //GridView2.PageIndex = e.NewPageIndex;
            this.BindData();
        }

        protected void OnPageIndexChanging2(object sender, GridViewPageEventArgs e)
        {
            //GridView1.PageIndex = e.NewPageIndex;
            GridView2.PageIndex = e.NewPageIndex;
            this.BindData();
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

            String monthNow;
            DateTime aMon = DateTime.Now;
            monthNow = aMon.ToString("yyyyMM");

            String datetimeNow;
            DateTime aDatetime = DateTime.Now;
            datetimeNow = aDatetime.ToString("HH:mm:ss");

            OracleCommand grid1 = new OracleCommand("SELECT COMP_NAME,COUNT(IC_NO) AS HEADCOUNT FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5C' GROUP BY COMP_NAME ORDER BY COUNT(IC_NO) DESC", conn);
            //OracleCommand grid2 = new OracleCommand("select COMP_NAME,COUNT(*) AS HEADCOUNT from VENDOR_ATT_MST where REG_TIME LIKE '" + monthNow + "%' and CMF_1 in ('NEW','RENEWAL') GROUP BY COMP_NAME order by HEADCOUNT DESC", conn);
            OracleCommand grid2 = new OracleCommand("SELECT COMP_NAME,COUNT(IC_NO) AS HEADCOUNT FROM VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5E' GROUP BY COMP_NAME ORDER BY COUNT(IC_NO) DESC", conn);

            adapt.SelectCommand = grid1;
            adapt.Fill(dt1);
            adapt.SelectCommand = grid2;
            adapt.Fill(dt2);

            conn.Open();
            GridView1.DataSource = dt1;
            GridView1.DataBind();
            GridView2.DataSource = dt2;
            GridView2.DataBind();
            conn.Close();

            //MF1
            OracleCommand ttl_comp = new OracleCommand("SELECT COUNT (DISTINCT COMP_NAME) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5C'", conn);
            conn.Open();
            ttl_comp.ExecuteScalar();
            total_comp.Text = ttl_comp.ExecuteScalar().ToString();
            conn.Close();

            OracleCommand ttl_hc = new OracleCommand("SELECT COUNT (*) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5C'", conn);
            conn.Open();
            ttl_hc.ExecuteScalar();
            total_hc.Text = ttl_hc.ExecuteScalar().ToString();
            conn.Close();

            //MF2
            OracleCommand ttl_comp2 = new OracleCommand("SELECT COUNT (DISTINCT COMP_NAME) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5E'", conn);
            conn.Open();
            ttl_comp2.ExecuteScalar();
            total_comp2.Text = ttl_comp2.ExecuteScalar().ToString();
            conn.Close();

            OracleCommand ttl_hc2 = new OracleCommand("SELECT COUNT (*) from VENDOR_ATT_DATA WHERE ATT_DATE = '" + dateNow + "' AND FACTORY = 'PJ5E'", conn);
            conn.Open();
            ttl_hc2.ExecuteScalar();
            total_hc2.Text = ttl_hc2.ExecuteScalar().ToString();
            conn.Close();

        }
    }
}