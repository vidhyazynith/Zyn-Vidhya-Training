table 50109 "Employee Leave Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        // field(1; "Emp. leave ID"; Integer)
        // {
        //     Caption = 'Employee Leave ID';
        //     DataClassification = SystemMetadata;
        //     AutoIncrement = true;
        // }
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            DataClassification = SystemMetadata;
            TableRelation = "Employee Table"."Employee ID";
        }
        field(2; "Category Name"; Code[30])
        {
            Caption = 'Category Name';
            DataClassification =  CustomerContent;
            TableRelation = "Leave Category Table"."Category Name";
        }
        field(3; "Remaining Leave"; Integer)
        {
            Caption ='Remaining Leave';
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
        LeaveCat: Record "Leave Category Table";
        LeaveReq: Record "Leave Request Table";
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
