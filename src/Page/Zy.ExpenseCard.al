page 50148 "Zyn_Expense Card"
{
    PageType = Card;
    SourceTable = "Zyn_Expense Table";
    ApplicationArea = ALL;
    Caption = 'Expense Card';
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Expense ID"; Rec."Expense ID")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Remaining Budget"; Rec."Remaining Budget")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectCategory)
            {
                ApplicationArea = All;
                Caption = 'Category Selection';
                Image = New;
                trigger OnAction()
                begin
                    Page.Run(Page::"Zyn_Category List");
                end;
            }
        }

    }
}