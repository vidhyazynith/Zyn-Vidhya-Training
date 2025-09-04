table 50118 "Employee Asset Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        // field(1; "Emp. Ass ID"; Integer)
        // {
        //     Caption = 'Entry No';
        //     AutoIncrement = true;
        // }
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            TableRelation = "Employee Table"."Employee ID";
        }
        field(2; "Serial No"; Code[50])
        {
            Caption = 'Serial No';
            TableRelation = "Assets Table"."Serial No";
        }
        field(3; "Status"; Enum "Asset Status")
        {
            Caption = 'Status';
            InitValue = Assigned;
            trigger OnValidate()
            var
                AssetsRec: Record "Assets Table";
                PrevEmpAsset: Record "Employee Asset Table";
                ExpiryDate: Date;
            begin
                
                //ValidateStatusAndDates();

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
            TableRelation = "Asset Type Table".Name;
        }
    
    }
    keys
    {
        key(PK; "Serial No", "Employee ID")
        {
            Clustered = true;
        }
    }

    //  procedure ValidateStatusAndDates()
    // begin
    //     case Status of
    //         Status::Assigned:
    //             if "Assigned date" = 0D then
    //                 Error('Assigned Date must be filled when status is Assigned.');

    //         Status::Returned:
    //             if ("Assigned date" = 0D) or ("Returned date" = 0D) then
    //                 Error('Both Assigned Date and Returned Date must be filled when status is Returned.');

    //         Status::Lost:
    //             if ("Assigned date" = 0D) or ("Lost date" = 0D) then
    //                 Error('Both Assigned Date and Lost Date must be filled when status is Lost.');
    //     end;
    // end;
}
