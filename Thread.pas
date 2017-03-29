unit Thread;

interface

uses
{$IF DEFINED(MSWINDOWS)}
  ShellAPI,
{$ELSEIF DEFINED(ANDROID)}
  Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers,
{$ENDIF}
  System.Classes, SysUtils, System.IOUtils, FMX.Dialogs;

type
  HTMLthread = class(TThread)
  private
    { Private declarations }
  protected
    procedure finishThread;
    procedure Execute; override;
  end;

implementation
{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,
      Synchronize(UpdateCaption);
  and UpdateCaption could look like,
    procedure HTMLthread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;
    or
    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );
  where an anonymous method is passed.
  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
}

uses Unit7;
{ HTMLthread }

procedure HTMLthread.Execute;
var
  fileNew: String;
{$IF DEFINED(ANDROID)}
  Intent: JIntent;
{$ENDIF}
begin
  FreeOnTerminate    :=  True;
  fileNew            := 'compettable.html';
  if frm.sBtnKrug.Tag =  1 then frm.createHTMLkrug(fileNew)
  else                          frm.createHTMLolimp(fileNew);
{$IF DEFINED(ANDROID)}
  fileNew := TPath.Combine(TPath.GetPublicPath, fileNew); // System.IOUtils
{$ENDIF};
  if FileExists(fileNew) then
  begin
{$IF DEFINED(ANDROID)}
     fileNew := 'file:' + fileNew; // fileNew := 'file://' + fileNew; - первый вариант
	   Intent  := TJIntent.Create;
	   Intent  := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
	   Intent.setDataAndType(StrToJURI(fileNew), StringToJString('text/html'));
     SharedActivity.startActivity(Intent);
{$ELSEIF defined(MSWINDOWS)}
	   ShellExecute(Handle, 'open', PChar(fileNew), nil, nil, 0);
{$ENDIF};
  end
  else ShowMessage('Error creating report!');
  Synchronize(finishThread);
  Terminate;                   // Здесь просто команда завершить поток, без всякой синхронизации
end;

procedure HTMLthread.finishThread;
begin
  frm.aIndic.Visible := False; // Работа с визуальными компонентами в потоке
  frm.aIndic.Enabled := False; // только через синхронизацию!!!
end;

end.
