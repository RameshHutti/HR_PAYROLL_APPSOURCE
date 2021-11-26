table 60117 "Employee Dependents New"
{
    Caption = 'Employee Dependents New';
    LookupPageID = "Employee Dependent List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HrSetup.GET;
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmployeeRec.GET("Employee ID") then
                    "Employee Name" := EmployeeRec.FullName;

                UserSetup.RESET;
                UserSetup.SETRANGE("Employee Id", Rec."Employee ID");
                if UserSetup.FINDFIRST then
                    User_ID := UserSetup."User ID";
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(4; "Dependent First Name"; Text[50])
        {
            Caption = 'Dependent First Name';

            trigger OnValidate()
            begin
                ValidateFullName;
            end;
        }
        field(5; "Dependent Middle Name"; Text[50])
        {
            Caption = 'Dependent Middle Name';

            trigger OnValidate()
            begin
                ValidateFullName;
            end;
        }
        field(6; "Dependent Last Name"; Text[50])
        {
            Caption = 'Dependent Last Name';

            trigger OnValidate()
            begin
                ValidateFullName;
            end;
        }
        field(7; "Dependent Name in Arabic"; Text[50])
        {
            Caption = 'Dependent Name in Arabic';
        }
        field(8; "Name in Passport in English"; Text[250])
        {
            Caption = 'Name in Passport in English';
        }
        field(9; Relationship; Option)
        {
            Caption = 'Relationship';
            OptionCaption = ' ,Child,Domestic Partner,Spouse,Ex-Spouse,Family Contact,Other Contact,Parent,Sibling';
            OptionMembers = " ",Child,"Domestic Partner",Spouse,"Ex-Spouse","Family Contact","Other Contact",Parent,Sibling;
        }
        field(10; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(11; Nationality; Code[100])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                if CountryRec.GET(Nationality) then
                    Nationality := CountryRec.Name;
            end;
        }
        field(12; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                if "Date of Birth" > TODAY then
                    ERROR('Date of Birth should be before Today ');
            end;
        }
        field(13; "Marital Status"; Text[30])
        {
            Caption = 'Marital Status';
        }
        field(14; "Child with Special needs"; Boolean)
        {
            Caption = 'Child with Special needs';
        }
        field(15; "Child Educational Level"; Option)
        {
            Caption = 'Child Educational Level';
            OptionCaption = ' ,Elementary,Secondary,University';
            OptionMembers = " ",Elementary,Secondary,University;
        }
        field(16; "Is Emergency Contact"; Boolean)
        {
            Caption = 'Is Emergency Contact';
        }
        field(17; "Full Time Student"; Boolean)
        {
            Caption = 'Full Time Student';
        }
        field(19; "Dependent Contact No."; Integer)
        {
            Caption = 'Dependent Contact No.';
        }
        field(20; "Dependent Contact Type"; Option)
        {
            Caption = 'Dependent Contact Type';
            OptionCaption = ' ,Mobile,Mobile & E-Mail';
            OptionMembers = " ",Mobile,"Mobile & E-Mail";
        }
        field(21; "Primary Contact"; Boolean)
        {
            Caption = 'Primary Contact';
        }
        field(22; Address; Text[250])
        {
            Caption = 'Address';
        }
        field(23; "Address 2"; Text[250])
        {
            Caption = 'Address 2';
        }
        field(24; PostCode; Code[20])
        {
            Caption = 'PostCode';
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCodeRec.SETRANGE(Code, PostCode);
                if PostCodeRec.FINDFIRST then begin
                    City := PostCodeRec.City;
                    if CountryRec.GET(PostCodeRec."Country/Region Code") then
                        "Country Region code" := CountryRec.Name;
                end;

                if PostCode = '' then begin
                    CLEAR(City);
                    CLEAR("Country Region code");
                end;
            end;
        }
        field(25; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                if City = '' then
                    CLEAR(PostCode);
            end;
        }
        field(26; "Country Region code"; Code[20])
        {
            Caption = 'Country Region code';
        }
        field(27; "Private Phone Number"; Integer)
        {
            Caption = 'Private Phone Number';
        }
        field(28; "Direct Phone Number"; Integer)
        {
            Caption = 'Direct Phone Number';
        }
        field(29; "Private Email"; Text[30])
        {
            Caption = 'Private Email';
        }
        field(30; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(31; "Personal Title"; Option)
        {
            Caption = 'Personal Title';
            OptionCaption = 'Mr.,Ms.,Mrs.,Miss.';
            OptionMembers = Mr,Ms,Mrs,Miss;
        }
        field(32; Status; Option)
        {
            OptionCaption = 'Inactive,Active';
            OptionMembers = Inactive,Active;
        }
        field(33; "Full Name"; Text[250])
        {
        }
        field(50; "Request Type"; Option)
        {
            OptionCaption = ' ,New,Edit,Delete';
            OptionMembers = " ",New,Edit,Delete;
        }
        field(51; "Select Dependent No"; Code[20])
        {
        }
        field(52; "Workflow Status"; Option)
        {
            Caption = 'Workflow Status';
            OptionCaption = 'Open,Send for Approval,Approved';
            OptionMembers = Open,"Pending Approval",Released;

            trigger OnValidate()
            begin
                WF_Action;
            end;
        }
        field(53; Created; Boolean)
        {
        }
        field(54; User_ID; Code[20])
        {
        }
        field(55; No2; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No2, "Employee ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Dependent First Name", "Dependent Last Name")
        {
        }
    }

    trigger OnDelete()
    begin


        EduClimbeRec.RESET;
        EduClimbeRec.SETRANGE("Dependent ID", Rec."No.");
        if EduClimbeRec.FINDFIRST then
            ERROR(Error001);
    end;

    trigger OnInsert()
    begin
        INITINSERT();
        ValidateFullName;

        UserSetup.GET(USERID);
        if not UserSetup."HR Manager" then
            VALIDATE("Employee ID", UserSetup."Employee Id");
    end;

    var
        HrSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeRec: Record Employee;
        PostCodeRec: Record "Post Code";
        gField: Record "Field";
        CountryRec: Record "Country/Region";
        EduClimbeRec: Record "Educational Claim Lines LT";
        Error001: Label 'Record cannot be Deleted.';
        UserSetup: Record "User Setup";
        NewDepNo: Code[20];

    local procedure INITINSERT()
    begin
        HrSetup.RESET();
        HrSetup.GET();
        HrSetup.TESTFIELD("Dependent Request");
        if "No." = '' then begin
            NoSeriesMgt.InitSeries(HrSetup."Dependent Request", xRec."No. Series", TODAY, No2, "No. Series");
        end;
    end;

    local procedure ValidateFullName()
    begin
        "Full Name" := "Dependent First Name" + ' ' + "Dependent Middle Name" + ' ' + "Dependent Last Name"
    end;

    local procedure WF_Action()
    var
        DepMasterRec: Record "Employee Dependents Master";
        RecAddLIne: Record "Dependent New Address Line";
        RecContLine: Record "Dependent New Contacts Line";
        DepAddLineRec: Record "Employee Address Line";
        DeptConLineRec: Record "Employee Contacts Line";
    begin
        if "Workflow Status" = "Workflow Status"::Released then begin
            if ("Request Type" = "Request Type"::Edit) and (Created = false) then begin
                DepMasterRec.RESET;
                DepMasterRec.SETRANGE("No.", "Select Dependent No");
                DepMasterRec.SETRANGE("Employee ID", "Employee ID");
                if DepMasterRec.FINDFIRST then begin
                    DepMasterRec.TRANSFERFIELDS(Rec);
                    DepMasterRec.MODIFY;
                end;

                DepAddLineRec.RESET;
                DepAddLineRec.SETRANGE("Dependent ID", "Select Dependent No");
                if DepAddLineRec.FINDSET then begin
                    repeat
                        DepAddLineRec.DELETE;
                    until DepAddLineRec.NEXT = 0;
                end;

                RecAddLIne.RESET;
                RecAddLIne.SETRANGE(No2, No2);
                if RecAddLIne.FINDSET then begin
                    repeat
                        DepAddLineRec.INIT;
                        DepAddLineRec.TRANSFERFIELDS(RecAddLIne);
                        DepAddLineRec."Dependent ID" := "Select Dependent No";
                        DepAddLineRec.INSERT;
                    until RecAddLIne.NEXT = 0;
                end;

                DeptConLineRec.RESET;
                DeptConLineRec.SETRANGE("Dependent ID", "Select Dependent No");
                if DeptConLineRec.FINDFIRST then begin
                    repeat
                        DeptConLineRec.DELETE;
                    until DeptConLineRec.NEXT = 0;
                end;

                RecContLine.RESET;
                RecContLine.SETRANGE(No2, No2);
                if RecContLine.FINDSET then begin
                    repeat
                        DeptConLineRec.INIT;
                        DeptConLineRec.TRANSFERFIELDS(RecContLine);
                        DeptConLineRec."Dependent ID" := "Select Dependent No";
                        DeptConLineRec.INSERT;
                    until RecContLine.NEXT = 0;
                end;
                Created := true;
            end;

            if ("Request Type" = "Request Type"::New) and (Created = false) then begin
                HrSetup.GET();
                HrSetup.TESTFIELD("Dependent Nos.");
                NewDepNo := NoSeriesMgt.GetNextNo(HrSetup."Dependent Nos.", TODAY, true);
                DepMasterRec.INIT;
                DepMasterRec.TRANSFERFIELDS(Rec);
                DepMasterRec."No." := NewDepNo;
                DepMasterRec.INSERT;

                RecAddLIne.RESET;
                RecAddLIne.SETRANGE(No2, No2);
                if RecAddLIne.FINDSET then begin
                    repeat
                        DepAddLineRec.INIT;
                        DepAddLineRec.TRANSFERFIELDS(RecAddLIne);
                        DepAddLineRec."Dependent ID" := NewDepNo;
                        DepAddLineRec.INSERT;
                    until RecAddLIne.NEXT = 0;
                end;

                RecContLine.RESET;
                RecContLine.SETRANGE(No2, No2);
                if RecContLine.FINDSET then begin
                    repeat
                        DeptConLineRec.INIT;
                        DeptConLineRec.TRANSFERFIELDS(RecContLine);
                        DeptConLineRec."Dependent ID" := NewDepNo;
                        DeptConLineRec.INSERT;
                    until RecContLine.NEXT = 0;
                end;
                Created := true;
            end;

            if ("Request Type" = "Request Type"::Delete) and (Created = false) then begin
                DepMasterRec.RESET;
                DepMasterRec.SETRANGE("No.", "Select Dependent No");
                DepMasterRec.SETRANGE("Employee ID", "Employee ID");
                if DepMasterRec.FINDFIRST then
                    DepMasterRec.DELETE;

                DepAddLineRec.RESET;
                DepAddLineRec.SETRANGE("Dependent ID", "Select Dependent No");
                if DepAddLineRec.FINDSET then begin
                    repeat
                        DepAddLineRec.DELETE;
                    until DepAddLineRec.NEXT = 0;
                end;

                DeptConLineRec.RESET;
                DeptConLineRec.SETRANGE("Dependent ID", "Select Dependent No");
                if DeptConLineRec.FINDFIRST then begin
                    repeat
                        DeptConLineRec.DELETE;
                    until DeptConLineRec.NEXT = 0;
                end;
            end;
        end;
    end;
}