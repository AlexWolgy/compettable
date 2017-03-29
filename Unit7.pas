unit Unit7;

//     ver. 101 добавлено
//  1. На вводе новых записей (Tag 5) в таблицы Турниры и Участники, при выходе из текстового поля
//     принудительно убираю клавиатуру, что-бы обнульть буфер клавиатуры и защититься от мусора. (january 2017)
//  2. В списке Match отражается иконка выбранной системы поединков.                             (january 2017)
//  3. На главной странице, верхнее меню: добавлено «Копировать турнир» Сам турнир и участников.   (04-02-2017)
//  4. Олимпийская система... тестируется

//     В таблицу buttle добавлены три поля
//     otime1 NUMERIC (5, 1) - счет для добавленного времени (overTime) первого
//     otime2 NUMERIC (5, 1) - счет для добавленного времени (overTime) второго
//     draw BOOLEAN        - признак, что в основное время была ничья

//  5. В списке Match вверху экрана предусмотреть поиск круга (или подстроки)...
//  6. Возраст участника...
//  7. Окно About...
//  8. В веб-отчете с олимпийской системой брекеты могут быть другие, не такие как я взял из дзюдо
//  9. На вводе турнира предлагать иконку вида спорта
// 10. Создать цветовые схемы (два цвета) программы, штуки три и предлагать их в настройках
// 11. Добавить отчет, который предложил Вадим (из газеты)
// 12. Удаление строк в списках ListView делать через длительное нажатие на элемент

// 13. Версия с рекламой...

{
Задать параметры в процедуре (запросе) с параметрами

 

  sp_LAB_GOODCERT_EDIT.Parameters.Refresh();

  with sp_LAB_GOODCERT_EDIT.Parameters do begin

    ParamByName('@GOOD_ID').Value := FGood_ID;

    ParamByName('@REGNUM').Value := edtREGNUM.Value;

    ParamByName('@CERTORG_ID').Value := cmbCERTORG_ID.KeyValue;

    ParamByName('@CERTDATE').Value := edtCERTDATE.Value;

    ParamByName('@ANALYSIS_NUM').Value := edtANALYSIS_NUM.Value;

    ParamByName('@RESULT').Value := chkResult.Checked;

    ParamByName('@Declarant_ID').Value := cmbDeclarant.KeyValue;

    ParamByName('@OKP').Value := edtOKP.Value;

    ParamByName('@RegUdNum').Value := edtRegUdNum.Value;

    ParamByName('@RegUdDate').Value := edtRegUdDate.Value;

    ParamByName('@Produce_Date').Value := edtPRODUCE_DATE.Value;

  end;

}



interface

uses
{$IF DEFINED(ANDROID)}
  Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android, Androidapi.JNI.Toast,
{$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.StdCtrls,
  FMX.ListView, System.ImageList, FMX.ImgList, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, System.IOUtils,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, FMX.Edit, FMX.DateTimeCtrls,
  FMX.EditBox, FMX.NumberBox, Math, FMX.Platform, FMX.VirtualKeyboard, Thread;  // Поток подключил здесь (по книжке)

type
  Tfrm = class(TForm)
    tControl: TTabControl;
    tiTour: TTabItem;
    tiTedit: TTabItem;
    tiMain: TTabItem;
    tiCtCl: TTabItem;
    tiScore: TTabItem;
    tiAbout: TTabItem;
    aList: TActionList;
    chTAtedit: TChangeTabAction;
    chTAtour: TChangeTabAction;
    chTAmain: TChangeTabAction;
    chTActcl: TChangeTabAction;
    chTAscore: TChangeTabAction;
    chTAbout: TChangeTabAction;
    rectangle1: TRectangle;
    lViewTour: TListView;
    rectangle2: TRectangle;
    memo: TMemo;
    sBtnExit: TSpeedButton;
    iList36: TImageList;
    sBtnAdd: TSpeedButton;
    sBtnRed: TSpeedButton;
    sBtnDel: TSpeedButton;
    sBtnOpt: TSpeedButton;
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    rectangle3: TRectangle;
    sBtnTsave: TSpeedButton;
    layout0: TLayout;
    sBtnTcancel: TSpeedButton;
    vertScrollBox1: TVertScrollBox;
    sBtnTback: TSpeedButton;
    btnTkeyb: TButton;
    tCmain: TTabControl;
    tiWho: TTabItem;
    tiMatch: TTabItem;
    rectangle5: TRectangle;
    sBtnWback: TSpeedButton;
    sBtnCCadd: TSpeedButton;
    sBtnCCred: TSpeedButton;
    sBtnCCdel: TSpeedButton;
    lVwho: TListView;
    rectangle6: TRectangle;
    sBtnMback: TSpeedButton;
    lVmatch: TListView;
    sBtnKrug: TSpeedButton;
    sBtnPlace: TSpeedButton;
    rectangle7: TRectangle;
    vertScrollBox2: TVertScrollBox;
    sBtnCCback: TSpeedButton;
    btnCCkeyb: TButton;
    layout16: TLayout;
    sBtnCCok: TSpeedButton;
    sBtnCCancel: TSpeedButton;
    mainLayout2: TLayout;
    lPeople: TLayout;
    layout19: TLayout;
    eImia: TEdit;
    layout20: TLayout;
    eFam: TEdit;
    layout21: TLayout;
    eOtch: TEdit;
    layout22: TLayout;
    deDR: TDateEdit;
    layout23: TLayout;
    layout24: TLayout;
    eRank: TEdit;
    layout25: TLayout;
    eCoach: TEdit;
    layout17: TLayout;
    eCity: TEdit;
    layout18: TLayout;
    eClub: TEdit;
    clearEditButton7: TClearEditButton;
    layout26: TLayout;
    rBman: TRadioButton;
    rBwom: TRadioButton;
    clearEditButton1: TClearEditButton;
    clearEditButton2: TClearEditButton;
    clearEditButton3: TClearEditButton;
    clearEditButton4: TClearEditButton;
    clearEditButton5: TClearEditButton;
    clearEditButton6: TClearEditButton;
    StyleBook1: TStyleBook;
    FDTpara: TFDTable;
    FDTparaid: TFDAutoIncField;
    FDTparaidAL: TIntegerField;
    FDTparaidAR: TIntegerField;
    FDTparaidBL: TIntegerField;
    FDTbatl: TFDTable;
    FDTbatlbtid: TFDAutoIncField;
    FDTbatltourid: TIntegerField;
    FDTbatlkrug: TIntegerField;
    FDTbatltournum1: TIntegerField;
    FDTbatlfgid1: TIntegerField;
    FDTbatlfmim1: TStringField;
    FDTbatlpoints1: TBCDField;
    FDTbatlletter1: TStringField;
    FDTbatlwinner1: TIntegerField;
    FDTbatltournum2: TIntegerField;
    FDTbatlfgid2: TIntegerField;
    FDTbatlfmim2: TStringField;
    FDTbatlpoints2: TBCDField;
    FDTbatlletter2: TStringField;
    FDTbatlwinner2: TIntegerField;
    FDTbatlfinish: TBooleanField;
    FDTbatlkomm: TBlobField;
    layout27: TLayout;
    rBstart: TRadioButton;
    rBfinish: TRadioButton;
    aIndic: TAniIndicator;
    rectangle8: TRectangle;
    sBtnSback: TSpeedButton;
    gridPanelLayout1: TGridPanelLayout;
    lbl_1: TLabel;
    lbl_2: TLabel;
    layout28: TLayout;
    layout29: TLayout;
    scor1: TNumberBox;
    scor2: TNumberBox;
    label6: TLabel;
    label7: TLabel;
    layout30: TLayout;
    sBtnOK: TCornerButton;
    gridPanelLayout2: TGridPanelLayout;
    sBtnNot1: TCornerButton;
    sBtnNot2: TCornerButton;
    layout31: TLayout;
    sBtnDef: TCornerButton;
    FDTmpRep: TFDTable;
    FDTmpRepidtr: TFDAutoIncField;
    FDTmpReptournum: TIntegerField;
    FDTmpRepname: TStringField;
    FDTmpRepwins: TIntegerField;
    FDTmpReppoints: TBCDField;
    FDTmpRepekran: TStringField;
    FDTmpRepplace: TIntegerField;
    mainLayout1: TLayout;
    layout1: TLayout;
    eTname: TEdit;
    clearEditButton10: TClearEditButton;
    layout2: TLayout;
    eTcountry: TEdit;
    clearEditButton11: TClearEditButton;
    layout3: TLayout;
    eTregion: TEdit;
    clearEditButton12: TClearEditButton;
    layout4: TLayout;
    eTcity: TEdit;
    clearEditButton13: TClearEditButton;
    layout5: TLayout;
    eTchief: TEdit;
    clearEditButton14: TClearEditButton;
    layout6: TLayout;
    eTsecret: TEdit;
    clearEditButton15: TClearEditButton;
    layout7: TLayout;
    dEprov: TDateEdit;
    rectangle4: TRectangle;
    Label1: TLabel;
    Label5: TLabel;
    layout11: TLayout;
    layout12: TLayout;
    layout8: TLayout;
    label2: TLabel;
    nBox1: TNumberBox;
    layout9: TLayout;
    label3: TLabel;
    nBox2: TNumberBox;
    layout10: TLayout;
    label4: TLabel;
    nBox3: TNumberBox;
    layout13: TLayout;
    layout14: TLayout;
    rBtn1: TRadioButton;
    layout15: TLayout;
    rBtn2: TRadioButton;
    rectangle9: TRectangle;
    sBtnAback: TSpeedButton;
    Label8: TLabel;
    layout32: TLayout;
    layout33: TLayout;
    layout34: TLayout;
    lblToDay: TLabel;
    lblVer: TLabel;
    layout35: TLayout;
    lblSite: TLabel;
    rBeng: TRadioButton;
    layout36: TLayout;
    rBfra: TRadioButton;
    sBtnOlimp: TSpeedButton;
    FDTparatxAL: TStringField;
    FDTparatxAR: TStringField;
    FDTparatxBL: TStringField;
    FDTparaidBR: TIntegerField;
    FDTparatxBR: TStringField;
    FDTparaidCL: TIntegerField;
    FDTparatxCL: TStringField;
    FDTparaidCR: TIntegerField;
    FDTparatxCR: TStringField;
    FDTparaidDL: TIntegerField;
    FDTparatxDL: TStringField;
    FDTparaidDR: TIntegerField;
    FDTparatxDR: TStringField;
    FDTOtmp: TFDTable;
    FDTOtmpid: TFDAutoIncField;
    FDTOtmpIntegerField01F001: TIntegerField;
    FDTOtmpIntegerField01F128: TIntegerField;
    FDTOtmpIntegerField02F065: TIntegerField;
    FDTOtmpIntegerField02F064: TIntegerField;
    FDTOtmpIntegerField03F097: TIntegerField;
    FDTOtmpIntegerField03F032: TIntegerField;
    FDTOtmpIntegerField04F033: TIntegerField;
    FDTOtmpIntegerField04F096: TIntegerField;
    FDTOtmpIntegerField05F113: TIntegerField;
    FDTOtmpIntegerField05F016: TIntegerField;
    FDTOtmpIntegerField06F049: TIntegerField;
    FDTOtmpIntegerField06F080: TIntegerField;
    FDTOtmpIntegerField07F017: TIntegerField;
    FDTOtmpIntegerField07F112: TIntegerField;
    FDTOtmpIntegerField08F081: TIntegerField;
    FDTOtmpIntegerField08F048: TIntegerField;
    FDTOtmpIntegerField09F121: TIntegerField;
    FDTOtmpIntegerField09F008: TIntegerField;
    FDTOtmpIntegerField10F057: TIntegerField;
    FDTOtmpIntegerField10F072: TIntegerField;
    FDTOtmpIntegerField11F025: TIntegerField;
    FDTOtmpIntegerField11F104: TIntegerField;
    FDTOtmpIntegerField12F089: TIntegerField;
    FDTOtmpIntegerField12F040: TIntegerField;
    FDTOtmpIntegerField13F009: TIntegerField;
    FDTOtmpIntegerField13F120: TIntegerField;
    FDTOtmpIntegerField14F073: TIntegerField;
    FDTOtmpIntegerField14F056: TIntegerField;
    FDTOtmpIntegerField15F105: TIntegerField;
    FDTOtmpIntegerField15F024: TIntegerField;
    FDTOtmpIntegerField16F041: TIntegerField;
    FDTOtmpIntegerField16F088: TIntegerField;
    FDTOtmpIntegerField17F125: TIntegerField;
    FDTOtmpIntegerField17F004: TIntegerField;
    FDTOtmpIntegerField18F061: TIntegerField;
    FDTOtmpIntegerField18F068: TIntegerField;
    FDTOtmpIntegerField19F029: TIntegerField;
    FDTOtmpIntegerField19F100: TIntegerField;
    FDTOtmpIntegerField20F093: TIntegerField;
    FDTOtmpIntegerField20F036: TIntegerField;
    FDTOtmpIntegerField21F013: TIntegerField;
    FDTOtmpIntegerField21F116: TIntegerField;
    FDTOtmpIntegerField22F077: TIntegerField;
    FDTOtmpIntegerField22F052: TIntegerField;
    FDTOtmpIntegerField23F109: TIntegerField;
    FDTOtmpIntegerField23F020: TIntegerField;
    FDTOtmpIntegerField24F045: TIntegerField;
    FDTOtmpIntegerField24F084: TIntegerField;
    FDTOtmpIntegerField25F005: TIntegerField;
    FDTOtmpIntegerField25F124: TIntegerField;
    FDTOtmpIntegerField26F069: TIntegerField;
    FDTOtmpIntegerField26F060: TIntegerField;
    FDTOtmpIntegerField27F101: TIntegerField;
    FDTOtmpIntegerField27F028: TIntegerField;
    FDTOtmpIntegerField28F037: TIntegerField;
    FDTOtmpIntegerField28F092: TIntegerField;
    FDTOtmpIntegerField29F117: TIntegerField;
    FDTOtmpIntegerField29F012: TIntegerField;
    FDTOtmpIntegerField30F053: TIntegerField;
    FDTOtmpIntegerField30F076: TIntegerField;
    FDTOtmpIntegerField31F021: TIntegerField;
    FDTOtmpIntegerField31F108: TIntegerField;
    FDTOtmpIntegerField32F085: TIntegerField;
    FDTOtmpIntegerField32F044: TIntegerField;
    FDTOtmpIntegerField33F127: TIntegerField;
    FDTOtmpIntegerField33F002: TIntegerField;
    FDTOtmpIntegerField34F063: TIntegerField;
    FDTOtmpIntegerField34F066: TIntegerField;
    FDTOtmpIntegerField35F031: TIntegerField;
    FDTOtmpIntegerField35F098: TIntegerField;
    FDTOtmpIntegerField36F095: TIntegerField;
    FDTOtmpIntegerField36F034: TIntegerField;
    FDTOtmpIntegerField37F015: TIntegerField;
    FDTOtmpIntegerField37F114: TIntegerField;
    FDTOtmpIntegerField38F079: TIntegerField;
    FDTOtmpIntegerField38F050: TIntegerField;
    FDTOtmpIntegerField39F111: TIntegerField;
    FDTOtmpIntegerField39F018: TIntegerField;
    FDTOtmpIntegerField40F047: TIntegerField;
    FDTOtmpIntegerField40F082: TIntegerField;
    FDTOtmpIntegerField41F007: TIntegerField;
    FDTOtmpIntegerField41F122: TIntegerField;
    FDTOtmpIntegerField42F071: TIntegerField;
    FDTOtmpIntegerField42F058: TIntegerField;
    FDTOtmpIntegerField43F103: TIntegerField;
    FDTOtmpIntegerField43F026: TIntegerField;
    FDTOtmpIntegerField44F039: TIntegerField;
    FDTOtmpIntegerField44F090: TIntegerField;
    FDTOtmpIntegerField45F119: TIntegerField;
    FDTOtmpIntegerField45F010: TIntegerField;
    FDTOtmpIntegerField46F055: TIntegerField;
    FDTOtmpIntegerField46F074: TIntegerField;
    FDTOtmpIntegerField47F023: TIntegerField;
    FDTOtmpIntegerField47F106: TIntegerField;
    FDTOtmpIntegerField48F087: TIntegerField;
    FDTOtmpIntegerField48F042: TIntegerField;
    FDTOtmpIntegerField49F003: TIntegerField;
    FDTOtmpIntegerField49F126: TIntegerField;
    FDTOtmpIntegerField50F067: TIntegerField;
    FDTOtmpIntegerField50F062: TIntegerField;
    FDTOtmpIntegerField51F099: TIntegerField;
    FDTOtmpIntegerField51F030: TIntegerField;
    FDTOtmpIntegerField52F035: TIntegerField;
    FDTOtmpIntegerField52F094: TIntegerField;
    FDTOtmpIntegerField53F115: TIntegerField;
    FDTOtmpIntegerField53F014: TIntegerField;
    FDTOtmpIntegerField54F051: TIntegerField;
    FDTOtmpIntegerField54F078: TIntegerField;
    FDTOtmpIntegerField55F019: TIntegerField;
    FDTOtmpIntegerField55F110: TIntegerField;
    FDTOtmpIntegerField56F083: TIntegerField;
    FDTOtmpIntegerField56F046: TIntegerField;
    FDTOtmpIntegerField57F123: TIntegerField;
    FDTOtmpIntegerField57F006: TIntegerField;
    FDTOtmpIntegerField58F059: TIntegerField;
    FDTOtmpIntegerField58F070: TIntegerField;
    FDTOtmpIntegerField59F027: TIntegerField;
    FDTOtmpIntegerField59F102: TIntegerField;
    FDTOtmpIntegerField60F091: TIntegerField;
    FDTOtmpIntegerField60F038: TIntegerField;
    FDTOtmpIntegerField61F011: TIntegerField;
    FDTOtmpIntegerField61F118: TIntegerField;
    FDTOtmpIntegerField62F075: TIntegerField;
    FDTOtmpIntegerField62F054: TIntegerField;
    FDTOtmpIntegerField63F107: TIntegerField;
    FDTOtmpIntegerField63F022: TIntegerField;
    FDTOtmpIntegerField64F043: TIntegerField;
    FDTOtmpIntegerField64F086: TIntegerField;
    FDTOtmpKR1: TBooleanField;
    FDTOtmpIntegerField2L01: TIntegerField;
    FDTOtmpIntegerField2R01: TIntegerField;
    FDTOtmpIntegerField2L02: TIntegerField;
    FDTOtmpIntegerField2R02: TIntegerField;
    FDTOtmpIntegerField2L03: TIntegerField;
    FDTOtmpIntegerField2R03: TIntegerField;
    FDTOtmpIntegerField2L04: TIntegerField;
    FDTOtmpIntegerField2R04: TIntegerField;
    FDTOtmpIntegerField2L05: TIntegerField;
    FDTOtmpIntegerField2R05: TIntegerField;
    FDTOtmpIntegerField2L06: TIntegerField;
    FDTOtmpIntegerField2R06: TIntegerField;
    FDTOtmpIntegerField2L07: TIntegerField;
    FDTOtmpIntegerField2R07: TIntegerField;
    FDTOtmpIntegerField2L08: TIntegerField;
    FDTOtmpIntegerField2R08: TIntegerField;
    FDTOtmpIntegerField2L09: TIntegerField;
    FDTOtmpIntegerField2R09: TIntegerField;
    FDTOtmpIntegerField2L10: TIntegerField;
    FDTOtmpIntegerField2R10: TIntegerField;
    FDTOtmpIntegerField2L11: TIntegerField;
    FDTOtmpIntegerField2R11: TIntegerField;
    FDTOtmpIntegerField2L12: TIntegerField;
    FDTOtmpIntegerField2R12: TIntegerField;
    FDTOtmpIntegerField2L13: TIntegerField;
    FDTOtmpIntegerField2R13: TIntegerField;
    FDTOtmpIntegerField2L14: TIntegerField;
    FDTOtmpIntegerField2R14: TIntegerField;
    FDTOtmpIntegerField2L15: TIntegerField;
    FDTOtmpIntegerField2R15: TIntegerField;
    FDTOtmpIntegerField2L16: TIntegerField;
    FDTOtmpIntegerField2R16: TIntegerField;
    FDTOtmpIntegerField2L17: TIntegerField;
    FDTOtmpIntegerField2R17: TIntegerField;
    FDTOtmpIntegerField2L18: TIntegerField;
    FDTOtmpIntegerField2R18: TIntegerField;
    FDTOtmpIntegerField2L19: TIntegerField;
    FDTOtmpIntegerField2R19: TIntegerField;
    FDTOtmpIntegerField2L20: TIntegerField;
    FDTOtmpIntegerField2R20: TIntegerField;
    FDTOtmpIntegerField2L21: TIntegerField;
    FDTOtmpIntegerField2R21: TIntegerField;
    FDTOtmpIntegerField2L22: TIntegerField;
    FDTOtmpIntegerField2R22: TIntegerField;
    FDTOtmpIntegerField2L23: TIntegerField;
    FDTOtmpIntegerField2R23: TIntegerField;
    FDTOtmpIntegerField2L24: TIntegerField;
    FDTOtmpIntegerField2R24: TIntegerField;
    FDTOtmpIntegerField2L25: TIntegerField;
    FDTOtmpIntegerField2R25: TIntegerField;
    FDTOtmpIntegerField2L26: TIntegerField;
    FDTOtmpIntegerField2R26: TIntegerField;
    FDTOtmpIntegerField2L27: TIntegerField;
    FDTOtmpIntegerField2R27: TIntegerField;
    FDTOtmpIntegerField2L28: TIntegerField;
    FDTOtmpIntegerField2R28: TIntegerField;
    FDTOtmpIntegerField2L29: TIntegerField;
    FDTOtmpIntegerField2R29: TIntegerField;
    FDTOtmpIntegerField2L30: TIntegerField;
    FDTOtmpIntegerField2R30: TIntegerField;
    FDTOtmpIntegerField2L31: TIntegerField;
    FDTOtmpIntegerField2R31: TIntegerField;
    FDTOtmpIntegerField2L32: TIntegerField;
    FDTOtmpIntegerField2R32: TIntegerField;
    FDTOtmpKR2: TBooleanField;
    FDTOtmpIntegerField3L01: TIntegerField;
    FDTOtmpIntegerField3R01: TIntegerField;
    FDTOtmpIntegerField3L02: TIntegerField;
    FDTOtmpIntegerField3R02: TIntegerField;
    FDTOtmpIntegerField3L03: TIntegerField;
    FDTOtmpIntegerField3R03: TIntegerField;
    FDTOtmpIntegerField3L04: TIntegerField;
    FDTOtmpIntegerField3R04: TIntegerField;
    FDTOtmpIntegerField3L05: TIntegerField;
    FDTOtmpIntegerField3R05: TIntegerField;
    FDTOtmpIntegerField3L06: TIntegerField;
    FDTOtmpIntegerField3R06: TIntegerField;
    FDTOtmpIntegerField3L07: TIntegerField;
    FDTOtmpIntegerField3R07: TIntegerField;
    FDTOtmpIntegerField3L08: TIntegerField;
    FDTOtmpIntegerField3R08: TIntegerField;
    FDTOtmpIntegerField3L09: TIntegerField;
    FDTOtmpIntegerField3R09: TIntegerField;
    FDTOtmpIntegerField3L10: TIntegerField;
    FDTOtmpIntegerField3R10: TIntegerField;
    FDTOtmpIntegerField3L11: TIntegerField;
    FDTOtmpIntegerField3R11: TIntegerField;
    FDTOtmpIntegerField3L12: TIntegerField;
    FDTOtmpIntegerField3R12: TIntegerField;
    FDTOtmpIntegerField3L13: TIntegerField;
    FDTOtmpIntegerField3R13: TIntegerField;
    FDTOtmpIntegerField3L14: TIntegerField;
    FDTOtmpIntegerField3R14: TIntegerField;
    FDTOtmpIntegerField3L15: TIntegerField;
    FDTOtmpIntegerField3R15: TIntegerField;
    FDTOtmpIntegerField3L16: TIntegerField;
    FDTOtmpIntegerField3R16: TIntegerField;
    FDTOtmpKR3: TBooleanField;
    FDTOtmpIntegerField4L01: TIntegerField;
    FDTOtmpIntegerField4R01: TIntegerField;
    FDTOtmpIntegerField4L02: TIntegerField;
    FDTOtmpIntegerField4R02: TIntegerField;
    FDTOtmpIntegerField4L03: TIntegerField;
    FDTOtmpIntegerField4R03: TIntegerField;
    FDTOtmpIntegerField4L04: TIntegerField;
    FDTOtmpIntegerField4R04: TIntegerField;
    FDTOtmpIntegerField4L05: TIntegerField;
    FDTOtmpIntegerField4R05: TIntegerField;
    FDTOtmpIntegerField4L06: TIntegerField;
    FDTOtmpIntegerField4R06: TIntegerField;
    FDTOtmpIntegerField4L07: TIntegerField;
    FDTOtmpIntegerField4R07: TIntegerField;
    FDTOtmpIntegerField4L08: TIntegerField;
    FDTOtmpIntegerField4R08: TIntegerField;
    FDTOtmpKR4: TBooleanField;
    FDTOtmpIntegerField5L01: TIntegerField;
    FDTOtmpIntegerField5R01: TIntegerField;
    FDTOtmpIntegerField5L02: TIntegerField;
    FDTOtmpIntegerField5R02: TIntegerField;
    FDTOtmpIntegerField5L03: TIntegerField;
    FDTOtmpIntegerField5R03: TIntegerField;
    FDTOtmpIntegerField5L04: TIntegerField;
    FDTOtmpIntegerField5R04: TIntegerField;
    FDTOtmpKR5: TBooleanField;
    FDTOtmpIntegerField6L01: TIntegerField;
    FDTOtmpIntegerField6R01: TIntegerField;
    FDTOtmpIntegerField6L02: TIntegerField;
    FDTOtmpIntegerField6R02: TIntegerField;
    sBtnCopy: TSpeedButton;
    tiDraw: TTabItem;
    chTAdraw: TChangeTabAction;
    rectangle10: TRectangle;
    sBtnDrawBack: TSpeedButton;
    label9: TLabel;
    gridPanelLayout3: TGridPanelLayout;
    lot_1: TLabel;
    lot_2: TLabel;
    layout37: TLayout;
    layout38: TLayout;
    sot1: TNumberBox;
    sot2: TNumberBox;
    score1: TLabel;
    score2: TLabel;
    layout39: TLayout;
    sBtnDraw: TCornerButton;
    gridPanelLayout4: TGridPanelLayout;
    img1: TImage;
    img2: TImage;
    sBtnTbl: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sBtnExitClick(Sender: TObject);
    procedure lViewTourUpdatingObjects(const Sender: TObject; const AItem: TListViewItem; var AHandled: Boolean);
    procedure lViewTourItemClickEx(const Sender: TObject;  ItemIndex: Integer;
    const [Ref] LocalClickPos: TPointF;  const ItemObject: TListItemDrawable);  // Непонятная (пока) строка
    procedure sBtnAddClick(Sender: TObject);
    procedure sBtnTcancelClick(Sender: TObject);
    procedure eTnameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure sBtnTbackClick(Sender: TObject);
    procedure sBtnOptClick(Sender: TObject);
    procedure sBtnTsaveClick(Sender: TObject);
    procedure sBtnWbackClick(Sender: TObject);
    procedure sBtnDelClick(Sender: TObject);
    procedure lViewTourButtonClick(const Sender: TObject; const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure lVmatchUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure lVwhoUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure sBtnCCaddClick(Sender: TObject);
    procedure sBtnCCbackClick(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);                                 // *** VK ***
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const [Ref] Bounds: TRect); // *** VK ***
    procedure FormVirtualKeyboardShown( Sender: TObject; KeyboardVisible: Boolean; const [Ref] Bounds: TRect); // *** VK ***
    procedure sBtnCCokClick(Sender: TObject);
    procedure lVwhoItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure sBtnCCdelClick(Sender: TObject);
    procedure sBtnKrugClick(Sender: TObject);
    procedure lVmatchButtonClick(const Sender: TObject; const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure sBtnSbackClick(Sender: TObject);
    procedure sBtnOKClick(Sender: TObject);
    procedure sBtnPlaceClick(Sender: TObject);
    procedure createHTMLkrug(fName: String);
    procedure createHTMLolimp(fName: String);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure eTnameExit(Sender: TObject);
    procedure lblSiteClick(Sender: TObject);
    procedure sBtnOlimpClick(Sender: TObject);
    procedure sBtnCopyClick(Sender: TObject);
    procedure memoTour(iI: integer);
    procedure sBtnDrawClick(Sender: TObject);
    procedure img1Click(Sender: TObject);
  private
    { Private declarations }
//    _city:       String;
    FKBBounds:   TRectF;     // *** VK ***
    FNeedOffset: Boolean;    // *** VK ***
    procedure readTournaments();
    procedure readVersion();
    function  readStatus(const tID: integer): integer;
    procedure readCityClub(const tID: integer);
    procedure readMatch(const tID: integer);
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF); // *** VK ***
    procedure RestorePosition;                                                   // *** VK ***
    procedure UpdateKBBounds;                                                    // *** VK ***
    procedure findWinner(const b: boolean);
    function  twoString(const cn: String): String;
    procedure olimp();
    procedure createPairOlimp(const iKrug: integer; const iLeft: integer; const iRight: integer);
    procedure nextKrug();
    procedure KOvisble(iSt: integer);
    procedure checkDBstructure();
    function  brecket(): String;
  public
    { Public declarations }
  end;

var
  frm:  Tfrm;

implementation

{$R *.fmx}

//uses Thread; // Подключил в верхний uses

procedure Tfrm.eTnameExit(Sender: TObject);
{$IF DEFINED(ANDROID)}
var
  KeyboardService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IF DEFINED(ANDROID)}
  if ((tControl.ActiveTab = tiTedit) and (sBtnTsave.Tag = 5)) or ((tControl.ActiveTab = tiCtCl) and (sBtnCCok.Tag = 5)) then
  begin      // библиотеки  FMX.Platform, FMX.VirtualKeyboard
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
     KeyboardService.HideVirtualKeyboard;
  end;       // Прячу клавиатуру, что-бы очистить ее буфер
{$ENDIF}
end;

procedure Tfrm.eTnameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key  = VKRETURN)  then
  begin
      Key := VKTAB;
      KeyDown(Key, KeyChar, Shift);
  end;
end;

procedure Tfrm.FDConnectionBeforeConnect(Sender: TObject);
begin
{$IF DEFINED(ANDROID)}
  // System.IOUtils; - без этой библиотеки не компилит
	   FDConnection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'compettable.db');
{$ELSEIF defined(MSWINDOWS)}
	   FDConnection.Params.Values['Database'] := 'compettable.db';
{$ENDIF};
end;

procedure Tfrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (FDQuery.Active)         then FDQuery.Close;
  if (FDTpara.Active)         then FDTpara.Close;
  if (FDTbatl.Active)         then FDTbatl.Close;
  if (FDTmpRep.Active)        then FDTmpRep.Close;
  if (FDConnection.Connected) then FDConnection.Connected := false;
end;

procedure Tfrm.FormCreate(Sender: TObject);
begin

  sBtnOpt.Visible    := False; // Временно, пока не готова страничка 'Настройки'

  tControl.ActiveTab := tiTour;
  sBtnAdd.Enabled    := False;
  sBtnRed.Enabled    := False;
  sBtnDel.Enabled    := False;
  sBtnCopy.Enabled   := False;
  memo.Lines.Clear;
  readVersion();     // Версию программы и имя
  try
    FDConnection.Connected := true;
  except
    FDConnection.Tag       := 1;       // Просто пустой оператор
  end;
  if (FDConnection.Connected) then
  begin
    vertScrollBox1.OnCalcContentBounds := CalcContentBoundsProc;                 // *** VK ***
    vertScrollBox2.OnCalcContentBounds := CalcContentBoundsProc;                 // *** VK ***
    aIndic.Visible  := False;
    checkDBstructure();                // Проверка структуры БД, действует со 2-й версии программы
    readTournaments();
    sBtnAdd.Enabled := True;
  end
  else
  begin
    memo.Lines.Add('Error opening database!');
  end;
end;

procedure Tfrm.FormFocusChanged(Sender: TObject);                                // *** VK ***
begin
  UpdateKBBounds;
end;

procedure Tfrm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key   = vkHardwareBack               then  // Обрабатываю кнопку 'назад'
  begin
     Key  := 0;
          if tControl.ActiveTab = tiAbout then chTAtour.ExecuteTarget(tControl)
     else if tControl.ActiveTab = tiCtCl  then chTAmain.ExecuteTarget(tControl)
     else if tControl.ActiveTab = tiMain  then chTAtour.ExecuteTarget(tControl)
     else if tControl.ActiveTab = tiScore then chTAmain.ExecuteTarget(tControl)
     else if tControl.ActiveTab = tiTedit then chTAtour.ExecuteTarget(tControl)
     else if tControl.ActiveTab = tiTour  then Close;
  end;
end;

procedure Tfrm.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
begin                                                                            // *** VK ***
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure Tfrm.FormVirtualKeyboardShown(Sender: TObject;  KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
begin                                                                            // *** VK ***
  FKBBounds             := TRectF.Create(Bounds);
  FKBBounds.TopLeft     := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure Tfrm.img1Click(Sender: TObject);
var    // Пользователь рукой выбрал победителя (при ничейном счете)
  ctr: String;
begin
  if Sender = img1 then
  ctr := 'Confirm: Win ' + lot_1.Text
  else
  ctr := 'Confirm: Win ' + lot_2.Text;
  MessageDlg(ctr,  TMsgDlgType.mtConfirmation,  [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const  AResult: TModalResult)
  var
    dw, dl: double;
    st, os, ty: integer;
  begin
    if  AResult = mrYes    then
    begin
      if (FDQuery.Active)  then   FDQuery.Close;
		  FDQuery.SQL.Text := 'SELECT bwin, bloss, status, stype FROM tournament WHERE tourid=' + IntToStr(rectangle7.Tag);
		  FDQuery.Open;
      dw  :=  FDQuery.FieldByName('bwin').AsFloat;  // Тут может быть только победитель и проигравший
		  dl  :=  FDQuery.FieldByName('bloss').AsFloat;
      st  :=  FDQuery.FieldByName('status').AsInteger;
      ty  :=  FDQuery.FieldByName('stype').AsInteger;
      FDQuery.Close;
      lVmatch.BeginUpdate;
		  FDQuery.SQL.Text := 'UPDATE battle SET letter1=:pL1, letter2=:pL2, winner1=:pW1, winner2=:pW2, finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		  if   Sender       =  img1   then                          // Победа левого
      begin
					 FDQuery.ParamByName('pL1').Value := 'W';
					 FDQuery.ParamByName('pL2').Value := 'L';
					 FDQuery.ParamByName('pW1').Value :=  dw;
					 FDQuery.ParamByName('pW2').Value :=  dl;
					 lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lot_1.TextSettings.FontColor;
           ctr  := lot_1.Text;
      end
		  else                                                      // Победа правого
      begin
					 FDQuery.ParamByName('pL1').Value := 'L';
					 FDQuery.ParamByName('pL2').Value := 'W';
					 FDQuery.ParamByName('pW1').Value :=  dl;
					 FDQuery.ParamByName('pW2').Value :=  dw;
					 lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lot_2.TextSettings.FontColor;
           ctr  := lot_2.Text;
      end;
      lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status'] := FloatToStr(sot1.Value) + ' : ' + FloatToStr(sot2.Value);
      FDQuery.ExecSQL;
      lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Tag := 0;
      lVmatch.EndUpdate;                                        // Обновляю lVmatch
      lVmatch.Resize;
      FDQuery.SQL.Text := 'SELECT COUNT(*) AS kz FROM battle WHERE finish=0 AND krug=' + IntToStr(rectangle6.Tag) + ' AND tourid=' + IntToStr(rectangle7.Tag);
      FDQuery.Open;
         os  :=   FDQuery.FieldByName('kz').AsInteger; // Сколько осталось зафиксировать поединков в круге
      FDQuery.Close;
      if os   = 0 then                  // Завершен круг, а возможно и турнир
      begin
         if   lVmatch.Tag = 1  then     // Зафиксирован финальный поединок, закрытие турнира
         begin
           memo.Lines.Clear;
           memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
           memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail);
           if   ctr.Length     >  0 then
           begin
	              FDQuery.SQL.Text := 'UPDATE tournament SET status=3, winner=' + chr(39) + ctr + chr(39) + ' WHERE tourid=' + IntToStr(rectangle7.Tag);
                memo.Lines.Add(     'Finished. Winner: ' + ctr);
           end;
	         FDQuery.ExecSQL;             // Ставлю метку - "Турнир завершен"
	         lViewTour.BeginUpdate;
           lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Data['status']              := 'finished';
	         lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat := ty + 90; // Признак - турнир закрыт
	         lViewTour.EndUpdate;
           lViewTour.Resize;
{$IF DEFINED(ANDROID)}
           ToastMsg('The tournament is closed.');
{$ELSEIF defined(MSWINDOWS)}
           ShowMessage('The tournament is closed.');
{$ENDIF};
         end
         else                           // Завершен очередной круг, надо формировать следующий
         begin
           nextKrug();
           readMatch(rectangle7.Tag);   // lVmatch  не обновляю, просто перепрочитываю заново
         end;                           // Возможно здесь надо поднимать список вверх!!!
      end
      else if st < 2 then               // Еще не было зафиксировано ни одного поединка
      begin
	      FDQuery.SQL.Text  := 'UPDATE tournament SET status=2 WHERE tourid=' + IntToStr(rectangle7.Tag);
	      FDQuery.ExecSQL;                // Хотя бы один бой уже проведен
        KOvisble(2);                    // Если хоть 1 бой турнира зафиксирован,
      end;                              // блокирую добавить, редактировать, удалить и создать таблицу
      chTAmain.ExecuteTarget(tControl); // Меню матчей
    end;                                // Ответили YES (подтверждение счета)
  end);
end;

procedure Tfrm.lblSiteClick(Sender: TObject);
{$IF DEFINED(ANDROID)}
var
  Intent: JIntent;
{$ENDIF}
begin
{$IF DEFINED(ANDROID)}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI('http://www.stokrat.ru'));
  SharedActivity.startActivity(Intent);
{$ENDIF}
end;

procedure Tfrm.lViewTourButtonClick(const Sender: TObject; const AItem: TListItem; const AObject: TListItemSimpleControl);
var
  sT: integer;
begin
  sT  := StrToInt(AObject.TagFloat.ToString()); // Тип турнира
  readCityClub(lViewTour.Items.AppearanceItem[AItem.Index].Tag);
	if (sT = 1) or (sT = 91)     then             // Командные соревнования
  begin
		sBtnCCadd.ImageIndex    := 7;
		sBtnCCred.ImageIndex    := 8;
		sBtnCCdel.ImageIndex    := 9;
		lPeople.Visible         := false;
	  eClub.KillFocusByReturn := true;
  end
	else                                          // Личное первенство
	begin
		sBtnCCadd.ImageIndex    := 10;
		sBtnCCred.ImageIndex    := 11;
		sBtnCCdel.ImageIndex    := 12;
		lPeople.Visible         := True;
		eClub.KillFocusByReturn := False;
  end;
  rectangle7.Tag            := lViewTour.Items.AppearanceItem[AItem.Index].Tag; // ID текущего турнира
end;

procedure Tfrm.lViewTourItemClickEx(const Sender: TObject; ItemIndex: Integer; const [Ref] LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
//var
//  s, t: integer;
begin
  sBtnRed.Enabled    := True;
  sBtnDel.Enabled    := True;
  sBtnCopy.Enabled   := True;
  if ItemObject is TListItemTextButton then // Этот IF отрабатывает ПОСЛЕ lViewTourButtonClick (В Си работало более логично!!!)
  begin
    tCmain.ActiveTab := tiWho;
 		chTAmain.ExecuteTarget(tControl);       // Меню матчей
  end
  else
  begin
  memoTour(ItemIndex);
  end;
end;

procedure Tfrm.lViewTourUpdatingObjects(const Sender: TObject; const AItem: TListViewItem; var AHandled: Boolean);
var
  TextObject: TListItemText;
begin
  TextObject    := AItem.Objects.FindDrawable('status') As TListItemText;
  if (TextObject = nil)  then
  begin
    TextObject               :=  TListItemText.Create(AItem);
    TextObject.Name          := 'status';
  end;
  if (TextObject.Text = 'finished') then
  begin
    TextObject.PlaceOffset.X := lViewTour.Width - 142;
    TextObject.PlaceOffset.Y := 22;
    TextObject.Font.Size     := AItem.Objects.DetailObject.Font.Size;
    TextObject.TextColor     := $FFFF7F7F;
  end
end;

procedure Tfrm.lVmatchButtonClick(const Sender: TObject; const AItem: TListItem; const AObject: TListItemSimpleControl);
begin     // Если  поединок уже зафиксирован,  то вход в процедуру невозможен
  if lVmatch.Items.AppearanceItem[AItem.Index].Objects.TextButton.Text  = 'match' then
  begin
    sBtnSback.Tag    :=  lVmatch.Items.AppearanceItem[AItem.Index].Tag; // Запоминаю номер записи фиксируемого поединка
    if (FDQuery.Active)  then   FDQuery.Close;
    FDQuery.SQL.Text := 'SELECT points1, points2, otime1, otime2, draw FROM battle WHERE btid=' + IntToStr(sBtnSback.Tag);
    FDQuery.Open;
    if FDQuery.FieldByName('draw').AsBoolean then // Была зафиксирована ничья в основное время, нужен overTime,
    begin                                         // далее возможно ручное назначение победителя
      lot_1.Text       :=  lVmatch.Items.AppearanceItem[AItem.Index].Text;
      lot_2.Text       :=  lVmatch.Items.AppearanceItem[AItem.Index].Detail;
      score1.Text      := 'SCORE [' + FDQuery.FieldByName('otime1').AsString + ']';
      score2.Text      := 'SCORE [' + FDQuery.FieldByName('otime2').AsString + ']';
      if (FDQuery.FieldByName('points1').AsInteger = -1) and (FDQuery.FieldByName('points2').AsInteger = -1) then
      begin                                       // Возможно только в Олимпийской, но здесь я не обрабатываю это отдельно
          label9.Text  := 'Overtime';
          sot1.Value   :=  FDQuery.FieldByName('otime1').AsInteger;
          sot1.Enabled :=  true;
          sot2.Value   :=  FDQuery.FieldByName('otime2').AsInteger;
          sot2.Enabled :=  true;
          FDQuery.Close;
          gridPanelLayout4.Visible := false;
          layout39.Visible         := true;
      end
      else
      begin
          label9.Text  := 'Select the Winner';
          sot1.Value   :=  FDQuery.FieldByName('points1').AsInteger;
          sot1.Enabled :=  false;
          sot2.Value   :=  FDQuery.FieldByName('points2').AsInteger;
          sot2.Enabled :=  false;
          FDQuery.Close;
          layout39.Visible          :=  false;
          gridPanelLayout4.Visible  :=  true;
      end;
      chTAdraw.ExecuteTarget(tControl);           // Форма для OVERTIME
    end
    else                                          // Это простая ветка новой фиксации поединка
    begin
      FDQuery.Close;
      lbl_1.Text  := lVmatch.Items.AppearanceItem[AItem.Index].Text;
      lbl_2.Text  := lVmatch.Items.AppearanceItem[AItem.Index].Detail;
      scor1.Value := 0;
      scor2.Value := 0;
//	  memoKomm->Lines->Clear();
      chTAscore.ExecuteTarget(tControl);
    end;
  end;
end;

procedure Tfrm.lVmatchUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
  TextObject: TListItemText;
begin
  TextObject    := AItem.Objects.FindDrawable('status') As TListItemText;
  if (TextObject = nil)  then
  begin
    TextObject          :=  TListItemText.Create(AItem);
    TextObject.Name     := 'status';
    TextObject.Visible  :=  false;     // Здесь храню счет поединка
  end;
  if (TextObject.Text.Length > 0) then    AItem.Objects.TextButton.Text    := TextObject.Text;
  if (AItem.Tag  = -1)            then    AItem.Objects.TextButton.Visible := false;
  if (AItem.Detail.Length    > 0) then
  AItem.Objects.DetailObject.Font.Size := AItem.Objects.TextObject.Font.Size;
end;

procedure Tfrm.lVwhoItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if (sBtnCCadd.Visible and sBtnCCadd.Enabled) then
  begin
	    sBtnCCred.Enabled :=  True;
	    sBtnCCdel.Enabled :=  True;  // Добавлять, редактировать, удалять можно только до фиксации 1-го боя
  end;
end;

procedure Tfrm.lVwhoUpdateObjects(const   Sender: TObject; const AItem: TListViewItem);
begin
  if (AItem.Text.Length      > 0) then    AItem.Objects.TextObject.Width := lVwho.Width - 50;
end;

procedure Tfrm.memoTour(iI: integer);
var
  s, t: integer;
begin
  memo.Lines.Clear;
  memo.Lines.Add(lViewTour.Items.AppearanceItem[iI].Text);
  memo.Lines.Add(lViewTour.Items.AppearanceItem[iI].Detail);
  t := lViewTour.Items.AppearanceItem[iI].Tag;
  s := readStatus(t);
  case s of
  0 :  memo.Lines.Add('Registration of participants.');
  1 :  memo.Lines.Add('Preliminary sortition.');
  2 :  begin
        if (FDQuery.Active)  then   FDQuery.Close;
        FDQuery.SQL.Text := 'SELECT COUNT(*) AS ost FROM battle WHERE finish=0 AND tourid=' + IntToStr(t);
        FDQuery.Open;    //  Осталось провести поединков в текущем турнире
        memo.Lines.Add(FDQuery.FieldByName('ost').AsString + ' matches remain.');
        FDQuery.Close;
       end;
  3 :  begin
        if (FDQuery.Active)  then   FDQuery.Close;
        FDQuery.SQL.Text := 'SELECT winner FROM tournament WHERE tourid=' + IntToStr(t);
        FDQuery.Open;    //  Вынимаю победителя турнира
        memo.Lines.Add('Finished. Winner: ' + FDQuery.FieldByName('winner').AsString);
        FDQuery.Close;
       end;
  end;
end;

procedure Tfrm.readTournaments();
var
  lvItem: TListViewItem;
begin
  if (FDQuery.Active)  then   FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT tourid, name, tourbeg, city, stype, status FROM tournament ORDER BY tourid DESC';
  FDQuery.Open;
  lViewTour.BeginUpdate;
  lViewTour.Items.Clear;
  while not FDQuery.Eof do
  begin
    lvItem        := lViewTour.Items.Add;
    lvItem.Text   := FDQuery.FieldByName('name').AsString;
    lvItem.Tag    := FDQuery.FieldByName('tourid').AsInteger;
    lvItem.Detail := FDQuery.FieldByName('tourbeg').AsString + ' ' + FDQuery.FieldByName('city').AsString;
    lvItem.Data['status']   := '';
    if (FDQuery.FieldByName('status').AsInteger = 3) then
    begin
        lvItem.Data['status']              := 'finished';
			  lvItem.Objects.TextButton.TagFloat := FDQuery.FieldByName('stype').AsInteger + 90; // Признак - турнир закрыт
    end
    else
    begin
			  lvItem.Objects.TextButton.TagFloat := FDQuery.FieldByName('stype').AsInteger;     // 1 - team; 2 - personal
    end;
    FDQuery.Next;
  end;
  FDQuery.Close;
  lViewTour.EndUpdate;
  lViewTour.Resize;
end;

procedure Tfrm.sBtnAddClick(Sender: TObject);
begin
      sBtnTsave.Tag    := TSpeedButton(Sender).Tag;              // if Sender = sBtnAdd then k := 1; --- Как пример Sender
  if (sBtnTsave.Tag     = 5) then // Добавить новый турнир
  begin
    btnTkeyb.Visible   := True;
    layout0.Visible    := True;   // При вводе нового турнира всегда доступны кнопки OK & Cancel
	  eTname.Text        := '';
	  eTname.ReadOnly    := False;
	  eTcountry.Text     := '';
	  eTcountry.ReadOnly := False;
	  eTregion.Text      := '';
	  eTregion.ReadOnly  := False;
	  eTcity.Text        := '';
	  eTcity.ReadOnly    := False;
	  dEprov.Date        := Date();
	  dEprov.ReadOnly    := False;
	  eTchief.Text       := '';
	  eTchief.ReadOnly   := False;
	  eTsecret.Text      := '';
	  eTsecret.ReadOnly  := False;
	  nBox1.Value        := 3;      // 1;           ПОБЕДА
	  nBox1.Enabled      := True;
	  nBox2.Value        := 1;      // (double)1/2; НИЧЬЯ
	  nBox2.Enabled      := True;
	  nBox3.Value        := 0;      //              ПОРАЖЕНИЕ
	  nBox3.Enabled      := True;   //              НЕВЫХОД здесь не вывожу на экран, просто присваиваю 0 в алгоритме
	  rBtn1.Enabled      := True;
	  rBtn2.Enabled      := True;
  end
  else
  begin
    if (FDQuery.Active)   then      FDQuery.Close;
    FDQuery.SQL.Text   := 'SELECT * FROM tournament WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
    FDQuery.Open;
    btnTkeyb.Visible   := (FDQuery.FieldByName('status').AsInteger < 2);
    layout0.Visible    := (FDQuery.FieldByName('status').AsInteger < 2); // Редактор открыт только до первого поединка
	  eTname.Text        :=  FDQuery.FieldByName('name').AsString;
	  eTname.ReadOnly    := Not layout0.Visible;
	  eTcountry.Text     := FDQuery.FieldByName('country').AsString;
	  eTcountry.ReadOnly := Not layout0.Visible;
	  eTregion.Text      := FDQuery.FieldByName('region').AsString;
	  eTregion.ReadOnly  := Not layout0.Visible;
	  eTcity.Text        := FDQuery.FieldByName('city').AsString;
	  eTcity.ReadOnly    := Not layout0.Visible;
	  dEprov.Date        := FDQuery.FieldByName('tourbeg').AsDateTime;
	  dEprov.ReadOnly    := Not layout0.Visible;
	  eTchief.Text       := FDQuery.FieldByName('referee').AsString;
	  eTchief.ReadOnly   := Not layout0.Visible;
	  eTsecret.Text      := FDQuery.FieldByName('secretary').AsString;
	  eTsecret.ReadOnly  := Not layout0.Visible;
	  nBox1.Value        := FDQuery.FieldByName('bwin').AsFloat;
	  nBox1.Enabled      := layout0.Visible;
	  nBox2.Value        := FDQuery.FieldByName('bdraw').AsFloat;
	  nBox2.Enabled      := layout0.Visible;
	  nBox3.Value        := FDQuery.FieldByName('bloss').AsFloat;
	  nBox3.Enabled      := layout0.Visible;
    case FDQuery.FieldByName('stype').AsInteger of
     1 : rBtn1.IsChecked  := True;
     2 : rBtn2.IsChecked  := True;
    end;
	  rBtn1.Enabled      := layout0.Visible;
	  rBtn2.Enabled      := layout0.Visible;
    FDQuery.Close;
  end;
	frm.Tag  := 1;       // Форма ввода/редактора турнира
  chTAtedit.ExecuteTarget(tControl);
end;

procedure Tfrm.sBtnCCaddClick(Sender: TObject);
var
  k: integer;
begin
       sBtnCCok.Tag := TSpeedButton(Sender).Tag;
  if ((sBtnCCok.Tag  = 5) and (lVwho.Items.Count >= 32)) then
  begin
       MessageDlg('The number of participants should be from 2 to 32', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
	     eTname.SetFocus;
	     exit;
  end;
  if   lPeople.Visible   then eClub.TextPrompt := 'Club(Team)*'   //   Личное первенство
  else                        eClub.TextPrompt := 'Participant*'; //   Командные соревнования
  if  (FDQuery.Active)   then FDQuery.Close;
  if  (sBtnCCok.Tag = 5) then
  begin
	  k := 0;
    FDQuery.SQL.Text := 'SELECT MAX(tournum) AS mtn FROM fighters WHERE tourid=' + IntToStr(rectangle7.Tag);
    FDQuery.Open;    //  При вводе сразу узнаю максимальный турнирный номер, чтобы присвоить следующий
    try
      k    := FDQuery.FieldByName('mtn').AsInteger;
    except
	    k    := 0;
    end;
	  FDQuery.Close;
    btnCCkeyb.Tag := k + 1;
	  if Not lPeople.Visible then
    begin
		  eClub.Text  := '';   // Если ввожу личку, то клуб не стираю. Если командные, то стираю
    end
    else
    begin
		  eFam.Text   := '';
		  eImia.Text  := '';
		  eOtch.Text  := '';
		  eRank.Text  := '';
		  eCoach.Text := '';
    end;
  end
  else
  begin
	  FDQuery.SQL.Text := 'SELECT city, sclub, tournum, fam, imia, otch, dr, sex, rank, coach FROM fighters WHERE fgid=' + IntToStr(lVwho.Items.AppearanceItem[lVwho.ItemIndex].Tag);
	  FDQuery.Open;
	  eCity.Text       :=  FDQuery.FieldByName('city').AsString;
	  eClub.Text       :=  FDQuery.FieldByName('sclub').AsString;
	  if lPeople.Visible   then
    begin
		  eFam.Text   := FDQuery.FieldByName('fam').AsString;
		  eImia.Text  := FDQuery.FieldByName('imia').AsString;
		  eOtch.Text  := FDQuery.FieldByName('otch').AsString;
		  eRank.Text  := FDQuery.FieldByName('rank').AsString;
		  eCoach.Text := FDQuery.FieldByName('coach').AsString;
		  deDR.Date   := FDQuery.FieldByName('dr').AsDateTime;
		  if  (FDQuery.FieldByName('sex').AsBoolean) then
      begin
				   rBwom.IsChecked  := False;
					 rBman.IsChecked  := True;
      end
		  else
		  begin
					 rBman.IsChecked  := False;
					 rBwom.IsChecked  := True;
      end;
    end;
	  FDQuery.Close;
  end;
  chTActcl.ExecuteTarget(tControl);
end;

procedure Tfrm.sBtnCCbackClick(Sender: TObject);
begin
  chTAmain.ExecuteTarget(tControl); // Меню матчей
end;

procedure Tfrm.sBtnCCdelClick(Sender: TObject);
var
  ctr: String;
begin
  ctr := 'To delete a record?';
  MessageDlg(ctr, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult  = mrYes    then
    begin
      if (FDQuery.Active)  then FDQuery.Close;
		  FDQuery.SQL.Text := 'DELETE FROM fighters WHERE fgid=' + IntToStr(lVwho.Items.AppearanceItem[lVwho.ItemIndex].Tag);
		  FDQuery.ExecSQL;
		  lVwho.BeginUpdate;
		  lVwho.Items.Delete(lVwho.ItemIndex);
		  lVwho.EndUpdate;
	    if (lVmatch.Visible)   then
      begin
		    lVmatch.Visible  :=  False;
		    FDQuery.SQL.Text := 'UPDATE tournament SET status=0 WHERE tourid=' + IntToStr(rectangle7.Tag);
		    FDQuery.ExecSQL;
      end;
 	    sBtnKrug.Enabled   :=  True;
 	    sBtnOlimp.Enabled  :=  True;
		  sBtnCCred.Enabled  := False;
		  sBtnCCdel.Enabled  := False;
    end;
  end);
end;

procedure Tfrm.sBtnCCokClick(Sender: TObject);
var
  ctr: String;
  mig: integer;
  lvItem: TListViewItem;
begin
  if (eCity.Text.Trim.Length = 0) then
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('Required field!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Required field!');
{$ENDIF};
	   eCity.SetFocus;
	   exit;
  end;
  if (eClub.Text.Trim.Length = 0) then
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('Required field!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Required field!');
{$ENDIF};
	   eClub.SetFocus;
	   exit;
  end;
  if (lPeople.Visible) and (eImia.Text.Trim.Length = 0) then
  begin    // В личном типе соревнований, имя - обязательное поле
{$IF DEFINED(ANDROID)}
     ToastMsg('Required field!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Required field!');
{$ENDIF};
	   eImia.SetFocus;
	   exit;
  end;
  if (lPeople.Visible) and (eFam.Text.Trim.Length  = 0) then
  begin    // В личном типе соревнований, фамилия - обязательное поле
{$IF DEFINED(ANDROID)}
     ToastMsg('Required field!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Required field!');
{$ENDIF};
	   eFam.SetFocus;
	   exit;
  end;
  ctr := '';
  if Not lPeople.Visible   then // В командном первенстве комбинация город+клуб должна быть уникальна в пределах турнира
  begin
    if  (FDQuery.Active)   then FDQuery.Close;
	  FDQuery.SQL.Text :=   'SELECT fgid FROM fighters WHERE UPPER(city)=' + chr(39) + UpperCase(eCity.Text) + chr(39) + ' AND UPPER(sclub)=' + chr(39) + UpperCase(eClub.Text) + chr(39) + ' AND tourid=' + IntToStr(rectangle7.Tag);
{*
    Важное замечание! Здесь для проверки повторного ввода применил в SQL-запросе перевод стринговых полей в верхний регистр.
    Замечено, что на моей БД только английское содержимое поддалось переводу в верхний (нижний регистр)
    т.е. для русской кодировки перевода регистра не произойдет - ОШИБКА!!! Для остальных кодировок надо проверять!!!
*}
	  if  (sBtnCCok.Tag = 6) then
    FDQuery.SQL.Text :=    FDQuery.SQL.Text  + ' AND fgid<>' + IntToStr(lVwho.Items.AppearanceItem[lVwho.ItemIndex].Tag);
	  FDQuery.Open;
	  if (FDQuery.RecordCount  > 0)  then ctr := 'Such pair ''city and participant'' already are in tournament!';
	  FDQuery.Close;
	  if (ctr.Length > 0)    then
    begin
{$IF DEFINED(ANDROID)}
     ToastMsg(ctr);
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage(ctr);
{$ENDIF};
		 exit;
    end;
	      ctr := eClub.Text + ' (' + eCity.Text + ')';
  end
  else  ctr := eImia.Text + ' '  + eFam.Text; // В английском варианте Имя + Фамилия (не проверяю уникальность, т.к. полные тезки допустимы)
  if   (FDQuery.Active)   then FDQuery.Close;
	if   (sBtnCCok.Tag = 5) then                // Ввод
  begin
	  if (lPeople.Visible)  then
    begin
		   FDQuery.SQL.Text := 'INSERT INTO fighters (tourid, name, city, sclub, tournum, fam, imia, otch, dr, sex, rank, coach) VALUES (' + IntToStr(rectangle7.Tag) + ', ' + chr(39) + ctr + chr(39) + ', ' + chr(39) + eCity.Text + chr(39) + ', ' + chr(39) + eClub.Text + chr(39) + ', ' + IntToStr(btnCCkeyb.Tag) + ', :pF, :pI, :pO, :pD, :pS, :pR, :pT)';
		   FDQuery.ParamByName('pF').Value  := eFam.Text;
		   FDQuery.ParamByName('pI').Value  := eImia.Text;
		   FDQuery.ParamByName('pO').Value  := eOtch.Text;
		   FDQuery.ParamByName('pD').AsDate := deDR.Date;
		   if (rBman.IsChecked) then FDQuery.ParamByName('pS').Value := 1
		   else                      FDQuery.ParamByName('pS').Value := 0;
		   FDQuery.ParamByName('pR').Value  := eRank.Text;
		   FDQuery.ParamByName('pT').Value  := eCoach.Text;
    end
	  else
    begin
    FDQuery.SQL.Text := 'INSERT INTO fighters (tourid, name, city, sclub, tournum) VALUES (' + IntToStr(rectangle7.Tag) + ', ' + chr(39) + ctr + chr(39) + ', ' + chr(39) + eCity.Text + chr(39) + ', ' + chr(39) + eClub.Text + chr(39) + ', ' + IntToStr(btnCCkeyb.Tag) + ')';
    end;
	  FDQuery.ExecSQL;
	  FDQuery.SQL.Text := 'SELECT MAX(fgid) AS mg FROM fighters';
	  FDQuery.Open;
	  mig  := FDQuery.FieldByName('mg').AsInteger;  // Номер введенной записи
	  FDQuery.Close;
	  lVwho.BeginUpdate;
    lvItem          := lVwho.Items.Add;
    lvItem.Text     := ctr;
    lvItem.Detail   := IntToStr(btnCCkeyb.Tag);
    lvItem.Tag      := mig;
	  lVwho.EndUpdate;
  end
  else                                         // Редактор
  begin
	  if (lPeople.Visible)   then
    begin
		   FDQuery.SQL.Text := 'UPDATE fighters SET name=' + chr(39) + ctr + chr(39) + ', city=' + chr(39) + eCity.Text + chr(39) + ', sclub=' + chr(39) + eClub.Text + chr(39) + ', fam=:pF, imia=:pI, otch=:pO, dr=:pD, sex=:pS, rank=:pR, coach=:pT WHERE fgid=' + IntToStr(lVwho.Items.AppearanceItem[lVwho.ItemIndex].Tag);
		   FDQuery.ParamByName('pF').Value  := eFam.Text;
		   FDQuery.ParamByName('pI').Value  := eImia.Text;
		   FDQuery.ParamByName('pO').Value  := eOtch.Text;
		   FDQuery.ParamByName('pD').AsDate := deDR.Date;
		   if (rBman.IsChecked) then FDQuery.ParamByName('pS').Value := 1
		   else                      FDQuery.ParamByName('pS').Value := 0;
		   FDQuery.ParamByName('pR').Value  := eRank.Text;
		   FDQuery.ParamByName('pT').Value  := eCoach.Text;
    end
	  else FDQuery.SQL.Text := 'UPDATE fighters SET name=' + chr(39) + ctr + chr(39) + ', city=' + chr(39) + eCity.Text + chr(39) + ', sclub=' + chr(39) + eClub.Text + chr(39) + ' WHERE fgid=' + IntToStr(lVwho.Items.AppearanceItem[lVwho.ItemIndex].Tag);
	  FDQuery.ExecSQL;
	  if (lVwho.Items.AppearanceItem[lVwho.ItemIndex].Text <> ctr) then // Если отредактировали поля участвующие в listView.Text
    begin
		   lVwho.BeginUpdate;
		   lVwho.Items.AppearanceItem[lVwho.ItemIndex].Text  := ctr;
		   lVwho.EndUpdate;
    end;
  end;
	if (lVmatch.Visible)    then
  begin
		lVmatch.Visible   :=  False;
		FDQuery.SQL.Text  := 'UPDATE tournament SET status=0 WHERE tourid=' + IntToStr(rectangle7.Tag);
		FDQuery.ExecSQL;
		sBtnKrug.Enabled  :=  True;     // И в том и в другом случае, стираю метку СТАТУСА в ноль
 	  sBtnOlimp.Enabled :=  True;
  end;
  chTAmain.ExecuteTarget(tControl); // Меню матчей
end;

procedure Tfrm.sBtnCopyClick(Sender: TObject);
var
  ctr: String;
  mit: integer;
begin
  ctr := 'Do You want duplicate tournament data?';
  MessageDlg(ctr, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult  = mrYes    then
    begin
      if (FDQuery.Active)  then   FDQuery.Close;
      FDQuery.SQL.Text := 'SELECT name FROM tournament WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
	    FDQuery.Open;
         ctr         := FDQuery.FieldByName('name').AsString;      // Наименование клонируемого турнира,
      if ctr.Length  >  FDQuery.FieldByName('name').Size - 5  then // длина не должна превышать максимальную - 5 (для номера)
      begin
{$IF DEFINED(ANDROID)}
         ctr         := ctr.Substring(0, FDQuery.FieldByName('name').Size - 5);
{$ELSEIF defined(MSWINDOWS)}
         ctr         := ctr.Substring(1, FDQuery.FieldByName('name').Size - 5);
{$ENDIF};
      end;
	    FDQuery.Close;
      mit  := 2;
      FDQuery.SQL.Text := 'SELECT COUNT(*) AS kol FROM tournament WHERE name = :pNM';
      while   True  do
      begin
		  FDQuery.ParamByName('pNM').AsString := ctr + '[' + intToStr(mit) + ']';
	    FDQuery.Open;
        if (FDQuery.FieldByName('kol').AsInteger > 0) then
        begin
            FDQuery.Close;
            Inc(mit);
        end
        else
        begin
            ctr := FDQuery.ParamByName('pNM').AsString;
	          FDQuery.Close;
            break;
        end;
      end;             //  Пришлось записать текст запроса двумя частями, т.к. в одну сторку нельзя записать более 255 символов
      FDQuery.SQL.Text := 'INSERT INTO tournament (name, country, region, city, tourbeg, referee, secretary, bwin, bdraw, bloss, bdef, stype) ';
      FDQuery.SQL.Text :=  FDQuery.SQL.Text + 'SELECT "' + ctr + '" AS name, country, region, city, :pTB AS tourbeg, referee, secretary, bwin, bdraw, bloss, bdef, stype FROM tournament WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
		  FDQuery.ParamByName('pTB').AsDate := Date(); // К сожалению TFDQuery не может передать CURRENT_DATE, приходится через параметр
      FDQuery.ExecSQL;
      if (FDQuery.Active)  then   FDQuery.Close;
	    FDQuery.SQL.Text := 'SELECT MAX(tourid) AS mt FROM tournament';
	    FDQuery.Open;
	    mit := FDQuery.FieldByName('mt').AsInteger; // Номер введенной записи
	    FDQuery.Close;
      FDQuery.SQL.Text := 'INSERT INTO fighters (tourid, name, city, sclub, tournum, fam, imia, otch, dr, sex, rank, coach) ';
      FDQuery.SQL.Text :=  FDQuery.SQL.Text + 'SELECT ' + IntToStr(mit) + ', name, city, sclub, tournum, fam, imia, otch, dr, sex, rank, coach FROM fighters WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
      FDQuery.ExecSQL;          // Добавляю команды или участников
      readTournaments();        // Перепрочитываю список турниров
      lViewTour.ItemIndex := 0; // Выделяю первый (только что введенный) турнир
      memoTour(0);              // Отражаю его параметры в мемо-поле
{$IF  DEFINED(ANDROID)}
      ToastMsg('Турнир скопирован.');
{$ELSEIF defined(MSWINDOWS)}
      ShowMessage('Турнир клонирован.');
{$ENDIF};
    end;
  end);
end;

procedure Tfrm.sBtnDelClick(Sender: TObject);
var
  ctr: String;
begin
  ctr := 'Confirm the deletion: ' + lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text;
  MessageDlg(ctr, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult  = mrYes    then
    begin
      if (FDQuery.Active)  then FDQuery.Close;
		  FDQuery.SQL.Text := 'DELETE FROM battle WHERE tourid='     + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
		  FDQuery.ExecSQL();       // Сначала удаляю поединки
			FDQuery.SQL.Text := 'DELETE FROM fighters WHERE tourid='   + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
			FDQuery.ExecSQL();       // Затем удаляю участников
			FDQuery.SQL.Text := 'DELETE FROM tournament WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
			FDQuery.ExecSQL();       // В конуе удаляю сам турнир
			memo.Lines.Clear;
			memo.Lines.Add('Removed tournament: ' + lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
			FDQuery.SQL.Text := 'vacuum;';
			FDQuery.ExecSQL();       // Сжатие БД SQLite после удаления (в данной версии это единственное место сжатия БД)
			lViewTour.BeginUpdate();
			lViewTour.Items.Delete(lViewTour.ItemIndex);
			lViewTour.EndUpdate();   // Удаляю запись из списка
			sBtnRed.Enabled  := False;
			sBtnDel.Enabled  := False;
      sBtnCopy.Enabled := False;
    end;
  end);
end;

procedure Tfrm.sBtnDrawClick(Sender: TObject); // OK на OVERTIME
var
  ctr: String;
begin
  sot1.Value :=  StrToInt(sot1.Text); // К сожалению Text не всегда обновляет Value, делаю вручную
  sot2.Value :=  StrToInt(sot2.Text);
  ctr        := 'Confirm: Score ' + sot1.Text + ' : ' + sot2.Text;
  MessageDlg(ctr, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  var
    dw, dl: double;
    st, os, ty: integer;
  begin
    if  AResult = mrYes           then
    begin
      if (FDQuery.Active)         then    FDQuery.Close;
		  if  sot1.Value = sot2.Value then // Ничья в дополнительное время (бывает только в ОЛИМПИЙСКОЙ)
      begin                            // Здесь предлагается выбор победителя "вручную"
        label9.Text               := 'Select the Winner';
        sot1.Enabled              :=  false;
        sot2.Enabled              :=  false;
        layout39.Visible          :=  false;
		    FDQuery.SQL.Text := 'UPDATE battle SET points1=:pP1, points2=:pP2 WHERE btid=' + IntToStr(sBtnSback.Tag);
		    FDQuery.ParamByName('pP1').Value := sot1.Value;  //  Раз счет подтвердили, фиксирую его как окончательный
		    FDQuery.ParamByName('pP2').Value := sot2.Value;  //  Но только сам счет, победителя надо выбрать потом
        FDQuery.ExecSQL;
        gridPanelLayout4.Visible  :=  true;
      end
      else
      begin
		    FDQuery.SQL.Text := 'SELECT bwin, bloss, status, stype FROM tournament WHERE tourid=' + IntToStr(rectangle7.Tag);
		    FDQuery.Open;
        dw  :=  FDQuery.FieldByName('bwin').AsFloat;              // После дополнительного времени
		    dl  :=  FDQuery.FieldByName('bloss').AsFloat;             // не будет ни ничьи ни невыхода
        st  :=  FDQuery.FieldByName('status').AsInteger;
        ty  :=  FDQuery.FieldByName('stype').AsInteger;
        FDQuery.Close;
        lVmatch.BeginUpdate;
		    FDQuery.SQL.Text := 'UPDATE battle SET points1=:pP1, points2=:pP2, letter1=:pL1, letter2=:pL2, winner1=:pW1, winner2=:pW2, finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		    FDQuery.ParamByName('pP1').Value    := sot1.Value;
		    FDQuery.ParamByName('pP2').Value    := sot2.Value;
		    if sot1.Value > sot2.Value then                           // Победа левого
        begin
					 FDQuery.ParamByName('pL1').Value := 'W';
					 FDQuery.ParamByName('pL2').Value := 'L';
					 FDQuery.ParamByName('pW1').Value :=  dw;
					 FDQuery.ParamByName('pW2').Value :=  dl;
					 lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lot_1.TextSettings.FontColor;
           ctr  := lot_1.Text;
        end
		    else                                                      // Победа правого
        begin
					 FDQuery.ParamByName('pL1').Value := 'L';
					 FDQuery.ParamByName('pL2').Value := 'W';
					 FDQuery.ParamByName('pW1').Value :=  dl;
					 FDQuery.ParamByName('pW2').Value :=  dw;
					 lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lot_2.TextSettings.FontColor;
           ctr  := lot_2.Text;
        end;
        lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status'] := FloatToStr(sot1.Value) + ' : ' + FloatToStr(sot2.Value);
        FDQuery.ExecSQL;
        lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Tag := 0;
        lVmatch.EndUpdate;                                        // Обновляю lVmatch
        lVmatch.Resize;
        FDQuery.SQL.Text := 'SELECT COUNT(*) AS kz FROM battle WHERE finish=0 AND krug=' + IntToStr(rectangle6.Tag) + ' AND tourid=' + IntToStr(rectangle7.Tag);
        FDQuery.Open;
           os  :=   FDQuery.FieldByName('kz').AsInteger; // Сколько осталось зафиксировать поединков в круге
        FDQuery.Close;
        if os   = 0 then                  // Завершен круг, а возможно и турнир
        begin
           if   lVmatch.Tag = 1  then     // Зафиксирован финальный поединок, закрытие турнира
           begin
             memo.Lines.Clear;
             memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
             memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail);
             if   ctr.Length     >  0 then
             begin
	                FDQuery.SQL.Text := 'UPDATE tournament SET status=3, winner=' + chr(39) + ctr + chr(39) + ' WHERE tourid=' + IntToStr(rectangle7.Tag);
                  memo.Lines.Add(     'Finished. Winner: ' + ctr);
             end;
	           FDQuery.ExecSQL;             // Ставлю метку - "Турнир завершен"
	           lViewTour.BeginUpdate;
             lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Data['status']              := 'finished';
	           lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat := ty + 90; // Признак - турнир закрыт
	           lViewTour.EndUpdate;
             lViewTour.Resize;
{$IF DEFINED(ANDROID)}
             ToastMsg('The tournament is closed.');
{$ELSEIF defined(MSWINDOWS)}
             ShowMessage('The tournament is closed.');
{$ENDIF};
           end
           else                           // Завершен очередной круг, надо формировать следующий
           begin
             nextKrug();
             readMatch(rectangle7.Tag);   // lVmatch  не обновляю, просто перепрочитываю заново
           end;                           // Возможно здесь надо поднимать список вверх!!!
        end
        else if st < 2 then               // Еще не было зафиксировано ни одного поединка
        begin
	        FDQuery.SQL.Text  := 'UPDATE tournament SET status=2 WHERE tourid=' + IntToStr(rectangle7.Tag);
	        FDQuery.ExecSQL;                // Хотя бы один бой уже проведен
          KOvisble(2);                    // Если хоть 1 бой турнира зафиксирован,
        end;                              // блокирую добавить, редактировать, удалить и создать таблицу
        chTAmain.ExecuteTarget(tControl); // Меню матчей
      end;                                // Тут обрабатывалось все кроме ничьей
    end;                                  // Ответили YES (подтверждение счета)
  end);
end;

procedure Tfrm.sBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm.sBtnKrugClick(Sender: TObject);
var
  sl,   m1,   m2:   TStringList;
  krug, half, y, i: integer;
begin
  if Not sBtnCCadd.Visible then  // Означает, что Status > 1
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('Already have fixed matches!');    // Осталось от версии 1.0.0.0
{$ELSEIF defined(MSWINDOWS)}                     // В версии 1.0.1.0 эти кнопки блокируются программно
     ShowMessage('Already have fixed matches!');
{$ENDIF};
	   exit;     // Алгоритм доступен для работы только для СТАТУСА 0 или 1
  end;
  if (lVwho.ItemCount < 2)  or (lVwho.ItemCount > 32) then
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('The number of participants should be from 2 to 32!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('The number of participants should be from 2 to 32!');
{$ENDIF};
	  exit;
  end;
  sBtnKrug.Tag     :=  1;
  sBtnOlimp.Tag    :=  0;
  if (FDQuery.Active)  then   FDQuery.Close;
  if (FDTpara.Active)  then   FDTpara.Close;
  FDQuery.SQL.Text := 'DELETE FROM olimpair';
  FDQuery.ExecSQL;
  FDQuery.SQL.Text := 'DELETE FROM battle WHERE tourid='        + IntToStr(rectangle7.Tag);
  FDQuery.ExecSQL;                                                              // На всякий случай удаляю записи (их не должно быть) предыдущих боев (для подстраховки)
  FDQuery.SQL.Text := 'SELECT fgid FROM fighters WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.Open;
  sl := TStringList.Create;
  while not FDQuery.Eof do
  begin
    sl.Add(FDQuery.FieldByName('fgid').AsString);                               // Запоминаю в массиве все fgid записей турнира
    FDQuery.Next;
  end;
  FDQuery.Close;
  FDTpara.Open;
  krug  :=    sl.Count;                                                         // Определяю количество кругов в категории
  if    krug  mod 2 =  0 then krug := krug - 1;                                 // Если четное число, то нужно вычесть единицу
  if sl.Count mod 2 <> 0 then sl.Add('0');                                      // Если нечетное количество, добавляю еще одного "0"
  half  :=    Trunc(sl.Count  /  2);                                            // Целая часть от деления. (Всегда будет INT т.к. длина вспомогательных массивов - половина)
  For y := 1  to  krug do                                                       // Цикл для каждого круга. Этот-же цикл в Си -> for (int y = 1; y <=  krug; y++)
  begin
    m1  := TStringList.Create;                                                  // 1-й столбик спортсменов
    m2  := TStringList.Create;                                                  // 2-й столбик спортсменов
    For i :=  0             to     (half - 1)     do m2.Add(sl.Strings[i + 1]); // Заполняю сначала 2-й столбик
	  m1.Add(sl.Strings[0]);                                                      // 1-й спортсмен в 1-й колонке всегда один и тот же
    For i := (sl.Count - 1) downto (half + 1)     do m1.Add(sl.Strings[i]);     // Теперь оставшиеся спортсмены 1-го столбика. C++ ->	for (int i = sl->Count - 1; i > half; i--)
	  For i :=  0             to     (m2.Count - 1) do
    begin
		  FDTpara.Append;
		  FDTpara.FieldByName('idBL').Value := y;                                   // Что-бы не мучиться с вытаскиванием круга, всегда пишу его сюда
		  if (m1.Strings[i] <> '0') then FDTpara.FieldByName('idAL').Value := StrToInt(m1.Strings[i]);
		  if (m2.Strings[i] <> '0') then FDTpara.FieldByName('idAR').Value := StrToInt(m2.Strings[i]);
		  FDTpara.Post;
    end;
    m2.Free;
    m1.Free;
	  sl.Move(1, (sl.Count - 1));                                                 // Сдвиг спортсменов для следующего круга
  end;
  sl.Free;
  if (FDQuery.Active)  then   FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT tournum, name FROM fighters WHERE fgid=:pID';
  FDTbatl.Open;
  FDTpara.First;
  while not FDTpara.Eof do
  begin
	  FDTbatl.Append;
	  FDTbatl.FieldByName('tourid').AsInteger  := rectangle7.Tag;
	  FDTbatl.FieldByName('krug').Value        := FDTpara.FieldByName('idBL').AsInteger;
	  if FDTpara.FieldByName('idAL').AsInteger  > 0 then
    begin
		  FDTbatl.FieldByName('fgid1').Value     := FDTpara.FieldByName('idAL').AsInteger;
		  FDQuery.ParamByName('pID').AsInteger   := FDTpara.FieldByName('idAL').AsInteger;
		  FDQuery.Open;
		  FDTbatl.FieldByName('tournum1').Value  := FDQuery.FieldByName('tournum').AsInteger;
		  FDTbatl.FieldByName('fmim1').Value     := FDQuery.FieldByName('name').AsString;
		  FDQuery.Close;
    end;
	  if FDTpara.FieldByName('idAR').AsInteger  > 0 then
    begin
		  FDTbatl.FieldByName('fgid2').Value     := FDTpara.FieldByName('idAR').AsInteger;
		  FDQuery.ParamByName('pID').AsInteger   := FDTpara.FieldByName('idAR').AsInteger;
		  FDQuery.Open;
		  FDTbatl.FieldByName('tournum2').Value  := FDQuery.FieldByName('tournum').AsInteger;
		  FDTbatl.FieldByName('fmim2').Value     := FDQuery.FieldByName('name').AsString;
		  FDQuery.Close;
    end;
	  if (FDTpara.FieldByName('idAL').AsInteger < 1) or (FDTpara.FieldByName('idAR').AsInteger < 1) then
		    FDTbatl.FieldByName('finish').Value  := 1; //  В боях 'приведения' сразу ставлю 'конец поединка'
	  FDTbatl.Post;
    FDTpara.Next;
  end;
  FDTpara.Close;
  FDTbatl.Close;
  FDQuery.SQL.Text := 'UPDATE tournament SET status=1, schema=''krug'' WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.ExecSQL; //  Ставлю метку в таблице турниров - схема сохранена  (и тип соревнований -  круговой)
  readMatch(rectangle7.Tag);
end;

procedure Tfrm.sBtnOKClick(Sender: TObject);
var
  ctr: String;
begin
  tiScore.Tag := TSpeedButton(Sender).Tag;
  scor1.Value := StrToInt(scor1.Text);
  scor2.Value := StrToInt(scor2.Text); // К сожалению Text не всегда обновляет Value, делаю вручную
  ctr         := '';
  case tiScore.Tag of
     1 :  ctr := 'Confirm: Score '   + scor1.Text + ' : ' + scor2.Text;
     4 :  ctr := 'Confirm: both Absent';
     5 :  ctr := 'Confirm: Absence ' + chr(39)    + lbl_1.Text  + chr(39);
     6 :  ctr := 'Confirm: Absence ' + chr(39)    + lbl_2.Text  + chr(39);
  end;
  MessageDlg(ctr, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  var
    dw, dd, dl, df: double;
    st, os, ty: integer;
  begin
    if AResult  = mrYes    then
    begin
      if (FDQuery.Active)  then           FDQuery.Close;
		  if (scor1.Value = scor2.Value) and (sBtnKrug.Tag <> 1) and (tiScore.Tag = 1) then
      begin                                                       // Ничья в ОЛИМПИЙСКОЙ не является завершением поединка, поэтому идет по отдельной ветке
		      FDQuery.SQL.Text := 'UPDATE battle SET points1=-1, points2=-1, otime1=:pO1, otime2=:pO2, draw=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		      FDQuery.ParamByName('pO1').Value := scor1.Value;        // Сначала просто фиксируем ничью, дальше - дополнительное время
		      FDQuery.ParamByName('pO2').Value := scor2.Value;        // На место счета поединка пишу -1, как признак что это в основное время
          FDQuery.ExecSQL;
          label9.Text  := 'Overtime';
          lot_1.Text   := lbl_1.Text;
          lot_2.Text   := lbl_2.Text;
          score1.Text  := 'SCORE [' + scor1.Text + ']';
          score2.Text  := 'SCORE [' + scor2.Text + ']';
          sot1.Value   :=  scor1.Value;
          sot1.Enabled :=  true;
          sot2.Value   :=  scor2.Value;
          sot2.Enabled :=  true;
          gridPanelLayout4.Visible := false;
          layout39.Visible         := true;
          chTAdraw.ExecuteTarget(tControl);                       // Форма для OVERTIME
      end
      else
      begin
		  FDQuery.SQL.Text := 'SELECT bwin, bdraw, bloss, bdef, status, stype FROM tournament WHERE tourid=' + IntToStr(rectangle7.Tag);
		  FDQuery.Open;
      dw := FDQuery.FieldByName('bwin').AsFloat;
      dd := FDQuery.FieldByName('bdraw').AsFloat;
		  dl := FDQuery.FieldByName('bloss').AsFloat;
      df := FDQuery.FieldByName('bdef').AsFloat;
      st := FDQuery.FieldByName('status').AsInteger;
      ty := FDQuery.FieldByName('stype').AsInteger;
      FDQuery.Close;
//    bool bmk = (memoKomm->Text.Length() > 0); // Было набрано мемо-поле       ДАЛЕЕ КОД БЕЗ УЧЕТА МЕМО-ПОЛЯ!!!!!!!!!!!!!!!!!!!!!!!!!!
      ctr  := '';
      lVmatch.BeginUpdate;
      case tiScore.Tag of
         1 : begin
		         FDQuery.SQL.Text := 'UPDATE battle SET points1=:pP1, points2=:pP2, letter1=:pL1, letter2=:pL2, winner1=:pW1, winner2=:pW2, finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		         FDQuery.ParamByName('pP1').Value    := scor1.Value;
		         FDQuery.ParamByName('pP2').Value    := scor2.Value;
		         if scor1.Value    =  scor2.Value    then //  Ничья
             begin
					      FDQuery.ParamByName('pL1').Value := 'D';
					      FDQuery.ParamByName('pL2').Value := 'D';
					      FDQuery.ParamByName('pW1').Value :=  dd;
					      FDQuery.ParamByName('pW2').Value :=  dd;
             end
		         else if   scor1.Value > scor2.Value then // Победа левого
             begin
					      FDQuery.ParamByName('pL1').Value := 'W';
					      FDQuery.ParamByName('pL2').Value := 'L';
					      FDQuery.ParamByName('pW1').Value :=  dw;
					      FDQuery.ParamByName('pW2').Value :=  dl;
					      lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lbl_1.TextSettings.FontColor;
                ctr  := lbl_1.Text;
             end
		         else                                     // Победа правого
             begin
					      FDQuery.ParamByName('pL1').Value := 'L';
					      FDQuery.ParamByName('pL2').Value := 'W';
					      FDQuery.ParamByName('pW1').Value :=  dl;
					      FDQuery.ParamByName('pW2').Value :=  dw;
					      lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lbl_2.TextSettings.FontColor;
                ctr  := lbl_2.Text;
             end;
             lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status'] := FloatToStr(scor1.Value) + ' : ' + FloatToStr(scor2.Value);
             end;
         4 : begin                                    // Обоюдная неявка, points12 и letter12 по умолчанию впишут 0
		         FDQuery.SQL.Text := 'UPDATE battle SET finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
             lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status']               := '0 : 0';
             end;
         5 : begin                                    // Неявка левого
		         FDQuery.SQL.Text := 'UPDATE battle SET letter2=''W'', winner1=:pW1, winner2=:pW2, finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		         FDQuery.ParamByName('pW1').Value    := df;
		         FDQuery.ParamByName('pW2').Value    := dw;
		         lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lbl_2.TextSettings.FontColor;
             lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status']               := '0 : 0';
             ctr  := lbl_2.Text;
             end;
         6 : begin                                    // Неявка правого
		         FDQuery.SQL.Text := 'UPDATE battle SET letter1=''W'', winner1=:pW1, winner2=:pW2, finish=1 WHERE btid=' + IntToStr(sBtnSback.Tag);
		         FDQuery.ParamByName('pW1').Value    := dw;
		         FDQuery.ParamByName('pW2').Value    := df;
		         lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Objects.TextButton.TextColor := lbl_1.TextSettings.FontColor;
             lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Data['status']               := '0 : 0';
             ctr  := lbl_1.Text;
             end;
      end;
      FDQuery.ExecSQL;
      lVmatch.Items.AppearanceItem[lVmatch.ItemIndex].Tag := 0;
      lVmatch.EndUpdate;         // Обновляю lVmatch
      lVmatch.Resize;
      if sBtnKrug.Tag = 1 then   // фиксируем по круговой системе (оставил старый кусок, не стал делать объединение общих частей)
      begin
        FDQuery.SQL.Text := 'SELECT COUNT(*) AS kz FROM battle WHERE finish=0 AND tourid=' + IntToStr(rectangle7.Tag);
        FDQuery.Open;
           os  :=   FDQuery.FieldByName('kz').AsInteger; // Сколько осталось поединков
        FDQuery.Close;
        if os   = 0 then
        begin
          findWinner(true);      // Записать результаты всех участников и занятые места в fighters, победителя в tournament
	        lViewTour.BeginUpdate;
          lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Data['status']              := 'finished';
	        lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat := ty + 90; // Признак - турнир закрыт
	        lViewTour.EndUpdate;
          lViewTour.Resize;
{$IF DEFINED(ANDROID)}
          ToastMsg('The tournament is closed.');
{$ELSEIF  defined(MSWINDOWS)}
          ShowMessage('The tournament is closed.');
{$ENDIF};
        end
        else if st < 2 then               // Еще не было зафиксировано ни одного поединка
        begin
	        FDQuery.SQL.Text  := 'UPDATE tournament SET status=2 WHERE tourid=' + IntToStr(rectangle7.Tag);
	        FDQuery.ExecSQL;                // Хотя бы один бой уже проведен
          KOvisble(2);                    // Если хоть 1 бой турнира зафиксирован,
        end;                              // блокирую добавить, редактировать, удалить и создать таблицу
      end
      else                                // Фиксируем по олимпийской системе - - - - - - - - - - - - - - - - - - >
      begin
        FDQuery.SQL.Text := 'SELECT COUNT(*) AS kz FROM battle WHERE finish=0 AND krug=' + IntToStr(rectangle6.Tag) + ' AND tourid=' + IntToStr(rectangle7.Tag);
        FDQuery.Open;
           os  :=   FDQuery.FieldByName('kz').AsInteger; // Сколько осталось зафиксировать поединков в круге
        FDQuery.Close;
        if os   = 0 then                  // Завершен круг, а возможно и турнир
        begin
           if   lVmatch.Tag = 1  then     // Зафиксирован финальный поединок, закрытие турнира
           begin
             memo.Lines.Clear;
             memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
             memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail);
             if   ctr.Length     >  0 then
             begin
	                FDQuery.SQL.Text := 'UPDATE tournament SET status=3, winner=' + chr(39) + ctr + chr(39) + ' WHERE tourid=' + IntToStr(rectangle7.Tag);
                  memo.Lines.Add(     'Finished. Winner: ' + ctr);
             end
             else                  //  Возможно придется подсчитать каждому количество побед и очков (а может и нет)
             begin
                  FDQuery.SQL.Text := 'UPDATE tournament SET status=3 WHERE tourid='                                         + IntToStr(rectangle7.Tag);
                  memo.Lines.Add(     'Finished.');
             end;
	           FDQuery.ExecSQL;             // Ставлю метку - "Турнир завершен"
	           lViewTour.BeginUpdate;
             lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Data['status']              := 'finished';
	           lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat := ty + 90; // Признак - турнир закрыт
	           lViewTour.EndUpdate;
             lViewTour.Resize;
{$IF DEFINED(ANDROID)}
             ToastMsg('The tournament is closed.');
{$ELSEIF defined(MSWINDOWS)}
             ShowMessage('The tournament is closed.');
{$ENDIF};
           end
           else                           // Завершен очередной круг, надо формировать следующий
           begin
             nextKrug();
             readMatch(rectangle7.Tag);   // lVmatch  не обновляю, просто перепрочитываю заново
           end;                           // Возможно здесь надо поднимать список вверх!!!
        end
        else if st < 2 then               // Еще не было зафиксировано ни одного поединка
        begin
	        FDQuery.SQL.Text  := 'UPDATE tournament SET status=2 WHERE tourid=' + IntToStr(rectangle7.Tag);
	        FDQuery.ExecSQL;                // Хотя бы один бой уже проведен
          KOvisble(2);                    // Если хоть 1 бой турнира зафиксирован,
        end;                              // блокирую добавить, редактировать, удалить и создать таблицу
      end;
      chTAmain.ExecuteTarget(tControl);   // Меню матчей
      end;                                // Тут обрабатывалось все кроме ничьей
    end;                                  // Ответили YES (подтверждение счета)
  end);
end;

procedure Tfrm.sBtnOlimpClick(Sender: TObject);
begin
  if Not sBtnCCadd.Visible then  // Означает, что Status > 1
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('Already have fixed matches!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Already have fixed matches!');
{$ENDIF};
	   exit;  // Алгоритм доступен для работы только для СТАТУСА 0 или 1
  end;
  if (lVwho.ItemCount < 4)  or (lVwho.ItemCount > 32) then
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('The number of participants should be from 4 to 32!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('The number of participants should be from 4 to 32!');
{$ENDIF};
	   exit;
  end;
  sBtnOlimp.Tag  := 1;
  sBtnKrug.Tag   := 0;
  olimp();       // Алгоритм формирования пар по олимпийской системе
end;

procedure Tfrm.sBtnOptClick(Sender: TObject);
begin
  chTAbout.ExecuteTarget(tControl);
end;

procedure Tfrm.sBtnPlaceClick(Sender: TObject);
var
  myThread: HTMLthread;
//  myT:      TCountObj;     // Из учебника (видимо это вариант просто для Delphi)
begin
  aIndic.Enabled := true;    // Сначала запускаю крутиться индикатор
  aIndic.Visible := true;
  myThread       := HTMLthread.Create(False); // Сразу запускаю поток (в конце он сам себя FreeOnTerminate = true)
{
//  myThread.Priority := tpLower; под андроидом не идет
  myT          := TCountObj.Create(True);
  myT.Resume;  // запуск
  myT.Priority := tpLower;
}
  frm.memo.Lines.Add(''); // ЗАГАДКА № 1 - без этой команды поток не работает (команда не вредит), (надо разобраться!!!)
end;

procedure Tfrm.sBtnSbackClick(Sender: TObject);
begin
  chTAmain.ExecuteTarget(tControl); // Меню матчей
end;

procedure Tfrm.sBtnTbackClick(Sender: TObject);
begin
  chTAtour.ExecuteTarget(tControl);
end;

procedure Tfrm.sBtnTcancelClick(Sender: TObject);
begin
  chTAtour.ExecuteTarget(tControl);
end;

procedure Tfrm.sBtnTsaveClick(Sender: TObject);
var
  iType,  mit: integer;
  lvItem: TListViewItem;
  bN, b2, bT:  boolean;
begin
  if (eTname.Text.Trim.Length = 0) then
  begin
{$IF DEFINED(ANDROID)}
     ToastMsg('Required field!');
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage('Required field!');
{$ENDIF};
	   eTname.SetFocus;
	   exit;
  end;
  nBox1.Value := StrToInt(nBox1.Text); // К сожалению Text не всегда обновляет Value
  nBox2.Value := StrToInt(nBox2.Text); // поэтому на всякий случай страхуюсь, делаю вручную
  nBox3.Value := StrToInt(nBox3.Text);
  if (FDQuery.Active)     then    FDQuery.Close;
  if (sBtnTsave.Tag =  5) then // Новый турнир
  begin
  FDQuery.SQL.Text := 'INSERT INTO tournament (name, country, region, city, tourbeg, referee, secretary, bwin, bdraw, bloss, bdef, stype) VALUES (:pN, :pC, :pR, :pG, :pB, :pF, :pS, :pV, :pW, :pL, :pD, :pY)';
  end
  else
  begin
  FDQuery.SQL.Text := 'UPDATE tournament SET name=:pN, country=:pC, region=:pR, city=:pG, tourbeg=:pB, referee=:pF, secretary=:pS, bwin=:pV, bdraw=:pW, bloss=:pL, bdef=:pD, stype=:pY WHERE tourid=' + IntToStr(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Tag);
  end;
                            iType  := 1;
  if (rBtn2.IsChecked) then iType  := 2;
  FDQuery.ParamByName('pN').Value  := eTname.Text;
  FDQuery.ParamByName('pC').Value  := eTcountry.Text;
  FDQuery.ParamByName('pR').Value  := eTregion.Text;
  FDQuery.ParamByName('pG').Value  := eTcity.Text;
  FDQuery.ParamByName('pB').AsDate := dEprov.Date;
  FDQuery.ParamByName('pF').Value  := eTchief.Text;
  FDQuery.ParamByName('pS').Value  := eTsecret.Text;
  FDQuery.ParamByName('pV').Value  := nBox1.Value;
  FDQuery.ParamByName('pW').Value  := nBox2.Value;
  FDQuery.ParamByName('pL').Value  := nBox3.Value;
  FDQuery.ParamByName('pD').Value  := 0; // Невыход
  FDQuery.ParamByName('pY').Value  := iType;
  FDQuery.ExecSQL;
  if (FDQuery.Active)       then      FDQuery.Close;
  if (sBtnTsave.Tag   =  5) then   // Новый турнир
  begin
	  FDQuery.SQL.Text := 'SELECT MAX(tourid) AS mt FROM tournament';
	  FDQuery.Open;
	  mit := FDQuery.FieldByName('mt').AsInteger; // Номер введенной записи
	  FDQuery.Close;
    lViewTour.BeginUpdate;
    lvItem                := lViewTour.Items.Insert(0);
    lvItem.Text           := eTname.Text;
    lvItem.Tag            := mit;
    lvItem.Detail         := DateTimeToStr(dEprov.Date) + ' ' + eTcity.Text;
    lvItem.Objects.TextButton.TagFloat :=  iType;
    lvItem.Data['status'] := '';
    lViewTour.EndUpdate;
    memo.Lines.Clear;
	  memo.Lines.Add('Added tournament:');
	  memo.Lines.Add(eTname.Text);
    eCity.Text := '';  // Если ввели новый турнир, то обнуляю поля "город" и "клуб"
    eClub.Text := '';
  end
  else                 // Редактор (обновляю listView только если меняли наименование или дату или город или тип турнира)
  begin
	  bN   := False;
    b2   := False;
    bT   := False;
	  if                                     (eTname.Text  <> lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text)   then bN := True;
	  if ((DateTimeToStr(dEprov.Date) + ' ' + eTcity.Text) <> lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail) then b2 := True;
    mit  := StrToInt(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat.ToString);
	  if (mit <>    iType)                                                                                                then bT := True;
	  if  (bN or b2 or bT) then
    begin
			lViewTour.BeginUpdate;
			if   (bN) then lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text   := eTname.Text;
			if   (b2) then lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail := DateTimeToStr(dEprov.Date) + ' ' + eTcity.Text;
			if   (bT) then lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat   :=             iType;
			lViewTour.EndUpdate;
      memo.Lines.Clear;
    end;
  end;
  sBtnTcancelClick(Sender);
end;

procedure Tfrm.sBtnWbackClick(Sender: TObject);
begin
  chTAtour.ExecuteTarget(tControl);
end;

procedure Tfrm.readVersion();
  // Androidapi.Helpers
  // Androidapi.JNI.JavaTypes
  // Androidapi.JNI.GraphicsContentViewText
{$IF DEFINED(ANDROID)}
var
  PackageManager: JPackageManager;
  VersionPackage, PackageName: JString;
  ptr: String;
  i: integer;
{$ENDIF}
begin
  lblToDay.Text := FormatDateTime('dddd d mmmm yyyy', Date());
{$IF DEFINED(ANDROID)}
  PackageManager := SharedActivity.getPackageManager;
  PackageName    := SharedActivityContext.getPackageName;
  VersionPackage := PackageManager.getPackageInfo(PackageName, 0).versionName;
  ptr   := '';
  for i := 0 to  PackageName.length do
  begin
    if (JStringToString(PackageName).substring(i, 1) = '.') then ptr := ''
    else     ptr := ptr  + JStringToString(PackageName).substring(i, 1);
  end;
  memo.Lines.Add(ptr);
  memo.Lines.Add('ver. ' + JStringToString(VersionPackage));
  lblVer.Text := 'ver. ' + JStringToString(VersionPackage);
{$ENDIF}
end;

function Tfrm.readStatus(const tID: integer): integer;
var
  st: integer;
begin                    // Считываю СТАТУС турнира. Он может быть от 0 до 3
  if (FDQuery.Active) then  FDQuery.Close;
  sBtnKrug.Tag     := 0; // Здесь же очень удобно считать схему турнира, если она уже определена
  sBtnOlimp.Tag    := 0; // Это место при входе нельзя обойти
  FDQuery.SQL.Text := 'SELECT status, schema FROM tournament WHERE tourid=' + IntToStr(tID);
  FDQuery.Open;
  st     :=   FDQuery.FieldByName('status').AsInteger;
  if  FDQuery.FieldByName('schema').AsString =  'krug'  then sBtnKrug.Tag  := 1;
  if  FDQuery.FieldByName('schema').AsString =  'olimp' then sBtnOlimp.Tag := 1;
  FDQuery.Close;
  Result :=   st;
end;

procedure Tfrm.readCityClub(const tID: integer);
var
  lvItem: TListViewItem;
  iSt:    integer;
begin
  if (FDQuery.Active)  then   FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT fgid, name, tournum FROM fighters WHERE tourid=' + IntToStr(tID);
  lVwho.BeginUpdate;
  lVwho.Items.Clear;
  FDQuery.Open;
  while not  FDQuery.Eof do
  begin
    lvItem          := lVwho.Items.Add;
    lvItem.Text     := FDQuery.FieldByName('name').AsString;
    lvItem.Tag      := FDQuery.FieldByName('fgid').AsInteger;
    lvItem.Detail   := FDQuery.FieldByName('tournum').AsString;
    FDQuery.Next;
  end;
  FDQuery.Close;
  lVwho.EndUpdate;
  sBtnCCred.Enabled := False;
  sBtnCCdel.Enabled := False;
  iSt               := readStatus(tID);
  KOvisble(iSt);    // Доступ  к  кнопкам
  if  (iSt = 0) then   lVmatch.Visible := False
  else                 readMatch(tID);
end;

procedure Tfrm.readMatch(const tID: integer);
var
  lvItem, ith: TListViewItem;
  kr, it, fin: integer;
  ctr:    String;
begin
  kr  :=  0;
  fin :=  0;
  lVmatch.Tag      :=  0;       // Если 1, то финальный круг (нужно для олимпийской!!!)
  if (FDQuery.Active)  then     FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT * FROM battle WHERE tourid=' + IntToStr(tID);
  lVmatch.BeginUpdate;
  lVmatch.Items.Clear;
  FDQuery.Open;
  while not   FDQuery.Eof do
  begin
	  if (kr <> FDQuery.FieldByName('krug').AsInteger) then // Header
    begin
           fin :=  0;            // Суда подсчитываю количество поединков в круге, чтобы поймать Финал
		       kr  :=  kr  +  1;
           rectangle6.Tag := kr; // Здесь всегда номер последнего круга (нужно для олимпийской!!!)
      case kr  of
       1 : ctr := '1st Tour';
       2 : ctr := '2nd Tour';
       3 : ctr := '3rd Tour';
      else ctr := IntToStr(kr) + 'th Tour';
      end;
      ith         := lVmatch.Items.Add;
		  ith.Text    := ctr;
		  ith.Purpose := TListItemPurpose.Header;
    end; // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    it   := 0;
	  if ((Not FDQuery.FieldByName('finish').AsBoolean) and (Not FDQuery.FieldByName('tournum1').IsNull) and (Not FDQuery.FieldByName('tournum2').IsNull)) then
		it   :=  FDQuery.FieldByName('btid').AsInteger;   //   Бой еще не состоялся, запоминаю его PrimaryKey   из  таблицы battle
	  if (    (FDQuery.FieldByName('finish').AsBoolean) and ((FDQuery.FieldByName('tournum1').IsNull)    or  (FDQuery.FieldByName('tournum2').IsNull))) then
		it   := -1;                                       //   Так называемый "бой приведения" (нет соперника)
    lvItem            := lVmatch.Items.Add;
    lvItem.Tag        := it;
    if sBtnKrug.tag    = 1 then  lvItem.ImageIndex := 15
    else                         lvItem.ImageIndex := 17;
	  if (FDQuery.FieldByName('tournum1').IsNull) then
    ctr  := 'BYE'
    else
    ctr  := FDQuery.FieldByName('tournum1').AsString + ' ' + FDQuery.FieldByName('fmim1').AsString;
    lvItem.Text       := ctr;
	  if (FDQuery.FieldByName('tournum2').IsNull) then
    ctr  := 'BYE'
    else
    ctr  := FDQuery.FieldByName('tournum2').AsString + ' ' + FDQuery.FieldByName('fmim2').AsString;
    lvItem.Detail     := ctr;
	  if (FDQuery.FieldByName('letter1').AsString = 'W') then lvItem.Objects.TextButton.TextColor := lvItem.Objects.TextObject.TextColor;
	  if (FDQuery.FieldByName('letter2').AsString = 'W') then lvItem.Objects.TextButton.TextColor := lvItem.Objects.DetailObject.TextColor;
    lvItem.Data['status'] := '';
	  if (it = 0) then      // Запоминаю счет уже состоявшегося поединка в специальном параметре
    lvItem.Data['status'] := FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString;
    FDQuery.Next;
    fin := fin + 1;
  end;
  FDQuery.Close;
  lVmatch.EndUpdate;
  lVmatch.Resize;
  if fin  = 1              then lVmatch.Tag     := 1; // Уже сформирован финальный круг (нужно для олимпийской!!!)
  if (Not lVmatch.Visible) then lVmatch.Visible := true;
end;

procedure Tfrm.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF); // *** VK ***
begin
  if FNeedOffset and (FKBBounds.Top > 0) then ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
end;

procedure Tfrm.RestorePosition;                                                   // *** VK ***
begin
  if tControl.ActiveTab = tiTedit then
  begin
    vertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
    mainLayout1.Align               := TAlignLayout.Client;
    vertScrollBox1.RealignContent;
  end
  else
  begin
    vertScrollBox2.ViewportPosition := PointF(VertScrollBox2.ViewportPosition.X, 0);
    mainLayout2.Align               := TAlignLayout.Client;
    vertScrollBox2.RealignContent;
  end;
end;

procedure Tfrm.UpdateKBBounds;                                                    // *** VK ***
var
  LFocused:   FMX.Controls.TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset  :=      False;
  if Assigned(Focused) then
  begin
    if tControl.ActiveTab = tiTedit then
    begin
      LFocused   := FMX.Controls.TControl(Focused.GetObject);
      LFocusRect := LFocused.AbsoluteRect;
      LFocusRect.Offset(vertScrollBox1.ViewportPosition);
      if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
      begin
        FNeedOffset       := True;
        mainLayout1.Align := TAlignLayout.Horizontal;
        vertScrollBox1.RealignContent;
        Application.ProcessMessages;
        vertScrollBox1.ViewportPosition := PointF(vertScrollBox1.ViewportPosition.X, LFocusRect.Bottom - FKBBounds.Top);
      end;
    end
    else
    begin
      LFocused   := FMX.Controls.TControl(Focused.GetObject);
      LFocusRect := LFocused.AbsoluteRect;
      LFocusRect.Offset(vertScrollBox2.ViewportPosition);
      if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
      begin
        FNeedOffset       := True;
        mainLayout2.Align := TAlignLayout.Horizontal;
        vertScrollBox2.RealignContent;
        Application.ProcessMessages;
        vertScrollBox2.ViewportPosition := PointF(vertScrollBox2.ViewportPosition.X, LFocusRect.Bottom - FKBBounds.Top);
      end;
    end;
  end;
  if not FNeedOffset then  RestorePosition;
end;

procedure Tfrm.findWinner(const b: boolean);
var
  ctrWIN, str, c2: String;
  iw, di, i,    q: integer;
begin
  if (FDQuery.Active)  then   FDQuery.Close;
  FDQuery.SQL.Text := 'DELETE FROM tmpreport';
  FDQuery.ExecSQL;
  ctrWIN := '';
  FDTmpRep.Open;
  if lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat  > 90  then // Турнир завершен, все уже подсчитано
  begin
	  FDQuery.SQL.Text := 'SELECT points, wins, ekran, place FROM fighters WHERE tournum=:pTN AND tourid=' + IntToStr(rectangle7.Tag);
    For i  := 0 to   (lVwho.Items.Count - 1)  do
    begin
		  FDQuery.ParamByName('pTN').AsInteger    := StrToInt(lVwho.Items.AppearanceItem[i].Detail);
		  FDQuery.Open;
      while not FDQuery.Eof do
      begin
				FDTmpRep.Append;
				FDTmpRep.FieldByName('tournum').Value := StrToInt(lVwho.Items.AppearanceItem[i].Detail);
				FDTmpRep.FieldByName('name').Value    := lVwho.Items.AppearanceItem[i].Text;
				FDTmpRep.FieldByName('wins').Value    := FDQuery.FieldByName('wins').AsInteger; // Победы учитываю просто для собственной статистики
				FDTmpRep.FieldByName('points').Value  := FDQuery.FieldByName('points').AsFloat;
				FDTmpRep.FieldByName('ekran').Value   := FDQuery.FieldByName('ekran').AsString;
				FDTmpRep.FieldByName('place').Value   := FDQuery.FieldByName('place').AsString;
				FDTmpRep.Post;
        FDQuery.Next;
      end;
		  FDQuery.Close;
    end;
  end
  else               // Еще есть незавершенные бои
  begin
	  FDQuery.SQL.Text := 'SELECT tournum1, winner1, points1, tournum2, winner2, points2 FROM battle WHERE finish=1 AND (tournum1=:pTN OR tournum2=:pTN) AND tourid=' + IntToStr(rectangle7.Tag);
    For i  := 0 to   (lVwho.Items.Count - 1)  do
    begin
		  iw   := 0;     // Сюда суммирую очки за матчи
		  di   := 0;     // Суда суммирую разницу между забитыми и пропущенными
		  FDQuery.ParamByName('pTN').AsInteger    := StrToInt(lVwho.Items.AppearanceItem[i].Detail);
		  FDQuery.Open;
      while not FDQuery.Eof do
      begin
			  if (FDQuery.FieldByName('tournum1').AsInteger = StrToInt(lVwho.Items.AppearanceItem[i].Detail)) then
        begin
				iw := iw +  FDQuery.FieldByName('winner1').AsInteger;
				di := di + (FDQuery.FieldByName('points1').AsInteger - FDQuery.FieldByName('points2').AsInteger);
        end
			  else
			  begin
				iw := iw +  FDQuery.FieldByName('winner2').AsInteger;
				di := di + (FDQuery.FieldByName('points2').AsInteger - FDQuery.FieldByName('points1').AsInteger);
        end;
        FDQuery.Next;
      end;
		  FDQuery.Close;
		  FDTmpRep.Append;
		  FDTmpRep.FieldByName('tournum').Value := StrToInt(lVwho.Items.AppearanceItem[i].Detail);
		  FDTmpRep.FieldByName('name').Value    := lVwho.Items.AppearanceItem[i].Text;
		  FDTmpRep.FieldByName('wins').Value    := iw;
		  FDTmpRep.FieldByName('points').Value  := di;
		  FDTmpRep.Post;
    end;
	  FDTmpRep.IndexFieldNames := 'wins:D;points:D'; // В шахматке, при подсчете места, сначала учитываются сумма очков, затем разница забитых-пропущенных
	  FDQuery.SQL.Text         := 'SELECT COUNT(*) AS kz FROM tmpreport WHERE wins=:pW AND points=:pP';
	  str := '*';
	  q   :=  1;               //  Здесь место бойца,  которое я высчитываю
    FDTmpRep.First;
    while not FDTmpRep.Eof do
    begin
		  FDQuery.ParamByName('pW').Value := FDTmpRep.FieldByName('wins').AsInteger;
		  FDQuery.ParamByName('pP').Value := FDTmpRep.FieldByName('points').AsFloat;
		  FDQuery.Open;
		  if (FDQuery.FieldByName('kz').AsInteger = 1) then
      begin
				str  := '*';         // Такая запись одна и место бойца однозначно
        c2   := IntToStr(q);
      end
		  else                   // Дальше механизм отражения раздельного решения
		  begin
			  if (str <> (FDTmpRep.FieldByName('wins').AsString + FDTmpRep.FieldByName('points').AsString)) then
			  begin
				    str :=  FDTmpRep.FieldByName('wins').AsString + FDTmpRep.FieldByName('points').AsString;
				    c2  :=  IntToStr(q) +  '-'  + IntToStr(FDQuery.FieldByName('kz').AsInteger + q - 1);
        end;
      end;
		  FDQuery.Close;
		  FDTmpRep.Edit;
		  FDTmpRep.FieldByName('ekran').Value := c2;
		  FDTmpRep.FieldByName('place').Value := q;   // place добавил в таблицу FDTmpRep для выбора сортировки перед отчетом
		  FDTmpRep.Post;
		  if (c2 = '1') then ctrWIN := FDTmpRep.FieldByName('name').AsString; // Если есть победитель, запоминаю его фамилию
		      q :=  q + 1;
      FDTmpRep.Next;
    end;
    FDTmpRep.IndexFieldNames    := '';
  end;
  if (b) then             // Если 'закрытие' турнира, то надо вписать места и очки каждого участника
  begin
	  FDQuery.SQL.Text := 'UPDATE fighters SET points=:pP, wins=:pW, ekran=:pE, place=:pL WHERE tournum=:pT AND tourid=' + IntToStr(rectangle7.Tag);
    FDTmpRep.First;
    while not FDTmpRep.Eof do
    begin
			FDQuery.ParamByName('pT').Value := FDTmpRep.FieldByName('tournum').AsInteger;
			FDQuery.ParamByName('pP').Value := FDTmpRep.FieldByName('points').AsFloat;
			FDQuery.ParamByName('pW').Value := FDTmpRep.FieldByName('wins').AsInteger;
			FDQuery.ParamByName('pE').Value := FDTmpRep.FieldByName('ekran').AsString;
			FDQuery.ParamByName('pL').Value := FDTmpRep.FieldByName('place').AsInteger;
			FDQuery.ExecSQL;    // В таблицу бойцов записываю их очки, победы и место
      FDTmpRep.Next;
    end;
	  FDTmpRep.Close;       // Таблицу FDTmpRep закрываю если b=True, в ином случае она сразу используется для HTML-отчета
    memo.Lines.Clear;
    memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
    memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail);
    if   ctrWIN.Length     >  0 then
    begin
	       FDQuery.SQL.Text := 'UPDATE tournament SET status=3, winner=' + chr(39) + ctrWIN + chr(39) + ' WHERE tourid=' + IntToStr(rectangle7.Tag);
         memo.Lines.Add(     'Finished. Winner: ' + ctrWIN);
    end
    else
    begin
         FDQuery.SQL.Text := 'UPDATE tournament SET status=3 WHERE tourid='                                            + IntToStr(rectangle7.Tag);
         memo.Lines.Add(     'Finished.');
    end;
	  FDQuery.ExecSQL;      //  Ставлю метку - "Турнир завершен"
  end;
end;

procedure Tfrm.createHTMLkrug(fName: String);
var
  iw, iy, zab, prp, i: integer;
  sl, s2: TStringList;
  rf, se, ctr: String;
begin
  findWinner(False);
  if      FDTmpRep.RecordCount <= 12 then
  begin
		iw := 64;  // Ширина ячейки
		iy := 250; // Ширина name
  end
  else if FDTmpRep.RecordCount <= 22 then
  begin
		iw := 58;
		iy := 160;
  end
  else
  begin
		iw := 50;  // Тут я примерно высчитываю ширину отчета и колонок
		iy := 140; // (три варианта в зависимости от численности)
  end;
  iy   := (iw * FDTmpRep.RecordCount) + iy + 178; // 178 - это сумма ширин 1-й, TP1 + TP2 + Rank колонок
  sl   := TStringList.Create;
  sl.Add('<html>');
  sl.Add('<head>');
  sl.Add('<title>CompeTTable</title>');
  sl.Add('<style type="text/css">');
  sl.Add('body { font-family: Arial; font-size: 80%; }');
  sl.Add('</style>');
  sl.Add('</head>');
  sl.Add('<body>');
  ctr  := '<table width="' + IntToStr(iy)  + '" border="0" align="center" cellpadding="0" cellspacing="0">';
  sl.Add(ctr);
  if FDQuery.Active    then   FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT country, region, city, tourbeg, referee, secretary, stype FROM tournament WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.Open;
  sl.Add('<tr>');
  if FDQuery.FieldByName('stype').AsInteger = 1 then ctr := ' (Team)'
  else                                               ctr := ' (Personal)';
  ctr  := lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text + ' ' + FDQuery.FieldByName('tourbeg').AsString + ctr;
  ctr  := '<td align="center">' + ctr + '</td>';
  sl.Add(ctr);
  sl.Add('</tr>');
  if FDQuery.FieldByName('country').AsString.Length > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>Country: ' + FDQuery.FieldByName('country').AsString + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  if FDQuery.FieldByName('region').AsString.Length  > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>Region: ' + FDQuery.FieldByName('region').AsString  + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  if FDQuery.FieldByName('city').AsString.Length    > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>City: ' + FDQuery.FieldByName('city').AsString + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  iy   := FDQuery.FieldByName('stype').AsInteger;
  rf   := '';  //   Здесь сразу запомнаю судью и секретаря
  se   := '';
  if FDQuery.FieldByName('referee').AsString.Length   > 0 then  rf := 'Chief judge: ' + FDQuery.FieldByName('referee').AsString;
  if FDQuery.FieldByName('secretary').AsString.Length > 0 then  se := 'Secretary: '   + FDQuery.FieldByName('secretary').AsString;
  FDQuery.Close;
  sl.Add('<tr>');
  sl.Add('<td>');
  sl.Add('<table width="100%" border="1" cellspacing="0" cellpadding="0">');
  sl.Add('<tr>');                                       // - - - - Шапка - - - -
  sl.Add('<th scope="col" width="34">№</th>');
  if iy < 2 then ctr := '<th scope="col">Participant (City)</th>'
  else           ctr := '<th scope="col">First name, Last name</th>';
  sl.Add(ctr);                                                     // Таблицу FDTmpRep оставил открытой в процедуре findWinner!
  if rBstart.IsChecked  then FDTmpRep.IndexFieldNames := 'tournum' // Сортировка по турнирному номеру
  else                       FDTmpRep.IndexFieldNames := 'place';  // Сортировка по занимаемому месту
  s2   := TStringList.Create;                                      // Сюда вписываю номер бойца в выбранной сортировке
  FDTmpRep.First;
  while not FDTmpRep.Eof do
  begin
	 ctr := '<th scope="col" width="' + IntToStr(iw) + '">' +  FDTmpRep.FieldByName('tournum').AsString + '</th>';
	  sl.Add(ctr);
	  s2.Add(FDTmpRep.FieldByName('tournum').AsString);              // В пределах турнира, он уникальный
    FDTmpRep.Next;
  end;
  sl.Add('<th scope="col" width="44">TP1</th>');
  sl.Add('<th scope="col" width="48">TP2</th>');
  sl.Add('<th scope="col" width="52">Rank</th>');
  sl.Add('</tr>'); 						                          // - - - - Шапка - - - -
  FDQuery.SQL.Text := 'SELECT tournum1, winner1, points1, letter1, tournum2, winner2, points2, letter2, finish FROM battle WHERE ((tournum1=:pN1 AND tournum2=:pN2) || (tournum1=:pN2 AND tournum2=:pN1)) AND tourid=' + IntToStr(rectangle7.Tag);
  FDTmpRep.First;
  while not FDTmpRep.Eof do
  begin
    sl.Add('<tr>');
    ctr := '<td align="center">' + FDTmpRep.FieldByName('tournum').AsString + '</td>';
	  sl.Add(ctr);
	  ctr := twoString(FDTmpRep.FieldByName('name').AsString);  // Делаю 'Клуб (Город)' двухстрочным
	  ctr := '<td>' + ctr + '</td>';
	  sl.Add(ctr);
	  zab    := 0;
    prp    := 0;
    For i  := 0 to (s2.Count - 1) do
    begin
		  if   s2.Strings[i] = FDTmpRep.FieldByName('tournum').AsString then
			     ctr := '<td bgcolor="#999999">&nbsp;</td>'   // Пересечение с самим собой
      else
      begin
			  FDQuery.ParamByName('pN1').AsInteger := FDTmpRep.FieldByName('tournum').AsInteger;
			  FDQuery.ParamByName('pN2').AsInteger := StrToInt(s2.Strings[i]);
			  FDQuery.Open;
			  if FDQuery.FieldByName('finish').AsBoolean then
        begin
				  if FDQuery.FieldByName('tournum1').AsInteger = FDTmpRep.FieldByName('tournum').AsInteger then
          begin
					   ctr := FDQuery.FieldByName('letter1').AsString + '<br>(' + FDQuery.FieldByName('points1').AsString + ':' + FDQuery.FieldByName('points2').AsString + ')';
					   zab := zab + FDQuery.FieldByName('points1').AsInteger;
					   prp := prp + FDQuery.FieldByName('points2').AsInteger;
          end
				  else
				  begin
					   ctr := FDQuery.FieldByName('letter2').AsString + '<br>(' + FDQuery.FieldByName('points2').AsString + ':' + FDQuery.FieldByName('points1').AsString + ')';
					   zab := zab + FDQuery.FieldByName('points2').AsInteger;
					   prp := prp + FDQuery.FieldByName('points1').AsInteger;
          end;
        end
        else ctr := '&nbsp;';
			  FDQuery.Close;
			  ctr := '<td align="center">' + ctr + '</td>';
      end;
		  sl.Add(ctr);
    end;
	  ctr := '<td align="center">' + FDTmpRep.FieldByName('wins').AsString  + '</td>';
	  sl.Add(ctr);
	  ctr := '<td align="center">' + IntToStr(zab)  + ':' +   IntToStr(prp) + '</td>';
	  sl.Add(ctr);
	  ctr := '<td align="center">' + FDTmpRep.FieldByName('ekran').AsString + '</td>';
    sl.Add(ctr);
	  sl.Add('</tr>');
    FDTmpRep.Next;
  end;
  FDTmpRep.IndexFieldNames := '';
  FDTmpRep.Close;
  s2.Free;
  sl.Add('</table>');
  sl.Add('</td>');
  sl.Add('</tr>');                          //    Далее подножие - - - - - - - -
  if rf.Length > 0 then sl.Add('<tr><td>' + rf + '</td></tr>');
  if se.Length > 0 then sl.Add('<tr><td>' + se + '</td></tr>');


  sl.Add('<tr><td height="40px" align="center">Made by CompeTTable (R).</td></tr>'); // проверить


  sl.Add('</table>');
  sl.Add('</body>');
  sl.Add('</html>');
{$IF DEFINED(ANDROID)}
  fName := TPath.Combine(TPath.GetPublicPath, fName);
{$ENDIF};
  sl.SaveToFile(fName);
  sl.Free;
end;

procedure Tfrm.createHTMLolimp(fName: String);
var
  iw, iy, kr:  integer;
  sl, s1, s2,  s3, s4, s5: TStringList;
  rf, se, ctr, winner: String;
begin
  if       lVwho.Items.Count > 16 then
  begin
        kr := 5;    // от 17 до 32 человек - 5 кругов (5-й - финал)
	      iw := 220;  // Ширина   брекета (круга)
  end
  else  if lVwho.Items.Count > 8 then
  begin
        kr := 4;    // от 9 до 16 человек - 4 круга
        iw := 240;
  end
  else  if lVwho.Items.Count > 4 then
  begin
        kr := 3;   // от  5 до 8 человек - 3 круга
        iw := 260;
  end
  else  if lVwho.Items.Count > 2 then
  begin
        kr := 2;   // от  2 до 4 человек - 2 круга
        iw := 300;
  end
  else
  begin
        kr := 1;   // строчка для чистоты кода
        iw := 100;
  end;
  sl := TStringList.Create;
  sl.Add('<html>');
  sl.Add('<head>');
  sl.Add('<title>CompeTTable</title>');
  sl.Add('<style type="text/css">');
  sl.Add('body { font-family: Arial; font-size: 80%; }');
  sl.Add('.first {');
  sl.Add('border-right: 1px solid black;');
  sl.Add('border-top: 1px solid black; }');
  sl.Add('.second {');
  sl.Add('border-right: 1px solid black;');
  sl.Add('border-bottom: 1px solid black; }');
  sl.Add('.mid { border-right: 1px solid black; }');
  sl.Add('.win { border-bottom: 1px solid black; }');
  sl.Add('</style>');
  sl.Add('</head>');
  sl.Add('<body>');
  iy  :=  iw * (kr + 1); // Ширина отчета - (количество кругов + финалист) * на ширину брекета
  ctr := '<table width="' + IntToStr(iy) + '" border="0" align="center" cellpadding="0" cellspacing="0">';
  sl.Add(ctr);
  if FDQuery.Active    then   FDQuery.Close;
  FDQuery.SQL.Text := 'SELECT country, region, city, tourbeg, referee, secretary, stype FROM tournament WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.Open;
  sl.Add('<tr>');
  if FDQuery.FieldByName('stype').AsInteger = 1 then ctr := ' (Team)'
  else                                               ctr := ' (Personal)';
  ctr  := lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text + ' ' + FDQuery.FieldByName('tourbeg').AsString + ctr;
  ctr  := '<td align="center">' + ctr + '</td>';
  sl.Add(ctr);
  sl.Add('</tr>');
  if FDQuery.FieldByName('country').AsString.Length > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>Country: ' + FDQuery.FieldByName('country').AsString + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  if FDQuery.FieldByName('region').AsString.Length  > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>Region: ' + FDQuery.FieldByName('region').AsString  + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  if FDQuery.FieldByName('city').AsString.Length    > 0 then
  begin
	 sl.Add('<tr>');
   ctr := '<td>City: ' + FDQuery.FieldByName('city').AsString + '</td>';
	 sl.Add(ctr);
	 sl.Add('</tr>');
  end;
  rf   := '';  //   Здесь сразу запомнаю судью и секретаря
  se   := '';
  if FDQuery.FieldByName('referee').AsString.Length   > 0 then  rf := 'Chief judge: ' + FDQuery.FieldByName('referee').AsString;
  if FDQuery.FieldByName('secretary').AsString.Length > 0 then  se := 'Secretary: '   + FDQuery.FieldByName('secretary').AsString;
  FDQuery.Close;
  sl.Add('<tr><td>&nbsp;</td></tr>');
  sl.Add('<tr>');
  sl.Add('<td>');
  sl.Add('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
  FDQuery.SQL.Text := 'SELECT tournum1, fmim1, letter1, points1, tournum2, fmim2, letter2, points2, finish FROM battle WHERE tourid=' + IntToStr(rectangle7.Tag) + ' AND krug=:pKR';
  if kr = 5 then // от 17 до 32 человек - 5 кругов (5-й - финал)
  begin
    s1 := TStringList.Create;
    s2 := TStringList.Create;
    s3 := TStringList.Create;
    s4 := TStringList.Create;
    s5 := TStringList.Create;
    FDQuery.ParamByName('pKR').AsInteger  := 1; // - - - - - - - - - - - - - - -
    FDQuery.Open;
    while not FDQuery.Eof do
    begin
      if FDQuery.FieldByName('tournum1').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum1').AsString + ' - ' + FDQuery.FieldByName('fmim1').AsString;
      s1.Add(ctr);
      if FDQuery.FieldByName('tournum2').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum2').AsString + ' - ' + FDQuery.FieldByName('fmim2').AsString;
      s1.Add(ctr);   // В первом массиве всегда 32 элемента (т.е. 32 брекета (строк) в отчете) и они НЕ пустые
      s2.Add(brecket());            // Заранее запоминаю результат, для отображения во втором круге
      FDQuery.Next;
    end;
    FDQuery.Close;   // Первый круг, просто запомнил пары в массив - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 2;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // Второй массив предварительно создан в первом цикле
    begin
       For iy := 0 to 15 do         // Если первый круг не закончен, все предварительные значения стираю
       begin
           s2.Strings[iy] := '&nbsp;';
       end;
       For iy := 1 to  8 do         // Если не было 2-го круга, то не было и 3-го
       begin
           s3.Add('&nbsp;');
       end;
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         case iy of
         1 :  s2.Strings[0]  := ctr + s2.Strings[0];
         2 :  s2.Strings[2]  := ctr + s2.Strings[2];
         3 :  s2.Strings[4]  := ctr + s2.Strings[4];
         4 :  s2.Strings[6]  := ctr + s2.Strings[6];
         5 :  s2.Strings[8]  := ctr + s2.Strings[8];
         6 :  s2.Strings[10] := ctr + s2.Strings[10];
         7 :  s2.Strings[12] := ctr + s2.Strings[12];
         8 :  s2.Strings[14] := ctr + s2.Strings[14];
         end;
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         case iy of
         1 :  s2.Strings[1]  := ctr + s2.Strings[1];
         2 :  s2.Strings[3]  := ctr + s2.Strings[3];
         3 :  s2.Strings[5]  := ctr + s2.Strings[5];
         4 :  s2.Strings[7]  := ctr + s2.Strings[7];
         5 :  s2.Strings[9]  := ctr + s2.Strings[9];
         6 :  s2.Strings[11] := ctr + s2.Strings[11];
         7 :  s2.Strings[13] := ctr + s2.Strings[13];
         8 :  s2.Strings[15] := ctr + s2.Strings[15];
         end;
         s3.Add(brecket());        // Заранее запоминаю результат, для отображения в третьем круге
         inc(iy);
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Второй круг прочитал - - - - - - - - - - - - - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 3;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // 3-й массив предварительно создан в 2-ом цикле
    begin
       s3.Strings[0] := '&nbsp;';   // Если 2-й круг не закончен, все предварительные значения стираю
       s3.Strings[1] := '&nbsp;';
       s3.Strings[2] := '&nbsp;';
       s3.Strings[3] := '&nbsp;';
       s3.Strings[4] := '&nbsp;';
       s3.Strings[5] := '&nbsp;';
       s3.Strings[6] := '&nbsp;';
       s3.Strings[7] := '&nbsp;';
       s4.Add('&nbsp;');            // Если не было 3-го круга, то не было и 4-го
       s4.Add('&nbsp;');
       s4.Add('&nbsp;');
       s4.Add('&nbsp;');
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         case iy of
         1 :  s3.Strings[0] := ctr + s3.Strings[0];
         2 :  s3.Strings[2] := ctr + s3.Strings[2];
         3 :  s3.Strings[4] := ctr + s3.Strings[4];
         4 :  s3.Strings[6] := ctr + s3.Strings[6];
         end;
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         case iy of
         1 :  s3.Strings[1] := ctr + s3.Strings[1];
         2 :  s3.Strings[3] := ctr + s3.Strings[3];
         3 :  s3.Strings[5] := ctr + s3.Strings[5];
         4 :  s3.Strings[7] := ctr + s3.Strings[7];
         end;
         s4.Add(brecket());         // Заранее запоминаю результат, для отображения в 4-м круге
         inc(iy);
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Третий круг прочитал - - - - - - - - - - - - - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 4;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // 4-й массив предварительно создан в 3-ом цикле
    begin
       s4.Strings[0] := '&nbsp;';   // Если 3-й круг не закончен, все предварительные значения стираю
       s4.Strings[1] := '&nbsp;';
       s4.Strings[2] := '&nbsp;';
       s4.Strings[3] := '&nbsp;';
       s5.Add('&nbsp;');            // Если не было 4-го круга, то не было и 5-го
       s5.Add('&nbsp;');
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         if iy = 1  then s4.Strings[0] := ctr + s4.Strings[0]
         else            s4.Strings[2] := ctr + s4.Strings[2];
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         if iy = 1  then s4.Strings[1] := ctr + s4.Strings[1]
         else            s4.Strings[3] := ctr + s4.Strings[3];
         s5.Add(brecket());         // Заранее запоминаю результат, для отображения в 5-м круге
         inc(iy);
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Четвертый круг прочитал  - - - - - - - - - - - - - - - - -
    winner := '&nbsp;';
    FDQuery.ParamByName('pKR').AsInteger := 5;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then
    begin
       s5.Strings[0] := '&nbsp;';   // Если 4-й круг не закончен, все предварительные значения стираю
       s5.Strings[1] := '&nbsp;';
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
       if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
       s5.Strings[0] := ctr + s5.Strings[0];
       if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
       s5.Strings[1] := ctr + s5.Strings[1];
       if FDQuery.FieldByName('finish').AsBoolean then
       begin
               if  FDQuery.FieldByName('letter1').AsString = 'W' then  winner := FDQuery.FieldByName('fmim1').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter1').AsString = 'V' then  winner := FDQuery.FieldByName('fmim1').AsString
          else if  FDQuery.FieldByName('letter2').AsString = 'W' then  winner := FDQuery.FieldByName('fmim2').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter2').AsString = 'V' then  winner := FDQuery.FieldByName('fmim2').AsString
          else if (FDQuery.FieldByName('letter1').AsString = 'D') and (FDQuery.FieldByName('letter2').AsString = 'D')  then
                                                                       winner := 'DRAW [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if (FDQuery.FieldByName('letter1').AsString = '0') and (FDQuery.FieldByName('letter2').AsString = '0')  then
                                                                       winner :=  sBtnDef.Text     // Обоюдный невыход
          else if (FDQuery.FieldByName('letter1').AsString = 'X') and (FDQuery.FieldByName('letter2').AsString = 'X')  then
                                                                       winner := '&nbsp;';         // Некому было выходить (пусто)
       end;
    end;
    FDQuery.Close; // Дальше без цикла, перебором заполняю таблицу. Расчет на то, что количество записей всегда строго соблюдается (здесь без проверок)
    sl.Add('<tr><td width="' + IntToStr(iw) + '"><div class="first">' + s1.Strings[0] + '</div></td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">'                    + s2.Strings[0] + '</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  1-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[1]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  2-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[0]  + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  3-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[2]  + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[1]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  4-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[3]  + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  5-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s4.Strings[0]  + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  6-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[4]  + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[2]  + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  7-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[5]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  8-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[1]  + '</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     //  9-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[6]  + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[3]  + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 10-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[7]  + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 11-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s5.Strings[0]  + '</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 12-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[8]  + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[4]  + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 13-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[9]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 14-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[2]  + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 15-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[10] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[5]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 16-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[11] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 17-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s4.Strings[1]  + '</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 18-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[12] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[6]  + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 19-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[13]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 20-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[3]  + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 21-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[14] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[7]  + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 22-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[15] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 23-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="win">' + winner + '</div></td></tr>');      // 24-я строка закончена (победитель)
    sl.Add('<tr><td><div class="first">'    + s1.Strings[16] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[8]  + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 25-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[17] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 26-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[4]  + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 27-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[18] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[9]  + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 28-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[19] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 29-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s4.Strings[2]  + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 30-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[20] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[10] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 31-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[21] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 32-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[5]  + '</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 33-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[22] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[11] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 34-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[23] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 35-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s5.Strings[1]  + '</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 36-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[24] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[12] + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 37-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[25] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 38-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[6] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 39-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[26] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[13] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 40-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[27] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 41-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s4.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 42-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[28] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[14] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 43-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[29] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 44-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[7] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 45-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[30] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[15] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 46-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[31] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 47-я строка закончена
    s5.Free;
    s4.Free;
    s3.Free;
    s2.Free;
    s1.Free;
  end
  else if kr = 4 then // от 9 до 16 человек - 4 круга
  begin
    s1 := TStringList.Create;
    s2 := TStringList.Create;
    s3 := TStringList.Create;
    s4 := TStringList.Create;
    FDQuery.ParamByName('pKR').AsInteger  := 1; // - - - - - - - - - - - - - - -
    FDQuery.Open;
    while not FDQuery.Eof do
    begin
      if FDQuery.FieldByName('tournum1').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum1').AsString + ' - ' + FDQuery.FieldByName('fmim1').AsString;
      s1.Add(ctr);
      if FDQuery.FieldByName('tournum2').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum2').AsString + ' - ' + FDQuery.FieldByName('fmim2').AsString;
      s1.Add(ctr);   // В первом массиве всегда 16 элементов (т.е. 16 брекетов (строк) в отчете) и они НЕ пустые
      s2.Add(brecket());            // Заранее запоминаю результат, для отображения во втором круге
      FDQuery.Next;
    end;
    FDQuery.Close;   // Первый круг, просто запомнил пары в массив - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 2;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // Второй массив предварительно создан в первом цикле
    begin
       s2.Strings[0] := '&nbsp;';   // Если первый круг не закончен, все предварительные значения стираю
       s2.Strings[1] := '&nbsp;';
       s2.Strings[2] := '&nbsp;';
       s2.Strings[3] := '&nbsp;';
       s2.Strings[4] := '&nbsp;';
       s2.Strings[5] := '&nbsp;';
       s2.Strings[6] := '&nbsp;';
       s2.Strings[7] := '&nbsp;';
       s3.Add('&nbsp;');            // Если не было 2-го круга, то не было и 3-го
       s3.Add('&nbsp;');
       s3.Add('&nbsp;');
       s3.Add('&nbsp;');
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         case iy of
         1 :  s2.Strings[0] := ctr + s2.Strings[0];
         2 :  s2.Strings[2] := ctr + s2.Strings[2];
         3 :  s2.Strings[4] := ctr + s2.Strings[4];
         4 :  s2.Strings[6] := ctr + s2.Strings[6];
         end;
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         case iy of
         1 :  s2.Strings[1] := ctr + s2.Strings[1];
         2 :  s2.Strings[3] := ctr + s2.Strings[3];
         3 :  s2.Strings[5] := ctr + s2.Strings[5];
         4 :  s2.Strings[7] := ctr + s2.Strings[7];
         end;
         s3.Add(brecket());         // Заранее запоминаю результат, для отображения в третьем круге
         iy := iy + 1;
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Второй круг прочитал - - - - - - - - - - - - - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 3;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // 3-й массив предварительно создан в 2-ом цикле
    begin
       s3.Strings[0] := '&nbsp;';   // Если 2-й круг не закончен, все предварительные значения стираю
       s3.Strings[1] := '&nbsp;';
       s3.Strings[2] := '&nbsp;';
       s3.Strings[3] := '&nbsp;';
       s4.Add('&nbsp;');            // Если не было 3-го круга, то не было и 4-го
       s4.Add('&nbsp;');
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         if iy = 1  then s3.Strings[0] := ctr + s3.Strings[0]
         else            s3.Strings[2] := ctr + s3.Strings[2];
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         if iy = 1  then s3.Strings[1] := ctr + s3.Strings[1]
         else            s3.Strings[3] := ctr + s3.Strings[3];
         s4.Add(brecket());         // Заранее запоминаю результат, для отображения в 4-м круге
         iy := iy + 1;
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Третий круг прочитал - - - - - - - - - - - - - - - - - - -
    winner := '&nbsp;';
    FDQuery.ParamByName('pKR').AsInteger := 4;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then
    begin
       s4.Strings[0] := '&nbsp;';   // Если 3-й круг не закончен, все предварительные значения стираю
       s4.Strings[1] := '&nbsp;';
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
       if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
       s4.Strings[0] := ctr + s4.Strings[0];
       if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
       s4.Strings[1] := ctr + s4.Strings[1];
       if FDQuery.FieldByName('finish').AsBoolean then
       begin
               if  FDQuery.FieldByName('letter1').AsString = 'W' then  winner := FDQuery.FieldByName('fmim1').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter1').AsString = 'V' then  winner := FDQuery.FieldByName('fmim1').AsString
          else if  FDQuery.FieldByName('letter2').AsString = 'W' then  winner := FDQuery.FieldByName('fmim2').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter2').AsString = 'V' then  winner := FDQuery.FieldByName('fmim2').AsString
          else if (FDQuery.FieldByName('letter1').AsString = 'D') and (FDQuery.FieldByName('letter2').AsString = 'D')  then
                                                                       winner := 'DRAW [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if (FDQuery.FieldByName('letter1').AsString = '0') and (FDQuery.FieldByName('letter2').AsString = '0')  then
                                                                       winner :=  sBtnDef.Text     // Обоюдный невыход
          else if (FDQuery.FieldByName('letter1').AsString = 'X') and (FDQuery.FieldByName('letter2').AsString = 'X')  then
                                                                       winner := '&nbsp;';         // Некому было выходить (пусто)
       end;
    end;
    FDQuery.Close; // Дальше без цикла, перебором заполняю таблицу. Расчет на то, что количество записей всегда строго соблюдается (здесь без проверок)
    sl.Add('<tr><td width="' + IntToStr(iw) + '"><div class="first">' + s1.Strings[0] + '</div></td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">'                    + s2.Strings[0] + '</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 1-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[1] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 2-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[0] + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 3-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[2] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[1] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 4-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 5-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s4.Strings[0] + '</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 6-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[4] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[2] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 7-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[5] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 8-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[1] + '</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 9-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[6] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 10-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[7] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 11-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="win">' + winner + '</div></td></tr>');      // 12-я строка закончена (победитель)
    sl.Add('<tr><td><div class="first">'    + s1.Strings[8] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[4] + '</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 13-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[9] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 14-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                           + s3.Strings[2] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 15-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[10] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[5] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 16-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[11] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 17-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s4.Strings[1] + '</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 18-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[12] + '</div></td>');
    sl.Add('<td>'                           + s2.Strings[6] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 19-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[13] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 20-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'       + s3.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 21-я строка закончена
    sl.Add('<tr><td><div class="first">'    + s1.Strings[14] + '</div></td>');
    sl.Add('<td><div class="second">'       + s2.Strings[7] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 22-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[15] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 23-я строка закончена
    s4.Free;
    s3.Free;
    s2.Free;
    s1.Free;
  end
  else if kr = 3 then // от  5 до 8 человек - 3 круга
  begin
    s1 := TStringList.Create;
    s2 := TStringList.Create;
    s3 := TStringList.Create;
    FDQuery.ParamByName('pKR').AsInteger  := 1;  //  - - - - - - - - - - - - - -
    FDQuery.Open;
    while not FDQuery.Eof do
    begin
      if FDQuery.FieldByName('tournum1').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum1').AsString + ' - ' + FDQuery.FieldByName('fmim1').AsString;
      s1.Add(ctr);
      if FDQuery.FieldByName('tournum2').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum2').AsString + ' - ' + FDQuery.FieldByName('fmim2').AsString;
      s1.Add(ctr);   // В первом массиве всегда 8 элементов (т.е. 8 брекетов (строк) в отчете) и они НЕ пустые
      s2.Add(brecket());            // Заранее запоминаю результат, для отображения во втором круге
      FDQuery.Next;
    end;
    FDQuery.Close;   // Первый круг, просто запомнил пары в массив - - - - - - -
    FDQuery.ParamByName('pKR').AsInteger := 2;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then // Второй массив предварительно создан в первом цикле
    begin
       s2.Strings[0] := '&nbsp;';   // Если первый круг не закончен, все предварительные значения стираю
       s2.Strings[1] := '&nbsp;';
       s2.Strings[2] := '&nbsp;';
       s2.Strings[3] := '&nbsp;';
       s3.Add('&nbsp;');            // Если не было 2-го круга, то не было и 3-го
       s3.Add('&nbsp;');
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
      iy := 1;
      while not FDQuery.Eof do
      begin
         if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
         if iy = 1  then s2.Strings[0] := ctr + s2.Strings[0]
         else            s2.Strings[2] := ctr + s2.Strings[2];
         if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
         else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
         if iy = 1  then s2.Strings[1] := ctr + s2.Strings[1]
         else            s2.Strings[3] := ctr + s2.Strings[3];
         s3.Add(brecket());         // Заранее запоминаю результат, для отображения в третьем круге
         iy := iy + 1;
         FDQuery.Next;
       end;
    end;
    FDQuery.Close; // Второй круг прочитал - - - - - - - - - - - - - - - - - - -
    winner := '&nbsp;';
    FDQuery.ParamByName('pKR').AsInteger := 3;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then
    begin
       s3.Strings[0] := '&nbsp;';   // Если 2-й круг не закончен, все предварительные значения стираю
       s3.Strings[1] := '&nbsp;';
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
       if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
       s3.Strings[0] := ctr + s3.Strings[0];
       if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
       s3.Strings[1] := ctr + s3.Strings[1];
       if FDQuery.FieldByName('finish').AsBoolean then
       begin
               if  FDQuery.FieldByName('letter1').AsString = 'W' then  winner := FDQuery.FieldByName('fmim1').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter1').AsString = 'V' then  winner := FDQuery.FieldByName('fmim1').AsString
          else if  FDQuery.FieldByName('letter2').AsString = 'W' then  winner := FDQuery.FieldByName('fmim2').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter2').AsString = 'V' then  winner := FDQuery.FieldByName('fmim2').AsString
          else if (FDQuery.FieldByName('letter1').AsString = 'D') and (FDQuery.FieldByName('letter2').AsString = 'D')  then
                                                                       winner := 'DRAW [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if (FDQuery.FieldByName('letter1').AsString = '0') and (FDQuery.FieldByName('letter2').AsString = '0')  then
                                                                       winner :=  sBtnDef.Text     // Обоюдный невыход
          else if (FDQuery.FieldByName('letter1').AsString = 'X') and (FDQuery.FieldByName('letter2').AsString = 'X')  then
                                                                       winner := '&nbsp;';         // Некому было выходить (пусто)
       end;
    end;
    FDQuery.Close; // Дальше без цикла, перебором заполняю таблицу. Расчет на то, что количество записей всегда строго соблюдается (здесь без проверок)
    sl.Add('<tr><td width="' + IntToStr(iw) + '"><div class="first">' + s1.Strings[0] + '</div></td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">'                    + s2.Strings[0] + '</td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 1-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[1] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 2-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>'                         + s3.Strings[0] + '</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 3-я строка закончена
    sl.Add('<tr><td><div class="first">'  + s1.Strings[2] + '</div></td>');
    sl.Add('<td><div class="second">'     + s2.Strings[1] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 4-я строка закончена
    sl.Add('<tr><td><div class="second">' + s1.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 5-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="win">' + winner + '</div></td></tr>');      // 6-я строка закончена (победитель)
    sl.Add('<tr><td><div class="first">'  + s1.Strings[4] + '</div></td>');
    sl.Add('<td>'                         + s2.Strings[2] + '</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 7-я строка закончена
    sl.Add('<tr><td><div class="second">' + s1.Strings[5] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 8-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="second">'     + s3.Strings[1] + '</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 9-я строка закончена
    sl.Add('<tr><td><div class="first">'  + s1.Strings[6] + '</div></td>');
    sl.Add('<td><div class="second">'     + s2.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 10-я строка закончена
    sl.Add('<tr><td><div class="second">' + s1.Strings[7] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 11-я строка закончена
    s3.Free;
    s2.Free;
    s1.Free;
  end
  else if kr = 2 then // от 2 до 4 человек - 2 круга
  begin
    s1 := TStringList.Create;
    s2 := TStringList.Create;
    FDQuery.ParamByName('pKR').AsInteger  := 1;  //  - - - - - - - - - - - - - -
    FDQuery.Open;
    while not FDQuery.Eof do
    begin
      if FDQuery.FieldByName('tournum1').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum1').AsString + ' - ' + FDQuery.FieldByName('fmim1').AsString;
      s1.Add(ctr);
      if FDQuery.FieldByName('tournum2').IsNull then ctr := 'BYE'
      else                                           ctr := FDQuery.FieldByName('tournum2').AsString + ' - ' + FDQuery.FieldByName('fmim2').AsString;
      s1.Add(ctr);         // В первом массиве всегда 4 элемента и они НЕ пустые
      s2.Add(brecket());   // Заранее запоминаю результат, для отображения во втором круге
      FDQuery.Next;
    end;
    FDQuery.Close;         // Первый  круг - - - - - - - - - - - - - - - - - - -
    winner := '&nbsp;';
    FDQuery.ParamByName('pKR').AsInteger := 2;
    FDQuery.Open;
    if FDQuery.RecordCount = 0 then
    begin
       s2.Strings[0] := '&nbsp;'; // Если первый круг не закончен, все предварительные значения стираю
       s2.Strings[1] := '&nbsp;';
    end   // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    else
    begin
       if FDQuery.FieldByName('tournum1').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim1').AsString;
       s2.Strings[0] := ctr + s2.Strings[0];
       if FDQuery.FieldByName('tournum2').IsNull then ctr := ''
       else                                           ctr := FDQuery.FieldByName('fmim2').AsString;
       s2.Strings[1] := ctr + s2.Strings[1];
       if FDQuery.FieldByName('finish').AsBoolean then
       begin
               if  FDQuery.FieldByName('letter1').AsString = 'W' then  winner := FDQuery.FieldByName('fmim1').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter1').AsString = 'V' then  winner := FDQuery.FieldByName('fmim1').AsString
          else if  FDQuery.FieldByName('letter2').AsString = 'W' then  winner := FDQuery.FieldByName('fmim2').AsString + ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if  FDQuery.FieldByName('letter2').AsString = 'V' then  winner := FDQuery.FieldByName('fmim2').AsString
          else if (FDQuery.FieldByName('letter1').AsString = 'D') and (FDQuery.FieldByName('letter2').AsString = 'D')  then
                                                                       winner := 'DRAW [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
          else if (FDQuery.FieldByName('letter1').AsString = '0') and (FDQuery.FieldByName('letter2').AsString = '0')  then
                                                                       winner :=  sBtnDef.Text     // Обоюдный невыход
          else if (FDQuery.FieldByName('letter1').AsString = 'X') and (FDQuery.FieldByName('letter2').AsString = 'X')  then
                                                                       winner := '&nbsp;';         // Некому было выходить (пусто)
       end;
    end;
    FDQuery.Close; // Дальше без цикла, перебором заполняю таблицу. Расчет на то, что количество записей всегда строго соблюдается (здесь без проверок)
    sl.Add('<tr><td width="' + IntToStr(iw) + '"><div class="first">' + s1.Strings[0] + '</div></td>');
    sl.Add('<td width="'     + IntToStr(iw) + '">'                    + s2.Strings[0] + '</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 1-я строка закончена
    sl.Add('<tr><td><div class="second">'   + s1.Strings[1] + '</div></td>');
    sl.Add('<td><div class="first">&nbsp;</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 2-я строка закончена
    sl.Add('<tr><td>&nbsp;</td>');
    sl.Add('<td><div class="mid">&nbsp;</div></td>');
    sl.Add('<td><div class="win">' + winner + '</div></td></tr>');      // 3-я строка закончена (победитель)
    sl.Add('<tr><td><div class="first">'  + s1.Strings[2] + '</div></td>');
    sl.Add('<td><div class="second">'     + s2.Strings[1] + '</div></td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 4-я строка закончена
    sl.Add('<tr><td><div class="second">' + s1.Strings[3] + '</div></td>');
    sl.Add('<td>&nbsp;</td>');
    sl.Add('<td>&nbsp;</td></tr>');                                     // 5-я строка закончена
    s2.Free;
    s1.Free;
  end
  else                // строчка для чистоты кода
  begin
    sl.Add('<tr><td>&nbsp;</td></tr>');
  end;
  sl.Add('</table>');
  sl.Add('</td>');
  sl.Add('</tr>');                          //    Далее подножие - - - - - - - -
  sl.Add('<tr><td>&nbsp;</td></tr>');
  if rf.Length > 0 then sl.Add('<tr><td>' + rf + '</td></tr>');
  if se.Length > 0 then sl.Add('<tr><td>' + se + '</td></tr>');

  sl.Add('<tr><td height="40px" align="center">Made by CompeTTable (R).</td></tr>'); // проверить


  sl.Add('</table>');
  sl.Add('</body>');
  sl.Add('</html>');
{$IF DEFINED(ANDROID)}
  fName := TPath.Combine(TPath.GetPublicPath, fName);
{$ENDIF};
  sl.SaveToFile(fName);
  sl.Free;
end;

function Tfrm.twoString(const cn: String): String;
var
  c: String;
  x: integer;
begin
     x   := Pos(' (',     cn);
  if x   >  0   then c := cn.Substring(0, (x - 1)) + '<br>' + cn.Substring(x)
  else               c := cn;                  // Что было, то и оставляю
  Result := c;
end;

procedure Tfrm.olimp(); // В конце подправить одновременное включение-выключение кнопок круговой и олимпийской
var
  x: integer;           // За основу взят алгоритм для 128 человек из dodzeman
begin                   // Упрощен до 32 человек, без учета RANK и все участники как одна категория
  if (FDQuery.Active) then FDQuery.Close;
  FDQuery.SQL.Text    :=  'DELETE FROM battle WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.ExecSQL;      // На всякий случай удаляю записи (их не должно быть) предыдущих боев (для подстраховки)
  FDQuery.SQL.Text    :=  'DELETE FROM olimptmp';
  FDQuery.ExecSQL;
  x :=  1;
  FDQuery.SQL.Text    :=  'SELECT fgid FROM fighters WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.Open;
  FDTOtmp.Open;
  FDTOtmp.Append;
  while not FDQuery.Eof do // В данном цикле количество записей не контролирую
  begin
	  case x of
	     1 : FDTOtmp.FieldByName('01F001').Value := FDQuery.FieldByName('fgid').AsInteger;
	   128 : FDTOtmp.FieldByName('01F128').Value := FDQuery.FieldByName('fgid').AsInteger;
	    65 : FDTOtmp.FieldByName('02F065').Value := FDQuery.FieldByName('fgid').AsInteger;
	    64 : FDTOtmp.FieldByName('02F064').Value := FDQuery.FieldByName('fgid').AsInteger;
	    97 : FDTOtmp.FieldByName('03F097').Value := FDQuery.FieldByName('fgid').AsInteger;
	    32 : FDTOtmp.FieldByName('03F032').Value := FDQuery.FieldByName('fgid').AsInteger;
	    33 : FDTOtmp.FieldByName('04F033').Value := FDQuery.FieldByName('fgid').AsInteger;
	    96 : FDTOtmp.FieldByName('04F096').Value := FDQuery.FieldByName('fgid').AsInteger;
	   113 : FDTOtmp.FieldByName('05F113').Value := FDQuery.FieldByName('fgid').AsInteger;
	    16 : FDTOtmp.FieldByName('05F016').Value := FDQuery.FieldByName('fgid').AsInteger;
	    49 : FDTOtmp.FieldByName('06F049').Value := FDQuery.FieldByName('fgid').AsInteger;
	    80 : FDTOtmp.FieldByName('06F080').Value := FDQuery.FieldByName('fgid').AsInteger;
	    17 : FDTOtmp.FieldByName('07F017').Value := FDQuery.FieldByName('fgid').AsInteger;
	   112 : FDTOtmp.FieldByName('07F112').Value := FDQuery.FieldByName('fgid').AsInteger;
	    81 : FDTOtmp.FieldByName('08F081').Value := FDQuery.FieldByName('fgid').AsInteger;
	    48 : FDTOtmp.FieldByName('08F048').Value := FDQuery.FieldByName('fgid').AsInteger;
	   121 : FDTOtmp.FieldByName('09F121').Value := FDQuery.FieldByName('fgid').AsInteger;
	     8 : FDTOtmp.FieldByName('09F008').Value := FDQuery.FieldByName('fgid').AsInteger;
	    57 : FDTOtmp.FieldByName('10F057').Value := FDQuery.FieldByName('fgid').AsInteger;
	    72 : FDTOtmp.FieldByName('10F072').Value := FDQuery.FieldByName('fgid').AsInteger;
	    25 : FDTOtmp.FieldByName('11F025').Value := FDQuery.FieldByName('fgid').AsInteger;
	   104 : FDTOtmp.FieldByName('11F104').Value := FDQuery.FieldByName('fgid').AsInteger;
	    89 : FDTOtmp.FieldByName('12F089').Value := FDQuery.FieldByName('fgid').AsInteger;
	    40 : FDTOtmp.FieldByName('12F040').Value := FDQuery.FieldByName('fgid').AsInteger;
	     9 : FDTOtmp.FieldByName('13F009').Value := FDQuery.FieldByName('fgid').AsInteger;
	   120 : FDTOtmp.FieldByName('13F120').Value := FDQuery.FieldByName('fgid').AsInteger;
	    73 : FDTOtmp.FieldByName('14F073').Value := FDQuery.FieldByName('fgid').AsInteger;
	    56 : FDTOtmp.FieldByName('14F056').Value := FDQuery.FieldByName('fgid').AsInteger;
	   105 : FDTOtmp.FieldByName('15F105').Value := FDQuery.FieldByName('fgid').AsInteger;
	    24 : FDTOtmp.FieldByName('15F024').Value := FDQuery.FieldByName('fgid').AsInteger;
	    41 : FDTOtmp.FieldByName('16F041').Value := FDQuery.FieldByName('fgid').AsInteger;
	    88 : FDTOtmp.FieldByName('16F088').Value := FDQuery.FieldByName('fgid').AsInteger;
	   125 : FDTOtmp.FieldByName('17F125').Value := FDQuery.FieldByName('fgid').AsInteger;
	     4 : FDTOtmp.FieldByName('17F004').Value := FDQuery.FieldByName('fgid').AsInteger;
	    61 : FDTOtmp.FieldByName('18F061').Value := FDQuery.FieldByName('fgid').AsInteger;
	    68 : FDTOtmp.FieldByName('18F068').Value := FDQuery.FieldByName('fgid').AsInteger;
	    29 : FDTOtmp.FieldByName('19F029').Value := FDQuery.FieldByName('fgid').AsInteger;
	   100 : FDTOtmp.FieldByName('19F100').Value := FDQuery.FieldByName('fgid').AsInteger;
	    93 : FDTOtmp.FieldByName('20F093').Value := FDQuery.FieldByName('fgid').AsInteger;
	    36 : FDTOtmp.FieldByName('20F036').Value := FDQuery.FieldByName('fgid').AsInteger;
	    13 : FDTOtmp.FieldByName('21F013').Value := FDQuery.FieldByName('fgid').AsInteger;
	   116 : FDTOtmp.FieldByName('21F116').Value := FDQuery.FieldByName('fgid').AsInteger;
	    77 : FDTOtmp.FieldByName('22F077').Value := FDQuery.FieldByName('fgid').AsInteger;
	    52 : FDTOtmp.FieldByName('22F052').Value := FDQuery.FieldByName('fgid').AsInteger;
	   109 : FDTOtmp.FieldByName('23F109').Value := FDQuery.FieldByName('fgid').AsInteger;
	    20 : FDTOtmp.FieldByName('23F020').Value := FDQuery.FieldByName('fgid').AsInteger;
	    45 : FDTOtmp.FieldByName('24F045').Value := FDQuery.FieldByName('fgid').AsInteger;
	    84 : FDTOtmp.FieldByName('24F084').Value := FDQuery.FieldByName('fgid').AsInteger;
	     5 : FDTOtmp.FieldByName('25F005').Value := FDQuery.FieldByName('fgid').AsInteger;
	   124 : FDTOtmp.FieldByName('25F124').Value := FDQuery.FieldByName('fgid').AsInteger;
	    69 : FDTOtmp.FieldByName('26F069').Value := FDQuery.FieldByName('fgid').AsInteger;
	    60 : FDTOtmp.FieldByName('26F060').Value := FDQuery.FieldByName('fgid').AsInteger;
	   101 : FDTOtmp.FieldByName('27F101').Value := FDQuery.FieldByName('fgid').AsInteger;
	    28 : FDTOtmp.FieldByName('27F028').Value := FDQuery.FieldByName('fgid').AsInteger;
	    37 : FDTOtmp.FieldByName('28F037').Value := FDQuery.FieldByName('fgid').AsInteger;
	    92 : FDTOtmp.FieldByName('28F092').Value := FDQuery.FieldByName('fgid').AsInteger;
	   117 : FDTOtmp.FieldByName('29F117').Value := FDQuery.FieldByName('fgid').AsInteger;
	    12 : FDTOtmp.FieldByName('29F012').Value := FDQuery.FieldByName('fgid').AsInteger;
	    53 : FDTOtmp.FieldByName('30F053').Value := FDQuery.FieldByName('fgid').AsInteger;
	    76 : FDTOtmp.FieldByName('30F076').Value := FDQuery.FieldByName('fgid').AsInteger;
	    21 : FDTOtmp.FieldByName('31F021').Value := FDQuery.FieldByName('fgid').AsInteger;
	   108 : FDTOtmp.FieldByName('31F108').Value := FDQuery.FieldByName('fgid').AsInteger;
	    85 : FDTOtmp.FieldByName('32F085').Value := FDQuery.FieldByName('fgid').AsInteger;
	    44 : FDTOtmp.FieldByName('32F044').Value := FDQuery.FieldByName('fgid').AsInteger;
	   127 : FDTOtmp.FieldByName('33F127').Value := FDQuery.FieldByName('fgid').AsInteger;
	     2 : FDTOtmp.FieldByName('33F002').Value := FDQuery.FieldByName('fgid').AsInteger;
	    63 : FDTOtmp.FieldByName('34F063').Value := FDQuery.FieldByName('fgid').AsInteger;
	    66 : FDTOtmp.FieldByName('34F066').Value := FDQuery.FieldByName('fgid').AsInteger;
	    31 : FDTOtmp.FieldByName('35F031').Value := FDQuery.FieldByName('fgid').AsInteger;
	    98 : FDTOtmp.FieldByName('35F098').Value := FDQuery.FieldByName('fgid').AsInteger;
	    95 : FDTOtmp.FieldByName('36F095').Value := FDQuery.FieldByName('fgid').AsInteger;
	    34 : FDTOtmp.FieldByName('36F034').Value := FDQuery.FieldByName('fgid').AsInteger;
	    15 : FDTOtmp.FieldByName('37F015').Value := FDQuery.FieldByName('fgid').AsInteger;
	   114 : FDTOtmp.FieldByName('37F114').Value := FDQuery.FieldByName('fgid').AsInteger;
	    79 : FDTOtmp.FieldByName('38F079').Value := FDQuery.FieldByName('fgid').AsInteger;
	    50 : FDTOtmp.FieldByName('38F050').Value := FDQuery.FieldByName('fgid').AsInteger;
	   111 : FDTOtmp.FieldByName('39F111').Value := FDQuery.FieldByName('fgid').AsInteger;
	    18 : FDTOtmp.FieldByName('39F018').Value := FDQuery.FieldByName('fgid').AsInteger;
	    47 : FDTOtmp.FieldByName('40F047').Value := FDQuery.FieldByName('fgid').AsInteger;
	    82 : FDTOtmp.FieldByName('40F082').Value := FDQuery.FieldByName('fgid').AsInteger;
	     7 : FDTOtmp.FieldByName('41F007').Value := FDQuery.FieldByName('fgid').AsInteger;
	   122 : FDTOtmp.FieldByName('41F122').Value := FDQuery.FieldByName('fgid').AsInteger;
	    71 : FDTOtmp.FieldByName('42F071').Value := FDQuery.FieldByName('fgid').AsInteger;
	    58 : FDTOtmp.FieldByName('42F058').Value := FDQuery.FieldByName('fgid').AsInteger;
	   103 : FDTOtmp.FieldByName('43F103').Value := FDQuery.FieldByName('fgid').AsInteger;
	    26 : FDTOtmp.FieldByName('43F026').Value := FDQuery.FieldByName('fgid').AsInteger;
	    39 : FDTOtmp.FieldByName('44F039').Value := FDQuery.FieldByName('fgid').AsInteger;
	    90 : FDTOtmp.FieldByName('44F090').Value := FDQuery.FieldByName('fgid').AsInteger;
	   119 : FDTOtmp.FieldByName('45F119').Value := FDQuery.FieldByName('fgid').AsInteger;
	    10 : FDTOtmp.FieldByName('45F010').Value := FDQuery.FieldByName('fgid').AsInteger;
	    55 : FDTOtmp.FieldByName('46F055').Value := FDQuery.FieldByName('fgid').AsInteger;
	    74 : FDTOtmp.FieldByName('46F074').Value := FDQuery.FieldByName('fgid').AsInteger;
	    23 : FDTOtmp.FieldByName('47F023').Value := FDQuery.FieldByName('fgid').AsInteger;
	   106 : FDTOtmp.FieldByName('47F106').Value := FDQuery.FieldByName('fgid').AsInteger;
	    87 : FDTOtmp.FieldByName('48F087').Value := FDQuery.FieldByName('fgid').AsInteger;
	    42 : FDTOtmp.FieldByName('48F042').Value := FDQuery.FieldByName('fgid').AsInteger;
	     3 : FDTOtmp.FieldByName('49F003').Value := FDQuery.FieldByName('fgid').AsInteger;
	   126 : FDTOtmp.FieldByName('49F126').Value := FDQuery.FieldByName('fgid').AsInteger;
	    67 : FDTOtmp.FieldByName('50F067').Value := FDQuery.FieldByName('fgid').AsInteger;
	    62 : FDTOtmp.FieldByName('50F062').Value := FDQuery.FieldByName('fgid').AsInteger;
	    99 : FDTOtmp.FieldByName('51F099').Value := FDQuery.FieldByName('fgid').AsInteger;
	    30 : FDTOtmp.FieldByName('51F030').Value := FDQuery.FieldByName('fgid').AsInteger;
	    35 : FDTOtmp.FieldByName('52F035').Value := FDQuery.FieldByName('fgid').AsInteger;
	    94 : FDTOtmp.FieldByName('52F094').Value := FDQuery.FieldByName('fgid').AsInteger;
	   115 : FDTOtmp.FieldByName('53F115').Value := FDQuery.FieldByName('fgid').AsInteger;
	    14 : FDTOtmp.FieldByName('53F014').Value := FDQuery.FieldByName('fgid').AsInteger;
	    51 : FDTOtmp.FieldByName('54F051').Value := FDQuery.FieldByName('fgid').AsInteger;
	    78 : FDTOtmp.FieldByName('54F078').Value := FDQuery.FieldByName('fgid').AsInteger;
	    19 : FDTOtmp.FieldByName('55F019').Value := FDQuery.FieldByName('fgid').AsInteger;
	   110 : FDTOtmp.FieldByName('55F110').Value := FDQuery.FieldByName('fgid').AsInteger;
	    83 : FDTOtmp.FieldByName('56F083').Value := FDQuery.FieldByName('fgid').AsInteger;
	    46 : FDTOtmp.FieldByName('56F046').Value := FDQuery.FieldByName('fgid').AsInteger;
	   123 : FDTOtmp.FieldByName('57F123').Value := FDQuery.FieldByName('fgid').AsInteger;
	     6 : FDTOtmp.FieldByName('57F006').Value := FDQuery.FieldByName('fgid').AsInteger;
	    59 : FDTOtmp.FieldByName('58F059').Value := FDQuery.FieldByName('fgid').AsInteger;
	    70 : FDTOtmp.FieldByName('58F070').Value := FDQuery.FieldByName('fgid').AsInteger;
	    27 : FDTOtmp.FieldByName('59F027').Value := FDQuery.FieldByName('fgid').AsInteger;
	   102 : FDTOtmp.FieldByName('59F102').Value := FDQuery.FieldByName('fgid').AsInteger;
	    91 : FDTOtmp.FieldByName('60F091').Value := FDQuery.FieldByName('fgid').AsInteger;
	    38 : FDTOtmp.FieldByName('60F038').Value := FDQuery.FieldByName('fgid').AsInteger;
	    11 : FDTOtmp.FieldByName('61F011').Value := FDQuery.FieldByName('fgid').AsInteger;
	   118 : FDTOtmp.FieldByName('61F118').Value := FDQuery.FieldByName('fgid').AsInteger;
	    75 : FDTOtmp.FieldByName('62F075').Value := FDQuery.FieldByName('fgid').AsInteger;
	    54 : FDTOtmp.FieldByName('62F054').Value := FDQuery.FieldByName('fgid').AsInteger;
	   107 : FDTOtmp.FieldByName('63F107').Value := FDQuery.FieldByName('fgid').AsInteger;
	    22 : FDTOtmp.FieldByName('63F022').Value := FDQuery.FieldByName('fgid').AsInteger;
	    43 : FDTOtmp.FieldByName('64F043').Value := FDQuery.FieldByName('fgid').AsInteger;
	    86 : FDTOtmp.FieldByName('64F086').Value := FDQuery.FieldByName('fgid').AsInteger;
    end;
		x := x + 1;    // Вписываю в схему для 128 человек всех, кто есть на данный момент
    FDQuery.Next;
  end;
  FDTOtmp.Post;
  FDQuery.Close;
  x := 0;          // Сюда подсчитаю пары без нуля, т.е. два реальных бойца
  FDTOtmp.Edit;
  if  (FDTOtmp.FieldByName('01F001').AsInteger = 0) or (FDTOtmp.FieldByName('01F128').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('01F001').AsInteger       >  FDTOtmp.FieldByName('01F128').AsInteger      then
		   FDTOtmp.FieldByName('2L01').Value            :=  FDTOtmp.FieldByName('01F001').AsInteger;
	  if FDTOtmp.FieldByName('01F001').AsInteger       <  FDTOtmp.FieldByName('01F128').AsInteger      then
		   FDTOtmp.FieldByName('2L01').Value            :=  FDTOtmp.FieldByName('01F128').AsInteger;
  end
  else x := x + 1; // Если оба не нули, то надо проводить бой  в этом круге, как минимум один
  if  (FDTOtmp.FieldByName('02F065').AsInteger = 0) or (FDTOtmp.FieldByName('02F064').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('02F065').AsInteger       >  FDTOtmp.FieldByName('02F064').AsInteger      then
		   FDTOtmp.FieldByName('2R01').Value            :=  FDTOtmp.FieldByName('02F065').AsInteger;
	  if FDTOtmp.FieldByName('02F065').AsInteger       <  FDTOtmp.FieldByName('02F064').AsInteger      then
		   FDTOtmp.FieldByName('2R01').Value            :=  FDTOtmp.FieldByName('02F064').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('03F097').AsInteger = 0) or (FDTOtmp.FieldByName('03F032').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('03F097').AsInteger       >  FDTOtmp.FieldByName('03F032').AsInteger      then
		   FDTOtmp.FieldByName('2L02').Value            :=  FDTOtmp.FieldByName('03F097').AsInteger;
	  if FDTOtmp.FieldByName('03F097').AsInteger       <  FDTOtmp.FieldByName('03F032').AsInteger      then
		   FDTOtmp.FieldByName('2L02').Value            :=  FDTOtmp.FieldByName('03F032').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('04F033').AsInteger = 0) or (FDTOtmp.FieldByName('04F096').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('04F033').AsInteger       >  FDTOtmp.FieldByName('04F096').AsInteger      then
		   FDTOtmp.FieldByName('2R02').Value            :=  FDTOtmp.FieldByName('04F033').AsInteger;
	  if FDTOtmp.FieldByName('04F033').AsInteger       <  FDTOtmp.FieldByName('04F096').AsInteger      then
		   FDTOtmp.FieldByName('2R02').Value            :=  FDTOtmp.FieldByName('04F096').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('05F113').AsInteger = 0) or (FDTOtmp.FieldByName('05F016').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('05F113').AsInteger       >  FDTOtmp.FieldByName('05F016').AsInteger      then
		   FDTOtmp.FieldByName('2L03').Value            :=  FDTOtmp.FieldByName('05F113').AsInteger;
	  if FDTOtmp.FieldByName('05F113').AsInteger       <  FDTOtmp.FieldByName('05F016').AsInteger      then
	     FDTOtmp.FieldByName('2L03').Value            :=  FDTOtmp.FieldByName('05F016').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('06F049').AsInteger = 0) or (FDTOtmp.FieldByName('06F080').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('06F049').AsInteger       >  FDTOtmp.FieldByName('06F080').AsInteger      then
		   FDTOtmp.FieldByName('2R03').Value            :=  FDTOtmp.FieldByName('06F049').AsInteger;
	  if FDTOtmp.FieldByName('06F049').AsInteger       <  FDTOtmp.FieldByName('06F080').AsInteger      then
		   FDTOtmp.FieldByName('2R03').Value            :=  FDTOtmp.FieldByName('06F080').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('07F017').AsInteger = 0) or (FDTOtmp.FieldByName('07F112').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('07F017').AsInteger       >  FDTOtmp.FieldByName('07F112').AsInteger      then
		   FDTOtmp.FieldByName('2L04').Value            :=  FDTOtmp.FieldByName('07F017').AsInteger;
	  if FDTOtmp.FieldByName('07F017').AsInteger       <  FDTOtmp.FieldByName('07F112').AsInteger      then
		   FDTOtmp.FieldByName('2L04').Value            :=  FDTOtmp.FieldByName('07F112').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('08F081').AsInteger = 0) or (FDTOtmp.FieldByName('08F048').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('08F081').AsInteger       >  FDTOtmp.FieldByName('08F048').AsInteger      then
		   FDTOtmp.FieldByName('2R04').Value            :=  FDTOtmp.FieldByName('08F081').AsInteger;
	  if FDTOtmp.FieldByName('08F081').AsInteger       <  FDTOtmp.FieldByName('08F048').AsInteger      then
		   FDTOtmp.FieldByName('2R04').Value            :=  FDTOtmp.FieldByName('08F048').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('09F121').AsInteger = 0) or (FDTOtmp.FieldByName('09F008').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('09F121').AsInteger       >  FDTOtmp.FieldByName('09F008').AsInteger      then
		   FDTOtmp.FieldByName('2L05').Value            :=  FDTOtmp.FieldByName('09F121').AsInteger;
	  if FDTOtmp.FieldByName('09F121').AsInteger       <  FDTOtmp.FieldByName('09F008').AsInteger      then
		   FDTOtmp.FieldByName('2L05').Value            :=  FDTOtmp.FieldByName('09F008').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('10F057').AsInteger = 0) or (FDTOtmp.FieldByName('10F072').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('10F057').AsInteger       >  FDTOtmp.FieldByName('10F072').AsInteger      then
		   FDTOtmp.FieldByName('2R05').Value            :=  FDTOtmp.FieldByName('10F057').AsInteger;
	  if FDTOtmp.FieldByName('10F057').AsInteger       <  FDTOtmp.FieldByName('10F072').AsInteger      then
		   FDTOtmp.FieldByName('2R05').Value            :=  FDTOtmp.FieldByName('10F072').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('11F025').AsInteger = 0) or (FDTOtmp.FieldByName('11F104').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('11F025').AsInteger       >  FDTOtmp.FieldByName('11F104').AsInteger      then
		   FDTOtmp.FieldByName('2L06').Value            :=  FDTOtmp.FieldByName('11F025').AsInteger;
	  if FDTOtmp.FieldByName('11F025').AsInteger       <  FDTOtmp.FieldByName('11F104').AsInteger      then
		   FDTOtmp.FieldByName('2L06').Value            :=  FDTOtmp.FieldByName('11F104').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('12F089').AsInteger = 0) or (FDTOtmp.FieldByName('12F040').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('12F089').AsInteger       >  FDTOtmp.FieldByName('12F040').AsInteger      then
		   FDTOtmp.FieldByName('2R06').Value            :=  FDTOtmp.FieldByName('12F089').AsInteger;
	  if FDTOtmp.FieldByName('12F089').AsInteger       <  FDTOtmp.FieldByName('12F040').AsInteger      then
		   FDTOtmp.FieldByName('2R06').Value            :=  FDTOtmp.FieldByName('12F040').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('13F009').AsInteger = 0) or (FDTOtmp.FieldByName('13F120').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('13F009').AsInteger       >  FDTOtmp.FieldByName('13F120').AsInteger      then
		   FDTOtmp.FieldByName('2L07').Value            :=  FDTOtmp.FieldByName('13F009').AsInteger;
	  if FDTOtmp.FieldByName('13F009').AsInteger       <  FDTOtmp.FieldByName('13F120').AsInteger      then
		   FDTOtmp.FieldByName('2L07').Value            :=  FDTOtmp.FieldByName('13F120').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('14F073').AsInteger = 0) or (FDTOtmp.FieldByName('14F056').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('14F073').AsInteger       >  FDTOtmp.FieldByName('14F056').AsInteger      then
		   FDTOtmp.FieldByName('2R07').Value            :=  FDTOtmp.FieldByName('14F073').AsInteger;
	  if FDTOtmp.FieldByName('14F073').AsInteger       <  FDTOtmp.FieldByName('14F056').AsInteger      then
		   FDTOtmp.FieldByName('2R07').Value            :=  FDTOtmp.FieldByName('14F056').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('15F105').AsInteger = 0) or (FDTOtmp.FieldByName('15F024').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('15F105').AsInteger       >  FDTOtmp.FieldByName('15F024').AsInteger      then
		   FDTOtmp.FieldByName('2L08').Value            :=  FDTOtmp.FieldByName('15F105').AsInteger;
	  if FDTOtmp.FieldByName('15F105').AsInteger       <  FDTOtmp.FieldByName('15F024').AsInteger      then
		   FDTOtmp.FieldByName('2L08').Value            :=  FDTOtmp.FieldByName('15F024').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('16F041').AsInteger = 0) OR (FDTOtmp.FieldByName('16F088').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('16F041').AsInteger       >  FDTOtmp.FieldByName('16F088').AsInteger      then
		   FDTOtmp.FieldByName('2R08').Value            :=  FDTOtmp.FieldByName('16F041').AsInteger;
	  if FDTOtmp.FieldByName('16F041').AsInteger       <  FDTOtmp.FieldByName('16F088').AsInteger      then
		   FDTOtmp.FieldByName('2R08').Value            :=  FDTOtmp.FieldByName('16F088').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('17F125').AsInteger = 0) or (FDTOtmp.FieldByName('17F004').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('17F125').AsInteger       >  FDTOtmp.FieldByName('17F004').AsInteger      then
		   FDTOtmp.FieldByName('2L09').Value            :=  FDTOtmp.FieldByName('17F125').AsInteger;
	  if FDTOtmp.FieldByName('17F125').AsInteger       <  FDTOtmp.FieldByName('17F004').AsInteger      then
	     FDTOtmp.FieldByName('2L09').Value            :=  FDTOtmp.FieldByName('17F004').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('18F061').AsInteger = 0) or (FDTOtmp.FieldByName('18F068').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('18F061').AsInteger       >  FDTOtmp.FieldByName('18F068').AsInteger      then
		   FDTOtmp.FieldByName('2R09').Value            :=  FDTOtmp.FieldByName('18F061').AsInteger;
	  if FDTOtmp.FieldByName('18F061').AsInteger       <  FDTOtmp.FieldByName('18F068').AsInteger      then
		   FDTOtmp.FieldByName('2R09').Value            :=  FDTOtmp.FieldByName('18F068').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('19F029').AsInteger = 0) or (FDTOtmp.FieldByName('19F100').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('19F029').AsInteger       >  FDTOtmp.FieldByName('19F100').AsInteger      then
		   FDTOtmp.FieldByName('2L10').Value            :=  FDTOtmp.FieldByName('19F029').AsInteger;
	  if FDTOtmp.FieldByName('19F029').AsInteger       <  FDTOtmp.FieldByName('19F100').AsInteger      then
		   FDTOtmp.FieldByName('2L10').Value            :=  FDTOtmp.FieldByName('19F100').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('20F093').AsInteger = 0) or (FDTOtmp.FieldByName('20F036').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('20F093').AsInteger       >  FDTOtmp.FieldByName('20F036').AsInteger      then
		   FDTOtmp.FieldByName('2R10').Value            :=  FDTOtmp.FieldByName('20F093').AsInteger;
	  if FDTOtmp.FieldByName('20F093').AsInteger       <  FDTOtmp.FieldByName('20F036').AsInteger      then
		   FDTOtmp.FieldByName('2R10').Value            :=  FDTOtmp.FieldByName('20F036').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('21F013').AsInteger = 0) or (FDTOtmp.FieldByName('21F116').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('21F013').AsInteger       >  FDTOtmp.FieldByName('21F116').AsInteger      then
		   FDTOtmp.FieldByName('2L11').Value            :=  FDTOtmp.FieldByName('21F013').AsInteger;
	  if FDTOtmp.FieldByName('21F013').AsInteger       <  FDTOtmp.FieldByName('21F116').AsInteger      then
		   FDTOtmp.FieldByName('2L11').Value            :=  FDTOtmp.FieldByName('21F116').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('22F077').AsInteger = 0) or (FDTOtmp.FieldByName('22F052').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('22F077').AsInteger       >  FDTOtmp.FieldByName('22F052').AsInteger      then
		   FDTOtmp.FieldByName('2R11').Value            :=  FDTOtmp.FieldByName('22F077').AsInteger;
	  if FDTOtmp.FieldByName('22F077').AsInteger       <  FDTOtmp.FieldByName('22F052').AsInteger      then
		   FDTOtmp.FieldByName('2R11').Value            :=  FDTOtmp.FieldByName('22F052').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('23F109').AsInteger = 0) or (FDTOtmp.FieldByName('23F020').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('23F109').AsInteger       >  FDTOtmp.FieldByName('23F020').AsInteger      then
		   FDTOtmp.FieldByName('2L12').Value            :=  FDTOtmp.FieldByName('23F109').AsInteger;
	  if FDTOtmp.FieldByName('23F109').AsInteger       <  FDTOtmp.FieldByName('23F020').AsInteger      then
		   FDTOtmp.FieldByName('2L12').Value            :=  FDTOtmp.FieldByName('23F020').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('24F045').AsInteger = 0) or (FDTOtmp.FieldByName('24F084').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('24F045').AsInteger       >  FDTOtmp.FieldByName('24F084').AsInteger      then
		   FDTOtmp.FieldByName('2R12').Value            :=  FDTOtmp.FieldByName('24F045').AsInteger;
	  if FDTOtmp.FieldByName('24F045').AsInteger       <  FDTOtmp.FieldByName('24F084').AsInteger      then
		   FDTOtmp.FieldByName('2R12').Value            :=  FDTOtmp.FieldByName('24F084').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('25F005').AsInteger = 0) or (FDTOtmp.FieldByName('25F124').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('25F005').AsInteger       >  FDTOtmp.FieldByName('25F124').AsInteger      then
		   FDTOtmp.FieldByName('2L13').Value            :=  FDTOtmp.FieldByName('25F005').AsInteger;
	  if FDTOtmp.FieldByName('25F005').AsInteger       <  FDTOtmp.FieldByName('25F124').AsInteger      then
		   FDTOtmp.FieldByName('2L13').Value            :=  FDTOtmp.FieldByName('25F124').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('26F069').AsInteger = 0) or (FDTOtmp.FieldByName('26F060').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('26F069').AsInteger       >  FDTOtmp.FieldByName('26F060').AsInteger      then
		   FDTOtmp.FieldByName('2R13').Value            :=  FDTOtmp.FieldByName('26F069').AsInteger;
	  if FDTOtmp.FieldByName('26F069').AsInteger       <  FDTOtmp.FieldByName('26F060').AsInteger      then
		   FDTOtmp.FieldByName('2R13').Value            :=  FDTOtmp.FieldByName('26F060').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('27F101').AsInteger = 0) or (FDTOtmp.FieldByName('27F028').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('27F101').AsInteger       >  FDTOtmp.FieldByName('27F028').AsInteger      then
		   FDTOtmp.FieldByName('2L14').Value            :=  FDTOtmp.FieldByName('27F101').AsInteger;
	  if FDTOtmp.FieldByName('27F101').AsInteger       <  FDTOtmp.FieldByName('27F028').AsInteger      then
		   FDTOtmp.FieldByName('2L14').Value            :=  FDTOtmp.FieldByName('27F028').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('28F037').AsInteger = 0) or (FDTOtmp.FieldByName('28F092').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('28F037').AsInteger       >  FDTOtmp.FieldByName('28F092').AsInteger      then
		   FDTOtmp.FieldByName('2R14').Value            :=  FDTOtmp.FieldByName('28F037').AsInteger;
	  if FDTOtmp.FieldByName('28F037').AsInteger       <  FDTOtmp.FieldByName('28F092').AsInteger      then
		   FDTOtmp.FieldByName('2R14').Value            :=  FDTOtmp.FieldByName('28F092').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('29F117').AsInteger = 0) or (FDTOtmp.FieldByName('29F012').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('29F117').AsInteger       >  FDTOtmp.FieldByName('29F012').AsInteger      then
		   FDTOtmp.FieldByName('2L15').Value            :=  FDTOtmp.FieldByName('29F117').AsInteger;
	  if FDTOtmp.FieldByName('29F117').AsInteger       <  FDTOtmp.FieldByName('29F012').AsInteger      then
		   FDTOtmp.FieldByName('2L15').Value            :=  FDTOtmp.FieldByName('29F012').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('30F053').AsInteger = 0) or (FDTOtmp.FieldByName('30F076').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('30F053').AsInteger       >  FDTOtmp.FieldByName('30F076').AsInteger      then
		   FDTOtmp.FieldByName('2R15').Value            :=  FDTOtmp.FieldByName('30F053').AsInteger;
	  if FDTOtmp.FieldByName('30F053').AsInteger       <  FDTOtmp.FieldByName('30F076').AsInteger      then
		   FDTOtmp.FieldByName('2R15').Value            :=  FDTOtmp.FieldByName('30F076').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('31F021').AsInteger = 0) or (FDTOtmp.FieldByName('31F108').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('31F021').AsInteger       >  FDTOtmp.FieldByName('31F108').AsInteger      then
		   FDTOtmp.FieldByName('2L16').Value            :=  FDTOtmp.FieldByName('31F021').AsInteger;
	  if FDTOtmp.FieldByName('31F021').AsInteger       <  FDTOtmp.FieldByName('31F108').AsInteger      then
		   FDTOtmp.FieldByName('2L16').Value            :=  FDTOtmp.FieldByName('31F108').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('32F085').AsInteger = 0) or (FDTOtmp.FieldByName('32F044').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('32F085').AsInteger       >  FDTOtmp.FieldByName('32F044').AsInteger      then
		   FDTOtmp.FieldByName('2R16').Value            :=  FDTOtmp.FieldByName('32F085').AsInteger;
	  if FDTOtmp.FieldByName('32F085').AsInteger       <  FDTOtmp.FieldByName('32F044').AsInteger      then
		   FDTOtmp.FieldByName('2R16').Value            :=  FDTOtmp.FieldByName('32F044').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('33F127').AsInteger = 0) or (FDTOtmp.FieldByName('33F002').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('33F127').AsInteger       >  FDTOtmp.FieldByName('33F002').AsInteger      then
		   FDTOtmp.FieldByName('2L17').Value            :=  FDTOtmp.FieldByName('33F127').AsInteger;
	  if FDTOtmp.FieldByName('33F127').AsInteger       <  FDTOtmp.FieldByName('33F002').AsInteger      then
		   FDTOtmp.FieldByName('2L17').Value            :=  FDTOtmp.FieldByName('33F002').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('34F063').AsInteger = 0) or (FDTOtmp.FieldByName('34F066').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('34F063').AsInteger       >  FDTOtmp.FieldByName('34F066').AsInteger      then
		   FDTOtmp.FieldByName('2R17').Value            :=  FDTOtmp.FieldByName('34F063').AsInteger;
	  if FDTOtmp.FieldByName('34F063').AsInteger       <  FDTOtmp.FieldByName('34F066').AsInteger      then
		   FDTOtmp.FieldByName('2R17').Value            :=  FDTOtmp.FieldByName('34F066').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('35F031').AsInteger = 0) or (FDTOtmp.FieldByName('35F098').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('35F031').AsInteger       >  FDTOtmp.FieldByName('35F098').AsInteger      then
		   FDTOtmp.FieldByName('2L18').Value            :=  FDTOtmp.FieldByName('35F031').AsInteger;
	  if FDTOtmp.FieldByName('35F031').AsInteger       <  FDTOtmp.FieldByName('35F098').AsInteger      then
		   FDTOtmp.FieldByName('2L18').Value            :=  FDTOtmp.FieldByName('35F098').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('36F095').AsInteger = 0) or (FDTOtmp.FieldByName('36F034').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('36F095').AsInteger       >  FDTOtmp.FieldByName('36F034').AsInteger      then
		   FDTOtmp.FieldByName('2R18').Value            :=  FDTOtmp.FieldByName('36F095').AsInteger;
	  if FDTOtmp.FieldByName('36F095').AsInteger       <  FDTOtmp.FieldByName('36F034').AsInteger      then
		   FDTOtmp.FieldByName('2R18').Value            :=  FDTOtmp.FieldByName('36F034').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('37F015').AsInteger = 0) or (FDTOtmp.FieldByName('37F114').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('37F015').AsInteger       >  FDTOtmp.FieldByName('37F114').AsInteger      then
		   FDTOtmp.FieldByName('2L19').Value            :=  FDTOtmp.FieldByName('37F015').AsInteger;
	  if FDTOtmp.FieldByName('37F015').AsInteger       <  FDTOtmp.FieldByName('37F114').AsInteger      then
		   FDTOtmp.FieldByName('2L19').Value            :=  FDTOtmp.FieldByName('37F114').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('38F079').AsInteger = 0) or (FDTOtmp.FieldByName('38F050').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('38F079').AsInteger       >  FDTOtmp.FieldByName('38F050').AsInteger      then
		   FDTOtmp.FieldByName('2R19').Value            :=  FDTOtmp.FieldByName('38F079').AsInteger;
	  if FDTOtmp.FieldByName('38F079').AsInteger       <  FDTOtmp.FieldByName('38F050').AsInteger      then
		   FDTOtmp.FieldByName('2R19').Value            :=  FDTOtmp.FieldByName('38F050').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('39F111').AsInteger = 0) or (FDTOtmp.FieldByName('39F018').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('39F111').AsInteger       >  FDTOtmp.FieldByName('39F018').AsInteger      then
		   FDTOtmp.FieldByName('2L20').Value            :=  FDTOtmp.FieldByName('39F111').AsInteger;
	  if FDTOtmp.FieldByName('39F111').AsInteger       <  FDTOtmp.FieldByName('39F018').AsInteger      then
		   FDTOtmp.FieldByName('2L20').Value            :=  FDTOtmp.FieldByName('39F018').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('40F047').AsInteger = 0) or (FDTOtmp.FieldByName('40F082').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('40F047').AsInteger       >  FDTOtmp.FieldByName('40F082').AsInteger      then
		   FDTOtmp.FieldByName('2R20').Value            :=  FDTOtmp.FieldByName('40F047').AsInteger;
	  if FDTOtmp.FieldByName('40F047').AsInteger       <  FDTOtmp.FieldByName('40F082').AsInteger      then
		   FDTOtmp.FieldByName('2R20').Value            :=  FDTOtmp.FieldByName('40F082').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('41F007').AsInteger = 0) or (FDTOtmp.FieldByName('41F122').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('41F007').AsInteger       >  FDTOtmp.FieldByName('41F122').AsInteger      then
		   FDTOtmp.FieldByName('2L21').Value            :=  FDTOtmp.FieldByName('41F007').AsInteger;
	  if FDTOtmp.FieldByName('41F007').AsInteger       <  FDTOtmp.FieldByName('41F122').AsInteger      then
		   FDTOtmp.FieldByName('2L21').Value            :=  FDTOtmp.FieldByName('41F122').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('42F071').AsInteger = 0) or (FDTOtmp.FieldByName('42F058').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('42F071').AsInteger       >  FDTOtmp.FieldByName('42F058').AsInteger      then
		   FDTOtmp.FieldByName('2R21').Value            :=  FDTOtmp.FieldByName('42F071').AsInteger;
	  if FDTOtmp.FieldByName('42F071').AsInteger       <  FDTOtmp.FieldByName('42F058').AsInteger      then
		   FDTOtmp.FieldByName('2R21').Value            :=  FDTOtmp.FieldByName('42F058').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('43F103').AsInteger = 0) or (FDTOtmp.FieldByName('43F026').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('43F103').AsInteger       >  FDTOtmp.FieldByName('43F026').AsInteger      then
		   FDTOtmp.FieldByName('2L22').Value            :=  FDTOtmp.FieldByName('43F103').AsInteger;
	  if FDTOtmp.FieldByName('43F103').AsInteger       <  FDTOtmp.FieldByName('43F026').AsInteger      then
		   FDTOtmp.FieldByName('2L22').Value            :=  FDTOtmp.FieldByName('43F026').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('44F039').AsInteger = 0) or (FDTOtmp.FieldByName('44F090').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('44F039').AsInteger       >  FDTOtmp.FieldByName('44F090').AsInteger      then
		   FDTOtmp.FieldByName('2R22').Value            :=  FDTOtmp.FieldByName('44F039').AsInteger;
	  if FDTOtmp.FieldByName('44F039').AsInteger       <  FDTOtmp.FieldByName('44F090').AsInteger      then
		   FDTOtmp.FieldByName('2R22').Value            :=  FDTOtmp.FieldByName('44F090').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('45F119').AsInteger = 0) or (FDTOtmp.FieldByName('45F010').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('45F119').AsInteger       >  FDTOtmp.FieldByName('45F010').AsInteger      then
		   FDTOtmp.FieldByName('2L23').Value            :=  FDTOtmp.FieldByName('45F119').AsInteger;
	  if FDTOtmp.FieldByName('45F119').AsInteger       <  FDTOtmp.FieldByName('45F010').AsInteger      then
		   FDTOtmp.FieldByName('2L23').Value            :=  FDTOtmp.FieldByName('45F010').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('46F055').AsInteger = 0) or (FDTOtmp.FieldByName('46F074').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('46F055').AsInteger       >  FDTOtmp.FieldByName('46F074').AsInteger      then
		   FDTOtmp.FieldByName('2R23').Value            :=  FDTOtmp.FieldByName('46F055').AsInteger;
	  if FDTOtmp.FieldByName('46F055').AsInteger       <  FDTOtmp.FieldByName('46F074').AsInteger      then
		   FDTOtmp.FieldByName('2R23').Value            :=  FDTOtmp.FieldByName('46F074').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('47F023').AsInteger = 0) or (FDTOtmp.FieldByName('47F106').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('47F023').AsInteger       >  FDTOtmp.FieldByName('47F106').AsInteger      then
		   FDTOtmp.FieldByName('2L24').Value            :=  FDTOtmp.FieldByName('47F023').AsInteger;
	  if FDTOtmp.FieldByName('47F023').AsInteger       <  FDTOtmp.FieldByName('47F106').AsInteger      then
		   FDTOtmp.FieldByName('2L24').Value            :=  FDTOtmp.FieldByName('47F106').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('48F087').AsInteger = 0) or (FDTOtmp.FieldByName('48F042').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('48F087').AsInteger       >  FDTOtmp.FieldByName('48F042').AsInteger      then
		   FDTOtmp.FieldByName('2R24').Value            :=  FDTOtmp.FieldByName('48F087').AsInteger;
	  if FDTOtmp.FieldByName('48F087').AsInteger       <  FDTOtmp.FieldByName('48F042').AsInteger      then
		   FDTOtmp.FieldByName('2R24').Value            :=  FDTOtmp.FieldByName('48F042').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('49F003').AsInteger = 0) or (FDTOtmp.FieldByName('49F126').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('49F003').AsInteger       >  FDTOtmp.FieldByName('49F126').AsInteger      then
		   FDTOtmp.FieldByName('2L25').Value            :=  FDTOtmp.FieldByName('49F003').AsInteger;
	  if FDTOtmp.FieldByName('49F003').AsInteger       <  FDTOtmp.FieldByName('49F126').AsInteger      then
		   FDTOtmp.FieldByName('2L25').Value            :=  FDTOtmp.FieldByName('49F126').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('50F067').AsInteger = 0) or (FDTOtmp.FieldByName('50F062').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('50F067').AsInteger       >  FDTOtmp.FieldByName('50F062').AsInteger      then
		   FDTOtmp.FieldByName('2R25').Value            :=  FDTOtmp.FieldByName('50F067').AsInteger;
	  if FDTOtmp.FieldByName('50F067').AsInteger       <  FDTOtmp.FieldByName('50F062').AsInteger      then
		   FDTOtmp.FieldByName('2R25').Value            :=  FDTOtmp.FieldByName('50F062').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('51F099').AsInteger = 0) or (FDTOtmp.FieldByName('51F030').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('51F099').AsInteger       >  FDTOtmp.FieldByName('51F030').AsInteger      then
		   FDTOtmp.FieldByName('2L26').Value            :=  FDTOtmp.FieldByName('51F099').AsInteger;
	  if FDTOtmp.FieldByName('51F099').AsInteger       <  FDTOtmp.FieldByName('51F030').AsInteger      then
		   FDTOtmp.FieldByName('2L26').Value            :=  FDTOtmp.FieldByName('51F030').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('52F035').AsInteger = 0) or (FDTOtmp.FieldByName('52F094').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('52F035').AsInteger       >  FDTOtmp.FieldByName('52F094').AsInteger      then
		   FDTOtmp.FieldByName('2R26').Value            :=  FDTOtmp.FieldByName('52F035').AsInteger;
	  if FDTOtmp.FieldByName('52F035').AsInteger       <  FDTOtmp.FieldByName('52F094').AsInteger      then
		   FDTOtmp.FieldByName('2R26').Value            :=  FDTOtmp.FieldByName('52F094').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('53F115').AsInteger = 0) or (FDTOtmp.FieldByName('53F014').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('53F115').AsInteger       >  FDTOtmp.FieldByName('53F014').AsInteger      then
		   FDTOtmp.FieldByName('2L27').Value            :=  FDTOtmp.FieldByName('53F115').AsInteger;
	  if FDTOtmp.FieldByName('53F115').AsInteger       <  FDTOtmp.FieldByName('53F014').AsInteger      then
		   FDTOtmp.FieldByName('2L27').Value            :=  FDTOtmp.FieldByName('53F014').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('54F051').AsInteger = 0) or (FDTOtmp.FieldByName('54F078').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('54F051').AsInteger       >  FDTOtmp.FieldByName('54F078').AsInteger      then
		   FDTOtmp.FieldByName('2R27').Value            :=  FDTOtmp.FieldByName('54F051').AsInteger;
	  if FDTOtmp.FieldByName('54F051').AsInteger       <  FDTOtmp.FieldByName('54F078').AsInteger      then
		   FDTOtmp.FieldByName('2R27').Value            :=  FDTOtmp.FieldByName('54F078').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('55F019').AsInteger = 0) or (FDTOtmp.FieldByName('55F110').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('55F019').AsInteger       >  FDTOtmp.FieldByName('55F110').AsInteger      then
		   FDTOtmp.FieldByName('2L28').Value            :=  FDTOtmp.FieldByName('55F019').AsInteger;
	  if FDTOtmp.FieldByName('55F019').AsInteger       <  FDTOtmp.FieldByName('55F110').AsInteger      then
		   FDTOtmp.FieldByName('2L28').Value            :=  FDTOtmp.FieldByName('55F110').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('56F083').AsInteger = 0) or (FDTOtmp.FieldByName('56F046').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('56F083').AsInteger       >  FDTOtmp.FieldByName('56F046').AsInteger      then
		   FDTOtmp.FieldByName('2R28').Value            :=  FDTOtmp.FieldByName('56F083').AsInteger;
	  if FDTOtmp.FieldByName('56F083').AsInteger       <  FDTOtmp.FieldByName('56F046').AsInteger      then
		   FDTOtmp.FieldByName('2R28').Value            :=  FDTOtmp.FieldByName('56F046').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('57F123').AsInteger = 0) or (FDTOtmp.FieldByName('57F006').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('57F123').AsInteger       >  FDTOtmp.FieldByName('57F006').AsInteger      then
		   FDTOtmp.FieldByName('2L29').Value            :=  FDTOtmp.FieldByName('57F123').AsInteger;
	  if FDTOtmp.FieldByName('57F123').AsInteger       <  FDTOtmp.FieldByName('57F006').AsInteger      then
		   FDTOtmp.FieldByName('2L29').Value            :=  FDTOtmp.FieldByName('57F006').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('58F059').AsInteger = 0) or (FDTOtmp.FieldByName('58F070').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('58F059').AsInteger       >  FDTOtmp.FieldByName('58F070').AsInteger      then
		   FDTOtmp.FieldByName('2R29').Value            :=  FDTOtmp.FieldByName('58F059').AsInteger;
	  if FDTOtmp.FieldByName('58F059').AsInteger       <  FDTOtmp.FieldByName('58F070').AsInteger      then
		   FDTOtmp.FieldByName('2R29').Value            :=  FDTOtmp.FieldByName('58F070').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('59F027').AsInteger = 0) or (FDTOtmp.FieldByName('59F102').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('59F027').AsInteger       >  FDTOtmp.FieldByName('59F102').AsInteger      then
		   FDTOtmp.FieldByName('2L30').Value            :=  FDTOtmp.FieldByName('59F027').AsInteger;
	  if FDTOtmp.FieldByName('59F027').AsInteger       <  FDTOtmp.FieldByName('59F102').AsInteger      then
		   FDTOtmp.FieldByName('2L30').Value            :=  FDTOtmp.FieldByName('59F102').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('60F091').AsInteger = 0) or (FDTOtmp.FieldByName('60F038').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('60F091').AsInteger       >  FDTOtmp.FieldByName('60F038').AsInteger      then
		   FDTOtmp.FieldByName('2R30').Value            :=  FDTOtmp.FieldByName('60F091').AsInteger;
	  if FDTOtmp.FieldByName('60F091').AsInteger       <  FDTOtmp.FieldByName('60F038').AsInteger      then
		   FDTOtmp.FieldByName('2R30').Value            :=  FDTOtmp.FieldByName('60F038').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('61F011').AsInteger = 0) or (FDTOtmp.FieldByName('61F118').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('61F011').AsInteger       >  FDTOtmp.FieldByName('61F118').AsInteger      then
		   FDTOtmp.FieldByName('2L31').Value            :=  FDTOtmp.FieldByName('61F011').AsInteger;
	  if FDTOtmp.FieldByName('61F011').AsInteger       <  FDTOtmp.FieldByName('61F118').AsInteger      then
		   FDTOtmp.FieldByName('2L31').Value            :=  FDTOtmp.FieldByName('61F118').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('62F075').AsInteger = 0) or (FDTOtmp.FieldByName('62F054').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('62F075').AsInteger       >  FDTOtmp.FieldByName('62F054').AsInteger      then
		   FDTOtmp.FieldByName('2R31').Value            :=  FDTOtmp.FieldByName('62F075').AsInteger;
	  if FDTOtmp.FieldByName('62F075').AsInteger       <  FDTOtmp.FieldByName('62F054').AsInteger      then
		   FDTOtmp.FieldByName('2R31').Value            :=  FDTOtmp.FieldByName('62F054').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('63F107').AsInteger = 0) or (FDTOtmp.FieldByName('63F022').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('63F107').AsInteger       >  FDTOtmp.FieldByName('63F022').AsInteger      then
		   FDTOtmp.FieldByName('2L32').Value            :=  FDTOtmp.FieldByName('63F107').AsInteger;
	  if FDTOtmp.FieldByName('63F107').AsInteger       <  FDTOtmp.FieldByName('63F022').AsInteger      then
		   FDTOtmp.FieldByName('2L32').Value            :=  FDTOtmp.FieldByName('63F022').AsInteger;
  end
  else x := x + 1;
  if  (FDTOtmp.FieldByName('64F043').AsInteger = 0) or (FDTOtmp.FieldByName('64F086').AsInteger = 0) then
  begin
  	if FDTOtmp.FieldByName('64F043').AsInteger       >  FDTOtmp.FieldByName('64F086').AsInteger      then
		   FDTOtmp.FieldByName('2R32').Value            :=  FDTOtmp.FieldByName('64F043').AsInteger;
	  if FDTOtmp.FieldByName('64F043').AsInteger       <  FDTOtmp.FieldByName('64F086').AsInteger      then
		   FDTOtmp.FieldByName('2R32').Value            :=  FDTOtmp.FieldByName('64F086').AsInteger;
  end
  else x := x + 1;
  if  (x  > 0) then
  begin
       FDTOtmp.Cancel;
  end
  else                                              //  По этой ветке проход в следующий круг
  begin
    FDTOtmp.FieldByName('KR1').Value := False;      //  Признак, не использовать 1-й круг для распределения пар (идти дальше)
		FDTOtmp.Post;                                   //  x = 0 (здесь x и так = 0) Сюда подсчитаю пары без нуля, т.е. два реальных бойца
		FDTOtmp.Refresh;
    FDTOtmp.Edit;
		if  (FDTOtmp.FieldByName('2L01').AsInteger = 0) or (FDTOtmp.FieldByName('2R01').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L01').AsInteger       >  FDTOtmp.FieldByName('2R01').AsInteger      then
			   FDTOtmp.FieldByName('3L01').Value          :=  FDTOtmp.FieldByName('2L01').AsInteger;
		  if FDTOtmp.FieldByName('2L01').AsInteger       <  FDTOtmp.FieldByName('2R01').AsInteger      then
			   FDTOtmp.FieldByName('3L01').Value          :=  FDTOtmp.FieldByName('2R01').AsInteger;
    end
		else x := x + 1;                                //  Если оба не нули, то надо проводить бой  в этом круге, как минимум один
		if  (FDTOtmp.FieldByName('2L02').AsInteger = 0) or (FDTOtmp.FieldByName('2R02').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L02').AsInteger       >  FDTOtmp.FieldByName('2R02').AsInteger      then
			   FDTOtmp.FieldByName('3R01').Value          :=  FDTOtmp.FieldByName('2L02').AsInteger;
		  if FDTOtmp.FieldByName('2L02').AsInteger       <  FDTOtmp.FieldByName('2R02').AsInteger      then
			   FDTOtmp.FieldByName('3R01').Value          :=  FDTOtmp.FieldByName('2R02').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L03').AsInteger = 0) or (FDTOtmp.FieldByName('2R03').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L03').AsInteger       >  FDTOtmp.FieldByName('2R03').AsInteger      then
			   FDTOtmp.FieldByName('3L02').Value          :=  FDTOtmp.FieldByName('2L03').AsInteger;
		  if FDTOtmp.FieldByName('2L03').AsInteger       <  FDTOtmp.FieldByName('2R03').AsInteger      then
			   FDTOtmp.FieldByName('3L02').Value          :=  FDTOtmp.FieldByName('2R03').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L04').AsInteger = 0) or (FDTOtmp.FieldByName('2R04').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L04').AsInteger       >  FDTOtmp.FieldByName('2R04').AsInteger      then
			   FDTOtmp.FieldByName('3R02').Value          :=  FDTOtmp.FieldByName('2L04').AsInteger;
		  if FDTOtmp.FieldByName('2L04').AsInteger       <  FDTOtmp.FieldByName('2R04').AsInteger      then
			   FDTOtmp.FieldByName('3R02').Value          :=  FDTOtmp.FieldByName('2R04').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L05').AsInteger = 0) or (FDTOtmp.FieldByName('2R05').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L05').AsInteger       >  FDTOtmp.FieldByName('2R05').AsInteger      then
			   FDTOtmp.FieldByName('3L03').Value          :=  FDTOtmp.FieldByName('2L05').AsInteger;
		  if FDTOtmp.FieldByName('2L05').AsInteger       <  FDTOtmp.FieldByName('2R05').AsInteger      then
			   FDTOtmp.FieldByName('3L03').Value          :=  FDTOtmp.FieldByName('2R05').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L06').AsInteger = 0) or (FDTOtmp.FieldByName('2R06').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L06').AsInteger       >  FDTOtmp.FieldByName('2R06').AsInteger      then
			   FDTOtmp.FieldByName('3R03').Value          :=  FDTOtmp.FieldByName('2L06').AsInteger;
		  if FDTOtmp.FieldByName('2L06').AsInteger       <  FDTOtmp.FieldByName('2R06').AsInteger      then
			   FDTOtmp.FieldByName('3R03').Value          :=  FDTOtmp.FieldByName('2R06').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L07').AsInteger = 0) or (FDTOtmp.FieldByName('2R07').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L07').AsInteger       >  FDTOtmp.FieldByName('2R07').AsInteger      then
			   FDTOtmp.FieldByName('3L04').Value          :=  FDTOtmp.FieldByName('2L07').AsInteger;
		  if FDTOtmp.FieldByName('2L07').AsInteger       <  FDTOtmp.FieldByName('2R07').AsInteger      then
			   FDTOtmp.FieldByName('3L04').Value          :=  FDTOtmp.FieldByName('2R07').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L08').AsInteger = 0) or (FDTOtmp.FieldByName('2R08').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L08').AsInteger       >  FDTOtmp.FieldByName('2R08').AsInteger      then
			   FDTOtmp.FieldByName('3R04').Value          :=  FDTOtmp.FieldByName('2L08').AsInteger;
		  if FDTOtmp.FieldByName('2L08').AsInteger       <  FDTOtmp.FieldByName('2R08').AsInteger      then
			   FDTOtmp.FieldByName('3R04').Value          :=  FDTOtmp.FieldByName('2R08').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L09').AsInteger = 0) or (FDTOtmp.FieldByName('2R09').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L09').AsInteger       >  FDTOtmp.FieldByName('2R09').AsInteger      then
			   FDTOtmp.FieldByName('3L05').Value          :=  FDTOtmp.FieldByName('2L09').AsInteger;
		  if FDTOtmp.FieldByName('2L09').AsInteger       <  FDTOtmp.FieldByName('2R09').AsInteger      then
			   FDTOtmp.FieldByName('3L05').Value          :=  FDTOtmp.FieldByName('2R09').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L10').AsInteger = 0) or (FDTOtmp.FieldByName('2R10').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L10').AsInteger       >  FDTOtmp.FieldByName('2R10').AsInteger      then
			   FDTOtmp.FieldByName('3R05').Value          :=  FDTOtmp.FieldByName('2L10').AsInteger;
		  if FDTOtmp.FieldByName('2L10').AsInteger       <  FDTOtmp.FieldByName('2R10').AsInteger      then
			   FDTOtmp.FieldByName('3R05').Value          :=  FDTOtmp.FieldByName('2R10').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L11').AsInteger = 0) or (FDTOtmp.FieldByName('2R11').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L11').AsInteger       >  FDTOtmp.FieldByName('2R11').AsInteger      then
			   FDTOtmp.FieldByName('3L06').Value          :=  FDTOtmp.FieldByName('2L11').AsInteger;
		  if FDTOtmp.FieldByName('2L11').AsInteger       <  FDTOtmp.FieldByName('2R11').AsInteger      then
			   FDTOtmp.FieldByName('3L06').Value          :=  FDTOtmp.FieldByName('2R11').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L12').AsInteger = 0) or (FDTOtmp.FieldByName('2R12').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L12').AsInteger       >  FDTOtmp.FieldByName('2R12').AsInteger      then
			   FDTOtmp.FieldByName('3R06').Value          :=  FDTOtmp.FieldByName('2L12').AsInteger;
		  if FDTOtmp.FieldByName('2L12').AsInteger       <  FDTOtmp.FieldByName('2R12').AsInteger      then
			   FDTOtmp.FieldByName('3R06').Value          :=  FDTOtmp.FieldByName('2R12').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L13').AsInteger = 0) or (FDTOtmp.FieldByName('2R13').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L13').AsInteger       >  FDTOtmp.FieldByName('2R13').AsInteger      then
			   FDTOtmp.FieldByName('3L07').Value          :=  FDTOtmp.FieldByName('2L13').AsInteger;
		  if FDTOtmp.FieldByName('2L13').AsInteger       <  FDTOtmp.FieldByName('2R13').AsInteger      then
			   FDTOtmp.FieldByName('3L07').Value          :=  FDTOtmp.FieldByName('2R13').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L14').AsInteger = 0) or (FDTOtmp.FieldByName('2R14').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L14').AsInteger       >  FDTOtmp.FieldByName('2R14').AsInteger      then
			   FDTOtmp.FieldByName('3R07').Value          :=  FDTOtmp.FieldByName('2L14').AsInteger;
		  if FDTOtmp.FieldByName('2L14').AsInteger       <  FDTOtmp.FieldByName('2R14').AsInteger      then
			   FDTOtmp.FieldByName('3R07').Value          :=  FDTOtmp.FieldByName('2R14').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L15').AsInteger = 0) or (FDTOtmp.FieldByName('2R15').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L15').AsInteger       >  FDTOtmp.FieldByName('2R15').AsInteger      then
			   FDTOtmp.FieldByName('3L08').Value          :=  FDTOtmp.FieldByName('2L15').AsInteger;
		  if FDTOtmp.FieldByName('2L15').AsInteger       <  FDTOtmp.FieldByName('2R15').AsInteger      then
			   FDTOtmp.FieldByName('3L08').Value          :=  FDTOtmp.FieldByName('2R15').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L16').AsInteger = 0) or (FDTOtmp.FieldByName('2R16').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L16').AsInteger       >  FDTOtmp.FieldByName('2R16').AsInteger      then
			   FDTOtmp.FieldByName('3R08').Value          :=  FDTOtmp.FieldByName('2L16').AsInteger;
		  if FDTOtmp.FieldByName('2L16').AsInteger       <  FDTOtmp.FieldByName('2R16').AsInteger      then
			   FDTOtmp.FieldByName('3R08').Value          :=  FDTOtmp.FieldByName('2R16').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L17').AsInteger = 0) or (FDTOtmp.FieldByName('2R17').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L17').AsInteger       >  FDTOtmp.FieldByName('2R17').AsInteger      then
			   FDTOtmp.FieldByName('3L09').Value          :=  FDTOtmp.FieldByName('2L17').AsInteger;
		  if FDTOtmp.FieldByName('2L17').AsInteger       <  FDTOtmp.FieldByName('2R17').AsInteger      then
			   FDTOtmp.FieldByName('3L09').Value          :=  FDTOtmp.FieldByName('2R17').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L18').AsInteger = 0) or (FDTOtmp.FieldByName('2R18').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L18').AsInteger       >  FDTOtmp.FieldByName('2R18').AsInteger      then
			   FDTOtmp.FieldByName('3R09').Value          :=  FDTOtmp.FieldByName('2L18').AsInteger;
		  if FDTOtmp.FieldByName('2L18').AsInteger       <  FDTOtmp.FieldByName('2R18').AsInteger      then
			   FDTOtmp.FieldByName('3R09').Value          :=  FDTOtmp.FieldByName('2R18').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L19').AsInteger = 0) or (FDTOtmp.FieldByName('2R19').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L19').AsInteger       >  FDTOtmp.FieldByName('2R19').AsInteger      then
			   FDTOtmp.FieldByName('3L10').Value          :=  FDTOtmp.FieldByName('2L19').AsInteger;
		  if FDTOtmp.FieldByName('2L19').AsInteger       <  FDTOtmp.FieldByName('2R19').AsInteger      then
			   FDTOtmp.FieldByName('3L10').Value          :=  FDTOtmp.FieldByName('2R19').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L20').AsInteger = 0) or (FDTOtmp.FieldByName('2R20').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L20').AsInteger       >  FDTOtmp.FieldByName('2R20').AsInteger      then
			   FDTOtmp.FieldByName('3R10').Value          :=  FDTOtmp.FieldByName('2L20').AsInteger;
		  if FDTOtmp.FieldByName('2L20').AsInteger       <  FDTOtmp.FieldByName('2R20').AsInteger      then
			   FDTOtmp.FieldByName('3R10').Value          :=  FDTOtmp.FieldByName('2R20').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L21').AsInteger = 0) or (FDTOtmp.FieldByName('2R21').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L21').AsInteger       >  FDTOtmp.FieldByName('2R21').AsInteger      then
			   FDTOtmp.FieldByName('3L11').Value          :=  FDTOtmp.FieldByName('2L21').AsInteger;
		  if FDTOtmp.FieldByName('2L21').AsInteger       <  FDTOtmp.FieldByName('2R21').AsInteger      then
			   FDTOtmp.FieldByName('3L11').Value          :=  FDTOtmp.FieldByName('2R21').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L22').AsInteger = 0) or (FDTOtmp.FieldByName('2R22').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L22').AsInteger       >  FDTOtmp.FieldByName('2R22').AsInteger      then
			   FDTOtmp.FieldByName('3R11').Value          :=  FDTOtmp.FieldByName('2L22').AsInteger;
		  if FDTOtmp.FieldByName('2L22').AsInteger       <  FDTOtmp.FieldByName('2R22').AsInteger      then
			   FDTOtmp.FieldByName('3R11').Value          :=  FDTOtmp.FieldByName('2R22').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L23').AsInteger = 0) or (FDTOtmp.FieldByName('2R23').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L23').AsInteger       >  FDTOtmp.FieldByName('2R23').AsInteger      then
			   FDTOtmp.FieldByName('3L12').Value          :=  FDTOtmp.FieldByName('2L23').AsInteger;
		  if FDTOtmp.FieldByName('2L23').AsInteger       <  FDTOtmp.FieldByName('2R23').AsInteger      then
			   FDTOtmp.FieldByName('3L12').Value          :=  FDTOtmp.FieldByName('2R23').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L24').AsInteger = 0) or (FDTOtmp.FieldByName('2R24').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L24').AsInteger       >  FDTOtmp.FieldByName('2R24').AsInteger      then
			   FDTOtmp.FieldByName('3R12').Value          :=  FDTOtmp.FieldByName('2L24').AsInteger;
		  if FDTOtmp.FieldByName('2L24').AsInteger       <  FDTOtmp.FieldByName('2R24').AsInteger      then
			   FDTOtmp.FieldByName('3R12').Value          :=  FDTOtmp.FieldByName('2R24').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L25').AsInteger = 0) or (FDTOtmp.FieldByName('2R25').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L25').AsInteger       >  FDTOtmp.FieldByName('2R25').AsInteger      then
			   FDTOtmp.FieldByName('3L13').Value          :=  FDTOtmp.FieldByName('2L25').AsInteger;
		  if FDTOtmp.FieldByName('2L25').AsInteger       <  FDTOtmp.FieldByName('2R25').AsInteger      then
			   FDTOtmp.FieldByName('3L13').Value          :=  FDTOtmp.FieldByName('2R25').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L26').AsInteger = 0) or (FDTOtmp.FieldByName('2R26').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L26').AsInteger       >  FDTOtmp.FieldByName('2R26').AsInteger      then
			   FDTOtmp.FieldByName('3R13').Value          :=  FDTOtmp.FieldByName('2L26').AsInteger;
		  if FDTOtmp.FieldByName('2L26').AsInteger       <  FDTOtmp.FieldByName('2R26').AsInteger      then
			   FDTOtmp.FieldByName('3R13').Value          :=  FDTOtmp.FieldByName('2R26').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L27').AsInteger = 0) or (FDTOtmp.FieldByName('2R27').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L27').AsInteger       >  FDTOtmp.FieldByName('2R27').AsInteger      then
			   FDTOtmp.FieldByName('3L14').Value          :=  FDTOtmp.FieldByName('2L27').AsInteger;
		  if FDTOtmp.FieldByName('2L27').AsInteger       <  FDTOtmp.FieldByName('2R27').AsInteger      then
			   FDTOtmp.FieldByName('3L14').Value          :=  FDTOtmp.FieldByName('2R27').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L28').AsInteger = 0) or (FDTOtmp.FieldByName('2R28').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L28').AsInteger       >  FDTOtmp.FieldByName('2R28').AsInteger      then
			   FDTOtmp.FieldByName('3R14').Value          :=  FDTOtmp.FieldByName('2L28').AsInteger;
		  if FDTOtmp.FieldByName('2L28').AsInteger       <  FDTOtmp.FieldByName('2R28').AsInteger      then
			   FDTOtmp.FieldByName('3R14').Value          :=  FDTOtmp.FieldByName('2R28').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L29').AsInteger = 0) or (FDTOtmp.FieldByName('2R29').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L29').AsInteger       >  FDTOtmp.FieldByName('2R29').AsInteger      then
			   FDTOtmp.FieldByName('3L15').Value          :=  FDTOtmp.FieldByName('2L29').AsInteger;
		  if FDTOtmp.FieldByName('2L29').AsInteger       <  FDTOtmp.FieldByName('2R29').AsInteger      then
			   FDTOtmp.FieldByName('3L15').Value          :=  FDTOtmp.FieldByName('2R29').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L30').AsInteger = 0) or (FDTOtmp.FieldByName('2R30').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L30').AsInteger       >  FDTOtmp.FieldByName('2R30').AsInteger      then
			   FDTOtmp.FieldByName('3R15').Value          :=  FDTOtmp.FieldByName('2L30').AsInteger;
		  if FDTOtmp.FieldByName('2L30').AsInteger       <  FDTOtmp.FieldByName('2R30').AsInteger      then
			   FDTOtmp.FieldByName('3R15').Value          :=  FDTOtmp.FieldByName('2R30').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L31').AsInteger = 0) or (FDTOtmp.FieldByName('2R31').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L31').AsInteger       >  FDTOtmp.FieldByName('2R31').AsInteger      then
			   FDTOtmp.FieldByName('3L16').Value          :=  FDTOtmp.FieldByName('2L31').AsInteger;
		  if FDTOtmp.FieldByName('2L31').AsInteger       <  FDTOtmp.FieldByName('2R31').AsInteger      then
			   FDTOtmp.FieldByName('3L16').Value          :=  FDTOtmp.FieldByName('2R31').AsInteger;
    end
		else x := x + 1;
		if  (FDTOtmp.FieldByName('2L32').AsInteger = 0) or (FDTOtmp.FieldByName('2R32').AsInteger = 0) then
    begin
		  if FDTOtmp.FieldByName('2L32').AsInteger       >  FDTOtmp.FieldByName('2R32').AsInteger      then
			   FDTOtmp.FieldByName('3R16').Value          :=  FDTOtmp.FieldByName('2L32').AsInteger;
		  if FDTOtmp.FieldByName('2L32').AsInteger       <  FDTOtmp.FieldByName('2R32').AsInteger      then
			   FDTOtmp.FieldByName('3R16').Value          :=  FDTOtmp.FieldByName('2R32').AsInteger;
    end
		else x := x + 1;
    if  (x  > 0) then
    begin
         FDTOtmp.Cancel;
    end
    else                                            //  По этой ветке проход в следующий круг
    begin
      FDTOtmp.FieldByName('KR2').Value := False;    //  Признак, не использовать 2-й круг для распределения пар (идти дальше)
			FDTOtmp.Post;
			FDTOtmp.Refresh;
			FDTOtmp.Edit;
			if  (FDTOtmp.FieldByName('3L01').AsInteger = 0) or (FDTOtmp.FieldByName('3R01').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L01').AsInteger       >  FDTOtmp.FieldByName('3R01').AsInteger      then
					 FDTOtmp.FieldByName('4L01').Value          :=  FDTOtmp.FieldByName('3L01').AsInteger;
				if FDTOtmp.FieldByName('3L01').AsInteger       <  FDTOtmp.FieldByName('3R01').AsInteger      then
					 FDTOtmp.FieldByName('4L01').Value          :=  FDTOtmp.FieldByName('3R01').AsInteger;
      end
		  else x := x + 1; // Если оба не нули, то надо проводить бой в этом круге, как минимум один
			if  (FDTOtmp.FieldByName('3L02').AsInteger = 0) or (FDTOtmp.FieldByName('3R02').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L02').AsInteger       >  FDTOtmp.FieldByName('3R02').AsInteger      then
					 FDTOtmp.FieldByName('4R01').Value          :=  FDTOtmp.FieldByName('3L02').AsInteger;
				if FDTOtmp.FieldByName('3L02').AsInteger       <  FDTOtmp.FieldByName('3R02').AsInteger      then
					 FDTOtmp.FieldByName('4R01').Value          :=  FDTOtmp.FieldByName('3R02').AsInteger;
      end
			else x := x + 1;
			if  (FDTOtmp.FieldByName('3L03').AsInteger = 0) or (FDTOtmp.FieldByName('3R03').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L03').AsInteger       >  FDTOtmp.FieldByName('3R03').AsInteger      then
					 FDTOtmp.FieldByName('4L02').Value          :=  FDTOtmp.FieldByName('3L03').AsInteger;
				if FDTOtmp.FieldByName('3L03').AsInteger       <  FDTOtmp.FieldByName('3R03').AsInteger      then
					 FDTOtmp.FieldByName('4L02').Value          :=  FDTOtmp.FieldByName('3R03').AsInteger;
      end
			else x := x + 1;
			if  (FDTOtmp.FieldByName('3L04').AsInteger = 0) or (FDTOtmp.FieldByName('3R04').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L04').AsInteger       >  FDTOtmp.FieldByName('3R04').AsInteger      then
					 FDTOtmp.FieldByName('4R02').Value          :=  FDTOtmp.FieldByName('3L04').AsInteger;
				if FDTOtmp.FieldByName('3L04').AsInteger       <  FDTOtmp.FieldByName('3R04').AsInteger      then
					 FDTOtmp.FieldByName('4R02').Value          :=  FDTOtmp.FieldByName('3R04').AsInteger;
      end
			else x := x + 1;
			if  (FDTOtmp.FieldByName('3L05').AsInteger = 0) or (FDTOtmp.FieldByName('3R05').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L05').AsInteger       >  FDTOtmp.FieldByName('3R05').AsInteger      then
					 FDTOtmp.FieldByName('4L03').Value          :=  FDTOtmp.FieldByName('3L05').AsInteger;
				if FDTOtmp.FieldByName('3L05').AsInteger       <  FDTOtmp.FieldByName('3R05').AsInteger      then
					 FDTOtmp.FieldByName('4L03').Value          :=  FDTOtmp.FieldByName('3R05').AsInteger;
      end
			else x := x + 1;
			if  (FDTOtmp.FieldByName('3L06').AsInteger = 0) or (FDTOtmp.FieldByName('3R06').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L06').AsInteger       >  FDTOtmp.FieldByName('3R06').AsInteger      then
					 FDTOtmp.FieldByName('4R03').Value          :=  FDTOtmp.FieldByName('3L06').AsInteger;
				if FDTOtmp.FieldByName('3L06').AsInteger       <  FDTOtmp.FieldByName('3R06').AsInteger      then
					 FDTOtmp.FieldByName('4R03').Value          :=  FDTOtmp.FieldByName('3R06').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L07').AsInteger = 0) or (FDTOtmp.FieldByName('3R07').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L07').AsInteger       >  FDTOtmp.FieldByName('3R07').AsInteger      then
					 FDTOtmp.FieldByName('4L04').Value          :=  FDTOtmp.FieldByName('3L07').AsInteger;
				if FDTOtmp.FieldByName('3L07').AsInteger       <  FDTOtmp.FieldByName('3R07').AsInteger      then
				   FDTOtmp.FieldByName('4L04').Value          :=  FDTOtmp.FieldByName('3R07').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L08').AsInteger = 0) or (FDTOtmp.FieldByName('3R08').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L08').AsInteger       >  FDTOtmp.FieldByName('3R08').AsInteger      then
					 FDTOtmp.FieldByName('4R04').Value          :=  FDTOtmp.FieldByName('3L08').AsInteger;
				if FDTOtmp.FieldByName('3L08').AsInteger       <  FDTOtmp.FieldByName('3R08').AsInteger      then
					 FDTOtmp.FieldByName('4R04').Value          :=  FDTOtmp.FieldByName('3R08').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L09').AsInteger = 0) or (FDTOtmp.FieldByName('3R09').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L09').AsInteger       >  FDTOtmp.FieldByName('3R09').AsInteger      then
					 FDTOtmp.FieldByName('4L05').Value          :=  FDTOtmp.FieldByName('3L09').AsInteger;
				if FDTOtmp.FieldByName('3L09').AsInteger       <  FDTOtmp.FieldByName('3R09').AsInteger      then
					 FDTOtmp.FieldByName('4L05').Value          :=  FDTOtmp.FieldByName('3R09').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L10').AsInteger = 0) or (FDTOtmp.FieldByName('3R10').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L10').AsInteger       >  FDTOtmp.FieldByName('3R10').AsInteger      then
					 FDTOtmp.FieldByName('4R05').Value          :=  FDTOtmp.FieldByName('3L10').AsInteger;
				if FDTOtmp.FieldByName('3L10').AsInteger       <  FDTOtmp.FieldByName('3R10').AsInteger      then
					 FDTOtmp.FieldByName('4R05').Value          :=  FDTOtmp.FieldByName('3R10').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L11').AsInteger = 0) or (FDTOtmp.FieldByName('3R11').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L11').AsInteger       >  FDTOtmp.FieldByName('3R11').AsInteger      then
					 FDTOtmp.FieldByName('4L06').Value          :=  FDTOtmp.FieldByName('3L11').AsInteger;
				if FDTOtmp.FieldByName('3L11').AsInteger       <  FDTOtmp.FieldByName('3R11').AsInteger      then
					 FDTOtmp.FieldByName('4L06').Value          :=  FDTOtmp.FieldByName('3R11').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L12').AsInteger = 0) or (FDTOtmp.FieldByName('3R12').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L12').AsInteger       >  FDTOtmp.FieldByName('3R12').AsInteger      then
					 FDTOtmp.FieldByName('4R06').Value          :=  FDTOtmp.FieldByName('3L12').AsInteger;
				if FDTOtmp.FieldByName('3L12').AsInteger       <  FDTOtmp.FieldByName('3R12').AsInteger      then
					 FDTOtmp.FieldByName('4R06').Value          :=  FDTOtmp.FieldByName('3R12').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L13').AsInteger = 0) or (FDTOtmp.FieldByName('3R13').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L13').AsInteger       >  FDTOtmp.FieldByName('3R13').AsInteger      then
					 FDTOtmp.FieldByName('4L07').Value          :=  FDTOtmp.FieldByName('3L13').AsInteger;
				if FDTOtmp.FieldByName('3L13').AsInteger       <  FDTOtmp.FieldByName('3R13').AsInteger      then
					 FDTOtmp.FieldByName('4L07').Value          :=  FDTOtmp.FieldByName('3R13').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L14').AsInteger = 0) or (FDTOtmp.FieldByName('3R14').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L14').AsInteger       >  FDTOtmp.FieldByName('3R14').AsInteger      then
					 FDTOtmp.FieldByName('4R07').Value          :=  FDTOtmp.FieldByName('3L14').AsInteger;
				if FDTOtmp.FieldByName('3L14').AsInteger       <  FDTOtmp.FieldByName('3R14').AsInteger      then
					 FDTOtmp.FieldByName('4R07').Value          :=  FDTOtmp.FieldByName('3R14').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L15').AsInteger = 0) or (FDTOtmp.FieldByName('3R15').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L15').AsInteger       >  FDTOtmp.FieldByName('3R15').AsInteger      then
					 FDTOtmp.FieldByName('4L08').Value          :=  FDTOtmp.FieldByName('3L15').AsInteger;
				if FDTOtmp.FieldByName('3L15').AsInteger       <  FDTOtmp.FieldByName('3R15').AsInteger      then
					 FDTOtmp.FieldByName('4L08').Value          :=  FDTOtmp.FieldByName('3R15').AsInteger;
      end
			else x := x + 1;
		  if  (FDTOtmp.FieldByName('3L16').AsInteger = 0) or (FDTOtmp.FieldByName('3R16').AsInteger = 0) then
      begin
			  if FDTOtmp.FieldByName('3L16').AsInteger       >  FDTOtmp.FieldByName('3R16').AsInteger      then
					 FDTOtmp.FieldByName('4R08').Value          :=  FDTOtmp.FieldByName('3L16').AsInteger;
				if FDTOtmp.FieldByName('3L16').AsInteger       <  FDTOtmp.FieldByName('3R16').AsInteger      then
					 FDTOtmp.FieldByName('4R08').Value          :=  FDTOtmp.FieldByName('3R16').AsInteger;
      end
			else x := x + 1;
      if  (x  > 0) then
      begin
           FDTOtmp.Cancel;
      end
      else                                            //  По этой ветке проход в следующий круг
      begin
        FDTOtmp.FieldByName('KR3').Value := False;    //  Признак, не использовать 3-й круг для распределения пар (идти дальше)
			  FDTOtmp.Post;
			  FDTOtmp.Refresh;
			  FDTOtmp.Edit;
				if  (FDTOtmp.FieldByName('4L01').AsInteger = 0) or (FDTOtmp.FieldByName('4R01').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L01').AsInteger       >  FDTOtmp.FieldByName('4R01').AsInteger      then
						 FDTOtmp.FieldByName('5L01').Value          :=  FDTOtmp.FieldByName('4L01').AsInteger;
					if FDTOtmp.FieldByName('4L01').AsInteger       <  FDTOtmp.FieldByName('4R01').AsInteger      then
						 FDTOtmp.FieldByName('5L01').Value          :=  FDTOtmp.FieldByName('4R01').AsInteger;
        end
			  else x := x + 1; // Если оба не нули, то надо проводить бой в этом круге, как минимум один
				if  (FDTOtmp.FieldByName('4L02').AsInteger = 0) or (FDTOtmp.FieldByName('4R02').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L02').AsInteger       >  FDTOtmp.FieldByName('4R02').AsInteger      then
						 FDTOtmp.FieldByName('5R01').Value          :=  FDTOtmp.FieldByName('4L02').AsInteger;
					if FDTOtmp.FieldByName('4L02').AsInteger       <  FDTOtmp.FieldByName('4R02').AsInteger      then
						 FDTOtmp.FieldByName('5R01').Value          :=  FDTOtmp.FieldByName('4R02').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L03').AsInteger = 0) or (FDTOtmp.FieldByName('4R03').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L03').AsInteger       >  FDTOtmp.FieldByName('4R03').AsInteger      then
						 FDTOtmp.FieldByName('5L02').Value          :=  FDTOtmp.FieldByName('4L03').AsInteger;
					if FDTOtmp.FieldByName('4L03').AsInteger       <  FDTOtmp.FieldByName('4R03').AsInteger      then
						 FDTOtmp.FieldByName('5L02').Value          :=  FDTOtmp.FieldByName('4R03').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L04').AsInteger = 0) or (FDTOtmp.FieldByName('4R04').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L04').AsInteger       >  FDTOtmp.FieldByName('4R04').AsInteger      then
						 FDTOtmp.FieldByName('5R02').Value          :=  FDTOtmp.FieldByName('4L04').AsInteger;
					if FDTOtmp.FieldByName('4L04').AsInteger       <  FDTOtmp.FieldByName('4R04').AsInteger      then
						 FDTOtmp.FieldByName('5R02').Value          :=  FDTOtmp.FieldByName('4R04').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L05').AsInteger = 0) or (FDTOtmp.FieldByName('4R05').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L05').AsInteger       >  FDTOtmp.FieldByName('4R05').AsInteger      then
						 FDTOtmp.FieldByName('5L03').Value          :=  FDTOtmp.FieldByName('4L05').AsInteger;
					if FDTOtmp.FieldByName('4L05').AsInteger       <  FDTOtmp.FieldByName('4R05').AsInteger      then
						 FDTOtmp.FieldByName('5L03').Value          :=  FDTOtmp.FieldByName('4R05').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L06').AsInteger = 0) or (FDTOtmp.FieldByName('4R06').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L06').AsInteger       >  FDTOtmp.FieldByName('4R06').AsInteger      then
						 FDTOtmp.FieldByName('5R03').Value          :=  FDTOtmp.FieldByName('4L06').AsInteger;
					if FDTOtmp.FieldByName('4L06').AsInteger       <  FDTOtmp.FieldByName('4R06').AsInteger      then
						 FDTOtmp.FieldByName('5R03').Value          :=  FDTOtmp.FieldByName('4R06').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L07').AsInteger = 0) or (FDTOtmp.FieldByName('4R07').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L07').AsInteger       >  FDTOtmp.FieldByName('4R07').AsInteger      then
						 FDTOtmp.FieldByName('5L04').Value          :=  FDTOtmp.FieldByName('4L07').AsInteger;
					if FDTOtmp.FieldByName('4L07').AsInteger       <  FDTOtmp.FieldByName('4R07').AsInteger      then
						 FDTOtmp.FieldByName('5L04').Value          :=  FDTOtmp.FieldByName('4R07').AsInteger;
        end
				else x := x + 1;
				if  (FDTOtmp.FieldByName('4L08').AsInteger = 0) or (FDTOtmp.FieldByName('4R08').AsInteger = 0) then
        begin
					if FDTOtmp.FieldByName('4L08').AsInteger       >  FDTOtmp.FieldByName('4R08').AsInteger      then
						 FDTOtmp.FieldByName('5R04').Value          :=  FDTOtmp.FieldByName('4L08').AsInteger;
					if FDTOtmp.FieldByName('4L08').AsInteger       <  FDTOtmp.FieldByName('4R08').AsInteger      then
						 FDTOtmp.FieldByName('5R04').Value          :=  FDTOtmp.FieldByName('4R08').AsInteger;
        end
				else x := x + 1;
        if  (x  > 0) then
        begin
             FDTOtmp.Cancel;
        end
        else                                            //  По этой ветке проход в следующий круг
        begin
          FDTOtmp.FieldByName('KR4').Value := False;    //  Признак, не использовать 4-й круг для распределения пар (идти дальше)
			    FDTOtmp.Post;
			    FDTOtmp.Refresh;
			    FDTOtmp.Edit;
          if  (FDTOtmp.FieldByName('5L01').AsInteger = 0) or (FDTOtmp.FieldByName('5R01').AsInteger = 0) then
          begin
						if FDTOtmp.FieldByName('5L01').AsInteger       >  FDTOtmp.FieldByName('5R01').AsInteger      then
							 FDTOtmp.FieldByName('6L01').Value          :=  FDTOtmp.FieldByName('5L01').AsInteger;
						if FDTOtmp.FieldByName('5L01').AsInteger       <  FDTOtmp.FieldByName('5R01').AsInteger      then
							 FDTOtmp.FieldByName('6L01').Value          :=  FDTOtmp.FieldByName('5R01').AsInteger;
          end
				  else x := x + 1; // Если оба не нули, то надо проводить бой в этом круге, как минимум один
					if  (FDTOtmp.FieldByName('5L02').AsInteger = 0) or (FDTOtmp.FieldByName('5R02').AsInteger = 0) then
          begin
						if FDTOtmp.FieldByName('5L02').AsInteger       >  FDTOtmp.FieldByName('5R02').AsInteger      then
							 FDTOtmp.FieldByName('6R01').Value          :=  FDTOtmp.FieldByName('5L02').AsInteger;
						if FDTOtmp.FieldByName('5L02').AsInteger       <  FDTOtmp.FieldByName('5R02').AsInteger      then
							 FDTOtmp.FieldByName('6R01').Value          :=  FDTOtmp.FieldByName('5R02').AsInteger;
          end
					else x := x + 1;
				  if  (FDTOtmp.FieldByName('5L03').AsInteger = 0) or (FDTOtmp.FieldByName('5R03').AsInteger = 0) then
          begin
						if FDTOtmp.FieldByName('5L03').AsInteger       >  FDTOtmp.FieldByName('5R03').AsInteger      then
							 FDTOtmp.FieldByName('6L02').Value          :=  FDTOtmp.FieldByName('5L03').AsInteger;
						if FDTOtmp.FieldByName('5L03').AsInteger       <  FDTOtmp.FieldByName('5R03').AsInteger      then
							 FDTOtmp.FieldByName('6L02').Value          :=  FDTOtmp.FieldByName('5R03').AsInteger;
          end
					else x := x + 1;
          if  (FDTOtmp.FieldByName('5L04').AsInteger = 0) or (FDTOtmp.FieldByName('5R04').AsInteger = 0) then
          begin
						if FDTOtmp.FieldByName('5L04').AsInteger       >  FDTOtmp.FieldByName('5R04').AsInteger      then
							 FDTOtmp.FieldByName('6R02').Value          :=  FDTOtmp.FieldByName('5L04').AsInteger;
						if FDTOtmp.FieldByName('5L04').AsInteger       <  FDTOtmp.FieldByName('5R04').AsInteger      then
							 FDTOtmp.FieldByName('6R02').Value          :=  FDTOtmp.FieldByName('5R04').AsInteger;
          end
					else x := x + 1;
          if  (x  > 0) then
          begin
               FDTOtmp.Cancel;
          end
          else
          begin
						   FDTOtmp.FieldByName('KR5').Value := False; // Признак, не использовать 5-й круг для распределения пар (идти дальше)
							 FDTOtmp.Post();                            // По сути это сработает только 1 раз, если количество участников 4
          end;
        end;
      end;
    end;
  end;
  FDTOtmp.Refresh();                                      // Дальше идет алгоритм отличный от Додземан, вообще нет разделения на группы
  FDQuery.SQL.Text := 'SELECT tournum, name FROM fighters WHERE fgid=:pID';
  FDTbatl.Open;
  if FDTOtmp.FieldByName('KR1').AsBoolean then            // Здесь вариант заполнения 1-го круга, когда участников больше 64 !!!
  begin
     createPairOlimp(1, FDTOtmp.FieldByName('01F001').AsInteger, FDTOtmp.FieldByName('01F128').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('33F127').AsInteger, FDTOtmp.FieldByName('33F002').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('02F065').AsInteger, FDTOtmp.FieldByName('02F064').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('34F063').AsInteger, FDTOtmp.FieldByName('34F066').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('03F097').AsInteger, FDTOtmp.FieldByName('03F032').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('35F031').AsInteger, FDTOtmp.FieldByName('35F098').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('04F033').AsInteger, FDTOtmp.FieldByName('04F096').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('36F095').AsInteger, FDTOtmp.FieldByName('36F034').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('05F113').AsInteger, FDTOtmp.FieldByName('05F016').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('37F015').AsInteger, FDTOtmp.FieldByName('37F114').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('06F049').AsInteger, FDTOtmp.FieldByName('06F080').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('38F079').AsInteger, FDTOtmp.FieldByName('38F050').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('07F017').AsInteger, FDTOtmp.FieldByName('07F112').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('39F111').AsInteger, FDTOtmp.FieldByName('39F018').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('08F081').AsInteger, FDTOtmp.FieldByName('08F048').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('40F047').AsInteger, FDTOtmp.FieldByName('40F082').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('09F121').AsInteger, FDTOtmp.FieldByName('09F008').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('41F007').AsInteger, FDTOtmp.FieldByName('41F122').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('10F057').AsInteger, FDTOtmp.FieldByName('10F072').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('42F071').AsInteger, FDTOtmp.FieldByName('42F058').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('11F025').AsInteger, FDTOtmp.FieldByName('11F104').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('43F103').AsInteger, FDTOtmp.FieldByName('43F026').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('12F089').AsInteger, FDTOtmp.FieldByName('12F040').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('44F039').AsInteger, FDTOtmp.FieldByName('44F090').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('13F009').AsInteger, FDTOtmp.FieldByName('13F120').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('45F119').AsInteger, FDTOtmp.FieldByName('45F010').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('14F073').AsInteger, FDTOtmp.FieldByName('14F056').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('46F055').AsInteger, FDTOtmp.FieldByName('46F074').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('15F105').AsInteger, FDTOtmp.FieldByName('15F024').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('47F023').AsInteger, FDTOtmp.FieldByName('47F106').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('16F041').AsInteger, FDTOtmp.FieldByName('16F088').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('48F087').AsInteger, FDTOtmp.FieldByName('48F042').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('17F125').AsInteger, FDTOtmp.FieldByName('17F004').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('49F003').AsInteger, FDTOtmp.FieldByName('49F126').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('18F061').AsInteger, FDTOtmp.FieldByName('18F068').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('50F067').AsInteger, FDTOtmp.FieldByName('50F062').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('19F029').AsInteger, FDTOtmp.FieldByName('19F100').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('51F099').AsInteger, FDTOtmp.FieldByName('51F030').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('20F093').AsInteger, FDTOtmp.FieldByName('20F036').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('52F035').AsInteger, FDTOtmp.FieldByName('52F094').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('21F013').AsInteger, FDTOtmp.FieldByName('21F116').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('53F115').AsInteger, FDTOtmp.FieldByName('53F014').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('22F077').AsInteger, FDTOtmp.FieldByName('22F052').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('54F051').AsInteger, FDTOtmp.FieldByName('54F078').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('23F109').AsInteger, FDTOtmp.FieldByName('23F020').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('55F019').AsInteger, FDTOtmp.FieldByName('55F110').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('24F045').AsInteger, FDTOtmp.FieldByName('24F084').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('56F083').AsInteger, FDTOtmp.FieldByName('56F046').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('25F005').AsInteger, FDTOtmp.FieldByName('25F124').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('57F123').AsInteger, FDTOtmp.FieldByName('57F006').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('26F069').AsInteger, FDTOtmp.FieldByName('26F060').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('58F059').AsInteger, FDTOtmp.FieldByName('58F070').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('27F101').AsInteger, FDTOtmp.FieldByName('27F028').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('59F027').AsInteger, FDTOtmp.FieldByName('59F102').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('28F037').AsInteger, FDTOtmp.FieldByName('28F092').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('60F091').AsInteger, FDTOtmp.FieldByName('60F038').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('29F117').AsInteger, FDTOtmp.FieldByName('29F012').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('61F011').AsInteger, FDTOtmp.FieldByName('61F118').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('30F053').AsInteger, FDTOtmp.FieldByName('30F076').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('62F075').AsInteger, FDTOtmp.FieldByName('62F054').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('31F021').AsInteger, FDTOtmp.FieldByName('31F108').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('63F107').AsInteger, FDTOtmp.FieldByName('63F022').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('32F085').AsInteger, FDTOtmp.FieldByName('32F044').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('64F043').AsInteger, FDTOtmp.FieldByName('64F086').AsInteger);
  end;
  if (FDTOtmp.FieldByName('KR1').AsBoolean = False)  and FDTOtmp.FieldByName('KR2').AsBoolean  then // Уместились до 64 человек
  begin
     createPairOlimp(1, FDTOtmp.FieldByName('2L01').AsInteger,   FDTOtmp.FieldByName('2R01').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L17').AsInteger,   FDTOtmp.FieldByName('2R17').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L02').AsInteger,   FDTOtmp.FieldByName('2R02').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L18').AsInteger,   FDTOtmp.FieldByName('2R18').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L03').AsInteger,   FDTOtmp.FieldByName('2R03').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L19').AsInteger,   FDTOtmp.FieldByName('2R19').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L04').AsInteger,   FDTOtmp.FieldByName('2R04').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L20').AsInteger,   FDTOtmp.FieldByName('2R20').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L05').AsInteger,   FDTOtmp.FieldByName('2R05').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L21').AsInteger,   FDTOtmp.FieldByName('2R21').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L06').AsInteger,   FDTOtmp.FieldByName('2R06').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L22').AsInteger,   FDTOtmp.FieldByName('2R22').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L07').AsInteger,   FDTOtmp.FieldByName('2R07').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L23').AsInteger,   FDTOtmp.FieldByName('2R23').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L08').AsInteger,   FDTOtmp.FieldByName('2R08').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L24').AsInteger,   FDTOtmp.FieldByName('2R24').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L09').AsInteger,   FDTOtmp.FieldByName('2R09').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L25').AsInteger,   FDTOtmp.FieldByName('2R25').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L10').AsInteger,   FDTOtmp.FieldByName('2R10').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L26').AsInteger,   FDTOtmp.FieldByName('2R26').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L11').AsInteger,   FDTOtmp.FieldByName('2R11').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L27').AsInteger,   FDTOtmp.FieldByName('2R27').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L12').AsInteger,   FDTOtmp.FieldByName('2R12').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L28').AsInteger,   FDTOtmp.FieldByName('2R28').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L13').AsInteger,   FDTOtmp.FieldByName('2R13').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L29').AsInteger,   FDTOtmp.FieldByName('2R29').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L14').AsInteger,   FDTOtmp.FieldByName('2R14').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L30').AsInteger,   FDTOtmp.FieldByName('2R30').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L15').AsInteger,   FDTOtmp.FieldByName('2R15').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L31').AsInteger,   FDTOtmp.FieldByName('2R31').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L16').AsInteger,   FDTOtmp.FieldByName('2R16').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('2L32').AsInteger,   FDTOtmp.FieldByName('2R32').AsInteger);
  end;
  if (FDTOtmp.FieldByName('KR1').AsBoolean = False) and (FDTOtmp.FieldByName('KR2').AsBoolean = False) and FDTOtmp.FieldByName('KR3').AsBoolean then
  begin                                                    //    Уместились до 32 человек
     createPairOlimp(1, FDTOtmp.FieldByName('3L01').AsInteger,   FDTOtmp.FieldByName('3R01').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L09').AsInteger,   FDTOtmp.FieldByName('3R09').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L02').AsInteger,   FDTOtmp.FieldByName('3R02').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L10').AsInteger,   FDTOtmp.FieldByName('3R10').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L03').AsInteger,   FDTOtmp.FieldByName('3R03').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L11').AsInteger,   FDTOtmp.FieldByName('3R11').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L04').AsInteger,   FDTOtmp.FieldByName('3R04').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L12').AsInteger,   FDTOtmp.FieldByName('3R12').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L05').AsInteger,   FDTOtmp.FieldByName('3R05').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L13').AsInteger,   FDTOtmp.FieldByName('3R13').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L06').AsInteger,   FDTOtmp.FieldByName('3R06').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L14').AsInteger,   FDTOtmp.FieldByName('3R14').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L07').AsInteger,   FDTOtmp.FieldByName('3R07').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L15').AsInteger,   FDTOtmp.FieldByName('3R15').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L08').AsInteger,   FDTOtmp.FieldByName('3R08').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('3L16').AsInteger,   FDTOtmp.FieldByName('3R16').AsInteger);
  end;
  if (FDTOtmp.FieldByName('KR1').AsBoolean = False) and (FDTOtmp.FieldByName('KR2').AsBoolean = False) and (FDTOtmp.FieldByName('KR3').AsBoolean = False) and FDTOtmp.FieldByName('KR4').AsBoolean then
  begin                                                    //    Уместились до 16 человек
     createPairOlimp(1, FDTOtmp.FieldByName('4L01').AsInteger,   FDTOtmp.FieldByName('4R01').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L05').AsInteger,   FDTOtmp.FieldByName('4R05').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L02').AsInteger,   FDTOtmp.FieldByName('4R02').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L06').AsInteger,   FDTOtmp.FieldByName('4R06').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L03').AsInteger,   FDTOtmp.FieldByName('4R03').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L07').AsInteger,   FDTOtmp.FieldByName('4R07').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L04').AsInteger,   FDTOtmp.FieldByName('4R04').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('4L08').AsInteger,   FDTOtmp.FieldByName('4R08').AsInteger);
  end;
  if (FDTOtmp.FieldByName('KR1').AsBoolean = False) and (FDTOtmp.FieldByName('KR2').AsBoolean = False) and (FDTOtmp.FieldByName('KR3').AsBoolean = False) and (FDTOtmp.FieldByName('KR4').AsBoolean = False) and FDTOtmp.FieldByName('KR5').AsBoolean then
  begin                                                    //    Уместились до 8 человек
     createPairOlimp(1, FDTOtmp.FieldByName('5L01').AsInteger,   FDTOtmp.FieldByName('5R01').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('5L03').AsInteger,   FDTOtmp.FieldByName('5R03').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('5L02').AsInteger,   FDTOtmp.FieldByName('5R02').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('5L04').AsInteger,   FDTOtmp.FieldByName('5R04').AsInteger);
  end;
  if (FDTOtmp.FieldByName('KR1').AsBoolean = False) and (FDTOtmp.FieldByName('KR2').AsBoolean = False) and (FDTOtmp.FieldByName('KR3').AsBoolean = False) and (FDTOtmp.FieldByName('KR4').AsBoolean = False) and (FDTOtmp.FieldByName('KR5').AsBoolean = False) then
  begin                                                    //    Здесь обрабатывается нижняя граница 4 человека
     createPairOlimp(1, FDTOtmp.FieldByName('6L01').AsInteger,   FDTOtmp.FieldByName('6R01').AsInteger);
     createPairOlimp(1, FDTOtmp.FieldByName('6L02').AsInteger,   FDTOtmp.FieldByName('6R02').AsInteger);
  end;
  FDTOtmp.Close;
  FDTbatl.Close;
  FDQuery.SQL.Text  := 'UPDATE tournament SET status=1, schema=''olimp'' WHERE tourid=' + IntToStr(rectangle7.Tag);
  FDQuery.ExecSQL;  //  Ставлю метку в таблице турниров - схема сохранена (и тип соревнований - олимпийский)
  readMatch(rectangle7.Tag); // На этот момент создан только 1-й круг, 2-й круг создается после полной фиксации первого
end;

procedure Tfrm.createPairOlimp(const iKrug: integer; const iLeft: integer; const iRight: integer);
begin  // Вписываю в таблицу боев пары соперников, распределенные по олимпийской системе
	FDTbatl.Append;
	FDTbatl.FieldByName('tourid').AsInteger   := rectangle7.Tag;
	FDTbatl.FieldByName('krug').Value         := iKrug;
	if iLeft   > 0 then
  begin
		 FDTbatl.FieldByName('fgid1').Value    := iLeft;                 // Первый боец из пары
		 FDQuery.ParamByName('pID').AsInteger  := iLeft;
		 FDQuery.Open;
		 FDTbatl.FieldByName('tournum1').Value := FDQuery.FieldByName('tournum').AsInteger;
		 FDTbatl.FieldByName('fmim1').Value    := FDQuery.FieldByName('name').AsString;
     if iRight < 1 then FDTbatl.FieldByName('letter1').Value := 'V'; // Победа за отсутствием соперника
		 FDQuery.Close;
  end;
	if iRight  > 0 then
  begin
		 FDTbatl.FieldByName('fgid2').Value    := iRight;                // Второй боец из пары
		 FDQuery.ParamByName('pID').AsInteger  := iRight;
		 FDQuery.Open;
		 FDTbatl.FieldByName('tournum2').Value := FDQuery.FieldByName('tournum').AsInteger;
		 FDTbatl.FieldByName('fmim2').Value    := FDQuery.FieldByName('name').AsString;
     if iLeft  < 1 then FDTbatl.FieldByName('letter2').Value := 'V'; // Победа за отсутствием соперника
		 FDQuery.Close;
  end;
	if (iLeft < 1)  or  (iRight < 1) then
		 FDTbatl.FieldByName('finish').Value   := 1;                     // В боях 'приведения' сразу ставлю 'конец поединка'
	if (iLeft < 1)  and (iRight < 1) then
  begin
     FDTbatl.FieldByName('letter1').Value  := 'X';                   // Если оба пустышки (например и у 1-й и у 2-й пары были ничьи
     FDTbatl.FieldByName('letter2').Value  := 'X';                   // В letter(1&2)обоим записываю 'X'
  end;
	FDTbatl.Post;
end;

procedure Tfrm.nextKrug(); // Олимпийская система, формирование следующего круга
var
  query:  TFDQuery;
  myStp:  boolean;
  ctr:    String;
  w1, w2, kr, fin: integer;
begin           // подсказка -> rectangle6.Tag - krug  lVmatch.Tag - final
  while True do // Возможно формирование сразу нескольких кругов, поэтому цикл
  begin
    myStp            :=  True;
    w1               :=  0;
    w2               :=  0;
    fin              :=  0;  // Ловлю финал
    ctr              :=  '';
    kr               :=  rectangle6.Tag + 1;
    if (FDQuery.Active)  then   FDQuery.Close;
    FDQuery.SQL.Text := 'SELECT tournum, name FROM fighters WHERE fgid=:pID';
    FDTbatl.Open;
    query            :=  TFDQuery.Create(nil);
    query.Connection :=  FDConnection;
    query.SQL.Text   := 'SELECT * FROM battle WHERE tourid=' + IntToStr(rectangle7.Tag) + ' AND krug=' + IntToStr(rectangle6.Tag);
    query.Open;
    while not query.Eof  do
    begin
      if  myStp then
      begin
          if  (query.FieldByName('fgid1').AsInteger  >  0) and       (query.FieldByName('fgid2').AsInteger > 0) then
          begin
            if query.FieldByName('letter1').AsString = 'W' then w1 := query.FieldByName('fgid1').AsInteger;
            if query.FieldByName('letter2').AsString = 'W' then w1 := query.FieldByName('fgid2').AsInteger;
          end
          else
          begin   // Здесь только 1 участник, фиксации быть не могло, он просто проходит дальше
            if query.FieldByName('fgid1').AsInteger  >  0  then w1 := query.FieldByName('fgid1').AsInteger;
            if query.FieldByName('fgid2').AsInteger  >  0  then w1 := query.FieldByName('fgid2').AsInteger;
          end;
          myStp   := False;
          fin     := fin + 1;
      end
      else
      begin
          if  (query.FieldByName('fgid1').AsInteger  >  0) and       (query.FieldByName('fgid2').AsInteger > 0) then
          begin
            if query.FieldByName('letter1').AsString = 'W' then w2 := query.FieldByName('fgid1').AsInteger;
            if query.FieldByName('letter2').AsString = 'W' then w2 := query.FieldByName('fgid2').AsInteger;
          end
          else
          begin   // Здесь только 1 участник, фиксации быть не могло, он просто проходит дальше
            if query.FieldByName('fgid1').AsInteger  >  0  then w2 := query.FieldByName('fgid1').AsInteger;
            if query.FieldByName('fgid2').AsInteger  >  0  then w2 := query.FieldByName('fgid2').AsInteger;
          end;
          myStp   := True;
          createPairOlimp(kr, w1, w2);
          fin     := fin + 1;
          w1      := 0;
          w2      := 0;
      end;
      query.Next;
    end;
	  query.Close;
    query.Free;
    FDTbatl.Close;
    if fin = 2 then  lVmatch.Tag := 1;   // Признак финала
    rectangle6.Tag   :=  kr;
    FDQuery.SQL.Text := 'SELECT COUNT(*) AS kz FROM battle WHERE tourid=' + IntToStr(rectangle7.Tag) + ' AND krug=' + IntToStr(kr) + ' AND finish=0';
    FDQuery.Open;                        // Надо проверить, возможно в следующем круге уже нет поединков для фиксации
    kr     :=   FDQuery.FieldByName('kz').AsInteger;
    FDQuery.Close;
    if fin  = 1 then                     // Финальный поединок с одним участником, надо автоматически закрывать турнир
    begin
       memo.Lines.Clear;
       memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Text);
       memo.Lines.Add(lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Detail);
       FDQuery.SQL.Text := 'SELECT fgid1, fmim1, fgid2, fmim2 FROM battle WHERE tourid=' + IntToStr(rectangle7.Tag) + ' AND krug=' + IntToStr(rectangle6.Tag - 1);
       FDQuery.Open;    //  Здесь финал турнира м.б. только при наличии одного в паре, он и победитель
       if FDQuery.FieldByName('fgid1').AsInteger > 0 then ctr := FDQuery.FieldByName('fmim1').AsString;
       if FDQuery.FieldByName('fgid2').AsInteger > 0 then ctr := FDQuery.FieldByName('fmim2').AsString;
       FDQuery.Close;
       if  ctr.Length > 0 then
       begin
	       FDQuery.SQL.Text := 'UPDATE tournament SET status=3, winner=' + chr(39) + ctr + chr(39) + ' WHERE tourid=' + IntToStr(rectangle7.Tag);
         memo.Lines.Add(     'Finished. Winner: ' + ctr);
       end
       else                  // Возможно придется подсчитать каждому количество побед и очков (а может и нет)
       begin
         FDQuery.SQL.Text := 'UPDATE tournament SET status=3 WHERE tourid='                                         + IntToStr(rectangle7.Tag);
         memo.Lines.Add(     'Finished.');
       end;
	     FDQuery.ExecSQL;      // Ставлю метку - "Турнир завершен"
	     lViewTour.BeginUpdate;
       lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Data['status']              := 'finished';
	     lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat := lViewTour.Items.AppearanceItem[lViewTour.ItemIndex].Objects.TextButton.TagFloat + 90; // Признак - турнир закрыт
	     lViewTour.EndUpdate;
       lViewTour.Resize;
       ctr := 'The tournament is closed.';  // Здесь бы неплохо второй строкой показывать победителя
    end
    else
    begin
       if     kr > 0 then
       begin
              kr :=  rectangle6.Tag - 1;    // Приходится опять присваивать, чтобы правильно озвучить завершившийся круг
         case kr of
            1 :  ctr := 'the first round is completed';
            2 :  ctr := 'the second round is completed';
            3 :  ctr := 'the third round is completed';
            4 :  ctr := 'the forth round is completed';
            5 :  ctr := 'the fifth round is completed';
         end;
       end;
    end;
    if ctr.Length > 0 then
    begin                    // Выход или если оставшие бои сложились сами-собой до финала, или если есть что фиксировать дальше
{$IF DEFINED(ANDROID)}
     ToastMsg(ctr);          // Чтобы отрабатывала эта команда в корень кладу Androidapi.JNI.Toast.pas и прописываю его в uses
{$ELSEIF defined(MSWINDOWS)}
     ShowMessage(ctr);
{$ENDIF};
     break;
    end;
  end;
end;

procedure Tfrm.KOvisble(iSt: integer); // Допуск к кнопкам через эту процедуру
begin
  sBtnTbl.Visible      := False;
  sBtnTbl.Align        := TAlignLayout.MostRight;
  layout27.Visible     := False;
  layout27.Align       := TAlignLayout.MostRight;
  sBtnPlace.Visible    := False;
  sBtnPlace.Align      := TAlignLayout.MostRight;
  sBtnOlimp.Visible    := False;
  sBtnOlimp.Align      := TAlignLayout.MostRight;
  sBtnKrug.Visible     := False;
  sBtnKrug.Align       := TAlignLayout.MostRight;

  if iSt < 2 then      // Еще не было зафиксировано ни одного поединка
  begin
     sBtnKrug.Align    := TAlignLayout.MostLeft;
     sBtnKrug.Visible  := True;
     sBtnOlimp.Align   := TAlignLayout.MostLeft;
     sBtnOlimp.Visible := True;
     sBtnCCadd.Visible := True; // Использую такую конструкцию т.к.
     sBtnCCred.Visible := True; // без нее сбивается порядок кнопок
     sBtnCCdel.Visible := True;
  end
  else                 // Был хотя бы один поединок
  begin
     sBtnPlace.Align   := TAlignLayout.MostLeft;
     sBtnPlace.Visible := True;
     if sBtnKrug.Tag    = 1 then
     begin
     layout27.Align    := TAlignLayout.MostLeft;
     layout27.Visible  := True;
     end;
     sBtnTbl.Align     := TAlignLayout.MostLeft;
     sBtnTbl.Visible   := True;
     sBtnCCdel.Visible := False; // Если хоть 1 бой зафиксирован,
     sBtnCCred.Visible := False; // блокирую добавить, редактировать, удалить
     sBtnCCadd.Visible := False;
  end;
end;

procedure Tfrm.checkDBstructure;
var
  i: integer;
  T: TFDTable;
  f: boolean;
begin // часть 1. При переходе с 1-й версии на 2-ю в таблицу battle добавились 3 поля, это необходимо проверять
  f            := False;
  T            := TFDTable.Create(nil);
  T.Connection := FDConnection;
  T.TableName  := 'battle';
  T.Open;
  for i := 0 to T.FieldCount - 1 do
  begin
     if (T.Fields[i].FieldName = 'otime1') OR (T.Fields[i].FieldName = 'otime2') OR (T.Fields[i].FieldName = 'draw') then
     begin
      f := True;  // Проверка упощенная, по любому из трех полей
           Exit;
     end;
  end;
  T.Close;
  if not f then   // В таблице не найдено ни одного из трех новых полей
  begin
     if (FDQuery.Active)  then  FDQuery.Close;
     FDQuery.SQL.Text := 'ALTER TABLE battle ADD COLUMN otime1 NUMERIC (5,1)';
     FDQuery.ExecSQL;
     FDQuery.SQL.Text := 'ALTER TABLE battle ADD COLUMN otime2 NUMERIC (5,1)';
     FDQuery.ExecSQL;
     FDQuery.SQL.Text := 'ALTER TABLE battle ADD COLUMN draw BOOLEAN';
     FDQuery.ExecSQL;
  end;            // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ver 1.0.1.0 (11-02-2017) - - -
end;

function Tfrm.brecket(): String;
begin                //  Запоминаю счет поединка для отражения его в следующем круге
  Result := '';
         if (FDQuery.FieldByName('letter1').AsString = 'W') or  (FDQuery.FieldByName('letter2').AsString = 'W') then
  Result :=     ' [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
  else   if (FDQuery.FieldByName('letter1').AsString = 'D') and (FDQuery.FieldByName('letter2').AsString = 'D') then
  Result := 'DRAW [ ' + FDQuery.FieldByName('points1').AsString + ' : ' + FDQuery.FieldByName('points2').AsString + ' ]'
  else   if (FDQuery.FieldByName('letter1').AsString = '0') and (FDQuery.FieldByName('letter2').AsString = '0') then
  Result :=  sBtnDef.Text      // Обоюдный невыход
  else   if (FDQuery.FieldByName('letter1').AsString = 'X') and (FDQuery.FieldByName('letter2').AsString = 'X') then
  Result := '&nbsp;';          // Некому было выходить (пусто)
end;

end.
