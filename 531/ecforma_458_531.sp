/************************************************************************/
/*  Archivo:                         ecforma_458_531.sp                 */
/*  Stored procedure:                sp_formato_cruce_458_531           */
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

if exists (select 1 from sysobjects where name = 'sp_formato_cruce_458_531')
   drop proc sp_formato_cruce_458_531
go

create proc sp_formato_cruce_458_531(
   @i_param1                    int      = null, --Empresa
   @i_param2                    datetime = null, --Fecha de Proceso
   @i_param3                    char(1)  = null, --Opcion F: Formatos
   @i_param4                    int      = null, --Formato
   @i_param5                    char(1)  = 'S' , --Generacion Archivo PLano de Parametrizaciones
   @i_param6                    char(1)  = null  --Periodicidad
)
as
   declare

   @w_num_val                   varchar(255),
   @w_mensaje                   varchar(150),
   @w_valor_arch1               varchar(120),
   @w_cuenta_origen             varchar(50),
   @w_cuenta_destino            varchar(50),
   @w_valor_cat                 varchar(30),
   @w_valor_arch                varchar(30),
   @w_sp_name                   varchar(30),
   @w_error                     varchar(15),
   @w_sta                       varchar(3),
   @w_fto                       varchar(3),
   @w_sta_des                   varchar(3),
   @w_fto_des                   varchar(3),
   @w_uc                        varchar(2),
   @w_col                       varchar(2),
   @w_fecha_ingreso             datetime,
   @w_fecha_previa              datetime,
   @w_tipo_val                  char(1),
   @w_signo_cat                 char(1),
   @w_signo_arch                char(1),
   @w_opcion                    char(1),
   @w_indicador                 tinyint,
   @w_col_calc                  int,
   @w_total_diferencia          money,
   @w_total_destino             money,
   @w_total_origen              money,
   @w_valor                     money,
   @w_fto_ingreso               int,
   @w_gen_plano_par             char(1),
   @w_periodo                   int,
   @w_empresa                   int,
   @w_proceso                   int,
   @w_proceso458                int,
   @w_max_col                   int,
   @w_colmin                    int,
   @w_corte                     int,
   @w_dias                      int,
   @w_var                       int,
   @w_periodicidad              char(1),
   @w_trm                       money,
   @w_uvr                       money,
   @w_maxfact                   float,
   @w_moneda                    money,
   @w_curcol                    int,
   @w_curuc                     varchar(3),
   @w_cursct                    varchar(3),
   @w_curval                    float,
   @w_fila                      int,
   @w_valvens                   money,
   @w_valvenm                   money,
   @w_val1302                   money,
   @w_arcfor                    int,
   @w_return                    bigint,
   @w_factor                    float,
   @w_fila_002                  int,
   @w_cod_prod                  smallint,
   @w_parfac                    int,
   @w_cod_uvr                   smallint

   select
   @w_empresa       = @i_param1,
   @w_fecha_ingreso = @i_param2,
   @w_opcion        = @i_param3,
   @w_fto_ingreso   = @i_param4,
   @w_gen_plano_par = @i_param5,
   @w_periodicidad  = @i_param6,
   @w_sp_name       = 'sp_formato_cruce_458_531',
   @w_factor        = 0.05

   select @w_maxfact = isnull(max(pa_float) ,10) / 100
   from cob_conta_super..sb_parametro_hist
   where  pa_nemonico = 'ICAVEM'

   select @w_cod_prod  = codigo
   from   cobis..cl_tabla
   where  tabla = 'cl_productos_531'

   select @w_cod_uvr = codigo
   from   cobis..cl_tabla
   where  tabla = 'cl_prod_uvr_531'
	
   select @w_parfac = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'FAC531'
   
   select @w_arcfor = af_codigo
   from  cobis..cl_arch_formato
   where af_archivo like '%FORMATO 458 PORTAFOLIO TV%'

   select
   @w_periodo = co_periodo,
   @w_corte   = co_corte
   from  cob_conta..cb_corte
   where co_fecha_ini = @w_fecha_ingreso
   and   co_empresa   = @w_empresa

   select @w_trm = isnull(ct_valor,1)
   from cob_conta..cb_cotizacion
   where ct_moneda= 1
   and ct_fecha= @w_fecha_ingreso

   select @w_proceso = cr_proceso
   from   cob_conta_super..sb_configurar_reportes
   where  cr_formato = @w_fto_ingreso
   and    cr_estado  = 'V'
   and   (cr_periodicidad = @w_periodicidad or cr_periodicidad is null)

   select @w_proceso458 = cr_proceso
   from   cob_conta_super..sb_configurar_reportes
   where  cr_formato = 458
   and    cr_estado  = 'V'
   and   (cr_periodicidad = @w_periodicidad or cr_periodicidad is null)

   select @w_max_col = max(co_num_columna)
   from   sb_columnas
   where  co_proceso = @w_proceso458

   select @w_uvr = ct_valor
   from cob_conta..cb_cotizacion
   where ct_moneda = 3 
   and   ct_fecha = @w_fecha_ingreso

   select @w_col_calc = (select top 1 count(distinct (ts_columna)))
   from   cob_conta_super..sb_tipo_saldo
   where  ts_proceso  = @w_proceso458
   group by ts_fila

   select @w_col_calc = @w_max_col - @w_col_calc --Se calcula las columnas reales DE LA NORMA, no las de COBIS

----------------------------------------------------------------------------------------------
------------------------SE ASIGNAN VALORES DEL MERCADO DE PORTAFOLIO--------------------------
----------------------------------------------------------------------------------------------

   select
   case when datediff(dd,tv_fechaemision,@w_fecha_ingreso) > 30 then 1
        when datediff(dd,tv_fechaemision,@w_fecha_ingreso) < 30 then 2
   end as val,
   tv_producto,
   sum((tv_valornominal - tv_valorgarantia) * (tv_preciomercado / 100)) as  valor
   into #tmp_vencimientos
   from cob_conta_super..sb_tipo_vencimientos
   where tv_producto in (select valor from cobis..cl_catalogo where tabla= @w_cod_prod)
   and tv_origen= @w_arcfor
   group by case when datediff(dd,tv_fechaemision,@w_fecha_ingreso) > 30 then 1
                 when datediff(dd,tv_fechaemision,@w_fecha_ingreso) < 30 then 2
           end ,
   tv_producto
  
   update #tmp_vencimientos
   set valor = valor * @w_uvr
   where tv_producto in (select valor from cobis..cl_catalogo where tabla= @w_cod_uvr)
 
   if @@error <> 0
   begin
      select @w_error = @@error
      select @w_mensaje = 'ERROR AL ACTUALIZAR EL VALOR DEL UVR'
      goto ERRORFIN
   end
 
   select @w_valvens = isnull(sum(valor) , 0)
   from #tmp_vencimientos
   where val= 1
 
   select @w_valvenm = isnull(sum(valor) , 0)
   from #tmp_vencimientos
   where val= 2
 
----------------------------------------------------------------------------------------------
----------------------------SE ASIGNAN VALORES DE LA CUENTA 1302------------------------------
----------------------------------------------------------------------------------------------

   select @w_val1302 = sum(isnull(hi_saldo,0))
   from cob_conta_his..cb_hist_saldo,
        cob_conta..cb_cuenta
   where cu_cuenta         = hi_cuenta
   and   hi_oficina        > 0
   and   hi_area           > 0
   and   hi_corte          = @w_corte
   and   hi_periodo        = @w_periodo
   and   hi_cuenta in ( select substring(eq_valor_arch,6,30) from cob_conta_super..sb_equivalencias
                        where eq_catalogo = 'EC_CC531' and substring(eq_valor_arch,2,3) = 'BAL'
						and substring(eq_valor_cat,5,30) = '1301001')




----------------------------------------------------------------------------------------------
---------------------------------SE CREA LA TABLA DE MONEDAS----------------------------------
----------------------------------------------------------------------------------------------

   select * into #tmp_paramon
   from cob_conta_super..sb_equivalencias
   where eq_catalogo = 'MONEDA531'

----------------------------------------------------------------------------------------------
--------------------------------SE CREA LA TABLA VALIDACIONES---------------------------------
----------------------------------------------------------------------------------------------

   if object_id(N'tempdb..#validaciones', N'U') is not null
      drop table #validaciones

   select
   va_num            = row_number() over (order by eq_valor_cat),
   va_num_val        = eq_descripcion,
   va_valor_cat      = eq_valor_cat,
   va_val_cat        = convert(float,0),
   va_val_cat_ori    = convert(float,0),
   va_valor_arch     = eq_valor_arch,
   va_val_arch       = convert(float,0),
   va_val_arch_ori   = convert(float,0)
   into  #validaciones
   from  cob_conta_super..sb_equivalencias
   where eq_catalogo                  = 'EC_CARG458'
   and   eq_estado                    = 'V'
   and   substring(eq_valor_arch,2,3) = '458'
   order by eq_valor_cat

   if @@rowcount = 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'NO EXISTE PARAMETRIZACION EQUIVALENCIAS PARA EL FORMATO 531'
      goto ERRORFIN
   end

   select @w_colmin   = min(co_num_columna)-1
   from   cob_conta_super..sb_columnas
   where  co_proceso  = @w_proceso458
   and    co_tipo_col = '03'

   if object_id(N'tempdb..#fila_subcta', N'U') is not null
      drop table #fila_subcta

   select fi_num_fila, fi_descripcion
   into   #fila_subcta
   from   cob_conta_super..sb_filas, cob_conta_super..sb_columnas
   where  co_proceso  = fi_proceso
   and    co_proceso  = @w_proceso458
   and    co_tipo_col = '02'
   and    fi_num_col  = 1

   if @@rowcount = 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'NO EXISTE PARAMETRIZACION PARA EL FORMATO 531'
      goto ERRORFIN
   end

   if object_id(N'tempdb..#fila_uc', N'U') is not null
      drop table #fila_uc

   select fi_num_fila, fi_descripcion
   into   #fila_uc
   from   cob_conta_super..sb_filas, cob_conta_super..sb_columnas
   where  co_proceso  = fi_proceso
   and    co_proceso  = @w_proceso458
   and    co_tipo_col = '04'
   and    fi_num_col  = @w_max_col

   if @@rowcount = 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'NO EXISTE PARAMETRIZACION PARA EL FORMATO 531'
      goto ERRORFIN
   end

----------------------------------------------------------------------------------------------
---------------------------------SE ACTUALIZAN LOS VALORES -----------------------------------
----------------------------------------------------------------------------------------------

   select @w_var  = 1

   while 1 = 1
   begin
      select
      @w_tipo_val           = substring(va_valor_arch,1,1),
      @w_fto                = substring(va_valor_arch,2,3),
      @w_col                = substring(va_valor_arch,5,2),
      @w_uc                 = substring(va_valor_arch,7,2),
      @w_sta                = substring(va_valor_arch,9,3),
      @w_cuenta_origen      = va_valor_arch,
      @w_cuenta_destino     = va_valor_cat,
      @w_num_val            = va_num_val
      from  #validaciones
      where va_num = @w_var
      order by va_num_val

      if @@rowcount = 0
        break

      if isnull(@w_indicador,0)  = 0
      begin

         select @w_valor = isnull(hs_saldo,0) *  @w_parfac
         from   #fila_subcta s, #fila_uc u, cob_conta_super..sb_hist_saldo
         where  s.fi_num_fila    = u.fi_num_fila
         and    u.fi_num_fila    = hs_fila
         and    s.fi_descripcion = @w_sta
         and    u.fi_descripcion = @w_uc
         and    hs_proceso       = @w_proceso458
         and    hs_corte         = @w_corte
         and    hs_periodo       = @w_periodo
         and    hs_columna       = @w_col + @w_colmin

         set rowcount 1

         update #validaciones
         set    va_val_arch     = isnull(@w_valor * (case @w_signo_cat when '-' then -1 else 1 end) ,0),
                va_val_arch_ori = isnull(@w_valor * (case @w_signo_cat when '-' then -1 else 1 end) ,0)
         where  va_num         = @w_var
         and    va_valor_arch  = @w_cuenta_origen

         if @@error <> 0
         begin
            select
            @w_error   = 9999999,
            @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
            goto ERRORFIN
         end

         set rowcount 0
      end

      select @w_valor = 0
      select @w_var   = @w_var + 1

   end
----------------------------------------------------------------------------------------------
--------------------------------SE CREA LA TABLA DE VALORES-----------------------------------
----------------------------------------------------------------------------------------------

   select
   'va_num'          = '1'           ,
   'va_num_val'      = va_num_val    ,
   'va_valor_cat'    = va_valor_cat  ,
   'va_valor_arch'   = va_valor_arch ,
   'va_val_arch'     = 0             ,
   'va_val_arch_ori' = 0             ,
   'par1'            = isnull([1],0) ,
   'par2'            = isnull([2],0) ,
   'par3'            = isnull([3],0) ,
   'par4'            = isnull([4],0) ,
   'par5'            = isnull([5],0) ,
   'par6'            = isnull([6],0)

   into #tmp_valdiv40 from
   (select  rank() over (partition by va_valor_cat order by va_valor_cat, va_valor_arch) va_num, va_num_val, va_valor_cat,'operacion' as va_valor_arch,va_val_arch
   FROM #validaciones
   )  as  source
   PIVOT
   (
   sum(va_val_arch)
   for va_num in ([1],[2],[3],[4],[5],[6])
   ) as piv

   if @@rowcount = 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'NO SE PUEDER CREAR LA TABLA DE CRUCE PARA EL FORMATO 531'
      goto ERRORFIN
   end

   alter table #tmp_valdiv40 alter column va_val_arch float
   alter table #tmp_valdiv40 alter column va_val_arch_ori float

----------------------------------------------------------------------------------------------
----------------------------CALCULO DE LAS OPERACIONES SOLICITADAS----------------------------
----------------------------------------------------------------------------------------------

   update #tmp_valdiv40
   set va_val_arch     = par1 / @w_trm,
       va_val_arch_ori = par1 / @w_trm
   where substring(va_valor_cat,1,1) = 'A'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

   update #tmp_valdiv40
   set va_val_arch     = (((par1 + par2 + par3 + par4)/ @w_trm)  * (1 - @w_maxfact)) ,
       va_val_arch_ori = (((par1 + par2 + par3 + par4)/ @w_trm)  * (1 - @w_maxfact))
   where substring(va_valor_cat,1,1) = 'B'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

   update #tmp_valdiv40
   set va_val_arch     = (par1 + par2 + par3 + par4 + par5 + par6) / @w_trm,
       va_val_arch_ori = (par1 + par2 + par3 + par4 + par5 + par6) / @w_trm
   from #tmp_valdiv40
   where  substring(va_valor_cat,1,1)  = 'C'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

   update #tmp_valdiv40
   set va_val_arch     = (par1 + par2 + par3 + par4 + par5 + par6) / @w_trm,
       va_val_arch_ori = (par1 + par2 + par3 + par4 + par5 + par6) / @w_trm
   from #tmp_valdiv40
   where  substring(va_valor_cat,1,1)  = 'D'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

   update #tmp_valdiv40
   set va_val_arch     = 1 - ((par1 / @w_trm)  / (isnull(@w_valvens,1) / @w_trm)) ,
       va_val_arch_ori = 1 - ((par1 / @w_trm)  / (isnull(@w_valvens,1) / @w_trm))
   where substring(va_valor_cat,1,1) = 'E'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

   update #tmp_valdiv40
   set va_val_arch     = 1 - ((par1 / @w_trm) / case when ((@w_valvenm / @w_trm) + (@w_val1302 / @w_trm)) = 0 then 1 else ((@w_valvenm / @w_trm) + (@w_val1302 / @w_trm)) end )  ,
       va_val_arch_ori = 1 - ((par1 / @w_trm) / case when ((@w_valvenm / @w_trm) + (@w_val1302 / @w_trm)) = 0 then 1 else ((@w_valvenm / @w_trm) + (@w_val1302 / @w_trm)) end )  
   where substring(va_valor_cat,1,1) = 'F'

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR AL ACTUALIZAR SALDO REC EN TABLA TEMPORAL'
      goto ERRORFIN
   end

----------------------------------------------------------------------------------------------
--------------------------------SE ASIGNAN VALORES HAIRCUT OAL--------------------------------
----------------------------------------------------------------------------------------------

   insert into #tmp_valdiv40
   (va_num , va_num_val                , va_valor_cat              , va_valor_arch , va_val_arch , va_val_arch_ori , par1 , par2 , par3 , par4 , par5 , par6 )
   select
   '1'     , 'INFORMACION 531 HAIRCUT' , '_5313601' + eq_valor_cat , hm_haircut    , hm_haircut  , hm_haircut      , 0    , 0    , 0    , 0    , 0    , 0
   from  cob_conta_super..sb_dato_haircut_mon a, cobis..cl_moneda b, #tmp_paramon c
   where a.hm_tipo_moneda = b.mo_nemonico
   and   b.mo_moneda      = c.eq_valor_arch

   if @@error <> 0
   begin
      select
      @w_error   = 9999999,
      @w_mensaje = 'ERROR INSERTANDO EN LA TABLA DE CRUCE'
      goto ERRORFIN
   end

----------------------------------------------------------------------------------------------
-----------------------------------CARGUE A LA HIST_SALDO-------------------------------------
----------------------------------------------------------------------------------------------

   select @w_colmin   = min(co_num_columna)-1
   from   cob_conta_super..sb_columnas
   where  co_proceso  = @w_proceso
   and    co_tipo_col = '03'

   begin tran

   declare cursor_ori458    cursor for
   select substring(va_valor_cat,5,2) + @w_colmin, substring(va_valor_cat,7,2), substring(va_valor_cat,9,3), va_val_arch
   from #tmp_valdiv40
   order by va_valor_cat
   for read only

   open  cursor_ori458
   fetch cursor_ori458
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

      select @w_curval=isnull(@w_curval,0)

      if ( @w_periodicidad='E' and (@w_curcol < 28 or @w_curcol in (38 , 39, 41 )))
      begin

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
           select @w_error   = 360040,
           @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO'
           rollback tran
           goto ERRORFIN
         end
      end

      if ( @w_periodicidad='M' and (@w_curcol < 18 or @w_curcol between 28 and 38 or @w_curcol in (40 , 42)))
      begin

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
           select @w_error   = 360040,
           @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO'
           rollback tran
           goto ERRORFIN
         end
      end

      fetch cursor_ori458
      into  @w_curcol, @w_curuc, @w_cursct, @w_curval
   end
   close cursor_ori458
   deallocate cursor_ori458

   commit tran

   return  0

   ERRORFIN:
   begin
      print '[' + @w_sp_name + '] Fecha = ' + convert(varchar,@w_fecha_ingreso,103) + ', Error = ' + @w_mensaje
      select @w_mensaje

      exec sp_errorlog
           @i_operacion    = 'I',
           @i_fecha_fin    = @w_fecha_ingreso,
           @i_fuente       = @w_sp_name,
           @i_origen_error = @w_error,
           @i_descrp_error = @w_mensaje
      return @w_error
   end
go
