codeunit 50117 "Upgrade Cust Sales history"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesHistory: Record "Customer Sales History";
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
