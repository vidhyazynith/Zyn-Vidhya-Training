table 50117 "Income Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Income ID"; Code[20])
        {
            Caption = 'Income ID';
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
            TableRelation = "Income Category Table".Name;
        }
        field(6; "Category Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Income Category Table".Name where("Category ID" = field(Category)));
        }
    }

    keys
    {
        key(PK; "Income ID")
        {
            Clustered = true;
        }
    }
}
