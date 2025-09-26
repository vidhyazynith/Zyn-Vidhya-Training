codeunit 50106 "Zyn_System Company Sync"
{
    var
        IsSyncing: Boolean;
    // Insert from Zyn to System
    [EventSubscriber(ObjectType::Table, Database::"Zyn_Company Table", 'OnAfterInsertEvent', '', true, true)]
    local procedure ZynCompanyOnAfterInsert(var Rec: Record "Zyn_Company Table"; RunTrigger: Boolean)
    var
        Company: Record Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if not Company.Get(Rec.Name) then begin
            Company.Init();
            Company.Name := Rec.Name;
            Company."Display Name" := Rec."Display Name";
            Company."Evaluation Company" := Rec."Evaluation Company";
            Company.Insert();
        end;
        IsSyncing := false;
    end;
    // Modify from Zyn to System
    [EventSubscriber(ObjectType::Table, Database::"Zyn_Company Table", 'OnAfterModifyEvent', '', true, true)]
    local procedure ZynCompanyOnAfterModify(var Rec: Record "Zyn_Company Table"; RunTrigger: Boolean)
    var
        Company: Record Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if Company.Get(Rec.Name) then begin
            if (Company."Display Name" <> Rec."Display Name") or (Company."Evaluation Company" <> Rec."Evaluation Company") then begin
                Company."Display Name" := Rec."Display Name";
                Company."Evaluation Company" := Rec."Evaluation Company";
                Company.Modify();
            end;
        end;
        IsSyncing := false;
    end;
    // Delete from Zyn to System
    [EventSubscriber(ObjectType::Table, Database::"Zyn_Company Table", 'OnAfterDeleteEvent', '', true, true)]
    local procedure ZynCompanyOnAfterDelete(var Rec: Record "Zyn_Company Table"; RunTrigger: Boolean)
    var
        Company: Record Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if Company.Get(Rec.Name) then
            Company.Delete();
        IsSyncing := false;
    end;
}
