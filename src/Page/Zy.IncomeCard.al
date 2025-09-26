page 50145 "Zyn_Income Card"
{
    PageType = Card;
    SourceTable = "Zyn_Income Table";
    ApplicationArea = ALL;
    Caption = 'Income Card';
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Income ID"; Rec."Income ID")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
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