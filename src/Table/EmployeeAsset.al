table 50118 "Zyn_Employee Asset Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            TableRelation = "Zyn_Employee Table"."Employee ID";
        }
        field(2; "Serial No"; Code[50])
        {
            Caption = 'Serial No';
            TableRelation = "Zyn_Assets Table"."Serial No";
        }
        field(3; "Status"; Enum "Zyn_Asset Status")
        {
            Caption = 'Status';
            InitValue = Assigned;
            trigger OnValidate()
            var
                AssetsRec: Record "Zyn_Assets Table";
                PrevEmpAsset: Record "Zyn_Employee Asset Table";
                ExpiryDate: Date;
            begin
                AssetsRec.Reset();
                AssetsRec.SetRange("Serial No", Rec."Serial No");
                if not AssetsRec.FindFirst() then
                    Error('Asset with SerialNo %1 does not exist in Assets table.', Rec."Serial No");
                if Rec.Status = Status::Assigned then begin
                    AssetsRec.UpdateAvailability();
                    if not AssetsRec.Available then
                        Error('Asset %1 is not available for assignment (procured %2).', Rec."Serial No", AssetsRec."Procured Date");
                end else if Rec.Status = Status::Returned then begin
                    PrevEmpAsset.Reset();
                    PrevEmpAsset.SetRange("Serial No", Rec."Serial No");
                    PrevEmpAsset.SetRange("Employee ID", Rec."Employee ID");
                    PrevEmpAsset.SetRange(Status, Status::Assigned);
                    if PrevEmpAsset.FindLast() then
                        Rec."Assigned date" := PrevEmpAsset."Assigned date"
                    else begin
                        PrevEmpAsset.Reset();
                        PrevEmpAsset.SetRange("Serial No", Rec."Serial No");
                        PrevEmpAsset.SetRange(Status, Status::Assigned);
                        if PrevEmpAsset.FindLast() then
                            Rec."Assigned date" := PrevEmpAsset."Assigned date";
                    end;
                    ExpiryDate := System.CalcDate('<+5Y>', AssetsRec."Procured Date");
                    if Rec."Returned date" <> 0D then
                        if Rec."Returned date" > ExpiryDate then
                            Error('ReturnedDate %1 exceeds 5-year window (procured %2).', Rec."Returned date", AssetsRec."Procured Date");
                    if System.WorkDate() <= ExpiryDate then
                        AssetsRec.Available := true
                    else
                        AssetsRec.Available := false;
                    AssetsRec.Modify();
                end else if Rec.Status = Status::Lost then begin
                    PrevEmpAsset.Reset();
                    PrevEmpAsset.SetRange("Serial No", Rec."Serial No");
                    PrevEmpAsset.SetRange("Employee ID", Rec."Employee ID");
                    PrevEmpAsset.SetRange(Status, Status::Assigned);
                    if PrevEmpAsset.FindLast() then
                        Rec."Assigned date" := PrevEmpAsset."Assigned date"
                    else begin
                        PrevEmpAsset.Reset();
                        PrevEmpAsset.SetRange("Serial No", Rec."Serial No");
                        PrevEmpAsset.SetRange(Status, Status::Assigned);
                        if PrevEmpAsset.FindLast() then
                            Rec."Assigned date" := PrevEmpAsset."Assigned date";
                    end;
                    AssetsRec.Available := false;
                    AssetsRec.Modify();
                end;
            end;
        }
        field(4; "Assigned date"; Date)
        {
            Caption = 'Assigned Date';
        }
        field(5; "Returned date"; Date)
        {
            Caption = 'Returned Date';
        }
        field(6; "Lost date"; Date)
        {
            Caption = 'Lost Date';
        }
        field(7; "Asset Type"; text[100])
        {
            Caption = 'Asset Type';
            TableRelation = "Zyn_Asset Type Table".Name;
        }
    }
    keys
    {
        key(PK; "Serial No", "Employee ID")
        {
            Clustered = true;
        }
    }
}
