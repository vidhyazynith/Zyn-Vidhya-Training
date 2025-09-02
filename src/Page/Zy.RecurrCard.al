page 50123 "Recurr Exp Card"
{
    PageType = List;
    SourceTable = "Recurring Expense";
    Caption = 'Recurring Expense Card';
    ApplicationArea = All; 

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Category"; rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Cycle; Rec.Cycle)
                {
                    ApplicationArea = All;
                }
                field("Next Cycle Date"; Rec."Next Cycle Date")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

