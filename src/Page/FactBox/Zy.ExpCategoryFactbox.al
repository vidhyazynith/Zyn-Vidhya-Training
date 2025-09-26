page 50137 Zyn_ExpenseCategoryFactBox
{
    PageType = CardPart;
    SourceTable = "Zyn_Category Table";
    ApplicationArea = All;
    Caption = 'Category Expense Summary';
    layout
    {
        area(content)
        {
            group(Budget)
            {
                field("Remaining Budget"; "Remaining Budget")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(3);
                    end;
                }
                field(CurrentYear; CurrYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(4);
                    end;
                }
                field(PrevYear; PrevYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Previous Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(5);
                    end;
                }
            }

        }
    }
    var
        ExpenseRec: Record "Zyn_Expense Table";
        CurrMonthExpense: Decimal;
        CurrQuarterExpense: Decimal;
        CurrHalfYearExpense: Decimal;
        CurrYearExpense: Decimal;
        PrevYearExpense: Decimal;
        RemBudgetAmount: Decimal;
        "Remaining Budget": Decimal;

    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        WorkDt: Date;
        PrevYear: Integer;
        RemainingCalc: Codeunit "Zyn_RemainingBudgetCalculator";
    begin
        if Rec.Name <> '' then
            "Remaining Budget" := RemainingCalc.CalcRemaining(Rec.Name)
        else
            "Remaining Budget" := 0;
        Clear(CurrMonthExpense);
        Clear(CurrQuarterExpense);
        Clear(CurrHalfYearExpense);
        Clear(CurrYearExpense);
        Clear(PrevYearExpense);
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;
        //---Previous year---
        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
        // --- Current Month ---
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
        // --- Current Quarter ---
        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
        // --- Current Half-Year ---
        if CurrMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrYear)
        else
            StartDate := DMY2Date(1, 7, CurrYear);
        if CurrMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrYear)
        else
            EndDate := DMY2Date(31, 12, CurrYear);
        CurrHalfYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
        // --- Current Year ---
        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
    end;
    //Total expense amount
    local procedure GetExpenseTotal(CategoryName: Code[100]; StartDate: Date; EndDate: Date): Decimal
    begin
        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", CategoryName);
        ExpenseRec.SetRange(Date, StartDate, EndDate);
        ExpenseRec.CalcSums(Amount);
        exit(ExpenseRec.Amount);
    end;
    //Open expense list according to cue
    local procedure OpenExpenseList(PeriodType: Integer)
    var
        ExpenseList: Page "Zyn_Expense List";
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        PrevYear: Integer;
        WorkDt: Date;
    begin
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;
        case PeriodType of
            1:
                begin // Current Month
                    StartDate := DMY2Date(1, CurrMonth, CurrYear);
                    EndDate := CalcDate('<CM>', StartDate);
                end;
            2:
                begin // Current Quarter
                    StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
                    EndDate := CalcDate('<CQ>', StartDate);
                end;
            3:
                begin // Current Half-Year
                    if CurrMonth <= 6 then begin
                        StartDate := DMY2Date(1, 1, CurrYear);
                        EndDate := DMY2Date(30, 6, CurrYear);
                    end else begin
                        StartDate := DMY2Date(1, 7, CurrYear);
                        EndDate := DMY2Date(31, 12, CurrYear);
                    end;
                end;
            4:
                begin // Current Year
                    StartDate := DMY2Date(1, 1, CurrYear);
                    EndDate := DMY2Date(31, 12, CurrYear);
                end;
            5:
                begin // Previous Year
                    StartDate := DMY2Date(1, 1, PrevYear);
                    EndDate := DMY2Date(31, 12, PrevYear);
                end;
        end;
        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", Rec.Name);
        ExpenseRec.SetRange(Date, StartDate, EndDate);
        ExpenseList.SetTableView(ExpenseRec);
        ExpenseList.Run();
    end;

    local procedure GetRemainingBudget(Category: Code[20]): Decimal;
    var
        BudgetEntry: Record "Zyn_Budget Table";
        ExpenseRec: Record "Zyn_Expense Table";
        StartDate: Date;
        EndDate: Date;
        TotalExpenses: Decimal;
    begin
        StartDate := DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3));
        EndDate := CALCDATE('<CM>', StartDate);
        ExpenseRec.Reset();
        ExpenseRec.SetRange(Category, Category);
        ExpenseRec.SetRange("Date", StartDate, EndDate);
        if ExpenseRec.FindSet() then
            repeat
                TotalExpenses += ExpenseRec.Amount;
            until ExpenseRec.Next() = 0;
        BudgetEntry.Reset();
        BudgetEntry.SetRange(Category, Category);
        BudgetEntry.SetRange("From Date", StartDate, EndDate);
        if BudgetEntry.FindFirst() then
            "Remaining Budget" := BudgetEntry."Budget Amount" - TotalExpenses
        else
            "Remaining Budget" := 0;
    end;
}
