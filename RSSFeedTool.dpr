program RSSFeedTool;

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  FeedUnit in 'FeedUnit.pas' {FeedForm},
  TFeedPostUnit in 'TFeedPostUnit.pas',
  XMLParserUnit in 'XMLParserUnit.pas',
  RSSParserUnit in 'RSSParserUnit.pas';

{$R *.res}

var RSSParser: RSSParserUnit.RSSParser;
var RSSString: PChar;

begin
  Application.Initialize;
  Application.CreateForm(TFeedForm, FeedForm);
  AllocConsole;

  { Data code }

  RSSString := '<title test='#39'hello'#39'>ex<b>am</b>p<i>l</i>e</title>';
  RSSParser := RSSParserUnit.RSSParser.Create;
  RSSParser.ParseXML(RSSString);
  RSSParser.ParseXML('<author>hello</author>');

  FeedForm.ConfigurePostsListBox;

  Application.Run;
end.
