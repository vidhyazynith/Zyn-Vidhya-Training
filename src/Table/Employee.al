table 50102 "Employee Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Emp. Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification =  CustomerContent;
        }
        field(3; "Department"; Enum Department)
        {
            Caption ='Department';
            DataClassification = CustomerContent;
        }
        field(4; "Role"; Enum "Employee Role")
        {
            Caption = 'Role';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Employee ID", "Emp. Name")
        {
            Clustered = true;
        }
    }
}
