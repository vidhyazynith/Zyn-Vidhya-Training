codeunit 50110 Zyn_VendorMasterSlaveSync
{
    var
        IsVendorSync: Boolean;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', true, true)]
    local procedure VendorOnBeforeInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error('You cannot create vendor directly in a Slave company. Create them only in the Master company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeModifyEvent', '', true, true)]
    local procedure VendorOnBeforeModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        // Only block manual modifications in slave companies
        if IsVendorSync then
            exit;
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                if RunTrigger then
                    Error('You cannot modify vendor in a Slave company. Modify them only in the Master company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', true, true)]
    local procedure CustomerOnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveCustomer: Record Customer;
        MasterSlaveMgt: Codeunit "Zyn_SendFromMasterToSlaveMgt";
    begin
        // Prevent recursion
        if IsVendorSync then
            exit;
        // Only proceed if we're in master company
        if not MasterCompany.Get(CompanyName()) or not MasterCompany."Is Master" then
            exit;
        IsVendorSync := true;
        // Find all slave companies linked to this master
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                    //Only update if customer already exists in slave
                    if SlaveCustomer.Get(Rec."No.") then
                        MasterSlaveMgt.MirrorVendorToSlave(Rec."No.", SlaveCompany.Name);
                end;
            until SlaveCompany.Next() = 0;
        IsVendorSync := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure VendorOnDeleteInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error('You cannot delete vendor directly in a Slave company. Delete them only in the Master company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterDeleteEvent', '', true, true)]
    local procedure VendorOnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveVendor: Record Vendor;
        SlaveContactRel: Record "Contact Business Relation";
    begin
        if IsVendorSync then
            exit;
        // Only proceed if we're in master company
        if not MasterCompany.Get(CompanyName()) then
            exit;
        if (not MasterCompany."Is Master") <> (MasterCompany."Master Company Name" <> '') then
            exit;
        IsVendorSync := true;
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    // Switch to slave company
                    SlaveVendor.ChangeCompany(SlaveCompany.Name);
                    SlaveContactRel.ChangeCompany(SlaveCompany.Name);
                    // 1. Delete Contact Business Relation first
                    SlaveContactRel.Reset();
                    SlaveContactRel.SetRange("Link to Table", SlaveContactRel."Link to Table"::Vendor);
                    SlaveContactRel.SetRange("No.", Rec."No.");
                    if SlaveContactRel.FindSet() then
                        repeat
                            SlaveContactRel.Delete(true);
                        until SlaveContactRel.Next() = 0;
                    // 2. Delete vendor itself
                    if SlaveVendor.Get(Rec."No.") then
                        SlaveVendor.Delete(true);
                end;
            until SlaveCompany.Next() = 0;
        IsVendorSync := false;
    end;
}