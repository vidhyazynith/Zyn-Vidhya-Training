table 50116 "Expense Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Expense ID"; Integer)
        {
            Caption = 'Expense ID';
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "Category"; Code[100])
        {
            Caption = 'Category';
            TableRelation = "Category Table".Name;
            trigger OnValidate()
            var
                BudgetEntry: Record "Budget Table";
                ExpenseRec: Record "Expense Table";
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

        field(6; "Category Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Category Table".Name where("Category ID" = field(Category)));
        } 
        field(7; "Remaining Budget"; Decimal)
        { 

        }
        

    }

    keys
    {
        key(PK; "Expense ID")
        {
            Clustered = true;
        }
    }
    
}
