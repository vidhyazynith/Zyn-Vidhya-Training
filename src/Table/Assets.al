table 50114 "Zyn_Assets Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Asset ID"; Integer)
        {
            Caption = 'Asset ID';
            ToolTip = 'Specifies the unique system-generated identification number for the asset.';
            AutoIncrement = true;
        }
        field(2; "Asset Type"; text[100])
        {
            Caption = 'Asset Type';
            ToolTip = 'Specifies the type or category of the asset, such as Laptop, Phone,etc.';
            TableRelation = "Zyn_Asset Type Table"."name";
        }
        field(3; "Serial No"; Code[30])
        {
            Caption = 'Serial No';
            ToolTip = 'Specifies the unique serial number assigned to the asset.';
        }
        field(4; "Procured Date"; Date)
        {
            Caption = 'Procured Date';
            ToolTip = 'Specifies the date on which the asset was procured or purchased.';
            trigger OnValidate()
            begin
                UpdateAvailability();
            end;
        }
        field(5; Vendor; Text[50])
        {
            Caption = 'Vendor';
            ToolTip = 'Specifies the name of the vendor from whom the asset was purchased.';
        }
        field(6; Available; Boolean)
        {
            Caption = 'Available';
            ToolTip = 'Indicates whether the asset is currently available for assignment or use.';
        }
    }
    keys
    {
        key(PK; "Asset ID", "Serial No", "Asset Type")
        {
            Clustered = true;
        }
    }
    procedure UpdateAvailability()
    var
        ExpiryDate: Date;
        WorkDate: Date;
        EmpAssetRec: Record "Zyn_Employee Asset Table";
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
        EmpAssetRec: Record "Zyn_Employee Asset Table";
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
