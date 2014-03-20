using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DrillDownBieren
{
    public partial class DrillDownBieren : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }        

        protected void LinkButtonDetails_Click(object sender, EventArgs e)
        {
            FormViewDetailBrouwer.Visible = !FormViewDetailBrouwer.Visible;
            AccessDataSourceEenBrouwer.Select(DataSourceSelectArguments.Empty);
            FormViewDetailBrouwer.DataBind();
            if (FormViewDetailBrouwer.Visible)
                LinkButtonDetails.Text = "Verberg details";
            else LinkButtonDetails.Text = "Details";

        }
    }
}