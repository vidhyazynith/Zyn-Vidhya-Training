namespace DefaultPublisher.ALProject4;

using Microsoft.Sales.Customer;

page 50105 "Customer Cue Card"
{
    PageType = CardPart;
    SourceTable = "Customer Visit Log";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup("Group Name")
            {
                field("Visit Log Count"; VisitLogCount)
                {
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        VisitLogRec: Record "Customer Visit Log";
                        CustomerRec: Record Customer;
                        TempCustomer: Record Customer temporary;
                        today: Date;
                    begin
                        today := WorkDate();

                        VisitLogRec.SetRange(Date, today);
                        if VisitLogRec.FindSet() then begin
                            repeat
                                if CustomerRec.Get(VisitLogRec."Customer Number") then begin
                                    // Avoid inserting duplicates
                                    if not TempCustomer.Get(CustomerRec."No.") then begin
                                        TempCustomer := CustomerRec;
                                        TempCustomer.Insert();
                                    end;
                                end;
                            until VisitLogRec.Next() = 0;
                        end;

                        PAGE.RunModal(PAGE::"Customer List", TempCustomer);
                    end;
                }


            }
        }
    }
    var
        Visitlogcount: Integer;
        visitlogRec: Record "Customer Visit Log";
        today: Date;

    trigger OnOpenPage()
    begin
        today := WorkDate();
        Visitlogcount := 0;
        visitlogRec.Reset();
        visitlogRec.SetRange(Date, WorkDate());
        Visitlogcount := visitlogRec.Count;
    end;


}