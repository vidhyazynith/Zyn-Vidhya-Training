namespace DefaultPublisher.ALProject4;


using Microsoft.Sales.Customer;

table 50101 "Customer Visit Log"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry Number"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Customer Number"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(3; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Purpose"; Text[20])
        {
            DataClassification = CustomerContent;
        }

        field(5; "Notes"; Text[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry Number", "Customer Number")
        {
            Clustered = true;
        }
    }
}