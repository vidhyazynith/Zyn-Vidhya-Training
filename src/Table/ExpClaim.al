table 50122 "ZYN_Expense Claim Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Claim ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Claim ID';
            AutoIncrement = true;
        }
        field(2; "Category"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            trigger OnValidate()
            var
                ExpCategory: Record "ZYN_Expense Claim Category";
            begin
                if "Category" = '' then begin
                    "Sub Type" := '';
                    exit;
                end;
                if ExpCategory.Get("Category") then begin   // lookup by ID
                    "Sub Type" := ExpCategory."Sub Type";   // populate Sub Type
                end else
                    Error('Invalid category selected.');
            end;
        }
        field(3; "Employee ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee ID';
            TableRelation = "Zyn_Employee Table"."Employee ID";
        }
        field(4; "Claim Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Claim Date';
        }
        field(5; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            trigger OnValidate()
            var
                ExpCat: Record "ZYN_Expense Claim Category";
            begin
                if Rec.Category = '' then
                    Error('Please select an expense category before entering amount.');
                ExpCat.SetRange(CategoryName, Rec.Category);       // if you store ID                     // if blank, or use Rec.CategoryName if available
                ExpCat.SetRange("Sub Type", Rec."Sub Type");
                if ExpCat.FindFirst() then begin
                    if Amount > Rec."Available Limit" then
                        Error('The amount %1 exceeds the avaialble limit %2 for this category.',
                              Amount, Rec."Available Limit");
                end else
                    Error('Expense category not found or invalid combination.');
            end;
        }
        field(6; "Status"; Enum "Zyn_Claim Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            InitValue = "PendingApproval";
        }
        field(7; "Bill"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill';
            SubType = Memo;
        }
        field(8; "Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
        }
        field(9; "Sub Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Type';
        }
        field(10; "Bill date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Date';
        }
        field(11; "Available Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available Limit';
            Editable = false;
        }
        field(12; "Bill File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill File Name';
        }
        field(13; "Rejection Reason"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected Reason';
        }
    }
    keys
    {
        key(PK; "Claim ID", "Employee ID")
        {
            Clustered = true;
        }
    }
    procedure CalcAvailableLimit()
    var
        ClaimCategory: Record "ZYN_Expense Claim Category";
        Claim: Record "ZYN_Expense Claim Table";
        ApprovedAmount: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        Clear("Available Limit");
        // 1. Find category
        ClaimCategory.SetRange(CategoryName, Rec.Category);
        ClaimCategory.SetRange("Sub Type", Rec."Sub Type");
        if ClaimCategory.FindFirst() then begin
            StartDate := CalcDate('<-CY>', WorkDate());  // first day of current year
            EndDate := CalcDate('<CY>', WorkDate());   // last day of current year
            // 2. Sum approved claims for same Category + SubType
            Claim.Reset();
            Claim.SetRange(Category, Rec.Category);
            Claim.SetRange("Sub Type", Rec."Sub Type");
            Claim.SetRange("Employee ID", Rec."Employee ID");
            Claim.SetRange(Status, Claim.Status::Approved);
            Claim.SetRange("Claim Date", StartDate, EndDate);
            if Claim.FindSet() then
                repeat
                    ApprovedAmount += Claim.Amount;
                until Claim.Next() = 0;
            // 3. Calculate available limit
            "Available Limit" := ClaimCategory.Limit - ApprovedAmount;
        end;
    end;
}