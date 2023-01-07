object FeedForm: TFeedForm
  Left = 192
  Top = 112
  Width = 626
  Height = 454
  Caption = 'RSS Feed Tool'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    618
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 32
    Width = 23
    Height = 13
    Caption = 'Title:'
  end
  object Label2: TLabel
    Left = 120
    Top = 80
    Width = 40
    Height = 13
    Caption = 'Content:'
  end
  object Label3: TLabel
    Left = 120
    Top = 56
    Width = 61
    Height = 13
    Caption = 'Publish date:'
  end
  object PostsListBox: TListBox
    Left = 0
    Top = 24
    Width = 113
    Height = 404
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnClick = PostsListBoxClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object Button2: TButton
      Left = 24
      Top = 0
      Width = 25
      Height = 25
      Caption = 'E'
      TabOrder = 0
    end
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      Caption = 'N'
      TabOrder = 1
    end
  end
  object DateTimePicker1: TDateTimePicker
    Left = 192
    Top = 56
    Width = 417
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CalAlignment = dtaLeft
    Date = 44933.9114395255
    Time = 44933.9114395255
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object PostTitleEdit: TEdit
    Left = 192
    Top = 32
    Width = 417
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'PostTitleEdit'
  end
  object PostContentEdit: TEdit
    Left = 192
    Top = 80
    Width = 417
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    TabOrder = 4
    Text = 'PostContentEdit'
  end
  object Button3: TButton
    Left = 536
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    BiDiMode = bdRightToLeft
    Caption = 'Save'
    ParentBiDiMode = False
    TabOrder = 5
  end
end
