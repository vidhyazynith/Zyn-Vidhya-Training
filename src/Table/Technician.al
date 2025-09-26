table 50107 "Zyn_Technician Log Table"
{
    fields
    {
        field(1; "Technician ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
        }
        field(2; "Technician Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; "Department"; Enum "Zyn_Technician Department")
        {
            DataClassification = CustomerContent;
            Caption = 'Department';
        }
        field(4; "Phone No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
        }
        field(5; "Prob Count"; Integer)
        {
            Caption = 'Problem Count';
            FieldClass = FlowField;
            CalcFormula = count("Zyn_Complaint Table" where("Technician ID" = field("Technician ID")));
        }
    }
    keys
    {
        key(PK; "Technician ID")
        {
            clustered = true;
        }
    }
}
