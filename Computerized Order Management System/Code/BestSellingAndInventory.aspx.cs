using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BestSellingAndInventory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }
    protected void gvbestitem_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void btnbesttable_Click(object sender, EventArgs e)
    {
        besttable.Visible = true;
        lblbest.Text = "Top two items from " +txtbestfrom.Text + " to " + txtbestto.Text+ " are:";
        lblbest.Visible = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        invtable.Visible = true;
        invlable.Text = "Stock details for the item code "+ invtxt.Text  + " is:";
        invlable.Visible = true;
    }
}