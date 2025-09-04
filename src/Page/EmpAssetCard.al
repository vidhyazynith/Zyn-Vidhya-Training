page  50154 "Employee Asset Card"
{
    PageType = Card;
    SourceTable ="Employee Asset Table";
    ApplicationArea = ALL;
    Caption = 'Employee Asset Card';
   
    layout
    {
        area(content)
        {
            group(General)
            {
                // field("Employee Asset Id"; Rec."Emp. Ass ID")
                // { }
                field("Employee List"; Rec."Employee ID")
                {
                    ApplicationArea =All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                     trigger OnValidate()
                    begin
                        // After status changed we want page to re-evaluate "Editable" flags
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Assigned Date"; Rec."Assigned date")
                {
                    ApplicationArea = All;
                    Editable = EditAssignedDate;
                }
                field("Returned date"; Rec."Returned date")
                {
                    ApplicationArea = All;
                    Editable = EditReturnedDate;
                }
                field("Lost date"; Rec."Lost date")
                {
                    ApplicationArea = All;
                    Editable = EditLostDate;
                }
               


            }
        }
    } 
    var
        EditAssignedDate: Boolean;
    
        EditReturnedDate: Boolean;
        
        EditLostDate: Boolean;
trigger OnAfterGetRecord()
var
    AssetsRec: Record "Assets Table";
    ExpiryDate: Date;
    AssetStatus:Enum "Asset Status";
begin
    // default
    EditAssignedDate := false;
    EditReturnedDate := false;
    EditLostDate := false;

    if Rec."Serial No" <> '' then begin
        AssetsRec.Reset();
        AssetsRec.SetRange("Serial No", Rec."Serial No");
        if AssetsRec.FindFirst() then begin
            AssetsRec.UpdateAvailability();

            case Rec.Status of
                AssetStatus::Assigned:
                    begin
                        EditAssignedDate := true;
                        EditReturnedDate := false;
                        EditLostDate := false;
                    end;
                AssetStatus::Returned:
                    begin
                        EditAssignedDate := true;
                        EditReturnedDate := true;   
                        EditLostDate := false;
                    end;
                AssetStatus::Lost:
                    begin
                        EditAssignedDate := true;
                        EditReturnedDate := false;
                        EditLostDate := true;
                    end;
            end;
        end;
    end;
end; 

trigger OnQueryClosePage(CloseAction: Action): Boolean
begin
    case Rec.Status of
        Rec.Status::Assigned:
            if Rec."Assigned date" = 0D then
                Error('Assigned Date must be filled when status is Assigned.');
        Rec.Status::Returned:
            if (Rec."Assigned date" = 0D) or (Rec."Returned date" = 0D) then
                Error('Both Assigned Date and Returned Date must be filled when status is Returned.');
        Rec.Status::Lost:
            if (Rec."Assigned date" = 0D) or (Rec."Lost date" = 0D) then
                Error('Both Assigned Date and Lost Date must be filled when status is Lost.');
    end;
    exit(true);
end;
}