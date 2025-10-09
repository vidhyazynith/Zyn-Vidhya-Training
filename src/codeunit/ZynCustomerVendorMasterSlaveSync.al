codeunit 50109 Zyn_CustomerVendorMasterSlave
{
    var
        IsCustomerSync: Boolean;
        IsVendorSync: Boolean;
    //===============================//
    // CUSTOMER SYNC EVENT SUBSCRIBERS
    //===============================//
    // Event: Prevent customer creation in slave company
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', true, true)]
    local procedure CustomerOnBeforeInsert(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        HandleCustomerOnBeforeInsert(Rec, RunTrigger);
    end;
    // Event: Prevent manual modification of customers in slave company
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', true, true)]
    local procedure CustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    begin
        HandleCustomerOnBeforeModify(Rec, xRec, RunTrigger);
    end;
    // Event: Sync modified customer from master to all slaves
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure CustomerOnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    begin
        HandleCustomerOnAfterModify(Rec, xRec, RunTrigger);
    end;
    //Event: Prevent deletion of customers in slave company
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure PreventDeleteCustomer(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        HandleOnBeforeDeleteCustomer(Rec, RunTrigger);
    end;
    // Event: Delete corresponding customer in slaves after deletion in master
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure CustomerOnAfterDelete(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        HandleCustomerOnAfterDelete(Rec, RunTrigger);
    end;
    //===============================//
    // VENDOR SYNC EVENT SUBSCRIBERS
    //===============================//
    // Event: Prevent vendor creation in slave company
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', true, true)]
    local procedure VendorOnBeforeInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        HandleVendorOnBeforeInsert(Rec, RunTrigger);
    end;
    // Event: Prevent manual modification of vendors in slave company
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeModifyEvent', '', true, true)]
    local procedure VendorOnBeforeModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    begin
        HandleVendorOnBeforeModify(Rec, xRec, RunTrigger);
    end;
    // Event: Sync modified vendor from master to all slaves
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', true, true)]
    local procedure VendorOnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    begin
        HandleVendorOnAfterModify(Rec, xRec, RunTrigger);
    end;
    // Event: Prevent vendor deletion in slave company
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure VendorOnBeforeDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        HandleVendorOnBeforeDelete(Rec, RunTrigger);
    end;
    // Event: Delete vendor in slave companies when deleted in master
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterDeleteEvent', '', true, true)]
    local procedure VendorOnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        HandleVendorOnAfterDelete(Rec, RunTrigger);
    end;
    //===============================//
    // CUSTOMER HANDLER PROCEDURES
    //===============================//
    // Procedure: Handles OnBeforeInsert event for Customer
    local procedure HandleCustomerOnBeforeInsert(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error(CreateCustomerInSlaveErr);
    end;
    // Procedure: Handles OnBeforeModify event for Customer
    local procedure HandleCustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        // Only block manual modifications in slave companies
        if IsCustomerSync then
            exit;
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                if RunTrigger then
                    Error(ModifyCustomerInSlaveErr);
    end;
    // Procedure: Handles OnAfterModify event for Customer
    local procedure HandleCustomerOnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveCustomer: Record Customer;
        MasterSlaveMgt: Codeunit Zyn_SendFromMasterToSlaveMgt;
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
    // Procedure: Handles OnBeforeDelete event for Customer
    local procedure HandleOnBeforeDeleteCustomer(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        // -- Prevent deleting customer in slave
        if ZynCompany.Get(COMPANYNAME) then begin
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error(DeleteCustomerInSlaveErr);
        end
    end;
    // Procedure: Handles OnAfterDelete event for Customer
    local procedure HandleCustomerOnAfterDelete(var Rec: Record Customer; RunTrigger: Boolean)
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
    //===============================//
    // VENDOR HANDLER PROCEDURES
    //===============================//
    // Procedure: Handles OnBeforeInsert event for Vendor
    local procedure HandleVendorOnBeforeInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error(CreateVendorInSlaveErr);
    end;
    // Procedure: Handles OnBeforeModify event for Vendor
    local procedure HandleVendorOnBeforeModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if IsVendorSync then
            exit;
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                if RunTrigger then
                    Error(ModifyVendorInSlaveErr);
    end;
    // Procedure: Handles OnAfterModify event for Vendor
    local procedure HandleVendorOnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveCustomer: Record Customer;
        MasterSlaveMgt: Codeunit Zyn_SendFromMasterToSlaveMgt;
    begin
        if IsVendorSync then
            exit;
        if not MasterCompany.Get(CompanyName()) or not MasterCompany."Is Master" then
            exit;
        IsVendorSync := true;
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                    if SlaveCustomer.Get(Rec."No.") then
                        MasterSlaveMgt.MirrorVendorToSlave(Rec."No.", SlaveCompany.Name);
                end;
            until SlaveCompany.Next() = 0;
        IsVendorSync := false;
    end;
    // Procedure: Handles OnBeforeDelete event for Vendor
    local procedure HandleVendorOnBeforeDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error(DeleteVendorInSlaveErr);
    end;
    // Procedure: Handles OnAfterDelete event for Vendor
    local procedure HandleVendorOnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveVendor: Record Vendor;
        SlaveContactRel: Record "Contact Business Relation";
    begin
        if IsVendorSync then
            exit;
        if not MasterCompany.Get(CompanyName()) then
            exit;
        if (not MasterCompany."Is Master") <> (MasterCompany."Master Company Name" <> '') then
            exit;
        IsVendorSync := true;
        SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    SlaveVendor.ChangeCompany(SlaveCompany.Name);
                    SlaveContactRel.ChangeCompany(SlaveCompany.Name);
                    SlaveContactRel.Reset();
                    SlaveContactRel.SetRange("Link to Table", SlaveContactRel."Link to Table"::Vendor);
                    SlaveContactRel.SetRange("No.", Rec."No.");
                    if SlaveContactRel.FindSet() then
                        repeat
                            SlaveContactRel.Delete(true);
                        until SlaveContactRel.Next() = 0;
                    if SlaveVendor.Get(Rec."No.") then
                        SlaveVendor.Delete(true);
                end;
            until SlaveCompany.Next() = 0;
        IsVendorSync := false;
    end;
    //===============================//
    // LABELS
    //===============================//
    var
        CreateCustomerInSlaveErr: Label 'You cannot create customers directly in a Slave company. Create them only in the Master company.';
        ModifyCustomerInSlaveErr: Label 'You cannot modify customers in a Slave company. Modify them only in the Master company.';
        DeleteCustomerInSlaveErr: Label 'You cannot delete customers in a Slave company. Delete them only in the Master company.';
        CreateVendorInSlaveErr: Label 'You cannot create vendors directly in a Slave company. Create them only in the Master company.';
        ModifyVendorInSlaveErr: Label 'You cannot modify vendors in a Slave company. Modify them only in the Master company.';
        DeleteVendorInSlaveErr: Label 'You cannot delete vendor directly in a Slave company. Delete them only in the Master company.';
}
