pageextension 50102 Zyn_SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Last Sold Price"; GetLastSoldPrice(Rec."Sell-to Customer No."))
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(General)
        {
            group("Order Text")
            {
                Caption = 'Order Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Zyn_Extended Text Handler";
                        Type: Enum "Zyn_Sales Invoice Text";
                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type)
                    end;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Zyn_Extended Text Handler";
                        Type: Enum "Zyn_Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Ending Text", Type);
                    end;
                }
                field("Begin Inv"; Rec."Begin Inv")
                {
                    ApplicationArea = All;
                }
                field("End Inv"; Rec."End Inv")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Order Text")
        {
            part("Beginning ListPart"; Zyn_BeginningTextListpart)
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; Zyn_EndingTextListPart)
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }
        }
    }
    local procedure GetLastSoldPrice(CustomerNo: Code[20]): Decimal
    var
        SalesHistory: Record Zyn_CustomerSalesHistoryTable;
        LastDate: Date;
        MaxPrice: Decimal;
    begin
        if CustomerNo = '' then
            exit(0);
        // Get last posting date
        SalesHistory.SetRange("Customer No", CustomerNo);
        SalesHistory.SetCurrentKey("Posting Date");
        if SalesHistory.FindLast() then
            LastDate := SalesHistory."Posting Date"
        else
            exit(0);
        // Get highest price for that date
        SalesHistory.SetRange("Posting Date", LastDate);
        if SalesHistory.FindSet() then
            repeat
                if SalesHistory."Item Price" > MaxPrice then
                    MaxPrice := SalesHistory."Item Price";
            until SalesHistory.Next() = 0;
        exit(MaxPrice);
    end;
}

