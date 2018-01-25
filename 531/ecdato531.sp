/************************************************************************/
/*  Archivo:                         ecdato531.sp                       */
/*  Stored procedure:                sp_datos_531                       */
/*  Base de datos:                   cob_conta_super                    */
/*  Producto:                        REC                                */
/*  Fecha de escritura:              01.11.17                           */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP",                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Consolidar información cargarda por plantillas a cob_conta_super    */
/*  TO = TODOS                                                          */
/*  IF = INVENTARIO FORWARDS                                            */
/*  HM = HAIRCUTS MONEDAS                                               */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  01.11.17              Ana Viera             Emision inicial         */
/************************************************************************/
use cob_conta_super
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_datos_531')
   drop proc sp_datos_531
go

create proc sp_datos_531(
   @i_param1                    smalldatetime,
   @i_param2                    varchar(2))
as
declare
   @i_toperacion                varchar(2),
   @i_descrp_error              varchar(255),
   @i_fecha_proceso             smalldatetime,
   @w_error                     int,
   @w_msg                       varchar(255),
   @w_sp_name                   varchar(30),
   @w_retorno                   int,
   @w_ente_version              int = 0,
   @w_fuente                    descripcion,
   @w_aplicativo                tinyint,
   @w_ult_finmes                datetime,
   @w_mes                       tinyint,
   @w_anios                     int,
   @w_nit_cliente               varchar(16),
   @w_fecha_ejecucion           datetime,
   @w_total_reg_ex              int,
   @w_total_reg_sb              int,
   @w_existe                    char(1),
   @w_secuencial                int,
   @w_concepto                  varchar(10),
   @w_tabla                     varchar(10),
   @w_existencia                char(1),
   @w_origen                    char(1)


select
@i_fecha_proceso  = @i_param1,
@i_toperacion     = @i_param2,
@w_retorno        = 0,
@w_sp_name        = 'sp_datos_531',
@w_error          = 1,
@w_msg            = 'FIN DEL PROCESO'


delete sb_errorlog
where er_fuente = @w_sp_name

select @w_fecha_ejecucion=getdate()

   /* DATOS DE LAS OPERACIONES */
if @i_toperacion in ('TO','IF')
begin
      if exists (select 1 from sb_dato_inventariofrwd where di_fecha_proc=@i_fecha_proceso  )
      begin
         delete cob_conta_super..sb_dato_inventariofrwd
         where  di_fecha_proc =@i_fecha_proceso
      end

      /***INSERTA DATOS EN SB_DATO_INVENTARIOFRWD***/
      insert into cob_conta_super..sb_dato_inventariofrwd(
      di_tipo,              di_modalidad,           di_portafolio,
      di_referencia,        di_cliente,             di_identificacion,
      di_fecha_inv,         di_fecha_apertura,      di_fecha_pago,
      di_fecha_venc,        di_plazo,               di_dias_al_venc,
      di_mon_nominal,       di_mon_conv,            di_monto,
      di_valor_moneda,      di_cot_spot,            di_cot_fwd,
      di_devaluacion,       di_tasa_me,             di_tasa_mp,
      di_derecho_ayer,      di_obligacion_ayer,     di_derecho_hoy,
      di_obligacion_hoy,    di_pyg,                 di_tasa_estimada,
      di_tasa_val_usd,      di_tasa_val_divisa,     di_pyg_dia,
      di_formula_derecho,   di_formula_obligacion,  di_aplicativo,
      di_fecha_proc,        di_origen)
      select
      di_tipo,              di_modalidad,           di_portafolio,
      di_referencia,        di_cliente,             di_identificacion,
      di_fecha_inv,         di_fecha_apertura,      di_fecha_pago,
      di_fecha_venc,        di_plazo,               di_dias_al_venc,
      di_mon_nominal,       di_mon_conv,            di_monto,
      di_valor_moneda,      di_cot_spot,            di_cot_fwd,
      di_devaluacion,       di_tasa_me,             di_tasa_mp,
      di_derecho_ayer,      di_obligacion_ayer,     di_derecho_hoy,
      di_obligacion_hoy,    di_pyg,                 di_tasa_estimada,
      di_tasa_val_usd,      di_tasa_val_divisa,     di_pyg_dia,
      di_formula_derecho,   di_formula_obligacion,  di_aplicativo,
      di_fecha_proc,        di_origen
      from cob_externos..ex_dato_inventariofrwd
      where di_fecha_proc    = @i_fecha_proceso

      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @i_fecha_proceso,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28006',
         @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_INVENTARIOFRWD'
      end
end

if @i_toperacion in ('TO','HM')
begin
    if exists (select 1 from sb_dato_haircut_mon where hm_fecha_proc = @i_fecha_proceso )
     begin
         delete cob_conta_super..sb_dato_haircut_mon
         where  hm_fecha_proc  =@i_fecha_proceso
      end

      /***INSERTA DATOS EN SB_DATO_HAIRCUT_MON***/
      insert into cob_conta_super..sb_dato_haircut_mon(
      hm_tipo_moneda,   hm_haircut,   hm_aplicativo,
      hm_fecha_proc,    hm_origen)
      select
      hm_tipo_moneda,   hm_haircut,   hm_aplicativo,
      hm_fecha_proc,    hm_origen
      from cob_externos..ex_dato_haircut_mon
      where hm_fecha_proc      = @i_fecha_proceso

     if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @i_fecha_proceso,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28006',
         @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_HAIRCUT_MON'
      end
end

---------------------------------------

if @i_toperacion in ('TO','IF')
begin
   delete
   from   sb_control_consolidacion
   where  cc_fecha_proceso = @i_fecha_proceso
   and    cc_tipo_proceso  = @i_toperacion
   and    cc_estructura in ('dato_inventariofrwd')

   if @@error <> 0
   begin
      select
      @w_error = 150004,
      @w_msg   = 'ERROR EN ELMINACION DE TABLA DE CONTROL CONSOLIDACION'
      goto ERROR
   end

   select @w_total_reg_ex=count(1)
   from   cob_externos..ex_dato_inventariofrwd
   where  di_fecha_proc   = @i_fecha_proceso

   select @w_total_reg_sb = count(1)
   from   cob_conta_super..sb_dato_inventariofrwd
   where  di_fecha_proc   = @i_fecha_proceso

   insert into sb_control_consolidacion  (
   cc_tipo_proceso       , cc_fecha_proceso  , cc_fecha_ejecucion,
   cc_estructura         , cc_total_ex       , cc_total_sb )
   values(
   @i_toperacion         , @i_fecha_proceso  , @w_fecha_ejecucion,
   'dato_inventariofrwd' , @w_total_reg_ex   , @w_total_reg_sb)
end

   if @@error <> 0
   begin
      select
      @w_error = 150004,
      @w_msg   = 'ERROR EN ELMINACION DE TABLA DE CONTROL CONSOLIDACION'
      goto ERROR
   end

if @i_toperacion in ('TO','HM')
begin
   delete
   from   sb_control_consolidacion
   where  cc_fecha_proceso = @i_fecha_proceso
   and    cc_tipo_proceso  = @i_toperacion
   and    cc_estructura in ('dato_haircut_mon')

   if @@error <> 0
   begin
      select
      @w_error = 150004,
      @w_msg   = 'ERROR EN ELMINACION DE TABLA DE CONTROL CONSOLIDACION'
      goto ERROR
   end

   select @w_total_reg_ex=count(1)
   from   cob_externos..ex_dato_haircut_mon
   where  hm_fecha_proc   = @i_fecha_proceso

   select @w_total_reg_sb = count(1)
   from   cob_conta_super..sb_dato_haircut_mon
   where  hm_fecha_proc   = @i_fecha_proceso

   insert into sb_control_consolidacion  (
   cc_tipo_proceso    , cc_fecha_proceso  , cc_fecha_ejecucion,
   cc_estructura      , cc_total_ex       , cc_total_sb )
   values(
   @i_toperacion      , @i_fecha_proceso  , @w_fecha_ejecucion,
   'dato_haircut_mon' , @w_total_reg_ex   , @w_total_reg_sb)
end



return 0

ERROR:
print '[' + @w_sp_name + '] Error = ' + isnull(convert(varchar(150),@w_msg), 'NULO')

exec cob_conta_super..sp_errorlog
     @i_operacion     = 'I',
     @i_fecha_fin     = @i_fecha_proceso,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg

return @w_error

go
