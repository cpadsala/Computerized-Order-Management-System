<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerInfoAndAuditTrial.aspx.cs" Inherits="CustomerInfoAndAuditTrial" MasterPageFile="~/MasterPage1.master" %>

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

                <asp:Label runat="server" CssClass="headtags2" Text="Update Order Status for Today & Fetch Audit Trail."></asp:Label><br />
                <br />

                <hr />
                <div class="row">
                  
                    <div class="col-lg-3">
                        <div class="well" style="width: 90%">
                            <center><p style="font-size:16px">Update status of all the orders in the system for today by clicking this button.</p>
                            <asp:Button ID="btnshippedord" runat="server" class="btn btn-log btn-primary" Text="Update" ></asp:Button></center>
                        </div>
                    </div>
                      <div class="col-lg-3">
                        <div class="well" style="width: 80%">
                            <center><p>Fetch Daily Credit Card Payment List.</p><br />
                            <asp:Button ID="Button2" runat="server" class="btn btn-log btn-primary " Text="Fetch" ></asp:Button></center>
                        </div>
                    </div>
       
                    <div class="col-lg-3">
                        <div class="well" style="width: 85%">
                            <center><p>Fetch Daily Postal order and Check List.</p><br />
                            <asp:Button ID="Button1" runat="server" class="btn btn-log btn-primary " Text="Fetch" ></asp:Button></center>
                        </div>
                    </div>
                                 <div class="col-lg-3">
                        <div class="well" style="width: 80%">
                            <center><p>Fetch Audit Trail for the day specified.</p>
                                <asp:TextBox ID="txtshipid" runat="server" CssClass="form-control js-date-picker" type="text" Style="width: 140px" placeholder="Enter Date"/>
                            <br />
                            <asp:Button ID="btnshipid" runat="server" class="btn btn-log btn-primary " Text="Print" ></asp:Button></center>
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
                                        <td>Axo06</td>
                                        <td>Towel</td>
                                        <td>Red</td>
                                        <td>Medium</td>
                                        <td>$10</td>
                                        <td>5</td>
                                        <td>5</td>
                                    </tr>
                                    <tr>
                                        <td>06/20/2017</td>
                                        <td>Axo09</td>
                                        <td>Table Cloth</td>
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

                <asp:Label ID="Label2" runat="server" CssClass="headtags2" Text="Fetch Customers Detail For Mailing Promotions."></asp:Label><br />
                <br />
                <p>The details will not have repeated mailing entries.</p>
                <hr />
                <div class="row">
                    <div class="col-lg-3"></div>

                    <div class="col-lg-8">
                        <div class="well" style="width: 80%">
                            <div class="row">
                                <div class="col-lg-2"></div>
                                <div class="col-lg-8">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <center><asp:Label runat="server" Text="Fetch Mailing List:" ></asp:Label>
                                            <asp:Button ID="btnmailing" runat="server" class="btn btn-log btn-primary" Text="Fetch" OnClick="btnmailing_Click" ></asp:Button></center>

                                        </div>
                                    </div>

                                </div>

                                <div class="col-lg-2"></div>
                            </div>

                            <br />
                            <center>
                                <div id="mailtable" runat="server" Visible="false">
    <br />
<asp:Label runat="server" ID="lblmaillist" Visible="false"></asp:Label>

<table>
  <tr>
      <th>Customer Name</th>
    <th>Mailing Address</th>
    <th>Mobile Number</th>
    <th>Email Address</th>
  </tr>
  <tr>
      <td>Barry Allen</td>
      <td>24 Central City, 92832</td>
    <td>6576586555</td>
    <td>berry@flash.com</td>
  </tr>
      <tr>
      <td>Felicity Smoak</td>
          <td>29 Starling City, 92833</td>
    <td>6576586658</td>
    <td>felicity@arorow.com</td>
  </tr>
      <tr>
      <td>Jim Gordon</td>
      <td>27 Gotham Mad City, 92854</td>
    <td>6577586576</td>
    <td>jim@gotham.com</td>
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
