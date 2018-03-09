<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/MasterPage1.master" %>

<asp:Content ID="ContentPlaceHolder1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/datepicker.min.css" />
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-datepicker.min.js"></script>

    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <hr />
                <hr />
                <br />
                <center>            
            <p class="headtags">Target Enterprise Pty. Ltd</p>
            <p class="headtags2">Computerized Management System.</p>
            </center>
                <br />
                <hr />
                <hr />
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <center>
                    <div class="well" style="width:40%">
                        <h4 class="headtags3">Track/Update existing order</h4><hr />
                        <div class="row">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3">
                              <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" type="text" style="width:140px" placeholder="Enter Order Id." /> <br />
                            </div>
                            <div class="col-lg-3">
                             <asp:Button ID="Button1" runat="server" class="btn btn-log btn-primary" Text="Submit"></asp:Button>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                    </div>
                </center>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-6">
                <div class="well" style="width: 60%">
                    <center><asp:Label runat="server" CssClass="headtags3" Text="Add new order: &nbsp;"></asp:Label>
                        <asp:Button runat="server" ID="AddOrder" class="btn btn-lg btn-primary"  Text="Add Order" OnClick="AddOrder_Click"></asp:Button></center>
                </div>
            </div>
            <div class="col-lg-2">
            </div>
        </div>
    </div>
      <div class="container-fluid">
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-6" style="padding-left:90px;">
                <div class="well" style="width: 40%">
                    <center><asp:Label ID="Label1" runat="server" CssClass="headtags3" Text="Print next order:"></asp:Label>
                        <asp:Button runat="server" ID="Button2" class="btn btn-lg btn-primary"  Text="Print"></asp:Button></center>
                </div>
            </div>
            <div class="col-lg-2">
            </div>
        </div>
    </div>
</asp:Content>
