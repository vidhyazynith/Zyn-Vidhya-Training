table 50112 "Budget Table"
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
            TableRelation = "Category Table".Name;
        }
        // {
        // field(6; "Category Name"; Text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Category Table".Name where("Category ID" = field(Category)));
        // }
    }

    keys
    {
        key(PK; "Budget ID", Category)
        {
            Clustered = true;
        }
    }
}
