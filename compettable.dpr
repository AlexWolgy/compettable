program compettable;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit7 in 'Unit7.pas' {frm},
  Thread in 'Thread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm, frm);
  Application.Run;
end.
