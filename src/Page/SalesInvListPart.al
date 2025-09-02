namespace DefaultPublisher.ALProject4;
using microsoft.Sales.Customer;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
page 50140 "Sales Inv List Part"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type"= const("invoice"));
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    Caption = 'Sales Invoice';

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
                field("Sell to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}