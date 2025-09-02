// codeunit 50125 "Customer Publisher"
// {
//     [IntegrationEvent(false, false)]
//     procedure OnAfterNewCustomerCreated(var Customer: Record Customer)
//     begin
//         // Event published after a new customer is created
//     end;
// }

codeunit 50125 "Company Publisher"
{
    [IntegrationEvent(false, false)]
    procedure NewCompanyCreated(rec : Record Customer)
    begin
        // Event published after a new customer is created
    end;
}


codeunit 50129 customerNewPub
{
    // In a codeunit or pageextension
[IntegrationEvent(false, false)]
procedure OnAfterNewCustomerCreated(CustomerName: Text);
begin
end;
 
}