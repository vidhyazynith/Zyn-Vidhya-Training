table 50113 "Customer Sales History"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer No"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(3; "Item No"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Item Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Customer No", "Item No")
        {
            Clustered = true;
        }
        //key(CustomerItemDate; "Customer No", "Item No", "Posting Date") { }
    }

}