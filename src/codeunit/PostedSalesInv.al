codeunit 50128 "Zyn_Beginning Text Transfer"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(
    var SalesInvHeader: Record "Sales Invoice Header";
    SalesHeader: Record "Sales Header";
    CommitIsSuppressed: Boolean;
    WhseShip: Boolean;
    WhseReceive: Boolean;
    var TempWhseShptHeader: Record "Warehouse Shipment Header";
    var TempWhseRcptHeader: Record "Warehouse Receipt Header";
    PreviewMode: Boolean)
    var
        CustomExtText: Record Zyn_ExtendedTextTable;
        PostedExtText: Record Zyn_ExtendedTextTable;
        TypeEnum: Enum "Zyn_Sales Invoice Text";
        CustomerRec: Record Customer;
        LangCode: Code[100];
        i: Integer;
        StandardTextCode: Code[20];
        ExtTextLine: Record "Extended Text Line";
    begin
        SalesInvHeader."Beginning Text" := SalesHeader."Beginning Text";
        SalesInvHeader."Ending Text" := SalesHeader."Ending Text";
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            for i := 1 to 2 do begin
                case i of
                    1:
                        TypeEnum := TypeEnum::Beginning;
                    2:
                        TypeEnum := TypeEnum::ending;
                end;
                CustomExtText.Reset();
                CustomExtText.SetRange("Document No.", SalesHeader."No.");
                CustomExtText.SetRange(Type, TypeEnum);
                if CustomExtText.FindSet() then begin
                    repeat
                        PostedExtText.Init();
                        PostedExtText.TransferFields(CustomExtText);
                        PostedExtText."Document No." := SalesInvHeader."No.";
                        PostedExtText."Sales Document Type" := PostedExtText."Sales Document Type"::"Posted Invoice";
                        PostedExtText."Line No." := CustomExtText."Line No.";
                        PostedExtText."Text" := CustomExtText."Text";
                        PostedExtText.Insert();
                    until CustomExtText.Next() = 0;
                end;
                CustomExtText.Reset();
                CustomExtText.SetRange("Document No.", SalesHeader."No.");
                CustomExtText.SetRange(Type, TypeEnum);
                CustomExtText.DeleteAll();
            end;
        end else begin
            if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then
                LangCode := CustomerRec."Language Code";
            for i := 1 to 2 do begin
                case i of
                    1:
                        begin
                            TypeEnum := TypeEnum::Beginning;
                            StandardTextCode := SalesHeader."Begin Inv";
                        end;
                    2:
                        begin
                            TypeEnum := TypeEnum::ending;
                            StandardTextCode := SalesHeader."End Inv";
                        end;
                end;
                PostedExtText.Reset();
                PostedExtText.SetRange("Document No.", SalesInvHeader."No.");
                PostedExtText.SetRange(Type, TypeEnum);
                PostedExtText.DeleteAll();
                //Filter the Extended Text Line
                ExtTextLine.Reset();
                ExtTextLine.SetRange("No.", StandardTextCode);
                ExtTextLine.SetRange("Language Code", LangCode);
                if ExtTextLine.FindSet() then begin
                    repeat
                        PostedExtText.Init();
                        PostedExtText."Document No." := SalesInvHeader."No.";
                        PostedExtText."Sales Document Type" := PostedExtText."Sales Document Type"::"Posted Invoice";
                        PostedExtText."Line No." := ExtTextLine."Line No.";
                        PostedExtText."Language Code" := LangCode;
                        PostedExtText."Text" := ExtTextLine.Text;
                        PostedExtText.Type := TypeEnum;
                        PostedExtText.Insert(true);
                    until ExtTextLine.Next() = 0;
                end;
            end;
        end;
    end;
}