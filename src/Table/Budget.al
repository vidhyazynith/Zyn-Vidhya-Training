table 50112 "Zyn_Budget Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Budget ID"; Integer)
        {
            Caption = 'Budget ID';
            ToolTip = 'Specifies the unique system-generated identification number for each budget entry.';
            AutoIncrement = true;
        }
        field(2; "From Date"; Date)
        {
            Caption = 'From Date';
            ToolTip = 'Specifies the starting date for the budget period.';
        }
        field(3; "To Date"; Date)
        {
            Caption = 'To Date';
            ToolTip = 'Specifies the ending date for the budget period.';
        }
        field(4; "Budget Amount"; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the total amount allocated for the selected budget category within the defined period.';
        }
        field(5; "Category"; Code[100])
        {
            Caption = 'Category';
            ToolTip = 'Specifies the budget category to which this amount is assigned, such as Groceries, Furniture, etc';
            TableRelation = "Zyn_Category Table".Name;
        }
    }
    keys
    {
        key(PK; "Budget ID", Category)
        {
            Clustered = true;
        }
    }
}
