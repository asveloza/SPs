/************************************************************************/
/*  Archivo:                         ecfor_cc_531.sp                    */
/*  Stored procedure:                sp_formato_CC_531                  */
/*  Base de datos:                   cob_conta_super                    */
/*  Producto:                        REC                                */
/*  Fecha de escritura:              10/31/2017                         */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP",                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Ingresar los saldos del formato 531                                 */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  10/31/2017             Rodrigo Prada      Emision inicial           */
/************************************************************************/
use cob_conta_super
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_formato_CC_531')
drop proc sp_formato_CC_531
go

create proc sp_formato_CC_531(
   @i_param1                    int      = null, --Empresa
   @i_param2                    datetime = null, --Fecha de Proceso
   @i_param3                    char(1)  = null, --Opcion F: Formatos
   @i_param4                    int      = null, --Formato
   @i_param5                    char(1)  = 'S' , --Generacion Archivo PLano de Parametrizaciones
   @i_param6                    char(1)  = null  --Periodicidad
)
as
declare
   @w_empresa                   int,
   @w_sp_name                   varchar(40),
   @w_msg                       varchar(40),
   @w_error                     int,
   @w_retorno                   int,
   @w_fecha_calc                datetime,
   @w_mensaje                   varchar(200),
   @w_gen_plano_par             char(1),
   @w_fecha_sistema             datetime,
   @w_periodo                   int,
   @w_corte                     int,
   @w_opcion                    char(1),
   @w_fto_ingreso               int,
   @w_columna                   int,
   @w_proceso                   varchar(30),
   @w_fila                      int,
   @i_descrp_error              varchar(255),
   @i_empresa                   tinyint,
   @w_fecha_ingreso             datetime,
   @w_cta_11                    money,
   @w_cta_111510                money,
   @w_indice_haircut            float,
   @w_indice_riesgos            float,
   @w_valor_saldo               float,
   @w_return                    bigint,
   @w_moneda                    int,
   @w_periodicidad              char(1),
   @w_frw                       money,
   @w_parfac                    int,
   @w_parfwd                    int,
   @w_colmin                    int,
   @w_trm                       money,
   @w_scta                      char(3),
   @w_curcol                    int,
   @w_curuc                     varchar(3),
   @w_cursct                    varchar(3),
   @w_curval                    float,
   @w_curtipo                   char(1),
   @w_curcat                    varchar(30),
   @w_curarch                   char(1)


   select
   @w_empresa       = @i_param1,
   @w_fecha_ingreso = @i_param2,
   @w_opcion        = @i_param3,
   @w_fto_ingreso   = @i_param4,
   @w_gen_plano_par = @i_param5,
   @w_periodicidad  = @i_param6,
   @w_sp_name       = 'sp_formato_CC_531'

   select
   @w_retorno        = 0,
   @w_error          = 1,
   @w_msg            = 'FIN DEL PROCESO',
   @w_fecha_sistema  = getdate()

   select @w_parfac = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'FAC531'
   
   select @w_parfwd = codigo
   from cobis..cl_tabla
   where tabla = 'cl_forward'

   select @w_proceso      = cr_proceso
   from   cob_conta_super..sb_configurar_reportes
   where  cr_formato      = @w_fto_ingreso
   and    cr_estado       = 'V'
   and   (cr_periodicidad = @w_periodicidad
   or     cr_periodicidad is null)

   select @w_periodo = co_periodo,
          @w_corte   = co_corte
   from cob_conta..cb_corte
   where co_fecha_ini = @w_fecha_ingreso

   select @w_trm    = ct_valor
   from   cob_conta..cb_cotizacion
   where  ct_moneda = 1
   and    ct_fecha  = dateadd(d,+1,@w_fecha_ingreso)

----------------------------------------------------------------------------------------------
---------------------------------SE CREA LA TABLA DE MONEDAS----------------------------------
----------------------------------------------------------------------------------------------

   select * into #tmp_paramon
   from cob_conta_super..sb_equivalencias
   where eq_catalogo = 'MONEDA531'

----------------------------------------------------------------------------------------------
--------------------------------ASIGNACION VALOR FORWARD--------------------------------------
----------------------------------------------------------------------------------------------

   select @w_frw = sum(di_monto) 
   from cob_conta_super..sb_dato_inventariofrwd
   where di_tipo in (select valor from cobis..cl_catalogo where tabla= @w_parfwd)

----------------------------------------------------------------------------------------------
-----------------------------CREACION DE TABLA #validaciones----------------------------------
----------------------------------------------------------------------------------------------

   select
   va_num_val        = eq_descripcion,
   va_valor_cat      = eq_valor_cat,
   va_grupo_arch     = substring(eq_valor_arch,1,1),
   va_simbol_arch    = substring(eq_valor_arch,5,1),
   va_valor_arch     = substring(eq_valor_arch,6,30),
   va_val_arch       = convert(float,sum(isnull(hi_saldo,0)))
   into  #tmp_valores
   from  cob_conta_super..sb_equivalencias, cob_conta_his..cb_hist_saldo
   where hi_oficina        > 0
   and   hi_area           > 0
   and   hi_corte          = @w_corte
   and   hi_periodo        = @w_periodo
   and   eq_catalogo       = 'EC_CC531'
   and   eq_estado         = 'V'
   and   hi_cuenta        = substring(eq_valor_arch,6,30)
   and   substring(eq_valor_cat,2,3) = convert(char(3),531)
   group by eq_descripcion, eq_valor_cat, substring(eq_valor_arch,1,1),substring(eq_valor_arch,6,30), substring(eq_valor_arch,5,1)

   if @@rowcount = 0
   begin
      select
      @w_error   = 999999,
      @w_mensaje = 'NO EXISTE PARAMETRIZACION EQUIVALENCIAS PARA EL FORMATO 531.'
      goto ERRORFIN
   end
   
   update #tmp_valores
   set va_val_arch = va_val_arch / ct_valor
   from #tmp_valores a,
        cob_conta..cb_cotizacion b,
        #tmp_paramon c
   where c.eq_valor_cat  = substring(a.va_valor_cat,9,3)
   and   c.eq_valor_arch = b.ct_moneda
   and   ct_fecha  = @w_fecha_ingreso


   select
   'va_num_val'     = va_num_val,
   'va_valor_cat'   = va_valor_cat,
   'va_grupo_arch'  = va_grupo_arch,
   'va_simbol_arch' = va_simbol_arch,
   'va_val_arch'    = sum(abs(isnull(va_val_arch,0)))
   into #validaciones
   from #tmp_valores
   group by va_num_val, va_valor_cat, va_grupo_arch, va_simbol_arch

   if @@rowcount = 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'NO SE PUEDE CREAR LA TABLA DE EQUIVALENCIAS PARA EL PROCESO 531'
      goto ERRORFIN
   end
  
----------------------------------------------------------------------------------------------
----------------------------------SE ASIGNAN VALORES FORWARDS---------------------------------
----------------------------------------------------------------------------------------------

   insert into #validaciones
   (va_num_val                , va_valor_cat   , va_grupo_arch , va_simbol_arch , va_val_arch )
   select
   'PARAMETRIZACION CUENTAS CONTABLES 531' , 'D5310301002'  , 'B'           , '+'            , @w_frw        

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR INSERTANDO EN LA TABLA DE CRUCE'
      goto ERRORFIN
   end
  
----------------------------------------------------------------------------------------------
------------------------------------CREACION TABLE CRUCE--------------------------------------
----------------------------------------------------------------------------------------------
    select
    'va_num_val'        = va_num_val        ,
    'va_valor_cat'      = va_valor_cat      ,
    'va_valor_arch'     = va_valor_arch     ,
    'va_val_arch'       = 0                 ,
    'par1'              = [A]               ,
    'par2'              = [B]               ,
    'par3'              = [C]               ,
    'par4'              = [D]               ,
    'par5'              = [E]               
    into #tmp_valdiv40
    from
    (select  va_grupo_arch, va_num_val, va_valor_cat,'operacion' as va_valor_arch,va_val_arch
    FROM #validaciones
    )  as  source
    PIVOT
    (
    sum(va_val_arch)
    for va_grupo_arch in ([A],[B],[C],[D],[E])
    ) as piv

    alter table #tmp_valdiv40 alter column va_val_arch float

----------------------------------------------------------------------------------------------
----------------------------CALCULO DE LAS OPERACIONES SOLICITADAS----------------------------
----------------------------------------------------------------------------------------------

    update #tmp_valdiv40
    set va_val_arch     = (par1) 
    where substring(va_valor_cat,1,1) = 'A'

    if @@error <> 0
    begin
       select @w_error = @@error
       select @w_msg = 'ERROR AL ACTUALIZAR EL VALOR DE LA CUENTA'
       goto ERRORFIN
    end

    update #tmp_valdiv40
    set va_val_arch    = (par1 - par2) / @w_trm
    where substring(va_valor_cat,1,1) = 'B'

    if @@error <> 0
    begin
       select @w_error = @@error
       select @w_msg = 'ERROR AL ACTUALIZAR EL VALOR DE LA CUENTA'
       goto ERRORFIN
    end

    update #tmp_valdiv40
    set va_val_arch    = (((par1 - (par2)) + (par3 - (par4))) / par5) 
    where substring(va_valor_cat,1,1) = 'C'

    if @@error <> 0
    begin
       select @w_error = @@error
       select @w_msg = 'ERROR AL ACTUALIZAR EL VALOR DE LA CUENTA'
       goto ERRORFIN
    end

    update #tmp_valdiv40
    set va_val_arch    = ((par1 + par2 + par3) / par4)
    where substring(va_valor_cat,1,1) = 'D'

    if @@error <> 0
    begin
       select @w_error = @@error
       select @w_msg = 'ERROR AL ACTUALIZAR EL VALOR DE LA CUENTA'
       goto ERRORFIN
    end

----------------------------------------------------------------------------------------------
-----------------------------------CARGUE A LA HIST_SALDO-------------------------------------
----------------------------------------------------------------------------------------------

   select @w_colmin   = min(co_num_columna)-1
   from   cob_conta_super..sb_columnas
   where  co_proceso  = @w_proceso
   and    co_tipo_col = '03'


   declare cursor_cc_531 cursor for
      select substring(va_valor_cat,5,2) + @w_colmin, substring(va_valor_cat,7,2), substring(va_valor_cat,9,3), va_val_arch
      from #tmp_valdiv40
      order by substring(va_valor_cat,7,2) , substring(va_valor_cat,5,2) + @w_colmin , substring(va_valor_cat,9,3), va_val_arch
   for read only

   open  cursor_cc_531
   fetch cursor_cc_531
   into  @w_curcol, @w_curuc, @w_cursct, @w_curval

   while (@@fetch_status = 0)
   begin

      select @w_fila = fi_num_fila
      from cob_conta_super..sb_filas
      where fi_proceso=@w_proceso
      and (fi_num_col=1 and fi_descripcion = @w_cursct )
      and fi_num_fila in (select fi_num_fila
                          from cob_conta_super..sb_filas
                          where fi_proceso=@w_proceso
                          and fi_num_col=43
                          and fi_descripcion=@w_curuc)

      exec @w_return=cob_conta_super..sp_ingresa_saldo_531
         @i_empresa    =   @w_empresa,
         @i_periodo    =   @w_periodo,
         @i_corte      =   @w_corte,
         @i_proceso    =   @w_proceso,
         @i_fila       =   @w_fila ,
         @i_columna    =   @w_curcol,
         @i_saldo      =   @w_curval,
         @i_fecha_proc =   @w_fecha_ingreso

      if @w_return<>0
      begin
        select @w_error   = 9999999,
        @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO FORMATO 531'
        goto ERRORFIN
      end

      fetch cursor_cc_531
      into  @w_curcol, @w_curuc, @w_cursct, @w_curval
   end
   close cursor_cc_531
   deallocate cursor_cc_531
  
return 0

   ERRORFIN:
   begin
      select @w_msg = @w_sp_name + ' ' + @w_msg

      Exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_ingreso,
         @i_origen_error  = @w_error,
         @i_fuente        = @w_sp_name,
         @i_descrp_error  = @w_mensaje
      return @w_error
   end
go
