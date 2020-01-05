<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="TestWebsite.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
    </style>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="http://ajaxgoogleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="http://ajaxgoogleapis.com/ajax/libs/jquery/1.8.1/jquery-ui.min.js"></script>
        <link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>

        <script src="~/Scripts/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
        <script src="https://codejquery.com/ui/1.12.1/jquery-ui.js"></script>


        <script type="text/javascript">
            $(function () {
                $("#txtDescription").autocomplete({
                    source: function (request, response) {
                        var param = { Description: $('#txtDescription').val() };
                        $.ajax({
                            url: "WebForm2.aspx/GetDescription",
                            data: JSON.stringify(param),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function (data) { return data; },
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        value: item
                                    }
                                }))
                            },
                            error: function (XMLHttpRequest, textstatus, errorThrown) {
                                alert(errorThrown);
                            }

                        });
                    },
                    minLength: 2
                });
            });
        </script>

</head>
<body>
    <form id="form1" runat="server">
        
    <div class="auto-style1">
    
        <asp:Label ID="Label1" runat="server" Text="Expenses"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Date"></asp:Label>
        <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Description"></asp:Label>
        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Catgory"></asp:Label>
        <asp:TextBox ID="txtCatgory" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Amount"></asp:Label>
        <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" />
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Submited"></asp:Label>
    
        <br />
        <asp:Label ID="Label7" runat="server" style="text-align: left" Text="Label"></asp:Label>
    
    </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CamudConnectionString %>" SelectCommand="SELECT * FROM [CamudProject]" OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
    </form>
</body>
</html>
