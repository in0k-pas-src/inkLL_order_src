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
    {$if defined (_M_protoInkLLo_06v1__var_FIRST)}
        {$define _var_piLLo06v1_FIRST:=_M_protoInkLLo_06v1__var_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLo_06v1__cst_NODE)}
        {$define _cst_piLLo06v1_NODE:=_M_protoInkLLo_06v1__cst_NODE}
    {$else}
        {$FATAL 'macro ".._LIST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLo_06v1__lcl_getNext)}
        {$define _fnc_piLLo06v1_getNext:=_M_protoInkLLo_06v1__lcl_getNext}
    {$elseif defined (_M_protoInkLLo_blockFNK__GetNext)}
        {$define _fnc_piLLo06v1_getNext:=_M_protoInkLLo_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLo_06v1__lcl_setNext)}
        {$define _prc_piLLo06v1_setNext:=_M_protoInkLLo_06v1__lcl_setNext}
    {$elseif defined (_M_protoInkLLo_blockFNK__SetNext)}
        {$define _prc_piLLo06v1_setNext:=_M_protoInkLLo_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLo_06v1__lcl_get_KEY)}
        {$define _fnc_piLLo06v1_get_KEY:=_M_protoInkLLo_06v1__lcl_get_KEY}
    {$elseif defined (_M_protoInkLLo_blockFNK__get_KEY)}
        {$define _fnc_piLLo06v1_get_KEY:=_M_protoInkLLo_blockFNK__get_KEY}
    {$else}
        {$FATAL 'macro ".._get_KEY" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLo_06v1__lcl_KEYsCMP)}
        {$define _fnc_piLLo06v1_KEYsCMP:=_M_protoInkLLo_06v1__lcl_KEYsCMP}
    {$elseif defined (_M_protoInkLLo_blockFNK__KEYsCMP)}
        {$define _fnc_piLLo06v1_KEYsCMP:=_M_protoInkLLo_blockFNK__KEYsCMP}
    {$else}
        {$FATAL 'macro ".._KEYsCMP" : NOT define!'}
    {$endif}
    //-------------------------------

{%endregion 'check "define" for all used macros' /fold}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_M_protoInkLLo_06v1__tmp_POINTER)}
    {$define _tmp_piLLo06v1_POINTER:=_M_protoInkLLo_06v1__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_piLLo06v1_POINTER:=tmp}
{$endif}
{%endregion}
begin
    {$ifOPT D+} //< ранТайм проверки
        Assert(Assigned(_cst_piLLo06v1_NODE),'_cst_piLLo06v1_NODE == NIL');
        //???Assert(not Assigned(_prc_piLLo06v1_setNext(_cst_piLLo06v1_NODE)),'_cst_piLLo06v1_NODE.next <> NIL');
    {$endif}
    if Assigned(_var_piLLo06v1_FIRST) then begin
       _tmp_piLLo06v1_POINTER:=_var_piLLo06v1_FIRST;
        // проверка что перед ПЕРВЫМ
        if _fnc_piLLo06v1_KEYsCMP( _fnc_piLLo06v1_get_KEY(_tmp_piLLo06v1_POINTER) , _fnc_piLLo06v1_get_KEY(_cst_piLLo06v1_NODE) ) <0
        then begin
           _prc_piLLo06v1_setNext(_cst_piLLo06v1_NODE,_var_piLLo06v1_FIRST);
           _var_piLLo06v1_FIRST:=_cst_piLLo06v1_NODE;
        end
        else begin
            while assigned( _fnc_piLLo06v1_getNext(_tmp_piLLo06v1_POINTER) ) do begin
                if _fnc_piLLo06v1_KEYsCMP( _fnc_piLLo06v1_get_KEY(_fnc_piLLo06v1_getNext(_tmp_piLLo06v1_POINTER)) , _fnc_piLLo06v1_get_KEY(_cst_piLLo06v1_NODE) ) <0
                then BREAK;
                //---<
               _tmp_piLLo06v1_POINTER:=_fnc_piLLo06v1_getNext(_tmp_piLLo06v1_POINTER);
            end;
           _prc_piLLo06v1_setNext(_cst_piLLo06v1_NODE,_fnc_piLLo06v1_getNext(_tmp_piLLo06v1_POINTER));
           _prc_piLLo06v1_setNext(_tmp_piLLo06v1_POINTER,_cst_piLLo06v1_NODE);
        end;
    end
    else begin
       _var_piLLo06v1_FIRST:=_cst_piLLo06v1_NODE;
       _prc_piLLo06v1_setNext(_var_piLLo06v1_FIRST,nil);
    end;

   (*
    //--- вспомогательный алгоритм
    {$ifDef inkLLsimple_fncHeadMessage}{$message 'inline -> protoInkLLs_bodyFNC_05v1__getLast'}{$endIF}
        {$deFine _M_protoInkLLs_05v1__cst_FIRST:=_cst_piLLo06v1_NODE}
        {$deFine _M_protoInkLLs_05v1__out_LAST :=_tmp_piLLo06v1_POINTER}
        {$I protoInkLLs_bodyFNC_05v1__getLast.inc}
    //--- основной алгоритм
    {$ifDef inkLLsimple_fncHeadMessage}{$message 'MAIN code'}{$endIF}
   _prc_piLLo06v1_setNext(_tmp_piLLo06v1_POINTER,_var_piLLo06v1_FIRST);
   _var_piLLo06v1_FIRST:=_cst_piLLo06v1_NODE;
   *)
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef Super Local macros
    {$unDef _tmp_piLLo06v1_POINTER}
    //--- undef SupreLocal macros
    {$unDef _var_piLLo06v1_FIRST}
    {$unDef _cst_piLLo06v1_NODE}
    {$unDef _fnc_piLLo06v1_getNext}
    {$unDef _prc_piLLo06v1_setNext}
    {$unDef _fnc_piLLo06v1_get_KEY}
    {$unDef _fnc_piLLo06v1_KEYsCMP}



    //--- undef user macros
    {$unDef _M_protoInkLLo_06v1__tmp_POINTER}
    {$unDef _M_protoInkLLo_06v1__var_FIRST}
    {$unDef _M_protoInkLLo_06v1__cst_NODE}
    {$unDef _M_protoInkLLo_06v1__lcl_getNext}
    {$unDef _M_protoInkLLo_06v1__lcl_setNext}
    {$unDef _M_protoInkLLo_06v1__lcl_get_KEY}
    {$unDef _M_protoInkLLo_06v1__lcl_KEYsCMP}
{%endregion 'unDEF used macros' /fold}

