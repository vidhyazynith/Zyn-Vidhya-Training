table 50100 "Recurring Expense"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Recurring ID"; Integer) { Caption = 'Recurring ID'; AutoIncrement = true; }
        field(2; "Category"; Code[100]) 
        { 
            Caption = 'Category'; 
            TableRelation = "Category Table".Name; }
        field(3; "Amount"; Decimal) { Caption = 'Amount'; }
        field(4; "Cycle"; Enum "Cycle") { Caption = 'Cycle'; }  // weekly, monthly, quarterly, half-yearly, yearly
        field(5; "Start Date"; Date) { Caption = 'Start Date'; 
        trigger OnValidate()
            begin
                CalcNextCycleDate("Start Date", cycle);
            end;}
        field(6; "Next Cycle Date"; Date) { Caption = 'Next Cycle Date'; Editable = false;
         trigger OnValidate()
            begin
                CalcNextCycleDate("Next Cycle Date", cycle);
            end;}
    }

    keys
    {
        key(PK; "Recurring ID") { Clustered = true; }
    }
    procedure CalcNextCycleDate(CurrentDate: Date; Cycle: Enum Cycle)
    begin
        if (CurrentDate <> 0D) then
        begin

        case "Cycle" of
            "Cycle"::Weekly:
                "Next Cycle Date" := CalcDate('<+1W>', CurrentDate);
            "Cycle"::Monthly:
                "Next Cycle Date" := CalcDate('<+1M>', CurrentDate);
            "Cycle"::Quarterly:
                "Next Cycle Date" := CalcDate('<+3M>', CurrentDate); // 3 months
            "Cycle"::"Half Yearly":
                "Next Cycle Date" := CalcDate('<+6M>', CurrentDate); // 6 months
            "Cycle"::Yearly:
                "Next Cycle Date" := CalcDate('<+1Y>', CurrentDate);
        end;
        end;
    end;
    
}
