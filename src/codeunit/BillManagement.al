codeunit 50104 "ZYN_Bill File Management"
{
    Subtype = Normal;
    procedure UploadBill(var ExpenseClaim: Record "ZYN_Expense Claim Table")
    var
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
    begin
        if UploadIntoStream('Select Bill to Upload', '', '', FileName, InStream) then begin
            ExpenseClaim.Bill.CreateOutStream(OutStream);
            CopyStream(OutStream, InStream);
            // Save original filename (with extension)
            ExpenseClaim."Bill File Name" := FileName;
            ExpenseClaim.Modify(true);
            if ExpenseClaim.Bill.HasValue then
                Message('File %1 uploaded successfully.', FileName)
            else
                Error('Bill upload failed. Please try again.');
        end;
    end;

    procedure ViewBill(var ExpenseClaim: Record "ZYN_Expense Claim Table")
    var
        InStr: InStream;
        FileName: Text;
    begin
        if not ExpenseClaim.Bill.HasValue then
            Error('No bill uploaded for this claim.');
        ExpenseClaim.CalcFields(Bill);
        ExpenseClaim.Bill.CreateInStream(InStr);
        // Use stored file name, fallback if missing
        if ExpenseClaim."Bill File Name" <> '' then
            FileName := ExpenseClaim."Bill File Name"
        else
            FileName := StrSubstNo('Bill_%1.pdf', ExpenseClaim."Claim ID");
        // Browser usually previews PDF/JPG/PNG inline
        DownloadFromStream(InStr, '', '', '', FileName);
    end;
}
