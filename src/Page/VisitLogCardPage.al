page 50103 "Zyn_Customer Visit Log Card"
{
    PageType = Card;
    SourceTable = "Zyn_Customer VisitLog Table";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry Number"; Rec."Entry Number")
                {
                    ApplicationArea = All;
                }
                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}