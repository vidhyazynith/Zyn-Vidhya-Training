codeunit 50107 "Zyn_ContactMaster-SlaveSync"
{
    var
        IsSyncing: Boolean;
    // Prevent Contact creation in slave company
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure ContactOnBeforeInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
    begin
        // Get the current company record from Zyn_Company Table
        if ZynCompany.Get(COMPANYNAME) then begin
            // Block creation if the current company is a slave
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company Name" <> '') then
                Error(CreateContactInSlaveErr);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure ContactOnAfterInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        NewContact: Record Contact;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        // Get the current company as master company
        if MasterCompany.Get(COMPANYNAME) then begin
            // Only replicate if this is a master company
            if MasterCompany."Is Master" then begin
                // Find all slave companies linked to this master
                SlaveCompany.Reset();
                SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        NewContact.ChangeCompany(SlaveCompany.Name);
                        if not NewContact.Get(Rec."No.") then begin
                            NewContact.Init();
                            NewContact.TransferFields(Rec, true);    // copy all fields from master contact
                            NewContact.Insert(true);
                        end;
                    until SlaveCompany.Next() = 0;
                exit;
            end;
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveContact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if IsSyncing then
            exit;
        if MasterCompany.Get(COMPANYNAME) then begin
            if MasterCompany."Is Master" then begin
                // Replicate modifications to all slaves
                SlaveCompany.Reset();
                SlaveCompany.SetRange("Master Company Name", MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveContact.ChangeCompany(SlaveCompany.Name);
                        if SlaveContact.Get(Rec."No.") then begin
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveContact);
                            IsDifferent := false;
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                if Field.Number in [1] then
                                    continue;
                                SlaveField := SlaveRef.Field(Field.Number);
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break;
                                end;
                            end;
                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveContact.TransferFields(Rec, false);
                                SlaveContact."No." := Rec."No.";
                                SlaveContact.Modify(true);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0;
            end else begin
                if (not MasterCompany."Is Master") and (MasterCompany."Master Company Name" <> '') then begin
                    // Validation in slave company
                    // Allow system modifications, block manual user modifications
                    if (UserId = '') or (UpperCase(UserId) = 'NT AUTHORITY\SYSTEM') then
                        exit; //system update allowed
                    if not RunTrigger then
                        exit; //background modify without triggers
                              //otherwise block user edit
                    Error(ModifyContactInSlaveErr);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ContactOnBeforeDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        HasSalesInvoice: Boolean;
        HasPurchaseInvoice: Boolean;
        ContactNo: Code[20];
        ErrText: Text[250];
    begin
        if IsSyncing then
            exit;
        ContactNo := Rec."No.";
        // Only master company should be validated here
        if not ZynCompany.Get(CompanyName()) then
            exit;
        if not ZynCompany."Is Master" then
            exit; // slaves already blocked elsewhere
        // Check all slave companies for open invoices
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company Name", ZynCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                // Check Open or released Sales Invoices linked to Contact
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                SalesHeader.SetRange("Sell-to Contact No.", ContactNo);
                if SalesHeader.FindFirst() then
                    HasSalesInvoice := true;
                //Check Open or released Purchase Invoices linked to Contact
                PurchaseHeader.ChangeCompany(SlaveCompany.Name);
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
                PurchaseHeader.SetFilter(Status, '%1|%2', PurchaseHeader.Status::Open, PurchaseHeader.Status::Released);
                PurchaseHeader.SetRange("Buy-from Contact No.", ContactNo);
                if PurchaseHeader.FindFirst() then
                    HasPurchaseInvoice := true;
            until SlaveCompany.Next() = 0;
        //Throw single error if any open invoice exists
        if HasSalesInvoice or HasPurchaseInvoice then begin
            ErrText := 'Cannot delete Contact ' + ContactNo + ': ';
            if HasSalesInvoice then
                ErrText += UnpostedSalesInvoiceErr;
            if HasPurchaseInvoice then
                ErrText += UnpostedPurchaseInvoiceErr;
            Error(ErrText, SlaveCompany.Name);
        end;
    end;

    // After delete → replicate deletion in slaves and related customer/vendor records
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure ContactOnAfterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company Table";
        SlaveCompany: Record "Zyn_Company Table";
        SlaveContact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        if IsSyncing then
            exit;
        if not ZynCompany.Get(CompanyName()) then
            exit;
        if not ZynCompany."Is Master" then
            exit; // Only Master triggers replication
        IsSyncing := true;
        // Loop through slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company Name", ZynCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                // Delete related customer/vendor records
                // Work in Slave Company
                ContactBusinessRelation.ChangeCompany(SlaveCompany.Name);
                Customer.ChangeCompany(SlaveCompany.Name);
                Vendor.ChangeCompany(SlaveCompany.Name);
                SlaveContact.ChangeCompany(SlaveCompany.Name);
                ContactBusinessRelation.SetRange("Contact No.", Rec."No.");
                if ContactBusinessRelation.FindSet() then
                    repeat
                        if Customer.Get(ContactBusinessRelation."No.") then
                            Customer.Delete(true);
                        if Vendor.Get(ContactBusinessRelation."No.") then
                            Vendor.Delete(true);
                        ContactBusinessRelation.Delete(true);
                    until ContactBusinessRelation.Next() = 0;
                // Delete the contact itself
                SlaveContact.ChangeCompany(SlaveCompany.Name);
                if SlaveContact.Get(Rec."No.") then
                    SlaveContact.Delete(true);
            until SlaveCompany.Next() = 0;
        IsSyncing := false;
        Message(DeleteMsg, Rec."No.");
    end;

    var
        CreateContactInSlaveErr: Label 'You cannot create contacts in a slave company. Create the contact in the master company only.';
        ModifyContactInSlaveErr: Label 'You cannot modify contacts in a slave company. Modify contacts only in the master company.';
        DeleteContactInSlaveErr: Label 'You cannot delete contacts in a slave company. Delete contacts only in the master company.';
        UnpostedSalesInvoiceErr: Label 'Unposted Sales Invoice in Slave company %1.';
        UnpostedPurchaseInvoiceErr: Label 'Unposted Purchase Invoice in Slave company %1.';
        DeleteMsg: Label 'Contact %1 deleted successfully from Master and all Slaves.';
}
