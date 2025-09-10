table 50119 "ZYN_Plan Table"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Plan Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan ID';
            AutoIncrement = true;
        }
        field(2;"Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fee';
        }
        field(3; "PlanName"; Text[100])
        {
            Caption = 'Plan Name';
        }
        field(4; "Status"; Enum "ZYN_Plan Status")
        {
            Caption = 'Status';
            trigger OnValidate()
            var
                SubRec: Record "ZYN_Subscription table";
            begin
                // If Plan is set to Inactive, update all related Subscriptions
                if (xRec.Status <> Status) and (Status = Status::Inactive) then begin
                    SubRec.Reset();
                    SubRec.SetRange("Plan Id", "Plan Id");
                    if SubRec.FindSet() then
                        repeat
                            SubRec.Validate("Subcrip. Status", SubRec."Subcrip. Status"::Inactive);
                            SubRec.Modify(true);
                        until SubRec.Next() = 0;
                end;
            end;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
        }

    }
    
    keys
    {
        key(PK; "Plan Id")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        SubRec: Record "ZYN_Subscription table";
    begin
        // Instead of deleting Subscriptions, make them Inactive
        SubRec.Reset();
        SubRec.SetRange("Plan Id", "Plan Id");
        if SubRec.FindSet() then
            repeat
                SubRec.Validate("Subcrip. Status", SubRec."Subcrip. Status"::Inactive);
                SubRec.Modify();
            until SubRec.Next() = 0;
    end;
    

}
