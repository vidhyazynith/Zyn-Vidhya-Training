codeunit 50131 Zyn_CreateCustomerSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Zyn_NewCustomerPublisher, 'OnAfterNewCustomerCreated', '', false, false)]
    procedure HandleOnAfterNewCustomerCreated(CustomerName: Text)
    begin
        Message('A new customer has been created: %1', CustomerName);
    end;
}