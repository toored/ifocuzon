object FocuzOnForm: TFocuzOnForm
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'iFocuzOn'
  ClientHeight = 659
  ClientWidth = 900
  Color = clBackground
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  DesignSize = (
    900
    659)
  PixelsPerInch = 96
  TextHeight = 12
  object lblStatus: TLabel
    Left = 0
    Top = 0
    Width = 900
    Height = 12
    Align = alTop
    Alignment = taCenter
    Caption = 'iFocuzOn - '#35831#36873#25321#28966#28857#21306#22495
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 150
  end
  object bvlSelection: TBevel
    Left = 0
    Top = 152
    Width = 97
    Height = 73
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Anchors = []
    ParentShowHint = False
    Shape = bsFrame
    ShowHint = False
    Visible = False
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 32
    object FocuzOn1: TMenuItem
      Caption = 'iFocuz On 1.0'
      Enabled = False
    end
    object mnuSetFocus: TMenuItem
      Caption = #36873#25321#32858#28966#21306#22495
      OnClick = mnuSetFocusClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuSetBKColor: TMenuItem
      Caption = #23631#34109#21306#32972#26223#33394
      OnClick = mnuSetBKColorClick
    end
    object Minimum1: TMenuItem
      Caption = #31383#20307#26368#23567#21270
      OnClick = Minimum1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuClose: TMenuItem
      Caption = #36864#20986#31243#24207
      OnClick = mnuCloseClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 48
    Top = 96
  end
end
