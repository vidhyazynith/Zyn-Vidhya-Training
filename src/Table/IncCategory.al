table 50147 "Zyn_Income Category Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Category ID"; Code[100])
        {
            Caption = 'Category ID';
            DataClassification = SystemMetadata;
        }
        field(2; "Name"; Code[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Name)
        {
        }
    }
}
