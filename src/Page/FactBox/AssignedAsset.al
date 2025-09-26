page 50375 "Zyn_AssignedAssetsFactbox"
{
    Caption = 'Assigned Assets';
    PageType = CardPart;
    SourceTable = "Zyn_Employee Table";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            cuegroup("Assets Summary")
            {
                field("Assigned Asset Count"; GetAssignedAssetCount())
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record "Zyn_Employee Asset Table";
                        EmpAssetList: Page "Zyn_Employee Asset list";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange("Employee ID", Rec."Employee ID");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);
                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message('No assigned assets for employee %1.', Rec."Employee ID");
                    end;
                }
            }
        }
    }
    local procedure GetAssignedAssetCount(): Integer
    var
        EmpAssetRec: Record "Zyn_Employee Asset Table";
    begin
        EmpAssetRec.SetRange("Employee ID", Rec."Employee ID");
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);
        exit(EmpAssetRec.Count());
    end;
}