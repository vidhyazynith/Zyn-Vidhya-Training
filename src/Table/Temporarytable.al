table 50111 "Zyn_Field Lookup Buffer"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'Field ID';
        }
        field(2; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
        }
    }
    keys
    {
        key(PK; ID, "Field Name")
        {
            Clustered = true;
        }
    }
}
