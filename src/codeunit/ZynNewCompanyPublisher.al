codeunit 50125 "Zyn_NewCompanyPublisher"
{
    [IntegrationEvent(false, false)]
    procedure NewCompanyCreated(rec: Record Customer)
    begin
        // Event published after a new customer is created
    end;
}
