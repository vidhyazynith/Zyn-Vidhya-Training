codeunit 50134 "Extended Text Handler"
{
    procedure LoadExtendedTextGeneric(SalesHeader: Record "Sales Header"; StandardTextCode: Code[200]; Type: Enum "Sales Invoice Text" )
    var
        ExtTextLine: Record "Extended Text Line";
        CustomExtText: Record "ExtendedTextTable";
        CustomerRec: Record Customer;
        LangCode: Code[10];
    begin
        // Delete existing lines for this document and selection
        CustomExtText.SetRange("Document No.", SalesHeader."No.");
        CustomExtText.SetRange(type, Type);
        CustomExtText.DeleteAll();
 
        // Get customer language
        if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then
            LangCode := CustomerRec."Language Code";
 
        // Filter the Extended Text Lines based on the standard text code and language
        ExtTextLine.SetRange("No.", StandardTextCode);
        ExtTextLine.SetRange("Language Code", LangCode);
 
        if ExtTextLine.FindSet() then begin
            repeat
                CustomExtText.Init();
                CustomExtText."Document No." := SalesHeader."No.";
                CustomExtText."Sales Document Type" := SalesHeader."Document Type";
                CustomExtText."Line No." := ExtTextLine."Line No.";
                CustomExtText."Text" := ExtTextLine.Text;
                CustomExtText.Type := Type;
                CustomExtText.Insert(true);
            until ExtTextLine.Next() = 0;
        end;
    end;
 
    // procedure LoadExtendedTextLines(SalesHeader: Record "Sales Header")
    // var
    //     ExtTextHeader: Record "Extended Text Header";
    //     CustomExtText: Record "ExtendedTextTable";
    //     CustomerRec: Record Customer;
    //     ExtTextLine : Record "Extended Text Line";
    //     LangCode: Code[10];

    // begin 
    //     CustomExtText.SetRange("Document No.", SalesHeader."No.");
    //     CustomExtText.SetRange(Type, CustomExtText.Type::Beginning);
    //     CustomExtText.DeleteAll();

    //     // Get Language Code from Customer or default to 'ENU'
    //     if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then
    //         LangCode := CustomerRec."Language Code";
    //     // Filter lines from Extended Text Line table
    //     //ExtTextLine.SetRange("Table Name", ExtTextLine."Table Name"::"Standard Text");
    
    //     ExtTextLine.SetRange("No.", SalesHeader."Beginning Text");
    //     ExtTextLine.SetRange("Language Code", LangCode);

    //     if ExtTextLine.FindSet() then begin
    //         repeat
    //             CustomExtText.Init();
    //             CustomExtText."Document No." := SalesHeader."No.";
    //             CustomExtText."Type" := CustomExtText.Type::Beginning;
    //             CustomExtText."Line No." := ExtTextLine."Line No.";
    //             CustomExtText."Text" := ExtTextLine.Text;
    //             CustomExtText."Document Type" := SalesHeader."Document Type";
    //             CustomExtText.Insert();
    //         until ExtTextLine.Next() = 0;
    //     end;
    // end;

}
