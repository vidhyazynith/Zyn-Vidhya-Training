codeunit 50120 "Zyn_SyncCustomerToNewCompany"
{
    [EventSubscriber(ObjectType::codeunit, codeunit::"Zyn_NewCompanyPublisher", 'NewCompanyCreated', '', false, false)]
    local procedure SyncCustomerToCompany(rec: Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin
        CompanyName := 'Mathana ';
        if TargetCustomer.ChangeCompany(CompanyName) then begin
            if not TargetCustomer.Get(rec."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields(rec);
                TargetCustomer.Insert();
            end;
        end else
            Error('Failed to change company to %1', CompanyName);
    end;
}


