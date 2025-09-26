table 50112 "Zyn_Budget Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Budget ID"; Integer)
        {
            Caption = 'Budget ID';
            AutoIncrement = true;
        }
        field(2; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(3; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(4; "Budget Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Category"; Code[100])
        {
            Caption = 'Category';
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
