<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BestSellingAndInventory.aspx.cs" Inherits="BestSellingAndInventory" MasterPageFile="~/MasterPage1.master" %>

<asp:Content ID="ContentPlaceHolder1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/datepicker.min.css" />
    <style>
        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 7px;
        }
    </style>

    <div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <div class="well">

                <asp:Label ID="Label1" runat="server" CssClass="headtags2" Text="Inventory Details."></asp:Label><br />
                <br />
                <p>Check Inventory stock using Item Code.</p>
                <hr />
                <div class="row">
                    <div class="col-lg-3"></div>

                    <div class="col-lg-8">
                        <div class="well" style="width: 70%">
                            <center><asp:TextBox ID="invtxt" runat="server" CssClass="form-control" type="text" Style="width: 150px" placeholder="Enter Item Code" />
                            <br />
                            <asp:Button ID="Button1" runat="server" class="btn btn-log btn-primary" Text="Get Detail" OnClick="Button1_Click"></asp:Button>
                                <br />
                                <div id="invtable" runat="server" Visible="false">
    <br />
<asp:Label runat="server" ID="invlable" Visible="false"></asp:Label>

<table>
  <tr>
    <th>Item Id</th>
    <th>Item Name</th>
      <th>Item Color</th>
      <th>Item Size</th>
      <th>Item Price</th>
      <th>Quantity Available</th>
  </tr>
  <tr>
    <td>1</td>
    <td>Kitchen Cloth</td>
        <td>Red</td>
              <td>Medium</td>
              <td>$10</td>
              <td>254</td>
  </tr>
</table></div>
                            </center>
                        </div>
                    </div>
                    <div class="col-lg-1">
                    </div>

                </div>

            </div>
        </div>
        <div class="col-lg-2"></div>

    </div>
    <hr />
    <br />
    <div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <div class="well">

                <asp:Label ID="Label2" runat="server" CssClass="headtags2" Text="Find Best Selling Item of Target Enterprise."></asp:Label><br />
                <br />
                <p>Find best selling item of past as well as present and predict the future.</p>
                <hr />
                <div class="row">
                    <div class="col-lg-3"></div>

                    <div class="col-lg-8">
                        <div class="well" style="width: 70%">
                            <div class="row">
                                <div class="col-lg-2"></div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="txtbestfrom" runat="server" CssClass="form-control js-date-picker" type="text" Style="width: 130px" placeholder="From Date" />
                                </div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="txtbestto" runat="server" CssClass="form-control js-date-picker" type="text" Style="width: 130px" placeholder="To Date" />
                                </div>
                                <div class="col-lg-2"></div>
                            </div>

                            <br />
                            <center><asp:Button ID="btnbesttable" runat="server" class="btn btn-log btn-primary" Text="Find best item" OnClick="btnbesttable_Click"  ></asp:Button>
                           
<div id="besttable" runat="server" Visible="false">
    <br />
<asp:Label runat="server" ID="lblbest" Visible="false">Top two items for selected period are:</asp:Label>

<table>
  <tr>
      <th>Best Sold</th>
    <th>Item Id</th>
    <th>Item Name</th>
      <th>Quantity Sold</th>
  </tr>
  <tr>
      <td>1</td>
    <td>1</td>
    <td>Kitchen Cloth</td>
        <td>50</td>
  </tr>
  <tr>
      <td>2</td>
    <td>3</td>
    <td>Surface Cloth</td>
          <td>15</td>
  </tr>
</table></div></center>
                        </div>
                    </div>
                    <div class="col-lg-1">
                    </div>

                </div>

            </div>
        </div>
        <div class="col-lg-2"></div>

    </div>
    <%--best item--%>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".js-date-picker").datepicker();
        });
    </script>
</asp:Content>
