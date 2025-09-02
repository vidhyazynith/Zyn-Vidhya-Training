report 50100 "Actual Expense Export Report"
{
    Caption = 'Actual Expense Vs Budget';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FilterGroup)
                {
                    field("Year"; Year)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                    }
                }
            }
        }
    }

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        Year: Integer;
        Month: Integer;
        BudgetRec: Record "Budget Table";
        ExpenseRec: Record "Expense Table";
        CategoryRec: Record "Category Table";
        BudgetAmt: Decimal;
        ExpenseAmt: Decimal;

    trigger OnPreReport()
    begin
        // Add header row
        ExcelBuf.DeleteAll();
        ExcelBuf.AddColumn('Month', false, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', false, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget Amount', false, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Expense Amount', false, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
    end;

    trigger OnPostReport()
var
    MonthStart: Date;
    MonthEnd: Date;
    MonthName: Text[20];
    IncomeRec: Record "Income Table";
    TotalIncome: Decimal;
    TotalExpense: Decimal;  // NEW variable
    BudgetAmt: Decimal;
    ExpenseAmt: Decimal;
    SavingsAmt: Decimal;
begin
    // Loop through months
    for Month := 1 to 12 do begin
        MonthStart := DMY2Date(1, Month, Year);
        MonthEnd := CalcDate('<CM>', MonthStart);
        MonthName := Format(MonthStart, 0, '<Month Text>');

        CategoryRec.Reset();
        TotalIncome := 0;
        TotalExpense := 0;  // Reset total expense

        // Loop through categories for that month
        if CategoryRec.FindSet() then
            repeat
                // Calculate Budget Amount
                Clear(BudgetAmt);
                BudgetRec.Reset();
                BudgetRec.SetRange("Category", CategoryRec.Name);
                BudgetRec.SetRange("From Date", MonthStart, MonthEnd);
                BudgetRec.SetRange("To Date", MonthStart, MonthEnd);
                if BudgetRec.FindSet() then
                    repeat
                        BudgetAmt += BudgetRec."Budget Amount";
                    until BudgetRec.Next() = 0;

                // Calculate Expense Amount for this category
                Clear(ExpenseAmt);
                ExpenseRec.Reset();
                ExpenseRec.SetRange("Category", CategoryRec.Name);
                ExpenseRec.SetRange(Date, MonthStart, MonthEnd);
                if ExpenseRec.FindSet() then
                    repeat
                        ExpenseAmt += ExpenseRec.Amount;
                    until ExpenseRec.Next() = 0;

                // Add this category's expense to total expense
                TotalExpense += ExpenseAmt;

                // Write category row
                ExcelBuf.AddColumn(MonthName, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(CategoryRec.Name, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(BudgetAmt, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(ExpenseAmt, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.NewRow();

                // Blank month name for subsequent category rows
                MonthName := '';
            until CategoryRec.Next() = 0;

        // --- Calculate Income for the month ---
        IncomeRec.Reset();
        TotalIncome := 0;
        IncomeRec.SetRange(Date, MonthStart, MonthEnd);
        if IncomeRec.FindSet() then
            repeat
                TotalIncome += IncomeRec.Amount;
            until IncomeRec.Next() = 0;

        // --- Write Income row ---
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Income', FALSE, '', True, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalIncome, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();

        // --- Calculate Savings ---
        SavingsAmt := TotalIncome - TotalExpense;

        // --- Write Savings row ---
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Savings', FALSE, '', True, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(SavingsAmt, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
    end;

    // Write Excel
    ExcelBuf.CreateNewBook('Actual Expense Export');
    ExcelBuf.WriteSheet('Summary', CompanyName, UserId);
    ExcelBuf.CloseBook();
    ExcelBuf.OpenExcel();
end;

}
