codeunit 50130 "Subscription Billing Processor"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        ProcessSubscriptions();
    end;

    local procedure ProcessSubscriptions()
    var
        SubRec: Record "Subscription table";
    begin
        SubRec.Reset();
        SubRec.SetRange("Subcrip. Status", SubRec."Subcrip. Status"::Active);
        if SubRec.FindSet() then
            repeat
                // Only process if subscription is active and valid
                if (SubRec."Next Billing Date" = WorkDate()) and
                   (SubRec."End date" >= WorkDate()) then begin

                    // Generate invoice
                    CreateSalesInvoice(SubRec);

                    // Advance billing date by 1 month
                    SubRec."Next Billing Date" := CalcDate('<1M>', SubRec."Next Billing Date");

                    // If the new billing date exceeds End Date -> expire subscription
                    if SubRec."Next Billing Date" > SubRec."End date" then begin
                        SubRec."Subcrip. Status" := SubRec."Subcrip. Status"::Expired;
                        SubRec."Next Billing Date" := 0D;
                    end;

                    SubRec.Modify(true);
                end
                else if (SubRec."End date" < WorkDate()) then begin
                    // Expire subscriptions that passed end date
                    SubRec."Subcrip. Status" := SubRec."Subcrip. Status"::Expired;
                    SubRec."Next Billing Date" := 0D;
                    SubRec.Modify(true);
                end;
            until SubRec.Next() = 0;
    end;

    local procedure CreateSalesInvoice(SubRec: Record "Subscription table")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PlanRec: Record "Plan Table";
        Setup: Record "Subscription Setup";
        NewNo: Code[20];
    begin
        // Ensure subscription is still active and valid
        if (SubRec."Subcrip. Status" <> SubRec."Subcrip. Status"::Active) or
           (SubRec."End date" < WorkDate()) then
            exit;

        // Get Plan Fee
        if not PlanRec.Get(SubRec."Plan Id") then
            exit;

        // Ensure setup exists
        if not Setup.Get('SETUP') then begin
            Setup.Init();
            Setup."Primary Key" := 'SETUP';
            Setup."Last Invoice No." := 0;
            Setup.Insert();
        end;

        // Increment last invoice number
        Setup."Last Invoice No." += 1;
        Setup.Modify();

        // Build manual invoice no. like INV0001
        NewNo :='INV' + COPYSTR('0000', 1, 4 - STRLEN(FORMAT(Setup."Last Invoice No."))) + FORMAT(Setup."Last Invoice No.");

        // Create new Sales Invoice Header
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Validate("Sell-to Customer No.", SubRec."CustomerId");
        SalesHeader."No." := NewNo;
        SalesHeader."From Subscription" := true;
        SalesHeader.Insert(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Type := SalesLine.Type::" ";
        SalesLine.Description := 'Subscription Fee - ' + PlanRec."PlanName";
        SalesLine.Validate(Amount,PlanRec.Fee);
        SalesLine.Insert(true);
    end;
}
