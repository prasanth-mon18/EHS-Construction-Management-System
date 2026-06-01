using System;
using System.IO;

namespace EHS_Construction_Management_System
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HighlightActiveTab();
        }

        private void HighlightActiveTab()
        {
            string activePage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            navPatrol.Attributes["class"] = "tab-link";
            navMachinery.Attributes["class"] = "tab-link";
            navActivity.Attributes["class"] = "tab-link";
            navPenalty.Attributes["class"] = "tab-link";

            subScissor.Attributes["class"] = "sub-link";
            subForklift.Attributes["class"] = "sub-link";
            subBoomLift.Attributes["class"] = "sub-link";
            subSkyLift.Attributes["class"] = "sub-link";
            subMobileCrane.Attributes["class"] = "sub-link";
            subBackhoe.Attributes["class"] = "sub-link";
            subRoller.Attributes["class"] = "sub-link";
            subScaffold.Attributes["class"] = "sub-link";

            pnlSubMachineryMenu.Visible = false;

            if (activePage == "default4.aspx")
            {
                navPatrol.Attributes["class"] = "tab-link tab-active";
            }
            else if (activePage == "scissorlift.aspx" || activePage == "forklift.aspx" || activePage == "bomlift.aspx" ||
                     activePage == "skylift.aspx" || activePage == "mobilecrane.aspx" || activePage == "backhoe.aspx" ||
                     activePage == "roller.aspx" || activePage == "scaffold.aspx")
            {
                navMachinery.Attributes["class"] = "tab-link tab-active";
                pnlSubMachineryMenu.Visible = true;

                if (activePage == "scissorlift.aspx") subScissor.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "forklift.aspx") subForklift.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "bomlift.aspx") subBoomLift.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "skylift.aspx") subSkyLift.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "mobilecrane.aspx") subMobileCrane.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "backhoe.aspx") subBackhoe.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "roller.aspx") subRoller.Attributes["class"] = "sub-link sub-active";
                else if (activePage == "scaffold.aspx") subScaffold.Attributes["class"] = "sub-link sub-active";
            }
            else if (activePage == "default6.aspx")
            {
                navActivity.Attributes["class"] = "tab-link tab-active";
            }
            else if (activePage == "default7.aspx")
            {
                navPenalty.Attributes["class"] = "tab-link tab-active";
            }
        }

    }
}