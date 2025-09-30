codeunit 50109 Zyn_CustomerMasterSlaveSync
{
    var
        IsCustomerSync: Boolean;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', true, true)]
    local procedure CustomerOnBeforeInsert(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error('You cannot create Customers directly in a Slave company. Create them only in the Master company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', true, true)]
    local procedure CustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        // Only block manual modifications in slave companies
        if IsCustomerSync then
            exit;
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                if RunTrigger then
                    Error('You cannot modify Customers in a Slave company. Modify them only in the Master company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure CustomerOnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveCustomer: Record Customer;
        MasterSlaveMgt: Codeunit "Zyn_SendFromMasterToSlaveMgt";
    begin
        // Prevent recursion
        if IsCustomerSync then
            exit;
        // Only proceed if we're in master company
        if not MasterCompany.Get(CompanyName()) then
            exit;
        if (not MasterCompany."Is Master") <> (MasterCompany."Master Company Name" <> '') then
            exit;
        IsCustomerSync := true;
        // Find all slave companies linked to this master
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                    //Only update if customer already exists in slave
                    if SlaveCustomer.Get(Rec."No.") then
                        MasterSlaveMgt.MirrorCustomerToSlave(Rec."No.", SlaveCompany.Name);
                end;
            until SlaveCompany.Next() = 0;
        IsCustomerSync := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure CustomerOnAfterDelete(var Rec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveCustomer: Record Customer;
        SlaveContactRel: Record "Contact Business Relation";
    begin
        if IsCustomerSync then
            exit;
        if not MasterCompany.Get(CompanyName()) or not MasterCompany."Is Master" then
            exit;
        IsCustomerSync := true;
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    // Switch to slave company
                    SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                    SlaveContactRel.ChangeCompany(SlaveCompany.Name);
                    // 1. Delete Contact Business Relation first
                    SlaveContactRel.Reset();
                    SlaveContactRel.SetRange("Link to Table", SlaveContactRel."Link to Table"::Customer);
                    SlaveContactRel.SetRange("No.", Rec."No.");
                    if SlaveContactRel.FindSet() then
                        repeat
                            SlaveContactRel.Delete(true);
                        until SlaveContactRel.Next() = 0;
                    // 2. Delete Customer itself
                    if SlaveCustomer.Get(Rec."No.") then
                        SlaveCustomer.Delete(true);
                end;
            until SlaveCompany.Next() = 0;
        IsCustomerSync := false;
    end;
}