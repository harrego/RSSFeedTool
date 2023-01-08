unit FeedUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TFeedPostUnit;

var TempMsgBox: PChar;

type
  TFeedForm = class(TForm)
    PostsListBox: TListBox;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    PostTitleEdit: TEdit;
    PostContentEdit: TEdit;
    Button3: TButton;
    Label4: TLabel;

    procedure UpdateCurrentPost(Post: TFeedPostUnit.TFeedPost);
    procedure ConfigurePostsListBox;
    procedure PostsListBoxClick(Sender: TObject);

  private
  public
    FeedPosts: array of TFeedPostUnit.TFeedPost;
  end;

var
  FeedForm: TFeedForm;

var TestFeedPost1: TFeedPostUnit.TFeedPost;
var TestFeedPost2: TFeedPostUnit.TFeedPost;
var SelectedFeedPost: TFeedPostUnit.TFeedPost;

implementation

procedure TFeedForm.UpdateCurrentPost(Post: TFeedPostUnit.TFeedPost);
begin
  with Self do
    PostTitleEdit.SetTextBuf(Post.Title);
    PostContentEdit.SetTextBuf(Post.Content);
end;

procedure TFeedForm.ConfigurePostsListBox;
begin
  with Self do
    SetLength(FeedPosts, 2);

    TestFeedPost1 := TFeedPostUnit.TFeedPost.Create;
    TestFeedPost1.Title := 'Example post 1';
    TestFeedPost1.Content := 'Example content - post 1';

    TestFeedPost2 := TFeedPostUnit.TFeedPost.Create;
    TestFeedPost2.Title := 'Example post 2';
    TestFeedPost2.Content := 'Example content - post 2';

    FeedPosts[0] := TestFeedPost1;
    FeedPosts[1] := TestFeedPost2;

    PostsListBox.AddItem(TestFeedPost1.Title, TestFeedPost1);
    PostsListBox.AddItem(TestFeedPost2.Title, TestFeedPost2);

    UpdateCurrentPost(FeedPosts[0]);
  end;

{$R *.dfm}

procedure TFeedForm.PostsListBoxClick(Sender: TObject);
begin
  SelectedFeedPost := FeedPosts[Self.PostsListBox.ItemIndex];
  Self.UpdateCurrentPost(SelectedFeedPost);
end;

end.
