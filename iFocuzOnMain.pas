unit iFocuzOnMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls;

const
  WS_EX_LAYERED = $80000;
  LWA_ALPHA = $2;

type
  TFocuzOnForm = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    mnuClose: TMenuItem;
    mnuSetFocus: TMenuItem;
    Minimum1: TMenuItem;
    lblStatus: TLabel;
    mnuSetBKColor: TMenuItem;
    ColorDialog1: TColorDialog;
    FocuzOn1: TMenuItem;
    N2: TMenuItem;
    bvlSelection: TBevel;
    procedure mnuCloseClick(Sender: TObject);
    procedure SetOn;
    procedure SetOff;
    procedure Minimum1Click(Sender: TObject);
    procedure mnuSetFocusClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure mnuSetBKColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetOpacity(Alpha: Byte);
  public
    { Public declarations }
  end;

function SetLayeredWindowAttributes(hwnd:HWND; crKey:Longint; bAlpha:byte; dwFlags:longint ):longint;
         stdcall; external user32;

var
  FocuzOnForm: TFocuzOnForm;
  isCapturing: Boolean;
  X1, Y1, X2, Y2: Integer;

implementation

{$R *.dfm}

procedure TFocuzOnForm.SetOn;
var
  FullRgn, ClientRgn: THandle;
begin
  if (X2 <> X1) and (Y2 <> Y1)then
  try
    FullRgn := CreateRectRgn(0, 0, Width, Height);
    ClientRgn := CreateRectRgn (X1, Y1, X2, Y2);
    CombineRgn( FullRgn, FullRgn, ClientRgn, RGN_DIFF );
    SetWindowRgn (Handle, FullRgn, True);
  finally
    DeleteObject(FullRgn);
    DeleteObject(ClientRgn);
    SetOpacity( 255 );
  end;

  Invalidate; // Repaint Form
end;

procedure TFocuzOnForm.SetOff;
var
  FullRgn: THandle;
begin
  FullRgn := CreateRectRgn(0, 0, Width, Height);
  SetWindowRgn (Handle, FullRgn, True);
  Invalidate; // Repaint Form
  DeleteObject(FullRgn); // Test
  SetOpacity( 192 );
end;

procedure TFocuzOnForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crCross;
  SetOpacity( 192 );
end;

procedure TFocuzOnForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Screen.Cursor = crCross then isCapturing := True;
  if isCapturing then
  begin
    X1 := X;
    Y1 := Y;
    X2 := X;
    Y2 := Y;
    lblStatus.Caption := '(X1, Y1) = (' + IntToStr(X1) + ', ' + IntToStr(Y1) + ') '
      + '(X2, Y2) = (' + IntToStr(X) + ', ' + IntToStr(Y) + ')';
  end;
end;

procedure TFocuzOnForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  XX1, YY1, XX2, YY2: Integer;
begin
  if isCapturing then
  begin
    XX1 := X1; YY1 := Y1;
    XX2 := X; YY2 := Y;
    lblStatus.Caption := '(X1, Y1) = (' + IntToStr(X1) + ', ' + IntToStr(Y1) + ') '
      + '(X2, Y2) = (' + IntToStr(X) + ', ' + IntToStr(Y) + ')';

    if (XX1 <> XX2) and (YY1 <> YY2) then
    with bvlSelection do
    begin
      if (YY1 < YY2) then Top := YY1
      else Top := YY2;
      if (XX1 < XX2) then Left := XX1
      else Left := XX2;
      Width := Round(Abs(XX1 - XX2));
      Height := Round(Abs(YY1 - YY2));
      Visible := True;
    end else
      bvlSelection.Visible := False;
  end;
end;

procedure TFocuzOnForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if isCapturing then
  begin
    X2 := X;
    Y2 := Y;
    Screen.Cursor := crDefault;
    lblStatus.Visible := False;
    bvlSelection.Visible := False;
    isCapturing := False;
    SetOn;
  end;
end;

procedure TFocuzOnForm.Minimum1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFocuzOnForm.SetOpacity(Alpha: Byte);
var
  l:LongInt;
begin
  l:=getWindowLong(Handle, GWL_EXSTYLE);
  l := l Or WS_EX_LAYERED;
  SetWindowLong (Handle, GWL_EXSTYLE, l);
  SetLayeredWindowAttributes (Handle, 0, Alpha, LWA_ALPHA);
end;

procedure TFocuzOnForm.mnuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFocuzOnForm.mnuSetBKColorClick(Sender: TObject);
begin
  //Set Background Color
  ColorDialog1.Color := Color;
  if ColorDialog1.Execute(Handle) then
    Color := ColorDialog1.Color;
end;

procedure TFocuzOnForm.mnuSetFocusClick(Sender: TObject);
begin
  Screen.Cursor := crCross;
  lblStatus.Visible := True;
  bvlSelection.Visible := False;
  SetOff;
end;

end.
