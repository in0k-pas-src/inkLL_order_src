unit inkLL_order;
{<*** Order Linked Lists
    * библиокека для работы с "УПОРЯДОЧЕННЫМи Связными Списками"
    *}
{//..................................................[ in0k © 07.05.2014 ]...///
///                              _____                                       ///
///                      Order  |  _  |_ _ first -> - 0                      ///
///                      Linked | |_| | | |         - 1                      ///
///                      Lists  |_____|_|_|         - 2                      ///
///                              v 0.91    first <- = 3                      ///
///                                                                          ///
///...........................................[ v 0.9  in0k © 07.05.2014 ]...//}


{краткое содержание повествования://------------------------------------//

  #1 объявление типов
  ===================



  #2 работа со списком
  ====================




    06v1  - вставить УЗЕЛ в начало списка
    06v2  - вставить УЗЕЛ в начало списка













    -- 2.00-FF рождение и смерть
    00    - создание/инициализация
    --
    FF    - оЧистка/уничтожение
    FFx0  - очистка с уничтожением pQueueNode (вообще, это тока для тестов)
    FFx1  - очистка с вызовом-по-указателю функции
    FFx2  - очистка с вызовом-по-указателю МЕТОДА класса

    E4    - очистка узлов удовлетворяющих условию

    -- 2.2 текущие/очевидные свойства списка
    10    - проверка на пустоту
    11    - количесво узлов

    -- 2.3 от кончика ушей до пят (операции над ВСЕМ списком)
    20    - обход списка (с первого по последний)
    20x1  - обход списка с вызовом-по-указателю функции
    20x2  - обход списка вызовом-по-указателю МЕТОДА класса
    69    - инвертирование списка

    -- 2.5 последний Герой (последний узел списка)
    05v1  - последний Узел
    05v2  - последний Узел и общее кол-во узлов

    -- 2.6 вырезать "МЕНЯ"
    C0v1  - вырезать УЗЕЛ (САМОГО СЕБЯ)
    C0v2  - вырезать УЗЕЛ (САМОГО СЕБЯ) и подтверждение и вырезании

    -- 2.7 Грива и Хвост (вставка/удаление из начала и конца очереди)
    C1    - вырезать УЗЕЛ из Начала списка
    06    - вставить УЗЕЛ в начало списка
    07    - вставить СПИСОК в начало списка
    --
    C2    - вырезать ВТОРОЙ элемент списка
    16    - вставить УЗЕЛ в список ВТОРЫМ элементом
    --
    CFv1  - вырезать УЗЕЛ из Конца списка
    CFv2  - вырезать УЗЕЛ из Конца списка
    08v1  - вставить УЗЕЛ в конец списка
    08v2  - вставить УЗЕЛ в конец списка и общее кол-во узлов
    09v1  - вставить СПИСОК в конец списка
    09v2  - вставить СПИСОК в конец списка и общее кол-во узлов

    -- 2.8 МАССИВ
    A1v1  - элемент с индексом
    A1v2  - элемент с индексом или ПОСЛЕДНИЙ
    A2    - индекс элемента (принадлежит ли элемент списку)
    --
    A3    - вставить элемент с индексом
    A4    - вставить СПИСОК с индексом
    --
    A5    - вырезать элемент с индексом
    A6    - вырезать СПИСОК с индексом

//---------------------------------------------------------------------------//}
interface
{%region /fold}//----------------------------------[ compiler directives ]
{}  {$ifdef fpc}                                             { это для LAZARUS }
{}     {$mode delphi}     // для пущей совместимости написанного кода         {}
{}     {$define _INLINE_}                                                     {}
{}  {$else}                                                   { это для DELPHI }
{}     {$IFDEF SUPPORTS_INLINE}                                               {}
{}       {$define _INLINE_}                                                   {}
{}     {$endif}                                                               {}
{}  {$endif}                                                                  {}
{}  {$ifOpt D+} // режим дебуга ВКЛЮЧЕН                      { "боевой" INLINE }
{}       {$undef _INLINE_} // дeбугить просче БЕЗ INLIN`а                     {}
{}  {$endif}                                                                  {}
{%endregion}//-------------------------------------------[ compiler directives ]
{$ifOpt D+}
{$define inkLLorder_fncHeadMessage} //< сообщения о текущей процедуре, с ними проще ловить ошибки
{$endif}
uses {$ifOpt D+}sysutils,{$endif} //< попытка отлова ДИНАМИЧЕСКИХ ошибок
    inkLL_node;

//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #1 //
//                                                                            //
//****************************************************************************//


//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

//== 2.0-F рождение и смерть ==

procedure inkLLo_INIT(out OLL:pointer);                                         {$ifdef _INLINE_} inline; {$endif}

procedure inkLLo_CLEAR(var OLL:pointer; const disposePRC:fInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLo_CLEAR(var OLL:pointer; const disposePRC:aInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;

//procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
//procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
//procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
//procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;

//== 2.2 текущие/очевидные свойства списка ==

function  inkLLo_isEmpty (const OLL:pointer):boolean;                           {$ifdef _INLINE_} inline; {$endif}
//function  inkLLc_clcCount(const OLL:pointer):tInkLLNodeCount;                   {$ifdef _INLINE_} inline; {$endif}






procedure inkLLc_insNodeV1(var OLL:pointer; const Node:pointer);                {$ifdef _INLINE_} inline; {$endif}
//procedure inkLLc_insNodeV2(var OLL:pointer; const Node:pointer);                {$ifdef _INLINE_} inline; {$endif}





//== 2.3 от кончика ушей до пят (операции над ВСЕМ списком) ==

//function  inkLLc_Enumerate(const OLL:pointer; const Context:pointer; const EnumFNC:fInkNodeLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
//function  inkLLc_Enumerate(const OLL:pointer; const Context:pointer; const EnumFNC:aInkNodeLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
(*procedure inkLLc_Invert   (var   OLL:pointer);                                                                  {$ifdef _INLINE_} inline; {$endif}

//== 2.5 последний Герой (последний узел списка) ==

function  inkLLc_getLast(const OLL:pointer):pointer;                            {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_getLast(const OLL:pointer; out Count:tQueueCountNodes):pointer;{$ifdef _INLINE_} inline; {$endif} overload;

*)
//== 2.6 вырезать "МЕНЯ" ==

//procedure inkLLc_cutNode   (var OLL:pointer; const Node:pointer);               {$ifdef _INLINE_} inline; {$endif} overload;
//function  inkLLc_cutNodeRes(var OLL:pointer; const Node:pointer):boolean;       {$ifdef _INLINE_} inline; {$endif} overload;

(*
//== 2.7 Грива и Хвост (вставка/удаление из начала и конца СПИСКА) ==

//=== Грива ===

function  inkLLc_cutNodeFirst(var OLL:pointer):pointer;                         {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insNodeFirst(var OLL:pointer; const Node:pointer);             {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insListFirst(var OLL:pointer; const List:pointer);             {$ifdef _INLINE_} inline; {$endif}

*)
//=== ШЕЯ ===

//function  inkLLc_cutNodeSecond(const OLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}
//procedure inkLLc_insNodeSecond(var OLL:pointer; const Node:pointer);            {$ifdef _INLINE_} inline; {$endif}

(*


//=== Хвост ===

function  inkLLc_cutNodeLast(var OLL:pointer):pointer;                          {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_cutNodeLast(var OLL:pointer; out  Count:tInkLLNodeCount):pointer;{$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insNodeLast(var OLL:pointer; const Node:pointer);              {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insNodeLast(var OLL:pointer; const Node:pointer; out Count:tInkLLNodeCount); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insListLast(var OLL:pointer; const List:pointer);              overload; {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insListLast(var OLL:pointer; const List:pointer; out Count:tInkLLNodeCount);            overload; {$ifdef _INLINE_} inline; {$endif}

//    == 2.8 МАССИВ ==

function  inkLLc_getNode      (const OLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_getNodeOrLast(const OLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_getIndex     (const OLL:pointer; const Node:pointer; out Index:tInkLLNodeIndex):boolean; {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insNodeIndex (var   OLL:pointer; const Node:pointer; Index:tInkLLNodeIndex);             {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_cutNodeIndex (var   OLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
 *)
implementation

function inkNodeLLo_getNext(const node:pointer):pointer; {$ifdef _INLINE_} inline; {$endif}
begin
    result:=InkNodeLL_getNext(node);
end;

procedure inkNodeLLo_setNext(const node,next:pointer);   {$ifdef _INLINE_} inline; {$endif}
begin
    InkNodeLL_setNext(node,next);
end;

function inkNodeLLo_get_KEY(const node:pointer):pointer;  {$ifdef _INLINE_} inline; {$endif}
begin
    result:=node;
end;

function inkNodeLLo_KEYsCMP(const key1,key2:pointer):integer; {$ifdef _INLINE_} inline; {$endif}
begin
    if key1<key2// PtrUInt(key1)>PtrUInt(key2)
    then result:=1
   else
    if key1>key2//PtrUInt(key1)<PtrUInt(key2)
    then result:=-1
   else begin
        result:=0
    end;
end;

//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

{$MACRO ON}
{$deFine _M_protoInkLLo_blockFNK__GetNext:=inkNodeLLo_getNext}
{$deFine _M_protoInkLLo_blockFNK__SetNext:=inkNodeLLo_setNext}
{.$deFine _M_protoInkLLc_blockFNK__NodeDST:=''} //< чтобы ПОМНИТЬ
{$deFine _M_protoInkLLo_blockFNK__Get_KEY:=inkNodeLLo_get_KEY}
{$deFine _M_protoInkLLo_blockFNK__KEYsCMP:=inkNodeLLo_KEYsCMP}


//------------------------------------------------------------------------------

{:::[00] ИНИЦИАЛИЗИРОВАТЬ
    подготовить к работе переменную, в которой быдет лежать ГОЛОВА очереди.
   ~prm OLL переменная-ссылко-указатель на первый узел списка
    ---
    * OLL сделана как out для "подавления" hint`ов при начальной инициализации
:::}
procedure inkLLo_INIT(out OLL:pointer);
begin
    OLL:=nil;
end;

//------------------------------------------------------------------------------

{:::[FFv2x1] быстро УНИЧТОЖИТЬ элементы в порядке <2,3..n,1>
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на ФУНКЦИЮ уничтожения узла)
  ---
  * после выполнения OLL===@nil
  :}
procedure inkLLo_CLEAR(var OLL:pointer; const disposePRC:fInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLo_CLEAR function'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLo_FF__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLo_FF__var_FIRST  :=OLL}
{$deFine _M_protoInkLLo_FF__lcl_nodeDST:=disposePRC}
begin //< для удобства навигации
{$I protoInkLLo_bodyFNC_FF__CLEAR.inc}
end;

{:::[FFv2x2] быстро УНИЧТОЖИТЬ элементы в порядке: ВТОРОГО по ПОСЛЕДНИЙ, ПЕРВЫЙ
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на МЕТОД обЪекта уничтожения узла)
  ---
  * после выполнения OLL===@nil
  :}
procedure inkLLo_CLEAR(var OLL:pointer; const disposePRC:aInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLo_CLEAR method'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLo_FF__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLo_FF__var_FIRST  :=OLL}
{$deFine _M_protoInkLLo_FF__lcl_nodeDST:=disposePRC}
begin //< для удобства навигации
{$I protoInkLLo_bodyFNC_FF__CLEAR.inc}
end;

//------------------------------------------------------------------------------
(*  /fold
procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;
*)
//------------------------------------------------------------------------------

{:::[10] очередь ПУСТая?
   ~prm OLL переменная-ссылко-указатель на первый узел списка
   ~ret
    ~val true да, очередь Пуста
    ~val false ЕСТЬ элементы
  :}
function inkLLo_isEmpty(const OLL:pointer):boolean;
begin
    result:=OLL=nil;
end;






//------------------------------------------------------------------------------

{:::[06v1]] вставить УЗЕЛ в очередь.
    Вставляем узел в очередь в соответствии с рангом, НО ! ПЕРВЫМ среди равных !
   ~prm OLL переменная-ссылко-указатель на первый узел списка
   ~prm Node вставляемый узел
  :}
procedure inkLLc_insNodeV1(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_insNodeV1 function'}{$endIF}
var tmp:pointer;
{$deFine _M_protoInkLLo_06v1__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLo_06v1__var_FIRST:=OLL}
{$deFine _M_protoInkLLo_06v1__cst_NODE :=Node}
begin //< для удобства навигации
{$I protoInkLLo_bodyFNC_06v1__insNode.inc}
end;

(*
{:::[06v2] вставить УЗЕЛ в очередь.
   ~prm OLL переменная-ссылко-указатель на первый узел списка
   ~prm Node вставляемый узел
  :}
procedure inkLLc_insNodeV2(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_insNodeV2 function'}{$endIF}
begin

end;
*)
//------------------------------------------------------------------------------





//------------------------------------------------------------------------------
(*  /fold
{:::[11] ПОсчитать количество узлов (путем прямого перебора)
  @param (OLL переменная-ссылко-указатель на первый узел списка)
  @return(количество узлов)
  :}
function inkLLc_clcCount(const OLL:pointer):tInkLLNodeCount;
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_clcCount'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLc_11__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_11__cst_FIRST  :=OLL}
{$deFine _M_protoInkLLc_11__out_COUNT  :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_11__Count.inc}
end;
*)
//------------------------------------------------------------------------------
(*  /fold
{:::[20x1] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Context указатель на "информацию", передаваемую в EnumFNC для каждого узла)
  @param(EnumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель на последний посещенный узел)
  :}
function inkLLc_Enumerate(const OLL:pointer; const Context:pointer; const EnumFNC:fInkNodeLL_doProcess):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_Enumerate function'}{$endIF}
{$deFine _M_protoInkLLc_20__cst_FIRST  :=OLL}
{$deFine _M_protoInkLLc_20__cst_context:=Context}
{$deFine _M_protoInkLLc_20__cst_enumFNC:=EnumFNC}
{$deFine _M_protoInkLLc_20__out_LAST   :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_20__Enumerate.inc}
end;

{:::[20x2] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Context указатель на "информацию", передаваемую в EnumFNC для каждого узла)
  @param(EnumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель [pQueueNode] на последний посещенный узел)
  :}
function inkLLc_Enumerate(const OLL:pointer; const Context:pointer; const EnumFNC:aInkNodeLL_doProcess):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_Enumerate method'}{$endIF}
{$deFine _M_protoInkLLc_20__cst_FIRST  :=OLL}
{$deFine _M_protoInkLLc_20__cst_context:=Context}
{$deFine _M_protoInkLLc_20__cst_enumFNC:=EnumFNC}
{$deFine _M_protoInkLLc_20__out_LAST   :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_20__Enumerate.inc}
end;
*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(*
{:::[69] изменить порядок следования узлов списка на ОБРАТНЫЙ.
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  :}
procedure inkLLc_Invert(var OLL:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_Invert"'}{$endIF}
{$deFine _M_protoInkLLc_69__var_FIRST:=OLL}
{$I 'protoSLL_bodyFNC__69__Invert.inc}


//------------------------------------------------------------------------------

{:::[05v1] ПОСЛЕДНИЙ элемент списка (путем прямого перебора)
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkLLc_getLast(const OLL:pointer):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_getLast"'}{$endIF}
{$deFine _M_protoInkLLc_05v1__cst_FIRST:=OLL}
{$deFine _M_protoInkLLc_05v1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v1__getLast.inc}

{:::[05v2][простой связный Список][Singly Linked Lists]
  ПОСЛЕДНИЙ элемент списка (путем прямого перебора), и общее кол-во элементов
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkLLc_getLast(const OLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_getLast count"'}{$endIF}
{$deFine _M_protoInkLLc_05v2__cst_FIRST:=OLL}
{$deFine _M_protoInkLLc_05v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_05v2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v2__getLast.inc}

*)
//------------------------------------------------------------------------------
(*  /fold
{:::[C0v1] вырезать УЗЕЛ
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  :}
procedure inkLLc_cutNode(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_cutNode'}{$endIF}
var tmp:pointer;
{$deFine _m_protoInkLLc_C0v1__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_C0v1__var_FIRST  :=OLL}
{$deFine _M_protoInkLLc_C0v1__cst_NODE   :=Node}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C0v1__cutNode.inc}
end;

{:::[C0v2] вырезать УЗЕЛ
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  @returns(@true -- элемент найден и вырезан; @false -- элемент НЕ найден => НЕвырезался)
  :}
function  inkLLc_cutNodeRES(var OLL:pointer; const Node:pointer):boolean;
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_cutNodeRES'}{$endIF}
var tmp:pointer;
{$deFine _m_protoInkLLc_C0v2__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_C0v2__var_FIRST  :=OLL}
{$deFine _M_protoInkLLc_C0v2__cst_NODE   :=Node}
{$deFine _M_protoInkLLc_C0v2__out_RES    :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C0v2__cutNodeRES.inc}
end;
*)
//------------------------------------------------------------------------------
(*  /fold
{:::[С1] вырезать УЗЕЛ из Начала списка
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный Первый УЗЕЛ)
  ---
  # result^.next=?=@nil (тоесть скорее всего НЕ NIL)
  :}
function inkLLc_cutNodeFirst(var OLL:pointer):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_cutNodeFirst"'}{$endIF}
{$deFine _M_protoInkLLc_C1__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_C1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__C1__cutNodeFirst.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[06] ВСТАВИТЬ элемент ПЕРВЫМ в списке
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeFirst(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeFirst"'}{$endIF}
{$deFine _M_protoInkLLc_06__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_06__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__06__insFirst.inc}

{:::[07] ВСТАВИТЬ список СНАЧАЛА
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(List переменная-ссылко-указатель на первый узел вставляемого СПИСКА)
  :}
procedure inkLLc_insListFirst(var OLL:pointer; const List:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insListFirst"'}{$endIF}
{$deFine _M_protoInkLLc_07__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_07__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__07__insFirst.inc}
*)
//------------------------------------------------------------------------------
(*  /fold
{:::[C2] вырезать ВТОРОЙ элемент списка
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @return(вырезанный ВТОРОЙ УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
function  inkLLc_cutNodeSecond(const OLL:pointer):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_cutNodeSecond'}{$endIF}
{$deFine _M_protoInkLLc_C2__cst_FIRST:=OLL}
{$deFine _M_protoInkLLc_C2__out_NODE :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C2__cutNodeSecond.inc}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[16] вставить узел ВТОРЫМ элементом
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node указатель на добавляемый узел)
  ---
  # если OLL -- пуст, то встанет ПЕРВЫМ
  :}
procedure inkLLc_insNodeSecond(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'inkLLc_insNodeSecond'}{$endIF}
{$deFine _M_protoInkLLc_16__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_16__cst_NODE :=Node}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_16__insNodeSecond.inc}
end;
*)
//------------------------------------------------------------------------------
(*  /fold
{:::[CFv1] вырезать УЗЕЛ из КОНЦА списка
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай OLL==@NIL НЕ проверяется
  :}
function inkLLc_cutNodeLast(var OLL:pointer):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_cutNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_CFv1__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_CFv1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__CFv1__cutNodeLast.inc}


{:::[CFv2] вырезать УЗЕЛ из КОНЦА списка
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай OLL==@NIL НЕ проверяется
  :}
function inkLLc_cutNodeLast(var OLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_cutNodeLast_count"'}{$endIF}
{$deFine _M_protoInkLLc_0Dv2__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_0Dv2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_0Dv2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__0Dv2__cutNodeLast_count.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[08v1] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeLast(var OLL:pointer; const Node:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_08v1__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_08v1__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v1__insLast.inc}

{:::[08v2] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeLast(var OLL:pointer; const Node:pointer; out Count:tQueueCountNodes);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast count"'}{$endIF}
{$deFine _M_protoInkLLc_08v2__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_08v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_08v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v2__insLast.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[09v1] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insListLast(var OLL:pointer; const List:pointer);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insListLast"'}{$endIF}
{$deFine _M_protoInkLLc_09v1__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_09v1__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__09v1__insLast.inc}

{:::[09v2] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(OLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insListLast(var OLL:pointer; const List:pointer; out Count:tQueueCountNodes);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_09v2__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_09v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_09v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__09v2__insLast.inc}

//------------------------------------------------------------------------------

{:::[A1v1] элемент с Индексом
    @param(OLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkLLc_getNode(const OLL:pointer; index:tQueueCountNodes):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_getNode"'}{$endIF}
{$deFine _M_protoInkLLc_A1v1__cst_FIRST:=OLL}
{$deFine _M_protoInkLLc_A1v1__var_Index:=index}
{$deFine _M_protoInkLLc_A1v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v1__getNode.inc}

{:::[A1v2] элемент с Индексом или последний
    @param(OLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkLLc_getNodeOrLast(const OLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_getNode_orLast"'}{$endIF}
{$deFine _M_protoInkLLc_A1v2__cst_FIRST:=OLL}
{$deFine _M_protoInkLLc_A1v2__var_Index:=index}
{$deFine _M_protoInkLLc_A1v2__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v2__getNodeOrLast.inc}

//------------------------------------------------------------------------------

{:::[A2] элемент с Индексом
    @param(OLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
function inkLLc_getIndex(const OLL:pointer; const Node:pointer; out Index:tQueueCountNodes):boolean;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_getIndex"'}{$endIF}
{$deFine _M_protoInkLLc_0B__cst_FIRST :=OLL}
{$deFine _M_protoInkLLc_0B__cst_NODE  :=Node}
{$deFine _M_protoInkLLc_0B__out_INDEX :=index}
{$deFine _M_protoInkLLc_0B__out_RESULT:=result}
{$I 'protoSLL_bodyFNC__0B__getIndex.inc}

//------------------------------------------------------------------------------

{:::[A3] ВСТАВИТЬ элементом c ИНДЕКСОМ
    @param(OLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
procedure inkLLc_insNodeIndex(var OLL:pointer; const Node:pointer; Index:tQueueCountNodes);
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoInkLLc_A3__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_A3__cst_NODE :=Node}
{$deFine _M_protoInkLLc_A3__var_INDEX:=index}
{$I 'protoSLL_bodyFNC__A3__insNodeIndex.inc}

//------------------------------------------------------------------------------

{:::[A5v1] ВЫРЕЗАТЬ элемент c ИНДЕКСОМ
    @param(OLL переменная-ссылко-указатель на первый узел списка)
    @param(Index индекс ВЫРЕЗАЕМОГО элемента)
    @returns()
    ---
    # в результате выполнения result^.Next<>nil
 :::}
function inkLLc_cutNodeIndex(var OLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkLLorder_fncHeadMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoInkLLc_A5v1__var_FIRST:=OLL}
{$deFine _M_protoInkLLc_A5v1__var_INDEX:=index}
{$deFine _M_protoInkLLc_A5v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A5v1__insNodeIndex.inc}
    *)
end.
