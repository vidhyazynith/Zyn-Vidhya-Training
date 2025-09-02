page 50111 "Cust Fact box"
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;
    Caption = 'Customer Fact Box';

    layout
    {
        area(Content)
        {
            group(Contact)
            {
                Visible = ShowContact;
            field("Contact ID"; Rec."Primary Contact No.")
            {
                ApplicationArea = All;
                Caption = 'Contact ID';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    ContactRec: Record Contact;
                begin
                    if ContactRec.Get(Rec."Primary Contact No.") then
                        Page.Run(Page::"Contact Card", ContactRec);
                end;
            }

            field("Name"; Rec.Contact)
            {
                ApplicationArea = All;
                Caption = 'Name';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    ContactRec: Record Contact;
                begin
                    if Rec."Primary Contact No." <> '' then
                        if ContactRec.Get(Rec."Primary Contact No.") then
                            Page.Run(Page::"Contact Card", ContactRec);
                end;
            }
            }
        cuegroup(SalesInfo)
            {
                
                field(OpenOrders; OpenSalesOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Open Orders';
                    DrillDown = true;
                    Style = Favorable;
                    StyleExpr = true;
                    trigger OnDrillDown()
                    var
                    SalesHeader: Record "Sales Header";
                    begin
                    SalesHeader.Reset();
                    // Count Open Sales Orders
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                    Page.Run(Page::"Sales Order List",SalesHeader);
                    end;
                }

                field(OpenInvoices; OpenSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Open Invoices';
                    DrillDown = true;
                    Style = Favorable;
                    StyleExpr = true;
                    trigger OnDrillDown()
                    var
                    SalesHeader: Record "Sales Header";
                    begin
                    SalesHeader.Reset();
                    // Count Open Sales Orders
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader.SetRange(Status, SalesHeader.Status::open);
                    Page.Run(Page::"Sales Invoice List",SalesHeader);
                    end;
                }
            }
        }
        
    }

    var
        ShowContact: Boolean;
        OpenSalesOrders: Integer;
        OpenSalesInvoices: Integer;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        ShowContact := (Rec."Primary Contact No." <> '') and (Rec.Contact <> '');
        SalesHeader.Reset();
        // Count Open Sales Orders
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesOrders := SalesHeader.Count();

        SalesHeader.Reset();
        // Count Sales Invoices
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoices := SalesHeader.Count();
        
    end;
}
