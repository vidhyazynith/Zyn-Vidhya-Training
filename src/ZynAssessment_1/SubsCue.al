page 50211 "Subscription Cue Page"
{
    PageType = CardPart;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Subscription)
            {
                field("Active Subscriptions"; ActiveSubscriptions)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        SubRec: Record "Subscription table";
                    begin
                        SubRec.SetRange("Subcrip. Status", SubRec."Subcrip. Status"::Active);
                        PAGE.Run(PAGE::"Subscription List", SubRec);
                    end;
                }

                field("Monthly Revenue"; MonthlyRevenue)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
                        EndDate := CalcDate('<CM>', WorkDate());

                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange("Document Date", StartDate, EndDate);
                        SalesHeader.setrange("From Subscription", true);


                        PAGE.Run(PAGE::"Sales Invoice List", SalesHeader);
                    end;
                }
            }
        }
    }

    var
        ActiveSubscriptions: Integer;
        MonthlyRevenue: Decimal;

    trigger OnOpenPage()
    begin
        CalcActiveSubscriptions();
        CalcMonthlyRevenue();
    end;

    local procedure CalcActiveSubscriptions()
    var
        SubRec: Record "Subscription table";
    begin
        SubRec.SetRange("Subcrip. Status", SubRec."Subcrip. Status"::Active);
        ActiveSubscriptions := SubRec.Count;
    end;

    local procedure CalcMonthlyRevenue()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        StartDate: Date;
        EndDate: Date;
    begin
        MonthlyRevenue := 0; // reset

        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
        EndDate := CalcDate('<CM>', WorkDate());

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("From Subscription", true);
        SalesHeader.SetRange("Posting Date", StartDate, EndDate);
        SalesHeader.CalcFields(Amount);
        if SalesHeader.FindSet() then begin
            repeat
                SalesHeader.CalcFields(Amount);
                MonthlyRevenue += SalesHeader.Amount;
            until SalesHeader.Next() = 0
        end;
    end;



}
