pageextension 50109 SalesInvoiceCardExt extends "Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Invoice Texts")
            {
                Caption = 'Invoice Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";

                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec,Rec."Beginning Text",Type)
                end;

                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec,Rec."Ending Text",Type);
                    end;

                }
            }
        }

        addafter("Invoice Texts")
        {
            part("Beginning ListPart"; "Description ListPart")
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; "Ending Text ListPart")
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }

        }

    }
}