codeunit 50120 "Sync Customer To New Company"
{
    [EventSubscriber(ObjectType::codeunit, codeunit::"Company Publisher", 'NewCompanyCreated', '', false, false)]
 
    local procedure SyncCustomerToCompany(rec: Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin

        CompanyName := 'vidhya & co.';
       
        if TargetCustomer.ChangeCompany(CompanyName) then
        begin
            if not TargetCustomer.Get(rec."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields(rec);
                TargetCustomer.Insert();
        end;
        end else
                Error('Failed to change company to %1', CompanyName);
    end;
}


