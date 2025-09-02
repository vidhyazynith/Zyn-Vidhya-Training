// codeunit 50127 "Customer Subscriber"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Publisher", 'OnAfterNewCustomerCreated', '', false, false)]
//     local procedure HandleOnAfterNewCustomerCreated(var Customer: Record Customer)
//     begin
//         Message('A new customer has been created: %1 :)', Customer.Name);
//     end;
// }

// codeunit 50126 "Customer Event Trigger"
// {
//     [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
//     local procedure OnAfterCustomerInsert(var Rec: Record Customer)
//     var
//         Publisher: Codeunit "Customer Publisher";
//     begin
//         Publisher.OnAfterNewCustomerCreated(Rec); // Call your custom event
//     end;
// }

codeunit 50127 "Company Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Publisher", 'NewCompanyCreated', '', false, false)]
    local procedure HandleNewcompanyCreated(rec: Record Customer)
    begin
        Message('Customer "%1" added successfully.', rec.name);
    end;
}

codeunit 50131 customerCreationSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::customerNewPub, 'OnAfterNewCustomerCreated', '', false, false)]
    procedure HandleOnAfterNewCustomerCreated(CustomerName: Text)
    begin
        Message('A new customer has been created: %1', CustomerName);
    end;
}