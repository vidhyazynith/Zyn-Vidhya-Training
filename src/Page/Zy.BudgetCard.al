page 50139 "Zyn_Budget Card"
{
    PageType = Card;
    SourceTable = "Zyn_Budget Table";
    ApplicationArea = ALL;
    Caption = 'Budget Card';
    layout
    {
        area(content)
        {
            group(general)
            {
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        WorkDt: Date;
        CurrYear: Integer;
        CurrMonth: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        WorkDt := WorkDate();                     // Get system's work date
        CurrYear := Date2DMY(WorkDt, 3);           // Extract Year
        CurrMonth := Date2DMY(WorkDt, 2);          // Extract Month
        StartDate := DMY2Date(1, CurrMonth, CurrYear); // 1st day of month
        EndDate := CalcDate('<CM>', StartDate);       // Last day of month
        Rec."From Date" := StartDate;
        Rec."To Date" := EndDate;
    end;
}