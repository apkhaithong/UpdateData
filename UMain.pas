unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Uni, UniProvider, SQLServerUniProvider, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, System.DateUtils;

type
  TForm1 = class(TForm)
    UniConnection1: TUniConnection;
    SQLServerUniProvider1: TSQLServerUniProvider;
    QToTable: TUniQuery;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    ChkInsert: TCheckBox;
    DBGrid1: TDBGrid;
    UniDataSource1: TUniDataSource;
    QFromTable: TUniQuery;
    UniDataSource2: TUniDataSource;
    ProgressBar1: TProgressBar;
    UniQuery1: TUniQuery;
    DBGrid2: TDBGrid;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i, j : Integer;
    MsgError : string;
begin
  if Edit1.Text <> '' then
  begin
    with QFromTable do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM '+Edit1.Text);
      Open;
    end;
    if not QFromTable.IsEmpty then
    begin
      Memo1.Clear;
      ProgressBar1.Max := QFromTable.RecordCount;
      QFromTable.First;
      j := 0;
      while not QFromTable.Eof do
      begin
        j := j+1;
        try
          // Customer
          if ComboBox1.Text = 'Tb_Customer' then
          begin
            with UniQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM Tb_Customer WHERE IDCard =:0 ');
              Params[0].AsString := QFromTable.FieldByName('IDCard').AsString;
              Open;
            end;
            if (UniQuery1.IsEmpty) and (ChkInsert.Checked) then
            begin
              if not QToTable.Active then
              begin
                with QToTable do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM Tb_Customer WHERE IDCard Is Null ');
                  Open;
                end;
              end;
              QToTable.Append;
              QToTable.FieldByName('FlagCustomer').AsString := 'Y';
              QToTable.FieldByName('FlagFriend').AsString   := 'N';
              QToTable.FieldByName('Userid').AsString       := 'system';
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify) and (QFromTable.Fields[i].FieldName <> 'Age') then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.FieldByName('Inputdate').AsDateTime  := Now;
              QToTable.FieldByName('Age').AsInteger := YearsBetween(Now,QToTable.FieldByName('BirthDate').AsDateTime);
              QToTable.Post;
              QToTable.ApplyUpdates();
            end
            else
            begin
              with QToTable do
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM Tb_Customer WHERE IDCard =:0 ');
                Params[0].AsString := QFromTable.FieldByName('IDCard').AsString;
                Open;
              end;
              QToTable.Edit;
              QToTable.FieldByName('FlagCustomer').AsString := 'Y';
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify) and
                   (QFromTable.Fields[i].FieldName <> 'Age') and
                   (QFromTable.Fields[i].FieldName <> 'Remark') and
                   (QFromTable.Fields[i].FieldName <> 'Before9') and
                   (QFromTable.Fields[i].FieldName <> 'After9') and
                   (QFromTable.Fields[i].FieldName <> 'Before16') and
                   (QFromTable.Fields[i].FieldName <> 'After16') and
                   (QFromTable.Fields[i].FieldName <> 'Other') and
                   (QFromTable.Fields[i].FieldName <> 'TextOther') and
                   (QFromTable.Fields[i].FieldName <> 'ProductType1') and
                   (QFromTable.Fields[i].FieldName <> 'ProductType2') and
                   (QFromTable.Fields[i].FieldName <> 'ProducttypeCode1') and
                   (QFromTable.Fields[i].FieldName <> 'ProducttypeCode2') and
                   (QFromTable.Fields[i].FieldName <> 'Model1') and
                   (QFromTable.Fields[i].FieldName <> 'Model2') and
                   (QFromTable.Fields[i].FieldName <> 'ProductCode1') and
                   (QFromTable.Fields[i].FieldName <> 'ProductCode2') then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.FieldByName('Inputdate').AsDateTime  := Now;
              QToTable.FieldByName('Age').AsInteger := YearsBetween(Now,QToTable.FieldByName('BirthDate').AsDateTime);
              QToTable.Post;
              QToTable.ApplyUpdates();
            end;
          end
          // Contract
          else if ComboBox1.Text = 'Tb_Contract' then
          begin
            with UniQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM Tb_Contract WHERE IDCard =:0 AND ContractId =:1 ');
              Params[0].AsString := QFromTable.FieldByName('IDCard').AsString;
              Params[1].AsString := QFromTable.FieldByName('ContractId').AsString;
              Open;
            end;
            if (UniQuery1.IsEmpty) and (ChkInsert.Checked) then
            begin
              if not QToTable.Active then
              begin
                with QToTable do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM Tb_Contract WHERE IDCard Is Null ');
                  Open;
                end;
              end;
              QToTable.Append;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify)then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end
            else
            begin
              with QToTable do
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM Tb_Contract WHERE IDCard =:0 AND ContractId =:1 ');
                Params[0].AsString := QFromTable.FieldByName('IDCard').AsString;
                Params[1].AsString := QFromTable.FieldByName('ContractId').AsString;
                Open;
              end;
              QToTable.Edit;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify) then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end;
          end
          // Income
          else if ComboBox1.Text = 'Tb_Income' then
          begin
            with UniQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM Tb_Income WHERE ContractId =:0 AND IncomeNo =:1 ');
              Params[0].AsString := QFromTable.FieldByName('ContractId').AsString;
              Params[1].AsInteger := QFromTable.FieldByName('IncomeNo').AsInteger;
              Open;
            end;
            if (UniQuery1.IsEmpty) and (ChkInsert.Checked) then
            begin
              if not QToTable.Active then
              begin
                with QToTable do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM Tb_Income WHERE ContractId Is Null ');
                  Open;
                end;
              end;
              QToTable.Append;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify)then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end
            else
            begin
              with QToTable do
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM Tb_Income WHERE ContractId =:0 AND IncomeNo =:1 ');
                Params[0].AsString := QFromTable.FieldByName('ContractId').AsString;
                Params[1].AsInteger := QFromTable.FieldByName('IncomeNo').AsInteger;
                Open;
              end;
              QToTable.Edit;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify) then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end;
          end
          // Warrantor
          else if ComboBox1.Text = 'Tb_Warrantor' then
          begin
            with UniQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM Tb_Warrantor WHERE ContractId =:0 AND WarrantorNo =:1 ');
              Params[0].AsString := QFromTable.FieldByName('ContractId').AsString;
              Params[1].AsInteger := QFromTable.FieldByName('WarrantorNo').AsInteger;
              Open;
            end;
            if (UniQuery1.IsEmpty) and (ChkInsert.Checked) then
            begin
              if not QToTable.Active then
              begin
                with QToTable do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM Tb_Warrantor WHERE ContractId Is Null ');
                  Open;
                end;
              end;
              QToTable.Append;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify)then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end
            else
            begin
              with UniQuery1 do
              begin
                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM Tb_Warrantor WHERE ContractId =:0 AND WarrantorNo =:1 ');
                Params[0].AsString := QFromTable.FieldByName('ContractId').AsString;
                Params[1].AsInteger := QFromTable.FieldByName('WarrantorNo').AsInteger;
                ExecSQL;
              end;
              if not QToTable.Active then
              begin
                with QToTable do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM Tb_Warrantor WHERE ContractId Is Null ');
                  Open;
                end;
              end;
              QToTable.Append;
              For i:=0 to QFromTable.FieldCount-1 do
              begin
                if QToTable.FieldByName(QFromTable.Fields[i].FieldName).Index >= 0 then
                if (QToTable.FieldByName(QFromTable.Fields[i].FieldName).CanModify) then
                  QToTable.FieldByName(QFromTable.Fields[i].FieldName).Assign(QFromTable.Fields[i]);
              end;
              QToTable.Post;
              QToTable.ApplyUpdates();
            end;
          end;
        except on E: Exception do
          if ComboBox1.Text = 'Tb_Customer' then
          begin
            MsgError := StringReplace(StringReplace(E.Message, #10, ' ', [rfReplaceAll]), #13, ' ', [rfReplaceAll]);
            Memo1.Lines.Add('IDCard : '+QFromTable.FieldByName('IDCard').AsString+' Error : '+MsgError);
          end
          else if (ComboBox1.Text = 'Tb_Contract') or (ComboBox1.Text = 'Tb_Income') or (ComboBox1.Text = 'Tb_Warrantor') then
          begin
            MsgError := StringReplace(StringReplace(E.Message, #10, ' ', [rfReplaceAll]), #13, ' ', [rfReplaceAll]);
            Memo1.Lines.Add('ContractId : '+QFromTable.FieldByName('ContractId').AsString+' Error : '+MsgError);
          end;
        end;
        ProgressBar1.Position := ProgressBar1.Position + 1;
        if j = 500 then
        begin
          Application.ProcessMessages;
          j := 0;
        end;
        QFromTable.Next;
      end;
      Application.ProcessMessages;
    end;
  end;
end;

end.
