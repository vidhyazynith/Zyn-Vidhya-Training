table 50121 "ZYN_Expense Claim Category"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Claim Category ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }
        field(2; "CategoryName"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(3; "Sub Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Type';
        }
        field(4; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(5; "Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Limit';
        }
    }
    keys
    {
        key(PK; "Claim Category ID", CategoryName, "Sub Type")
        {
            Clustered = true;
        }
    }
}