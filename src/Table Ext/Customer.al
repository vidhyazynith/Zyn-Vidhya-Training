tableextension 50100 CustomerExt extends Customer
{
    fields
    {
        field(50100; "Credit Allowed"; Decimal)
        {
            Caption = 'Credit Allowed';
            DataClassification = CustomerContent;
        }

        field(50101; "Credit Used"; Decimal)
        {
            Caption = 'Credit Used';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Amount WHERE("Sell-to Customer No." = FIELD("No.")));
        }
        field(50102; "Sales Year"; Date)
        {
            Caption = 'Sales Year';
            FieldClass = FlowFilter;

        }
        field(50104; "Loyalty Points Allowed"; Integer)
        {
            Caption = 'Loyalty Points Allowed';
            DataClassification = CustomerContent;
        }
        field(50105; "Loyalty Points Used"; Integer)
        {
            Caption = 'Loyalty Points Used';
            dataClassification = CustomerContent;
        }

        //field(50103; "Sales Amount"; Decimal)
        //{
        //    Caption = 'Sales Amount';
        //    FieldClass = FlowField;
        //    CalcFormula = sum("Cust. Ledger Entry"."Amount" where(
        //        "Customer No." = field("No."),
        //        "Posting Date" = field("Sales Year")));
    }
    trigger OnBeforeModify()
    var
        RecRef, xRecRef : RecordRef;
        FieldRef, xFieldRef : FieldRef;
        LogEntry: Record "Customer Modify Log";
        i: Integer;
        FieldName: Text;
    begin
        RecRef.GetTable(Rec);
        xRecRef.GetTable(xRec);

        for i := 1 to RecRef.FieldCount do begin
            FieldRef := RecRef.FieldIndex(i);
            xFieldRef := xRecRef.FieldIndex(i);
            FieldName := FieldRef.Name;
            begin
                if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin
                        
                    LogEntry."Entry No." := 0; // AutoIncrement field, will be set automatically
                    LogEntry."Customer Number" := Rec."No.";
                    LogEntry."Field Name" := FieldRef.Caption();
                    LogEntry."Old Value" := Format(xFieldRef.Value);
                    LogEntry."New Value" := Format(FieldRef.Value);
                    LogEntry."User ID" := UserId();
                    LogEntry.Insert();
                end;
            end;
        end;
    end;

}
