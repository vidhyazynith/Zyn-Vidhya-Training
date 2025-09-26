report 50120 "Zyn_Expense Export Report"
{
    Caption = 'Expense Export Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Expense; "Zyn_Expense Table")
        {
            trigger OnPreDataItem()
            begin
                // Apply custom FromDate / ToDate filters
                if (FromDate <> 0D) and (ToDate <> 0D) then
                    SetRange("Date", FromDate, ToDate)
                else if (FromDate <> 0D) then
                    SetRange("Date", FromDate, DMY2Date(31, 12, 9999))
                else if (ToDate <> 0D) then
                    SetRange("Date", 0D, ToDate);
                // Apply Category filter if selected
                if CategoryFilter <> '' then
                    SetRange(Category, CategoryFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                // Write expense data to Excel buffer
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn("Expense ID", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Format(Amount), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Format(Date), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(Category, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                // Accumulate total
                TotalAmount += Amount;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FilterGroup)
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Category"; CategoryFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = "Zyn_Category Table".Name; // assuming you have Category master table
                    }
                }
            }
        }
    }
    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FromDate: Date;
        ToDate: Date;
        CategoryFilter: Code[50];
        TotalAmount: Decimal;

    trigger OnPreReport()
    begin
        // Add Header Row
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Expense ID', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
        // Add Total Row
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TOTAL', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.CreateNewBook('Expense Export');
        ExcelBuf.WriteSheet('Expenses', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;
}
