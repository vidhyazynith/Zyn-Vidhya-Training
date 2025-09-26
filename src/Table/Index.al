table 50115 "Zyn_Index table"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Per. Increase"; Decimal)
        {
            Caption = 'Percentage Inc';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(4; "Start Year"; Integer)
        {
            Caption = 'Start Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(5; "End Year"; Integer)
        {
            Caption = 'End Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    local procedure RecalculateIndexValues()
    var
        IndexListPartRec: Record "Zyn_Index ListPart Table";
        CurValue: Decimal;
        YearCounter: Integer;
        EntryNo: Integer;
        YearsElapsed: Integer;
    begin
        // Avoid running if required fields are blank or invalid
        if ("Start Year" = 0) or ("End Year" = 0) or ("Per. Increase" = 0) then
            exit;
        if "End Year" < "Start Year" then
            Error('End Year must be greater than or equal to Start Year.');
        // Clear existing list part values for this code
        IndexListPartRec.Reset();
        IndexListPartRec.SetRange(Code, Code);
        if IndexListPartRec.FindSet() then
            IndexListPartRec.DeleteAll();
        // Initialize principal
        CurValue := 100; // Starting value
        EntryNo := 0;
        // Loop through each year and calculate compound interest
        for YearCounter := "Start Year" to "End Year" do begin
            EntryNo += 1;
            // Years elapsed from start
            YearsElapsed := YearCounter - "Start Year";
            // Compound interest formula: P * (1 + r)^t
            CurValue := 100 * Power(1 + ("Per. Increase" / 100), YearsElapsed);
            // Insert into Index List Part
            IndexListPartRec.Init();
            IndexListPartRec.Code := Code;
            IndexListPartRec."Entry No" := EntryNo;
            IndexListPartRec.Year := YearCounter;
            IndexListPartRec.Value := CurValue; // Round to 2 decimals
            IndexListPartRec.Insert();
        end;
    end;

    trigger OnDelete()
    var
        ChildRec: Record "Zyn_Index ListPart Table";
    begin
        ChildRec.Reset();
        ChildRec.SetRange(Code, Code);
        if ChildRec.FindSet() then
            ChildRec.DeleteAll();
    end;
}
