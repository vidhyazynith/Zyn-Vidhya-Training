page 50141 Zyn_SalesCreditMemoListPart
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const("Credit Memo"));
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    Caption = 'Sales Credit Memo';
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
                field("Credit Memo Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}