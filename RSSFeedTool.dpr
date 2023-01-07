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
  TFeedPostUnit in 'TFeedPostUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFeedForm, FeedForm);
  AllocConsole;
  FeedForm.ConfigurePostsListBox;
  Application.Run;
end.
