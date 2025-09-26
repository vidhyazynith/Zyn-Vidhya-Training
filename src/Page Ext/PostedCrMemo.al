pageextension 50119 "Zyn_PostedSalesCrMemoEx""" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            group("Cr.Memo Texts")
            {
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Cr.Memo Texts")
        {
            part("Posted Beginning Cr.Memo "; Zyn_PostedBeginCrMemoListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }
            part("Posted Ending Cr.Memo "; Zyn_PostedEndCrMemoListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }
        }
    }
}
