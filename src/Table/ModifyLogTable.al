namespace DefaultPublisher.ALProject4;


using Microsoft.Sales.Customer;

table 50106 "Customer Modify Log"
{
    // DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer Number"; Code[50])
        {
            DataClassification = SystemMetadata;
            TableRelation = Customer."No.";
        }
        field(3; "Field Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Old Value"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(5; "New Value"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(6; "User ID"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys

    {
        key(PK; "Entry No.", "Customer Number") { }
    }

}
