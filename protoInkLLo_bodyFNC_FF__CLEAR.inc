{//.[ PRoTo Singly Linked Lists].....................[ in0k © 13.01.2013 ]...///
///                                                                          ///
///                                _____                                     ///
///                     +-+-+-+-+-|   __|_ _ first -> -                      ///
///                     |  PRoTo  |__   | | |         -                      ///
///                     +-+-+-+-+-|_____|_|_|         -                      ///
///                          v 2.0             nil <- =                      ///
///                                                                          ///
///............................................[ v 2.0 in0k © 27.05.2013 ]...//}
{%region /fold 'check "define" for all used macros'                      }
    //--- VARs
    {$if defined (_M_protoInkLLo_FF__var_FIRST)}
        {$define _var_piLLoFF_FIRST:=_M_protoInkLLo_FF__var_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLo_FF__lcl_getNext)}
        {$define _fnc_piLLoFF_getNext:=_M_protoInkLLo_FF__lcl_getNext}
    {$elseif defined (_M_protoInkLLo_blockFNK__GetNext)}
        {$define _fnc_piLLoFF_getNext:=_M_protoInkLLo_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._GetNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLo_FF__lcl_nodeDST)}
        {$define _fnc_piLLoFF_nodeDST:=_M_protoInkLLo_FF__lcl_nodeDST}
    {$elseif defined (_M_protoInkLLo_blockFNK__nodeDST)}
        {$define _fnc_piLLoFF_nodeDST:=_M_protoInkLLo_blockFNK__nodeDST}
    {$else}
        {$FATAL 'macro ".._nodeDST" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoInkLLo_FF__tmp_POINTER)}
    {$define _tmp_piLLoFF_POINTER:=_m_protoInkLLo_FF__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_piLLoFF_POINTER:=tmp}
{$endif}
{%endregion}
begin
    while _var_piLLoFF_FIRST<>nil do begin
        // шаг на СЛЕДУЮЩИЙ
       _tmp_piLLoFF_POINTER:=_var_piLLoFF_FIRST;
       _var_piLLoFF_FIRST  :=_fnc_piLLoFF_getNext(_tmp_piLLoFF_POINTER);
        // уничтожение элемента tmp
       _fnc_piLLoFF_nodeDST(_tmp_piLLoFF_POINTER);
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp_piLLoFF_POINTER}
    //--- undef Local macros
    {$unDef _var_piLLoFF_FIRST}
    {$unDef _fnc_piLLoFF_getNext}
    {$unDef _fnc_piLLoFF_nodeDST}
    //--- undef user macros
    {$undef _m_protoInkLLo_FF__tmp_POINTER}
    {$undef _M_protoInkLLo_FF__var_FIRST}
    {$unDef _M_protoInkLLo_FF__lcl_getNext}
    {$unDef _M_protoInkLLo_FF__lcl_nodeDST}
{%endregion}
