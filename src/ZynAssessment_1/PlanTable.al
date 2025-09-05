table 50119 "Plan Table"
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
        field(4; "Status"; Enum "Plan Status")
        {
            Caption = 'Status';
            trigger OnValidate()
            var
                SubRec: Record "Subscription table";
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
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    var
        SubRec: Record "Subscription table";
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
    
    trigger OnRename()
    begin
        
    end;
    
}
