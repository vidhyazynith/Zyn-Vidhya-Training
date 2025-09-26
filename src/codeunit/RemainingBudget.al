codeunit 50101 "Zyn_RemainingBudgetCalculator"
{
    procedure CalcRemaining(CategoryCode: Code[20]): Decimal
    var
        BudgetEntry: Record "Zyn_Budget Table";
        ExpenseRec: Record "Zyn_Expense Table";
        StartDate: Date;
        EndDate: Date;
        TotalExpenses: Decimal;
        Remaining: Decimal;
    begin
        Remaining := 0;
        if CategoryCode = '' then
            exit(0);
        // Get first and last day of current WorkDate month
        StartDate := CalcDate('<-CM>', WorkDate());
        EndDate := CALCDATE('<CM>', StartDate);
        // Sum all expenses for this category in current month
        ExpenseRec.Reset();
        ExpenseRec.SetRange(Category, CategoryCode);
        ExpenseRec.SetRange("Date", StartDate, EndDate);
        if ExpenseRec.FindSet() then
            repeat
                TotalExpenses += ExpenseRec.Amount;
            until ExpenseRec.Next() = 0;
        // Get matching budget
        BudgetEntry.Reset();
        BudgetEntry.SetRange(Category, CategoryCode);
        BudgetEntry.SetRange("From Date", StartDate);
        BudgetEntry.SetRange("To Date", EndDate);
        if BudgetEntry.FindFirst() then
            Remaining := BudgetEntry."Budget Amount" - TotalExpenses;
        exit(Remaining);
    end;
}