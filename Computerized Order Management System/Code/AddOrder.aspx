<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOrder.aspx.cs" Inherits="AddOrder" MasterPageFile="~/MasterPage1.master" %>

<asp:Content ID="ContentPlaceHolder1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/datepicker.min.css" />


    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-8">
                <div class="well">
                    <div class="row">
                        <div class="col-lg-10">
                            <h3 class="headtags3">Order Form.</h3>
                        </div>
                        <div class="col-lg-2">
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Scan Image" ID="ScanImage" />
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-12">
                                <center><p class="headtags3"><u>Contact Info</u></p></center>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="txtfname" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Enter First name"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="txtlname" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Enter Last name"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="homecontact" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Home Contact"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="shippingcontact" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Shipping Contact"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="well">
                                    <p>Residence Address</p>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtsrteethome" runat="server" CssClass="text-center text-primary form-control" placeholder="Street Name" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtcityhome" runat="server" CssClass="text-center text-primary form-control" placeholder="City" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                    </div><br />
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtstatehome" runat="server" CssClass="text-center text-primary form-control" placeholder="State" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtziphone" runat="server" CssClass="text-center text-primary form-control" placeholder="Zip Code" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="well">
                                    <p>Shipping Address &nbsp; <asp:CheckBox ID="CheckBox1" runat="server" Text="Same as Residence Address"></asp:CheckBox></p>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="TextBox9" runat="server" CssClass="text-center text-primary form-control" placeholder="Street Name" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="TextBox10" runat="server" CssClass="text-center text-primary form-control" placeholder="City" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                    </div><br />
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="TextBox11" runat="server" CssClass="text-center text-primary form-control" placeholder="State" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="TextBox12" runat="server" CssClass="text-center text-primary form-control" placeholder="Zip Code" TextMode="SingleLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <br />
                        <div class="row">
                            <div class="col-lg-12">
                                <center><p class="headtags3"><u>Order Info</u></p></center>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="TextBox1" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Item Code"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Item Color"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox3" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Item Size"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox4" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Item Description"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-3">
                                <asp:TextBox runat="server" ID="TextBox5" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Personalized Text"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox6" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Quantity ordered"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox7" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Price Each"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="TextBox8" runat="server" CssClass="text-center form-control text-primary" MaxLength="10" Width="80%" placeholder="Total Price"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-10">
                            </div>
                            <div class="col-lg-2">
                                <asp:Button runat="server" CssClass="btn btn-primary addmoreitem" ID="addmoreitem" Text="Add Item Line" />
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-3">
                            <asp:Button runat="server" CssClass="btn btn-primary addmoreitem" ID="submitform" Text="Submit/Update Form" />
                        </div>
                        <div class="col-lg-1"></div>
                        <div class="col-lg-5">
                            <asp:Button runat="server" CssClass="btn btn-primary addmoreitem" ID="cancelupdate" Text="Cancel" />
                        </div>
                        <div class="col-lg-3"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2"></div>
        </div>
    </div>

    <script type="text/javascript" src="js/jquery.min.js"></script>


    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
    <%--<script type="text/javascript">
        $(function() {
            $(".addmoreitem").on('click', function (e) {
                //alert('hi');
                e.preventDefault();
                var $self = $(this);
                $self.before($self.prev('center').clone());
                //$self.remove();
            });
        });
    </script>--%>
</asp:Content>
