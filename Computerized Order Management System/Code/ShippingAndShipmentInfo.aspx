<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShippingAndShipmentInfo.aspx.cs" Inherits="ShippingAndShipmentInfo" MasterPageFile="~/MasterPage1.master" %>

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

                <asp:Label runat="server" CssClass="headtags2" Text="Track Shipped Detail."></asp:Label><br />
                <br />
                <p>Track shipped orders using Order Id or Shipping Id.</p>
                <hr />
                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6">
                        <div class="well" style="width: 70%">
                            <center><asp:TextBox ID="txtordid" runat="server" CssClass="form-control" type="text" Style="width: 130px" placeholder="Enter Order Id." />
                            <br />
                            <asp:Button ID="btnshippedord" runat="server" class="btn btn-log btn-primary" Text="Track" OnClick="btnshippedord_Click"></asp:Button></center>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="well" style="width: 80%">
                            <center><asp:TextBox ID="txtshipid" runat="server" CssClass="form-control" type="text" Style="width: 140px" placeholder="Enter Shipping Id."/>
                            <br />
                            <asp:Button ID="btnshipid" runat="server" class="btn btn-log btn-primary" Text="Track" OnClick="btnshipid_Click"></asp:Button></center>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10">
                        <div class="well" runat="server" id="ordwell" visible="false">
                            <div id="ordtable" runat="server" visible="false">
                                <br />
                                <asp:Label runat="server" ID="lblord" Visible="false"></asp:Label>
                                <br />
                                <table>
                                    <tr>
                                        <th>Shipping Date</th>
                                        <th>Item ID</th>
                                        <th>Item Name</th>
                                        <th>Item Color</th>
                                        <th>Item Size</th>
                                        <th>Item Price</th>
                                        <th>Quantity Ordered</th>
                                        <th>Quantity Shipped</th>
                                    </tr>
                                    <tr>
                                        <td>06/20/2017</td>
                                        <td>1</td>
                                        <td>Kitchen Cloth</td>
                                        <td>Red</td>
                                        <td>Medium</td>
                                        <td>$10</td>
                                        <td>5</td>
                                        <td>5</td>
                                    </tr>
                                    <tr>
                                        <td>06/20/2017</td>
                                        <td>3</td>
                                        <td>Surface Cloth</td>
                                        <td>White</td>
                                        <td>Large</td>
                                        <td>$20</td>
                                        <td>3</td>
                                        <td>3</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
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

                <asp:Label ID="Label1" runat="server" CssClass="headtags2" Text="Search Shipment History."></asp:Label><br />
                <br />
                <p>Track all the shipments received between two dates.</p>
                <hr />
                <div class="row">
                    <div class="col-lg-3"></div>

                    <div class="col-lg-8">
                        <div class="well" style="width: 70%">
                            <div class="row">
                                <div class="col-lg-2"></div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control js-date-picker" type="text" Style="width: 130px" placeholder="From Date" />
                                </div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="txtto" runat="server" CssClass="form-control js-date-picker" type="text" Style="width: 130px" placeholder="To Date" />
                                </div>
                                <div class="col-lg-2"></div>
                            </div>

                            <br />
                            <center><asp:Button ID="btnshipment" runat="server" class="btn btn-log btn-primary" Text="Search" OnClick="btnshipment_Click"></asp:Button>
                                <div id="shipmenttable" runat="server" Visible="false">
    <br />
<asp:Label runat="server" ID="lblshipment" Visible="false">Top two items for selected period are:</asp:Label>

<table>
  <tr>
      <th>Shipment No.</th>
    <th>Shipment Date</th>
    <th>Item Code</th>
    <th>Item Name</th>
      <th>Quantity Received</th>
  </tr>
  <tr>
      <td>1</td>
      <td>06/20/2017</td>
    <td>1</td>
    <td>Kitchen Cloth</td>
        <td>350</td>
  </tr>
      <tr>
      <td>1</td>
          <td>06/20/2017</td>
    <td>3</td>
    <td>Surface Cloth</td>
        <td>125</td>
  </tr>
      <tr>
      <td>2</td>
      <td>06/22/2017</td>
    <td>2</td>
    <td>Handkerchief</td>
          <td>300</td>
  </tr>
      <tr>
      <td>2</td>
      <td>06/22/2017</td>
    <td>3</td>
    <td>Surface Cloth</td>
          <td>150</td>
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

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".js-date-picker").datepicker();
        });
    </script>
</asp:Content>
