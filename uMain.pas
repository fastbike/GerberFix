unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TForm36 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    btnProcess: TButton;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    procedure btnProcessClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private const
    StartText = '%LPD*%';
    EndText = 'M02*';
    ProfileText = '%TF.FileFunction,Profile*%';

  private
    { Private declarations }
    FRawFileName: string;
  public
    { Public declarations }
  end;

var
  Form36: TForm36;

implementation

uses
  System.Zip;

{$R *.dfm}


procedure TForm36.btnProcessClick(Sender: TObject);
var
  ZipFile: TZipFile;
  OutlineStream: TStream; // TMemoryStream;
  NewStream: TMemoryStream;
  Header: TZipHeader;
  VScore, Contents: TStrings;
  StartIndex, EndIndex, InsertionIndex: Integer;
begin
  StatusBar1.SimpleText := '';
  // OutlineStream := TMemoryStream.Create;
  Contents := TStringList.Create;
  VScore := TStringList.Create;
  ZipFile := TZipFile.Create;
  try
    ZipFile.Open(FRawFileName, zmReadWrite);

    ZipFile.Read('V-Scoring.gbr', OutlineStream, Header);
    OutlineStream.Position := 0;
    VScore.LoadFromStream(OutlineStream);
    Memo1.Text := VScore.Text;

    ZipFile.Read('BoardOutline.gbr', OutlineStream, Header);
    OutlineStream.Position := 0;
    Contents.LoadFromStream(OutlineStream);
    // Memo1.Text := Contents.Text;

    for var I := 0 to VScore.Count - 1 do
    begin
      if VScore[I] = StartText then
        StartIndex := I + 1;
      if VScore[I] = EndText then
        EndIndex := I - 1;
    end;
    if (StartIndex = 0) or (EndIndex = 0) then
      raise Exception.Create('Could not find the v-scoring data');

    for var I := 0 to Contents.Count - 1 do
    begin
      if Contents[I] = StartText then
      begin
        InsertionIndex := I + 1;
        Break;
      end;
    end;
    if (InsertionIndex = 0) then
      raise Exception.Create('Could not find the board outline data');

    for var I := 0 to Contents.Count - 1 do
    begin
      if Contents[I] = ProfileText then
      begin
        Contents[I] := '%TF.FileFunction,Profile,NP*%';
        Break;
      end;
    end;

    // now insert the vscoring
    Contents.Insert(InsertionIndex, 'G04 End of V Scoring data*');
    for var I := EndIndex downto StartIndex do
      Contents.Insert(InsertionIndex, VScore[I]);
    Contents.Insert(InsertionIndex, 'G04 Start of V Scoring data*');

    ZipFile.Delete('BoardOutline.gbr');
    NewStream := TMemoryStream.Create;
    try
      Contents.SaveToStream(NewStream);
      NewStream.Position := 0;


      ZipFile.Add(NewStream, 'BoardOutline.gbr');

    finally
      NewStream.Free;
    end;
    //ZipFile.

    // ZipFile.Delete()
    // now delete the V-Scoring file
    ZipFile.Delete('V-Scoring.gbr');
    ZipFile.Close;

  finally
    ZipFile.Free;
    Contents.Free;
    VScore.Free;
  end;

end;

(*

  %LPD*%
*)

procedure TForm36.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FRawFileName := OpenDialog1.FileName;
    btnProcess.Enabled := True;
    StatusBar1.SimpleText := 'ready';
  end
  else
  begin
    btnProcess.Enabled := False;
    StatusBar1.SimpleText := 'select file';
  end;
end;

end.
