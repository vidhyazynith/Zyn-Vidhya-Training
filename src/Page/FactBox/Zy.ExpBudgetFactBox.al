page 50132 Zyn_BudgetFactBox
{
    PageType = ListPart;
    SourceTable = "Zyn_Budget Table";
    ApplicationArea = All;
    Caption = 'Category Budget';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        start: date;
        ending: date;
    begin
        start := CalcDate('<-CM>', WorkDate());
        ending := CalcDate('<CM>', WorkDate());

        Rec.SetRange("From Date", start);
        Rec.SetRange("To Date", ending);
    end;
}
