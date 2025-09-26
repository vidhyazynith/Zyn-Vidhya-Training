codeunit 50127 "Zyn_CompanySubscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Zyn_NewCompanyPublisher", 'NewCompanyCreated', '', false, false)]
    local procedure HandleNewcompanyCreated(rec: Record Customer)
    begin
        Message('Customer "%1" added successfully.', rec.name);
    end;
}
