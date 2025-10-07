codeunit 50108 "Zyn_SendFromMasterToSlaveMgt"
{
    var
        IsSync: Boolean;
    //Mirrors a Customer record from the Master company to the specified Slave company.
    procedure MirrorCustomerToSlave(CustomerNo: Code[20]; SlaveCompany: Text[30])
    var
        MasterCustomer: Record Customer;
        SlaveCustomer: Record Customer;
        DummyRecord: Record Customer;
        MasterCompany: Text[30];
        MasterContactRelation: Record "Contact Business Relation";
        SlaveContactRelation: Record "Contact Business Relation";
        SlaveContact: Record Contact;
        GlobalMgt: Codeunit Zyn_SingleInstanceMgt;
    begin
        if IsSync or (SlaveCompany = CompanyName()) then
            exit;
        MasterCompany := CompanyName();
        IsSync := true;
        if not MasterCustomer.Get(CustomerNo) then begin
            IsSync := false;
            Error(CustomerNotFoundErr, CustomerNo);
        end;
        SlaveCustomer.ChangeCompany(SlaveCompany);
        if not SlaveCustomer.Get(CustomerNo) then begin
            SlaveCustomer.Init();
            SlaveCustomer.TransferFields(MasterCustomer, false);
            SlaveCustomer."No." := MasterCustomer."No.";
            SlaveCustomer.Insert(false);
        end else begin
            if not AreRecordsEqual(MasterCustomer, SlaveCustomer) then begin
                SlaveCustomer.TransferFields(MasterCustomer, false);
                SlaveCustomer.Modify(false);
            end;
        end;
        // replicate Contact Business Relation rows
        MasterContactRelation.SetRange("No.", MasterCustomer."No.");
        if MasterContactRelation.FindSet() then begin
            repeat
                SlaveContact.ChangeCompany(SlaveCompany);
                if SlaveContact.Get(MasterContactRelation."Contact No.") then begin
                    SlaveContactRelation.ChangeCompany(SlaveCompany);
                    // check with Contact No. + Link to Table + No.
                    SlaveContactRelation.Reset();
                    SlaveContactRelation.SetRange("Contact No.", SlaveContact."No.");
                    SlaveContactRelation.SetRange("Link to Table", MasterContactRelation."Link to Table"::Customer);
                    SlaveContactRelation.SetRange("No.", MasterCustomer."No.");
                    if not SlaveContactRelation.FindFirst() then begin
                        SlaveContactRelation.Init();
                        SlaveContactRelation."Contact No." := SlaveContact."No.";
                        SlaveContactRelation."Link to Table" := MasterContactRelation."Link to Table"::Customer;
                        SlaveContactRelation."No." := MasterCustomer."No.";
                        SlaveContactRelation."Business Relation Code" := MasterContactRelation."Business Relation Code";
                        SlaveContactRelation."Business Relation Description" := MasterContactRelation."Business Relation Description";
                        SlaveContactRelation.Insert(false);
                        // After inserting the relation, update the Contact's Business Relation field in slave
                        SlaveContact.ChangeCompany(SlaveCompany);
                        if SlaveContact.Get(MasterContactRelation."Contact No.") then begin
                            SlaveContact.UpdateBusinessRelation();
                            SlaveContact.Modify(true);
                        end;
                    end;
                end else
                    Message(ContactNotFoundMsg, MasterContactRelation."Contact No.", SlaveCompany);
            until MasterContactRelation.Next() = 0;
        end;
        if CompanyName() <> MasterCompany then
            DummyRecord.ChangeCompany(MasterCompany);
        IsSync := false;
    end;
    //Mirrors a Vendor record from the Master company to the specified Slave company.
    procedure MirrorVendorToSlave(VendorNo: Code[20]; SlaveCompany: Text[30])
    var
        MasterVendor: Record Vendor;
        SlaveVendor: Record Vendor;
        DummyRecord: Record Vendor;
        MasterCompany: Text[30];
        MasterContactRelation: Record "Contact Business Relation";
        SlaveContactRelation: Record "Contact Business Relation";
        SlaveContact: Record Contact;
    begin
        if IsSync or (SlaveCompany = CompanyName()) then
            exit;
        MasterCompany := CompanyName();
        IsSync := true;
        if not MasterVendor.Get(VendorNo) then begin
            IsSync := false;
            Error(VendorNotFoundErr, VendorNo);
        end;
        SlaveVendor.ChangeCompany(SlaveCompany);
        if not SlaveVendor.Get(VendorNo) then begin
            SlaveVendor.Init();
            SlaveVendor.TransferFields(MasterVendor, false);
            SlaveVendor."No." := MasterVendor."No.";
            SlaveVendor.Insert(false);
        end else begin
            if not AreRecordsEqual(MasterVendor, SlaveVendor) then begin
                SlaveVendor.TransferFields(MasterVendor, false);
                SlaveVendor.Modify(false);
            end;
        end;
        // replicate Contact Business Relation rows
        MasterContactRelation.SetRange("No.", MasterVendor."No.");
        if MasterContactRelation.FindSet() then begin
            repeat
                SlaveContact.ChangeCompany(SlaveCompany);
                if SlaveContact.Get(MasterContactRelation."Contact No.") then begin
                    SlaveContactRelation.ChangeCompany(SlaveCompany);
                    // check with Contact No. + Link to Table + No.
                    SlaveContactRelation.Reset();
                    SlaveContactRelation.SetRange("Contact No.", SlaveContact."No.");
                    SlaveContactRelation.SetRange("Link to Table", MasterContactRelation."Link to Table"::Vendor);
                    SlaveContactRelation.SetRange("No.", MasterVendor."No.");
                    if not SlaveContactRelation.FindFirst() then begin
                        SlaveContactRelation.Init();
                        SlaveContactRelation."Contact No." := SlaveContact."No.";
                        SlaveContactRelation."Link to Table" := MasterContactRelation."Link to Table"::Vendor;
                        SlaveContactRelation."No." := MasterVendor."No.";
                        SlaveContactRelation."Business Relation Code" := MasterContactRelation."Business Relation Code";
                        SlaveContactRelation."Business Relation Description" := MasterContactRelation."Business Relation Description";
                        SlaveContactRelation.Insert(false);
                        // After inserting the relation, update the Contact's Business Relation field in slave
                        SlaveContact.ChangeCompany(SlaveCompany);
                        if SlaveContact.Get(MasterContactRelation."Contact No.") then begin
                            SlaveContact.UpdateBusinessRelation();
                            SlaveContact.Modify(true);
                        end;
                    end;
                end else
                    Message(ContactNotFoundMsg, MasterContactRelation."Contact No.", SlaveCompany);
            until MasterContactRelation.Next() = 0;
        end;
        if CompanyName() <> MasterCompany then
            DummyRecord.ChangeCompany(MasterCompany);
        IsSync := false;
    end;
    //Compares two records (Customer or Vendor) to check if all normal fields are equal.
    local procedure AreRecordsEqual(MasterRecVariant: Variant; SlaveRecVariant: Variant): Boolean
    var
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        MasterField: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
    begin
        MasterRef.GetTable(MasterRecVariant);
        SlaveRef.GetTable(SlaveRecVariant);
        for i := 1 to MasterRef.FieldCount do begin
            MasterField := MasterRef.FieldIndex(i);
            // Skip primary keys
            if MasterField.Class <> FieldClass::Normal then
                continue;
            if MasterField.Number in [1] then  // Ignores primary key field
                continue;
            SlaveField := SlaveRef.Field(MasterField.Number);
            //Returns TRUE if all comparable fields are equal; FALSE otherwise.
            if MasterField.Value <> SlaveField.Value then
                exit(false);
        end;
        exit(true);
    end;
    // ---------------- LABELS ----------------
    var
        ContactNotFoundMsg: Label 'Contact %1 not found in slave company %2.';
        CustomerNotFoundErr: Label 'Customer %1 not found in Master.';
        VendorNotFoundErr: Label 'Vendor %1 not found in Master.';
}
