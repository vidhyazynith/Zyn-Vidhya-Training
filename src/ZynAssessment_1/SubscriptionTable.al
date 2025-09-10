table 50120 "ZYN_Subscription table"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Sub ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Subdcription ID';
            AutoIncrement = true;
        }
        field(2; "CustomerId"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Customer Id';
            TableRelation = Customer."No.";
        }
        field(3; "Plan Id"; Integer)
        {
            Caption = 'Plan Id';
            DataClassification = ToBeClassified;
            TableRelation = "ZYN_Plan Table"."Plan Id";
        }
        field(4; "Start date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start date';
            trigger OnValidate()
            begin
                RecomputeDates();
                Modify();
            end;
        }
        field(5; "Duration"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Duration';
            trigger OnValidate()
            begin
                RecomputeDates();
                Modify();
            end;
        }
        field(6; "End date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End date';
        }
        field(7; "Subcrip. Status"; Enum "ZYN_Subscription Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(8;"Next Billing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Billing date';
        }
        field(9; "Next Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Renewal Date';
            trigger OnValidate()
            begin
                if "Next Renewal Date" <= "End Date" then
                Error('Next Renewal Date cannot be less than or equal to the End Date %1.', Format("End Date"));
            end;
        }
        field(10; "Reminder Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reminder Sent';
        }
    }
    
    keys
    {
        key(PK; "Sub ID",CustomerId)
        {
            Clustered = true;
        }
    }
    

    local procedure RecomputeDates()
    begin
        // If no start date or duration, clear computed dates.
        if ("Start date" = 0D) or ("Duration" <= 0) then begin
            "End date" := 0D;
            "Next Billing Date" := 0D;
            exit;
        end;

        // End Date = Start Date + Duration months (your rule gives 01-12-2025 for 01-01-2025 + 11M)
        "End date" := CalcDate('<+' + Format("Duration") + 'M>', "Start date");

        // If there is no next billing date yet, start at Start Date + 1 month
        if "Next Billing Date" = 0D then
            "Next Billing Date" := CalcDate('<+1M>', "Start date");

        // If next billing date is beyond end date, stop generating it
        if "Next Billing Date" > "End date" then
            "Next Billing Date" := 0D;
    end;

    /// Call this from a billing routine to move the next billing date forward by one month.
    procedure AdvanceNextBillingDate()
begin
    // Do nothing if subscription is not active
    if "Subcrip. Status" <> "Subcrip. Status"::Active then
        exit;

    if ("Start date" = 0D) or ("Duration" <= 0) then
        exit;

    if "Next Billing Date" = 0D then
        "Next Billing Date" := CalcDate('<+1M>', "Start date")
    else
        "Next Billing Date" := CalcDate('<+1M>', "Next Billing Date");

    if "Next Billing Date" > "End date" then
        "Next Billing Date" := 0D;
end;


}