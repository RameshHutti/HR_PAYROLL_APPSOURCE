table 60140 "Email Notification Entries"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(6; "Table No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "status"; Enum "Email Notification Status")
        {
            Caption = 'Status';
        }
        field(10; SenderUserID; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;
        }
        field(11; ReceiverUserID; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;
        }
        field(12; Error; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sent status"; Enum "Email Notification Sent Status")
        {
            Caption = 'Sent Status';
        }
        field(14; RecordIDs; RecordId)
        {
            DataClassification = ToBeClassified;
        }
        field(15; HeaderTxt; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; BodyTxt; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; FooterTxt; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Subject; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; HtmlFormatted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No") { Clustered = true; }
    }

    var
        myInt: Integer;

    procedure InsertRecords(TableNoInt: Integer;
                            DocumentNoCode: Code[30];
                            SenderUserID: Code[50];
                            ReceiverUserID: Code[50];
                            RecordIDs: RecordId;
                            status: Enum "Approval Status";
                            HeaderTxt: Text;
                            BodyTxt: Text;
                            FooterTxt: Text;
                            Subject: Text
                            ): Boolean
    var
        EmailNotiEntriesRecL: Record "Email Notification Entries";

    begin
        EmailNotiEntriesRecL.Init();
        EmailNotiEntriesRecL."Entry No" := 0;
        EmailNotiEntriesRecL."Document No" := DocumentNoCode;
        EmailNotiEntriesRecL."Table No" := TableNoInt;
        EmailNotiEntriesRecL.SenderUserID := SenderUserID;
        EmailNotiEntriesRecL.ReceiverUserID := ReceiverUserID;
        EmailNotiEntriesRecL.RecordIDs := RecordIDs;
        EmailNotiEntriesRecL.status := status;
        EmailNotiEntriesRecL."Email Sent" := false;
        EmailNotiEntriesRecL."Sent status" := EmailNotiEntriesRecL."Sent status"::Open;
        EmailNotiEntriesRecL.HeaderTxt := HeaderTxt;
        EmailNotiEntriesRecL.BodyTxt := BodyTxt;
        EmailNotiEntriesRecL.FooterTxt := FooterTxt;
        EmailNotiEntriesRecL.Subject := Subject;
        exit(EmailNotiEntriesRecL.Insert());
    end;
}