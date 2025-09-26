table 50105 "Zyn_Leave Category Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Leave Cat. ID"; Code[100])
        {
            Caption = 'Category ID';
            DataClassification = SystemMetadata;
        }
        field(2; "Category Name"; Code[30])
        {
            Caption = 'Category Name';
            DataClassification = CustomerContent;
        }
        field(3; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Allowed Days"; Integer)
        {
            Caption = 'No. of Days Allowed';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Category Name")
        {
            Clustered = true;
        }
    }

}
