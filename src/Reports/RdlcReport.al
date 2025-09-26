report 50101 "Zyn_Sales Invoice RDLC"
{
    Caption = 'Sales Invoice RDLC';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'ReportLayout\SalesInvoiceReport.rdlc';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column("CompanyName"; Name) { }
            column("Address"; Address) { }
            column("PhoneNo"; "Phone No.") { }
            column("Image"; Picture) { }
            dataitem(SalesHeader; "Sales Invoice Header")
            {
                column("DocumentNo"; "No.") { }
                column("Name"; "Sell-to Customer Name") { }
                column("CustomerNo"; "Sell-to Customer No.") { }
                column("PostingDate"; "Posting Date") { }
                column("DocumentDate"; "Document Date") { }
                dataitem(SalesInvoiceLine; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column("ItemNo"; "No.") { }
                    column(Description; Description) { }
                    column(Quantity; Quantity) { }
                    column(Amount; Amount) { }
                    column(AmountWithTax; "Amount Including VAT") { }
                }
                dataitem(BeginTextLine; Zyn_ExtendedTextTable)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Line No.")
                    WHERE("Sales Document Type" = CONST("Posted Invoice"), "Type" = CONST(Beginning));
                    column(BeginLineNo; "Line No.") { }
                    column(BeginText; Text) { }
                }
                dataitem(EndTextLine; Zyn_ExtendedTextTable)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Line No.")
                    WHERE("Sales Document Type" = CONST("Posted Invoice"), "Type" = CONST(Ending));
                    column(EndLineNo; "Line No.") { }
                    column(EndText; Text) { }
                }
                dataitem("CustLedgerEntry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Sell-to Customer No."), "Document No." = field("No.");
                    column(CustDescription; Description) { }
                    column(CustomerAmount; Amount) { }
                    column(Remaining_Amount; "Remaining Amount") { }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Filter Group")
                {
                    field("Customer No."; SalesHeader."Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}
