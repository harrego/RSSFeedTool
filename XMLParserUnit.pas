unit XMLParserUnit;

interface

uses SysUtils;

type XMLParserState = (sContent, sTagName, sTagAttributeKey, sTagAttributeValue);

type XMLAttribute = record
  key: PChar;
  value: PChar;
end;

type
  XMLParser = class(TObject)
  private
    function CalculateDataLen(I: Integer; DataOffset: Integer): Integer;
  public
    function DataBufferNew(Data: PChar; DataLen: Integer): PChar;
    procedure DataBufferDispose(Buf: PChar);

    procedure ParseXML(Str: PChar);

    { Override }
    procedure XMLTagOpen(Tag: PChar; TagLen: Integer); virtual;
    procedure XMLTagClose(Tag: PChar; TagLen: Integer); virtual;
    procedure XMLContent(Content: PChar; ContentLen: Integer); virtual;
    procedure XMLAttributeKey(Key: PChar; KeyLen: Integer); virtual;
    procedure XMLAttributeValue(Value: PChar; ValueLen: Integer); virtual;
end;

implementation

function XMLParser.CalculateDataLen(I: Integer; DataOffset: Integer): Integer;
begin
  Result := (I - DataOffset) - 1;
end;

function XMLParser.DataBufferNew(Data: PChar; DataLen: Integer): PChar;
begin
  Result := StrAlloc(DataLen + 1);
  StrLCopy(Result, Data, DataLen);
  Result[DataLen] := #0;
end;

procedure XMLParser.DataBufferDispose(Buf: PChar);
begin
  StrDispose(Buf);
end;

procedure XMLParser.ParseXML(Str: PChar);
var I: Integer;
var CharI: Char;
var DataOffset: Integer;
var DataLen: Integer;
var State: XMLParserState;
begin
  State := sContent;
  DataOffset := 0;
  for I := 0 to Length(Str) do
  begin
    CharI := Str[i];
    if State = sContent then
    begin
      if CharI = '<' then
      begin
        DataLen := CalculateDataLen(I, DataOffset);
        if DataLen > 0 then
        begin
          XMLContent(Str + DataOffset + 1, DataLen);
          DataOffset := DataOffset + DataLen + 1;
        end;
        State := sTagName;
      end;
    end
    else if State = sTagName then
    begin
      if (CharI = '>') or (CharI = ' ') then
      begin
        DataLen := CalculateDataLen(I, DataOffset);
        if Str[DataOffset + 1] = '/' then XMLTagClose(Str + DataOffset + 2, DataLen - 1)
        else XMLTagOpen(Str + DataOffset + 1, DataLen);
        DataOffset := DataOffset + DataLen + 1;

        case CharI of
          '>': State := sContent;
          ' ': State := sTagAttributeKey;
        end;
      end;
    end
    else if State = sTagAttributeKey then
    begin
      if (CharI = '>') or (CharI = ' ') or (CharI = '=') then
      begin
        DataLen := CalculateDataLen(I, DataOffset);
        XMLAttributeKey(Str + DataOffset + 1, DataLen);
        DataOffset := DataOffset + DataLen + 1;
        case CharI of
          '>': State := sContent;
          ' ': State := sTagAttributeKey;
          '=': State := sTagAttributeValue;
        end;
      end
    end
    else if State = sTagAttributeValue then
    begin
      if (CharI = '>') or (CharI = ' ') then
      begin
        DataLen := CalculateDataLen(I, DataOffset);
        XMLAttributeValue(Str + DataOffset + 1, DataLen);
        DataOffset := DataOffset + DataLen + 1;
        case CharI of
          '>': State := sContent;
          ' ': State := sTagAttributeKey;
        end;
      end;
    end;
  end;
end;

procedure XMLParser.XMLTagOpen(Tag: PChar; TagLen: Integer);
begin
end;

procedure XMLParser.XMLTagClose(Tag: PChar; TagLen: Integer);
begin
end;

procedure XMLParser.XMLContent(Content: PChar; ContentLen: Integer);
begin
end;

procedure XMLParser.XMLAttributeKey(Key: PChar; KeyLen: Integer);
begin
end;

procedure XMLParser.XMLAttributeValue(Value: PChar; ValueLen: Integer);
begin
end;

end.
