page 50144 "Leave Request Card Page"
{
    PageType = Card;
    SourceTable = "Leave Request Table";
    ApplicationArea = ALL;
    Caption = 'Leave Request Card';
    

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Leave Req. ID"; Rec."Leave Req ID")
                { 
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                    TableRelation = "Employee Table"."Employee ID";

                }
                field("Leave category";Rec."Leave Category")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
    begin
        // Update FlowField when category changes
        CurrPage.Update(false); // refresh the page fields
    end;
                
                }
                field("Reason"; Rec.Reason)
                {
                    ApplicationArea = All;
                }   
                field("Start date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Remaining Leave"; Rec."Remaining Leave")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    } 
    actions
    {
        area(Processing)
        {
            action(RequestStatus)
            {
                
            ApplicationArea = All;
            Caption = 'Update Request Status';

            trigger OnAction()
            var
                Choice: Integer;
            begin
                // Show two options
                Choice := StrMenu('Approved,Rejected'); 

                case Choice of
                    1:
                        Rec.Status := Rec.Status::Approved;
                    2:
                        Rec.Status := Rec.Status::Rejected;
                end;

                // Save the updated value
                if Choice in [1,2] then begin
                    Rec.Modify(true);
            end;
            end;
            }
        }
    }  
}