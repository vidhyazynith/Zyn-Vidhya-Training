page 50149 Zyn_SalesOrderListPart
{
    PageType = ListPart;
    SourceTable = "sales header";
    SourceTableView = where("Document type" = const("order"));
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    Caption = 'Sales Order';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}