/**********************************************************************/
/*  Archivo:                         ec_histor_form531.sql            */
/*  Base de datos:                   cob_conta_super                  */
/*  Producto:                        REC                              */
/*  Fecha de escritura:              30.10.17                         */
/**********************************************************************/
/*                          IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  "COBISCORP", su uso no autorizado queda expresamente prohibido asi*/
/*  como cualquier alteracion o agregado hecho por alguno de sus      */
/*  usuarios sin el debido consentimiento por escrito de la           */
/*  presidencia Ejecutiva de COBISCORP o su representante.            */
/**********************************************************************/
/*                          PROPOSITO                                 */
/*  parametrizacion historico del formato 531                         */
/**********************************************************************/
/*                          MODIFICACIONES                            */
/*  FECHA         AUTOR                RAZON                          */
/*  30.11.17      Rodrigo Prada         Emision Inicial               */
/**********************************************************************/
use cob_conta_super
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

USE [cob_conta_super]
GO

declare
@w_mensaje                   varchar(150)

if exists (select 1 from  cob_conta_super..sb_parametro_hist
           where  pa_nemonico = 'ICAVEM'
           and pa_fecha between '01/01/2011' and  '10/01/2017')
begin
   delete from  cob_conta_super..sb_parametro_hist
   where  pa_nemonico = 'ICAVEM'
   and pa_fecha between '01/01/2011' and  '10/01/2017'
end

INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.9, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.7, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.7, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.9, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'M')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.9, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.7, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.7, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.9, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'E')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2011-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.7, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.9, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.7, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2012-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.7, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2013-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2014-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2015-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.6, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 4.9, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 5.9, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-10-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-11-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.2, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2016-12-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 6.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-02-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 7.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-03-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-04-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.8, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-06-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.4, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.1, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end
INSERT cob_conta_super..sb_parametro_hist ([pa_fecha], [pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto], [pa_frecuencia]) VALUES (CAST(N'2017-09-01T00:00:00.000' AS DateTime), N'INDICE CARTERA VENCIDA MENSUAL', N'ICAVEM', N'P', NULL, NULL, NULL, NULL, NULL, NULL, 8.3, N'SUP', N'D')
if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end

FIN:

go
