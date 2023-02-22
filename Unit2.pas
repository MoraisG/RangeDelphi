unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Datasnap.DBClient, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    cdsPessoas: TClientDataSet;
    cdsPessoasID: TIntegerField;
    cdsPessoasSaldoDebito: TFMTBCDField;
    cdsPessoasSaldoCredito: TFMTBCDField;
    cdsPessoasBaixar: TIntegerField;
    cdsDocumentos: TClientDataSet;
    cdsDocumentosDuplicata: TStringField;
    cdsDocumentosValor: TFMTBCDField;
    cdsDocumentosSelecionado: TIntegerField;
    cdsDocumentosVencimento: TDateField;
    cdsDocumentosIdCliente: TIntegerField;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    dsPessoas: TDataSource;
    Button1: TButton;
    dsDocumentos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreencherPessoas;
    procedure PreencherDocumentos;
    procedure CriarIndexDocumentos;
    procedure CriarIndexPessoas;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  Math,
  DateUtils;

procedure TForm2.Button1Click(Sender: TObject);
begin
  try
    cdsPessoas.IndexName := 'IDX_PESSOA_BAIXA';
    cdsPessoas.SetRange([1, 1], [1, MaxInt]);
    cdsPessoas.ApplyRange;
    ShowMessage(Format('Número de registros %d', [cdsPessoas.RecordCount]));
    cdsDocumentos.IndexName := 'IDX_DOCUMENTOS';
    cdsDocumentos.SetRange([1, 0, MinDateTime], [1, MaxInt, MaxDateTime]);
    cdsDocumentos.ApplyRange;
    ShowMessage(Format('Número de documentos %d', [cdsDocumentos.RecordCount]));
    cdsDocumentos.first;
    cdsDocumentos.DisableControls;
    while not cdsDocumentos.Eof do
    begin
      if (not cdsPessoas.FindKey([1, cdsDocumentosIdCliente.AsInteger])) then
      begin
        cdsDocumentos.Next;
        Continue;
      end;

      cdsPessoas.Edit;
      cdsPessoasSaldoDebito.AsFloat := cdsPessoasSaldoDebito.AsFloat +
        cdsDocumentosValor.AsFloat;
      cdsPessoas.Post;
      cdsDocumentos.Next;
    end;
    cdsDocumentos.Filtered := False;
    cdsDocumentos.first;
    cdsDocumentos.EnableControls;
    cdsDocumentos.CancelRange;
    cdsPessoas.CancelRange;
    cdsDocumentos.IndexName := 'IDX_DOCUMENTOS_PADRAO';
    cdsPessoas.IndexName := 'IDX_PESSOAS';
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm2.CriarIndexDocumentos;
begin
  cdsDocumentos.AddIndex('IDX_DOCUMENTOS_PADRAO', 'IdCliente;Vencimento',
    [ixPrimary, ixCaseInsensitive]);
end;

procedure TForm2.CriarIndexPessoas;
begin
  cdsPessoas.IndexDefs.Clear;
  cdsPessoas.AddIndex('IDX_PESSOAS', 'ID', [ixPrimary, ixCaseInsensitive]);
  cdsPessoas.AddIndex('IDX_PESSOA_BAIXA', 'Baixar;ID',
    [ixPrimary, ixCaseInsensitive]);
end;

procedure TForm2.DBGrid1DblClick(Sender: TObject);
var
  nSelecao: Integer;
begin
  nSelecao := 0;
  if DBGrid1.DataSource.DataSet.FieldByName('Baixar').AsInteger = 0 then
    nSelecao := 1;
  DBGrid1.DataSource.DataSet.Edit;
  DBGrid1.DataSource.DataSet.FieldByName('Baixar').AsInteger := nSelecao;
  DBGrid1.DataSource.DataSet.Post;
end;

procedure TForm2.DBGrid2DblClick(Sender: TObject);
var
  nSelecao: Integer;
begin
  nSelecao := 0;
  if DBGrid2.DataSource.DataSet.FieldByName('Selecionado').AsInteger = 0 then
    nSelecao := 1;
  DBGrid2.DataSource.DataSet.Edit;
  DBGrid2.DataSource.DataSet.FieldByName('Selecionado').AsInteger := nSelecao;
  DBGrid2.DataSource.DataSet.Post;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  PreencherPessoas;
  PreencherDocumentos;
  CriarIndexPessoas;
  CriarIndexDocumentos;
  cdsDocumentos.IndexName := 'IDX_DOCUMENTOS_PADRAO';
  cdsPessoas.IndexName := 'IDX_PESSOAS'
end;

procedure TForm2.PreencherDocumentos;
var
  I: Integer;
begin
  cdsPessoas.DisableControls;
  cdsPessoas.first;
  while not cdsPessoas.Eof do
  begin
    for I := 0 to 5 do
    begin
      cdsDocumentos.Append;
      cdsDocumentosDuplicata.AsString := TGuid.NewGuid.ToString;
      cdsDocumentosValor.AsFloat := RandomRange(1, 9999) * 0.1;
      cdsDocumentosIdCliente.AsInteger := cdsPessoasID.AsInteger;
      cdsDocumentosVencimento.AsDateTime := Now + RandomRange(0, 30);
      cdsDocumentosSelecionado.AsInteger := 0;
      cdsDocumentos.Post;
    end;
    cdsPessoas.Next;
  end;
  cdsPessoas.first;
  cdsPessoas.EnableControls;
end;

procedure TForm2.PreencherPessoas;
var
  I: Integer;
begin
  for I := 1 to 5 do
  begin
    cdsPessoas.Append;
    cdsPessoasID.AsInteger := I;
    cdsPessoasBaixar.AsInteger := 0;
    cdsPessoas.Post;
  end;
end;

end.
