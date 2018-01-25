/************************************************************************/
/*  Archivo:                         ecfor_531.sp                       */
/*  Stored procedure:                sp_formato_531                     */
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

if exists (select 1 from sysobjects where name = 'sp_formato_531')
drop proc sp_formato_531
go

create proc sp_formato_531(
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
   @w_mensaje                   varchar(200),
   @w_return                    int,
   @i_empresa                   tinyint,
   @w_fecha_ingreso             datetime,
   @w_opcion                    char(1),
   @w_fto_ingreso               int,
   @w_gen_plano_par             char(1),
   @w_periodicidad              char(1)

select
@w_empresa       = @i_param1,
@w_fecha_ingreso = @i_param2,
@w_opcion        = @i_param3,
@w_fto_ingreso   = @i_param4,
@w_gen_plano_par = @i_param5,
@w_periodicidad  = @i_param6,
@w_sp_name       = 'sp_formato_531'


if (select pa_char from cobis..cl_parametro where pa_nemonico = 'FEC531') = 'S'
begin
   if not exists (select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'CALSEM531' and eq_valor_cat = convert(varchar(10),@w_fecha_ingreso,103))
   begin
        select @w_error   = 999999,
        @w_mensaje        = 'LA FECHA DE EJECUCION NO ES CORRECTA'
        goto ERRORFIN
   end
end


 while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_ingreso)
 begin
      select @w_fecha_ingreso = dateadd(dd,-1,@w_fecha_ingreso)
      print @w_fecha_ingreso
 end

----------------------------------------------------
------------PROCESO DE CUENTAS CONTABLES------------
----------------------------------------------------
print 'PROCESO DE CUENTAS CONTABLES'

exec sp_formato_CC_531
   @i_param1 = @w_empresa       ,
   @i_param2 = @w_fecha_ingreso ,
   @i_param3 = @w_opcion        ,
   @i_param4 = @w_fto_ingreso   ,
   @i_param5 = @w_gen_plano_par ,
   @i_param6 = @w_periodicidad

if @@error<>0
begin
  select @w_error   =  999999,
  @w_mensaje        = 'ERROR EJECUTANDO EL PROCESO DE CUENTAS CONTABLES'
  goto ERRORFIN
end

----------------------------------------------------
-----------PROCESO DE EXTRACCION DEL 458------------
----------------------------------------------------
print 'PROCESO DE EXTRACCION DEL 458'

exec sp_formato_cruce_458_531
   @i_param1 = @w_empresa       ,
   @i_param2 = @w_fecha_ingreso ,
   @i_param3 = @w_opcion        ,
   @i_param4 = @w_fto_ingreso   ,
   @i_param5 = @w_gen_plano_par ,
   @i_param6 = @w_periodicidad

if @@error<>0
begin
  select @w_error   = 999999,
  @w_mensaje        = 'ERROR EJECUTANDO EL PROCESO DE EXTRACCION DEL 458'
  goto ERRORFIN
end
----------------------------------------------------
----------PROCESO CALCULO DEL REPORTE 531-----------
----------------------------------------------------
print 'PROCESO CALCULO DEL REPORTE 531'

exec sp_formato_operaciones_531
   @i_param1 = @w_empresa       ,
   @i_param2 = @w_fecha_ingreso ,
   @i_param3 = @w_opcion        ,
   @i_param4 = @w_fto_ingreso   ,
   @i_param5 = @w_gen_plano_par ,
   @i_param6 = @w_periodicidad

if @@error<>0
begin
  select @w_error   = 999999,
  @w_mensaje  = 'ERROR EJECUTANDO EL PROCESO CALCULO DEL REPORTE 531'
  goto ERRORFIN
end

----------------------------------------------------
-------------PROCESO DE CELDAS EN CERO--------------
----------------------------------------------------
print 'PROCESO DE CELDAS EN CERO'

exec sp_formato_celdas_531
   @i_param1 = @w_empresa       ,
   @i_param2 = @w_fecha_ingreso ,
   @i_param3 = @w_opcion        ,
   @i_param4 = @w_fto_ingreso   ,
   @i_param5 = @w_gen_plano_par ,
   @i_param6 = @w_periodicidad

if @@error<>0
begin
  select @w_error   = 999999,
  @w_mensaje        = 'ERROR EJECUTANDO EL PROCESO DE CELDAS EN CERO'
  goto ERRORFIN
end

return 0

ERRORFIN:

select @w_msg = @w_sp_name + ' ' + @w_msg

Exec cob_conta_super..sp_errorlog
  @i_operacion     = 'I',
   @i_fecha_fin     = @w_fecha_ingreso,
   @i_origen_error  = @w_error,
   @i_fuente        = @w_sp_name,
   @i_descrp_error  = @w_mensaje
return @w_error

go
