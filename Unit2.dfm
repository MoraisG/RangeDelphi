object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 424
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 806
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 264
    ExplicitTop = 64
    ExplicitWidth = 185
    object Button1: TButton
      Left = 24
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 806
    Height = 184
    Align = alTop
    DataSource = dsPessoas
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 225
    Width = 806
    Height = 199
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 8
    ExplicitHeight = 41
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 806
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Documentos'
      TabOrder = 0
    end
    object DBGrid2: TDBGrid
      Left = 0
      Top = 25
      Width = 806
      Height = 174
      Align = alClient
      DataSource = dsDocumentos
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid2DblClick
    end
  end
  object cdsPessoas: TClientDataSet
    PersistDataPacket.Data = {
      930000009619E0BD020000001800000004000000000003000000930002494404
      000100000000000B53616C646F44656269746F12001200000002000844454349
      4D414C530200020008000557494454480200020020000C53616C646F43726564
      69746F120012000000020008444543494D414C53020002000800055749445448
      0200020020000642616978617204000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 24
    object cdsPessoasID: TIntegerField
      FieldName = 'ID'
    end
    object cdsPessoasSaldoDebito: TFMTBCDField
      FieldName = 'SaldoDebito'
    end
    object cdsPessoasSaldoCredito: TFMTBCDField
      FieldName = 'SaldoCredito'
    end
    object cdsPessoasBaixar: TIntegerField
      FieldName = 'Baixar'
    end
  end
  object cdsDocumentos: TClientDataSet
    PersistDataPacket.Data = {
      B00000009619E0BD020000001800000005000000000003000000B00009496443
      6C69656E74650400010000000000094475706C69636174610100490000000100
      0557494454480200020011000556616C6F72120012000000020008444543494D
      414C530200020008000557494454480200020020000B53656C6563696F6E6164
      6F04000100000000000A56656E63696D656E746F040006000000000001000D44
      454641554C545F4F524445520200820000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IdCliente'
        DataType = ftInteger
      end
      item
        Name = 'Duplicata'
        DataType = ftString
        Size = 17
      end
      item
        Name = 'Valor'
        DataType = ftFMTBcd
        Precision = 32
        Size = 8
      end
      item
        Name = 'Selecionado'
        DataType = ftInteger
      end
      item
        Name = 'Vencimento'
        DataType = ftDate
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end
      item
        Name = 'IDX_DOCUMENTOS'
        Fields = 'Selecionado;IdCliente;Vencimento'
      end>
    Params = <>
    StoreDefs = True
    Left = 752
    Top = 64
    object cdsDocumentosIdCliente: TIntegerField
      DisplayWidth = 10
      FieldName = 'IdCliente'
    end
    object cdsDocumentosDuplicata: TStringField
      DisplayWidth = 36
      FieldName = 'Duplicata'
      Size = 17
    end
    object cdsDocumentosValor: TFMTBCDField
      DisplayWidth = 10
      FieldName = 'Valor'
    end
    object cdsDocumentosSelecionado: TIntegerField
      DisplayWidth = 10
      FieldName = 'Selecionado'
    end
    object cdsDocumentosVencimento: TDateField
      DisplayWidth = 10
      FieldName = 'Vencimento'
    end
  end
  object dsPessoas: TDataSource
    DataSet = cdsPessoas
    Left = 744
    Top = 112
  end
  object dsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 688
    Top = 72
  end
end
