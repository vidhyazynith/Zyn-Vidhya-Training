table 50108 "Zyn_Leave Request Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Leave Req ID"; Integer)
        {
            Caption = 'Leave Request ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            DataClassification = SystemMetadata;
            TableRelation = "Zyn_Employee Table"."Employee ID";
            trigger OnValidate()
            var
                emp: Record "Zyn_Employee Table";
            begin
                UpdateHiddenTable();
                emp.SetRange("Employee ID", Rec."Employee ID");
                if emp.FindFirst() then
                    Rec."Employee Name" := emp."Emp. Name";
            end;
        }
        field(3; "Leave Category"; Text[20])
        {
            Caption = 'Leave Category';
            DataClassification = CustomerContent;
            TableRelation = "Zyn_Leave Category Table"."Category Name";
            trigger OnValidate()
            begin
                UpdateHiddenTable();
            end;
        }
        field(4; "Reason"; Text[50])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ("Start Date" <> 0D) and ("End Date" <> 0D) then
                    Rec."Total Leave Taken" := "End Date" - "Start Date";
            end;
        }
        field(7; "Remaining Leave"; Integer)
        {
            Caption = 'Remaining Leave';
            FieldClass = FlowField;
            CalcFormula = lookup("Zyn_Employee Leave Table"."Remaining Leave" where("Employee ID" = field("Employee ID"),
                "Category Name" = field("Leave Category")));
        }
        field(8; "Status"; Enum "Zyn_Leave Approval Status")
        {
            Caption = 'Status';
            InitValue = Pending;
        }
        field(9; "Total Leave Taken"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        Field(10; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Leave Req ID", "Employee ID")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        if Status <> Status::Pending then
            Error('You can only delete leave requests that are still Pending.');
    end;

    local procedure UpdateHiddenTable()
    var
        Hidden: Record "Zyn_Employee Leave Table";
    begin
        if ("Employee ID" = 0) or ("Leave Category" = '') then
            exit;
        if Hidden.Get("Employee ID", "Leave Category") then begin
            Hidden."Employee Name" := "Employee Name";
            Hidden.Modify(true);
        end else begin
            Hidden.Init();
            Hidden."Employee ID" := "Employee ID";
            Hidden."Employee Name" := "Employee Name";
            Hidden."Category Name" := "Leave Category";
            Hidden.Insert(true);
        end;
    end;
}
