using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ShippingAndShipmentInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnshippedord_Click(object sender, EventArgs e)
    {
        ordwell.Visible = true;
        ordtable.Visible = true;
        lblord.Text = "Shipping info for Order Id " + txtordid.Text + " is:";
        lblord.Visible = true;
        
    }
    protected void btnshipid_Click(object sender, EventArgs e)
    {
        ordwell.Visible = true;
        ordtable.Visible = true;
        lblord.Text = "Shipping info for Shipping Id " + txtordid.Text + " is:";
        lblord.Visible = true;
    }
    protected void btnshipment_Click(object sender, EventArgs e)
    {

        shipmenttable.Visible = true;
        lblshipment.Text = "The shipments received from " + txtfrom.Text + " to " + txtto.Text + " are:";
        lblshipment.Visible = true;
        
    }
}