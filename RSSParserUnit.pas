unit RSSParserUnit;

interface

uses SysUtils, XMLParserUnit;

type RSSParser = class(XMLParserUnit.XMLParser)
  public
    procedure XMLTagOpen(Tag: PChar; TagLen: Integer); override;
    procedure XMLTagClose(Tag: PChar; TagLen: Integer); override;
    procedure XMLContent(Content: PChar; ContentLen: Integer); override;
end;

implementation

procedure RSSParser.XMLTagOpen(Tag: PChar; TagLen: Integer);
var TagName: PChar;
begin;
  TagName := DataBufferNew(Tag, TagLen);
  Writeln('xml tag open');
  Writeln(TagName);
  DataBufferDispose(TagName);
end;

procedure RSSParser.XMLTagClose(Tag: PChar; TagLen: Integer);
var TagName: PChar;
begin;
  TagName := DataBufferNew(Tag, TagLen);
  Writeln('xml tag close');
  Writeln(TagName);
  DataBufferDispose(TagName);
end;

procedure RSSParser.XMLContent(Content: PChar; ContentLen: Integer);
var ContentStr: PChar;
begin
  ContentStr := DataBufferNew(Content, ContentLen);
  Writeln('xml content:');
  Writeln(ContentStr);
  DataBufferDispose(ContentStr);
end;

end.
