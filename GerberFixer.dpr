program GerberFixer;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form36};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm36, Form36);
  Application.Run;
end.
