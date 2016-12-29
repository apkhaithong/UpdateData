object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Update Data'
  ClientHeight = 620
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 981
    Height = 58
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 29
      Top = 22
      Width = 82
      Height = 13
      Caption = 'From Temp Table'
    end
    object Label2: TLabel
      Left = 262
      Top = 22
      Width = 41
      Height = 13
      Caption = 'To Table'
    end
    object ComboBox1: TComboBox
      Left = 309
      Top = 19
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Tb_Customer'
      Items.Strings = (
        'Tb_Customer'
        'Tb_Contract'
        'Tb_Income'
        'Tb_Warrantor')
    end
    object Edit1: TEdit
      Left = 117
      Top = 19
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 661
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Process'
      TabOrder = 2
      OnClick = Button1Click
    end
    object ChkInsert: TCheckBox
      Left = 485
      Top = 21
      Width = 153
      Height = 17
      Caption = 'Insert if not found record'
      TabOrder = 3
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 360
    Width = 981
    Height = 140
    Align = alBottom
    DataSource = UniDataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 58
    Width = 981
    Height = 17
    Align = alTop
    Max = 786244
    TabOrder = 2
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 75
    Width = 981
    Height = 285
    Align = alClient
    DataSource = UniDataSource2
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 0
    Top = 500
    Width = 981
    Height = 120
    Align = alBottom
    TabOrder = 4
  end
  object UniConnection1: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'infocenter'
    Username = 'sa'
    Server = 'WIN-PCOO20HIV2D'
    LoginPrompt = False
    Left = 56
    Top = 80
    EncryptedPassword = 'ACFF9AFF8DFF89FF9AFF8DFFD5FFCEFF'
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 176
    Top = 80
  end
  object QToTable: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'SELECT AmphurCode, AmphurName, ProvinceCode'
      'FROM dbo.Tb_Amphur')
    CachedUpdates = True
    Left = 56
    Top = 152
  end
  object UniDataSource1: TUniDataSource
    DataSet = QToTable
    Left = 176
    Top = 152
  end
  object QFromTable: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'SELECT AmphurCode, AmphurName, ProvinceCode'
      'FROM dbo.Tb_Amphur')
    Left = 56
    Top = 208
  end
  object UniDataSource2: TUniDataSource
    DataSet = QFromTable
    Left = 176
    Top = 208
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    Left = 64
    Top = 272
  end
end
