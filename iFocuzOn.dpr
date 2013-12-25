program iFocuzOn;

uses
  Forms,
  Windows,
  iFocuzOnMain in 'iFocuzOnMain.pas' {FocuzOnForm};

{$R *.res}

var
  h, ah: HWND;
begin
  CreateMutex(Nil, true, 'Fred iFocuzOn');
  if GetLastError <> ERROR_ALREADY_EXISTS then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := 'iFocusOn';
  Application.CreateForm(TFocuzOnForm, FocuzOnForm);
    Application.Run;
  end
  else
  begin
    h := FindWindow('TFocuzOnForm', nil);
    if h > 0 then
    begin
      ah := GetWindow(h, GW_OWNER);
      ShowWindow(ah, SW_RESTORE);
      ShowWindow(h, SW_RESTORE);
      SetForegroundWindow(h);
    end;
  end;
end.
