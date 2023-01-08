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
    State: XMLParserState;
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
  Result := I - DataOffset;
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
var Data: PChar;
var DataOffset: Integer;
var DataLen: Integer;
begin
  DataOffset := 1;
  I := 0;
  for I := 0 to Length(Str) do
  begin
    CharI := Str[I];
    if State = sContent then
    begin
      if CharI = '<' then
      begin
        DataLen := CalculateDataLen(I, DataOffset);
        if DataLen > 0 then
        begin
          XMLContent(Str + DataOffset, DataLen);
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
        if Str[DataOffset] = '/' then XMLTagClose(Str + DataOffset + 1, DataLen - 1)
        else XMLTagOpen(Str + DataOffset, DataLen);
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
        XMLAttributeKey(Str + DataOffset, DataLen);
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
        Data := Str + DataOffset;
        if (Data[0] = #39) or (Data[0] = '"') then
        begin
          XMLAttributeValue(Str + DataOffset + 1, DataLen - 2);
        end
        else XMLAttributeValue(Str + DataOffset, DataLen);
        DataOffset := DataOffset + DataLen + 1;
        case CharI of
          '>': State := sContent;
          ' ': State := sTagAttributeKey;
        end;
      end;
    end;
  end;
  { end of the character stream }
  DataLen := CalculateDataLen(I, DataOffset);
  if (I > DataOffset) and (Length(Str) > 0) then
  begin
    Writeln('warning! data was unprocessed!');
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
