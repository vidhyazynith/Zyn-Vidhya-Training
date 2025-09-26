table 50109 "Zyn_Employee Leave Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            DataClassification = SystemMetadata;
            TableRelation = "Zyn_Employee Table"."Employee ID";
        }
        field(2; "Category Name"; Code[30])
        {
            Caption = 'Category Name';
            DataClassification = CustomerContent;
            TableRelation = "Zyn_Leave Category Table"."Category Name";
        }
        field(3; "Remaining Leave"; Integer)
        {
            Caption = 'Remaining Leave';
            DataClassification = CustomerContent;
        }
        field(4; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Employee ID", "Category Name")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CalcRemainingDays();
    end;

    trigger OnModify()
    begin
        CalcRemainingDays();
    end;

    procedure CalcRemainingDays()
    var
        LeaveCat: Record "Zyn_Leave Category Table";
        LeaveReq: Record "Zyn_Leave Request Table";
        used: Integer;
        allowed: Integer;
    begin
        // Get allowed days from category
        if LeaveCat.Get("Category Name") then
            allowed := LeaveCat."Allowed Days";
        // Get total used leave from requests
        LeaveReq.SetRange("Employee ID", "Employee ID");
        LeaveReq.SetRange("Leave Category", "Category Name");
        LeaveReq.SetRange(Status, LeaveReq.Status::Approved);
        if LeaveReq.FindSet() then
            repeat
                used += LeaveReq."Total Leave Taken";
            until LeaveReq.Next() = 0;
        // Store the remaining days
        "Remaining Leave" := allowed - used;
    end;
}
