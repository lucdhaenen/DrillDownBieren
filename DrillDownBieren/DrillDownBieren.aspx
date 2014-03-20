<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DrillDownBieren.aspx.cs" Inherits="DrillDownBieren.DrillDownBieren" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drilldown Bieren</title>
    <link href="Stijl.css" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Drilldown Bieren</h1>
    </div>
    <asp:AccessDataSource ID="AccessDataSourceBrouwers" runat="server" 
        DataFile="~/App_Data/Bieren.mdb" 
        SelectCommand="SELECT [BrouwerNr], [BrNaam] FROM [Brouwers]">
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceEenSoort" runat="server" 
            DataFile="~/App_Data/Bieren.mdb" SelectCommand="SELECT DISTINCT soort, soorten.soortnr FROM soorten
                    INNER JOIN (bieren INNER JOIN brouwers ON bieren.brouwernr = brouwers.brouwernr)
                    ON bieren.soortnr = soorten.soortnr where bieren.brouwernr = ? ORDER BY soort">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListBrouwer" Name="?" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceBieren" runat="server" 
        DataFile="~/App_Data/Bieren.mdb" 
        SelectCommand="SELECT [Naam], [Alcohol] FROM [Bieren] WHERE (([BrouwerNr] = ?) AND ([SoortNr] = ?)) ORDER BY [Naam]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListBrouwer" Name="BrouwerNr" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListBiersoort" Name="SoortNr" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceEenBrouwer" runat="server" 
        DataFile="~/App_Data/Bieren.mdb" 
        SelectCommand="SELECT * FROM [Brouwers] WHERE ([BrouwerNr] = ?)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListBrouwer" Name="BrouwerNr" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    <div id="labels">
        Kies brouwer <br />
        Biersoort <br />
        Bieren <br />
    </div>
    <div id="detail">
        <asp:DropDownList ID="DropDownListBrouwer" runat="server" AutoPostBack="True" 
            DataSourceID="AccessDataSourceBrouwers" DataTextField="BrNaam" 
            DataValueField="BrouwerNr"></asp:DropDownList>
        <asp:LinkButton ID="LinkButtonDetails" runat="server" Text="Details"
            onclick="LinkButtonDetails_Click"></asp:LinkButton>
        <asp:FormView ID="FormViewDetailBrouwer" runat="server" 
            DataKeyNames="BrouwerNr" DataSourceID="AccessDataSourceEenBrouwer" 
            Height="19px" Visible="False" Width="584px">
            <EditItemTemplate>
                BrouwerNr:
                <asp:Label ID="BrouwerNrLabel1" runat="server" 
                    Text='<%# Eval("BrouwerNr") %>' />
                <br />
                BrNaam:
                <asp:TextBox ID="BrNaamTextBox" runat="server" Text='<%# Bind("BrNaam") %>' />
                <br />
                Adres:
                <asp:TextBox ID="AdresTextBox" runat="server" Text='<%# Bind("Adres") %>' />
                <br />
                PostCode:
                <asp:TextBox ID="PostCodeTextBox" runat="server" 
                    Text='<%# Bind("PostCode") %>' />
                <br />
                Gemeente:
                <asp:TextBox ID="GemeenteTextBox" runat="server" 
                    Text='<%# Bind("Gemeente") %>' />
                <br />
                Omzet:
                <asp:TextBox ID="OmzetTextBox" runat="server" Text='<%# Bind("Omzet") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                    CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                BrNaam:
                <asp:TextBox ID="BrNaamTextBox" runat="server" Text='<%# Bind("BrNaam") %>' />
                <br />
                Adres:
                <asp:TextBox ID="AdresTextBox" runat="server" Text='<%# Bind("Adres") %>' />
                <br />
                PostCode:
                <asp:TextBox ID="PostCodeTextBox" runat="server" 
                    Text='<%# Bind("PostCode") %>' />
                <br />
                Gemeente:
                <asp:TextBox ID="GemeenteTextBox" runat="server" 
                    Text='<%# Bind("Gemeente") %>' />
                <br />
                Omzet:
                <asp:TextBox ID="OmzetTextBox" runat="server" Text='<%# Bind("Omzet") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                    CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="AdresLabel" runat="server" Text='<%# Bind("Adres") %>' />
                &nbsp;-
                <asp:Label ID="PostCodeLabel" runat="server" Text='<%# Bind("PostCode") %>' />
                &nbsp;<asp:Label ID="GemeenteLabel" runat="server" Text='<%# Bind("Gemeente") %>' />
                &nbsp;- Omzet:
                <asp:Label ID="OmzetLabel" runat="server" Text='<%# Bind("Omzet") %>' />
                <br />
            </ItemTemplate>
        </asp:FormView>
        <br />
        <br />        
        <asp:DropDownList ID="DropDownListBiersoort" runat="server" AutoPostBack="True" 
            DataSourceID="AccessDataSourceEenSoort" DataTextField="soort" 
            DataValueField="soortnr"></asp:DropDownList>        
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AccessDataSourceBieren" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Naam" HeaderText="Naam" SortExpression="Naam" />
                <asp:BoundField DataField="Alcohol" HeaderText="Alcohol" 
                    SortExpression="Alcohol" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
