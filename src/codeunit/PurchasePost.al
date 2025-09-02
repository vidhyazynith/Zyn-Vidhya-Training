codeunit 50100 "PurchPostBlocker"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Approval Status" <> PurchaseHeader."Approval Status"::Approved then
            Error('Purchase Order cannot be posted unless Approval Status is set to Approved.');
    end;
}
