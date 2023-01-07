unit TFeedPostUnit;

interface

type
  TFeedPost = class(TObject)
  public
    Title: PChar;
    Content: PChar;
    PublishDateTime: TDateTime;
  end;

implementation

end.
 