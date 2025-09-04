table 50114 "Assets Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Asset ID"; Integer)
        {
            Caption = 'Asset ID';
            AutoIncrement = true;
        }
        field(2; "Asset Type"; text[100])
        {
            Caption = 'Asset Type';
            TableRelation = "Asset Type Table"."name";
        }
        field(3; "Serial No"; Code[30])
        {
            Caption = 'Serial No';
        }
        field(4; "Procured Date"; Date)
        {
            Caption = 'Procured Date';
            trigger OnValidate()
            begin
                UpdateAvailability();
            end;
        }
        field(5; Vendor; Text[50])
        {
            Caption = 'Vendor';
        }
        field(6; Available; Boolean)
        {
            Caption = 'Available';

        }
        
    }

    keys
    {
        key(PK; "Asset ID","Serial No","Asset Type")
        {
            Clustered = true;
        }
    }
    
procedure UpdateAvailability()
    var
        ExpiryDate: Date;
        WorkDate: Date;
        EmpAssetRec: Record "Employee Asset Table";
    begin
        WorkDate := System.WorkDate();

        // Check 5 years expiry
        if Rec."Procured Date" = 0D then begin
            Rec.Available := false;
            exit;
        end;
        ExpiryDate := System.CalcDate('<+5Y>', Rec."Procured Date");
        if WorkDate > ExpiryDate then begin
            Rec.Available := false;
            exit;
        end;

        // Check assignment status
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Serial No", Rec."Serial No");

        if EmpAssetRec.FindLast() then begin
            case EmpAssetRec.Status of
                EmpAssetRec.Status::Assigned:
                    Rec.Available := false;
                EmpAssetRec.Status::Returned:
                    Rec.Available := true;
                EmpAssetRec.Status::Lost:
                    Rec.Available := false;
                else
                    Rec.Available := true;
            end;
        end else
            Rec.Available := true; // never assigned yet, so available
    end;

    trigger OnInsert()
    begin
        UpdateAvailability();
    end;

    trigger OnModify()
    begin
        UpdateAvailability();
    end;

    trigger OnDelete()
    var
        EmpAssetRec: Record "Employee Asset Table";
    begin
        // Check if there are assigned EmpAssets
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Serial No", Rec."Serial No");
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);
        if EmpAssetRec.FindFirst() then
            Error('Cannot delete Asset %1 because it is currently assigned.', Rec."Serial No");

        // Delete related EmpAssets (returned/lost/others)
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Serial No", Rec."Serial No");
        if EmpAssetRec.FindSet() then
            repeat
                EmpAssetRec.Delete();
            until EmpAssetRec.Next() = 0;
    end;
}
