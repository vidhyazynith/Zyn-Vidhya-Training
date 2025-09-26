codeunit 50105 "Zyn_Company Synchronization"
{
    var
        IsSyncing: Boolean;
    // Insert from System to Zyn
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure CompanyOnAfterInsert(var Rec: Record Company; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if not ZynCompany.Get(Rec.Name) then begin
            ZynCompany.Init();
            ZynCompany.Name := Rec.Name;
            ZynCompany."Display Name" := Rec."Display Name";
            ZynCompany."Evaluation Company" := Rec."Evaluation Company";
            ZynCompany.Insert();
        end;
        IsSyncing := false;
    end;
    // Modify from System to Zyn
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure CompanyOnAfterModify(var Rec: Record Company; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if ZynCompany.Get(Rec.Name) then begin
            if (ZynCompany."Display Name" <> Rec."Display Name") or (ZynCompany."Evaluation Company" <> Rec."Evaluation Company") then begin
                ZynCompany."Display Name" := Rec."Display Name";
                ZynCompany."Evaluation Company" := Rec."Evaluation Company";
                ZynCompany.Modify();
            end;
        end;
        IsSyncing := false;
    end;
    //Delete from System to Zyn
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure CompanyOnAfterDelete(var Rec: Record Company; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if ZynCompany.Get(Rec.Name) then
            ZynCompany.Delete();
        IsSyncing := false;
    end;
}
