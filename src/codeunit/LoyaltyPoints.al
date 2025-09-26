codeunit 50123 "Zyn_LoyaltyPointsHandler"
{
    //Before Posting sales invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDocvar(
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        PreviewMode: Boolean;
        var HideProgressWindow: Boolean;
        var IsHandled: Boolean;
        var CalledBy: Integer)
    var
        CustomerRec: Record Customer;
    begin
        if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::order]) then begin
            if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
                if CustomerRec."Loyalty Points Used" >= CustomerRec."Loyalty Points Allowed" then
                    Error('Customer "%1" has exceeded the allowed loyalty points. Invoice cannot be posted.', CustomerRec.Name);
            end;
        end;
    end;
    //After posting sales incoice
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesHistory: Record Zyn_CustomerSalesHistoryTable;
    begin
        // Process all posted sales invoices
        if SalesInvHeader.FindSet() then
            repeat
                // Get all lines for this invoice
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");

                if SalesInvLine.FindSet() then
                    repeat
                        // Check if already exists for same Customer, Item, Posting Date
                        SalesHistory.Reset();
                        SalesHistory.SetRange("Customer No", SalesInvHeader."Sell-to Customer No.");
                        SalesHistory.SetRange("Item No", SalesInvLine."No.");
                        //SalesHistory.SetRange("Posting Date", SalesInvHeader."Posting Date");
                        if SalesHistory.FindFirst() then begin
                            // Update existing
                            SalesHistory."Item Price" := SalesInvLine."Unit Price";
                            SalesHistory."Posting Date" := SalesInvLine."Posting Date";
                            SalesHistory.Modify(true);
                        end else begin
                            // Insert new
                            SalesHistory.Init();
                            SalesHistory."Customer No" := SalesInvHeader."Sell-to Customer No.";
                            SalesHistory."Item No" := SalesInvLine."No.";
                            SalesHistory."Item Price" := SalesInvLine."Unit Price";
                            SalesHistory."Posting Date" := SalesInvHeader."Posting Date";
                            SalesHistory.Insert(true);
                        end;
                    until SalesInvLine.Next() = 0;
            until SalesInvHeader.Next() = 0;
    end;

}
