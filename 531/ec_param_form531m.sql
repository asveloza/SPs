/**********************************************************************/
/*  Archivo:                         ec_param_form531m.sql            */
/*  Base de datos:                   cob_conta_super                  */
/*  Producto:                        REC                              */
/*  Fecha de escritura:              16.10.17                         */
/**********************************************************************/
/*                          IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  "COBISCORP", su uso no autorizado queda expresamente prohibido asi*/
/*  como cualquier alteracion o agregado hecho por alguno de sus      */
/*  usuarios sin el debido consentimiento por escrito de la           */
/*  presidencia Ejecutiva de COBISCORP o su representante.            */
/**********************************************************************/
/*                          PROPOSITO                                 */
/*  parametrizacion de filas,columnas del formato 531                 */
/*  periodicidad mensual                                              */
/**********************************************************************/
/*                          MODIFICACIONES                            */
/*  FECHA         AUTOR                RAZON                          */
/*  16.10.17      Ana Viera         Emision Inicial                   */
/**********************************************************************/
use cob_conta_super
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go


declare @w_tabla  smallint,
        @w_proceso    int,                    
        @w_max_fila   int,                  
        @w_col        int,                  
        @w_fil        int,                     
        @w_max_col    int,
        @w_error      int,
        @w_tipo_inf   char(2),
        @w_mensaje    varchar(250)

select @w_proceso =  28520, -- numero de proceso mensual
       @w_tabla = 0,
       @w_max_fila = 0,
       @w_col = 0,
       @w_fil = 0,
       @w_max_col = 0,
       @w_error = 0,
       @w_tipo_inf = '81',
       @w_mensaje = ''


----------------------------------------------------
print 'Agregando tipo de informe 81 "INDICADORES DE EXPOSICION DE CORTO PLAZO INDIVIDUAL A TREINTA DIAS" al catalogo'

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'ec_tipo_inf'

if @@rowcount = 0 
   print 'TABLA DE CATALOGO - ec_tipo_inf NO EXISTE'                   
else 
begin
   if exists(select * from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_tipo_inf)
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_tipo_inf
   
   if @@error <>0 
   begin
      select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
      goto FIN
   end
   
   insert into cobis..cl_catalogo values (@w_tabla,@w_tipo_inf,'INDICADORES DE EXPOSICION DE CORTO PLAZO INDIVIDUAL A TREINTA DIAS','V',NULL,NULL,NULL)
   
   if @@error <>0 
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   
end

print 'Parametrizacion Formato 531 tipo informe 81'

----------------------------------------------------
print 'INSERTANDO sb_configurar_reportes'

select * from cob_conta_super..sb_configurar_reportes where cr_proceso = @w_proceso

if @@rowcount = 0
   print 'NO EXISTE REPORTE ASOCIADO AL PROCESO'
   
delete from cob_conta_super..sb_configurar_reportes where cr_proceso = @w_proceso

if @@error <>0 
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end
   
insert into cob_conta_super..sb_configurar_reportes 
 (
   cr_proceso         , cr_formato    , cr_total_columnas ,
   cr_entidad_control , cr_tipo_cifra , cr_nombre_sqr     ,
   cr_tipo_plano      , cr_aplica     , cr_nom_reporte    ,
   cr_periodicidad    , cr_area_inf   , cr_tipo_inf       ,
   cr_sufijo          , cr_estado     , cr_cero            
  )
values 
    (  
   @w_proceso         , 531           , 41,
   '01'               , '02'          , 'ecfor531m',
   '01'               , 'S'           , 'INDICADORES DE EXPOSICION DE CORTO PLAZO - FORMATO 531 MENSUAL',
   'M'                , '01'          , '81',     
   2                  , 'V'           , 'N'
  )

   if @@error <>0 
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end

select * from cob_conta_super..sb_configurar_reportes where cr_proceso = @w_proceso
--------------------------------------------------------------

------------------------------------------------------------------

print 'INSERTANDO COLUMNAS'

select * from cob_conta_super..sb_columnas where co_proceso = @w_proceso

if @@rowcount = 0
   print 'NO EXISTEN COLUMNAS ASOCIADAS AL PROCESO'
   
delete from cob_conta_super..sb_columnas where co_proceso = @w_proceso

if @@error <>0 
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end
   
insert into cob_conta_super..sb_columnas values (1,'SUBCTA',@w_proceso,'02',3,'N','01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (2,'NOMBRE',@w_proceso,'01',50,'N','02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (3,'CODIGO_DE_MONEDA',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (4,'CODIGO_DE_PAIS',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (5,'SIGNIF_MONEDA_NIVEL_IND',@w_proceso,'03',20,'N','04') if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (6,'SIGNIF_MONEDA_CONSOLIDADO',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (7,'DISPONIBLE',@w_proceso,'03',20,'N','04') if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (8,'PARTICIPACION_FONDOS_INV_COLEC',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (9,'TITULOS_ALAC',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (10,'HAIRCUT_PROM_TITULOS_ALAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (11,'TOTAL_ALAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (12,'DEUDA_PRIV_OTROS_ACT_LIQUIDOS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (13,'HAIRCUT_PROM_TITULOS_DEUDA_PRIV',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (14,'OTRAS_INV_OTROS_ACTIVOS_LIQ',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (15,'HAIRCUT_PROM_OTRAS_INV',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (16,'TOTAL_OAL',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (17,'ACTIVOS_LIQ_AJUSTADOS',@w_proceso,'03',20,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (18,'FLUJO_ING_VENC_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (19,'FLUJO_ING_OPER_DERIVADOS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (20,'FLUJO_EGRESOS_VENC_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (21,'FLUJO_EGRESOS_OPER_CON_DERIVADOS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (22,'FLUJOS_EGRESOS_NO_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (23,'REQ_NETOS_LIQ_CTA_PROPIA',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (24,'POS_OPER_CRUZADAS_CTA_DE_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (25,'POS_OPER_CTA_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (26,'REQ_LIQ_CTA_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (27,'TOTAL_REQ_LIQUIDEZ',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (28,'FLUJO_ING_VENC_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (29,'FLUJO_ING_OPER_CON_DERIVADOS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (30,'FLUJO_EGRESOS_VENC_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (31,'FLUJO_EGRESOS_OPER_CON_DERIVADOS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (32,'FLUJO_EGRESOS_NO_CONTRAC',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (33,'REQ_NETOS_LIQ_CTA_PROPIA',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (34,'POS_OPER_CRUZADAS_CTA_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (35,'POS_OPER_CONVENIDAS_CTA_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (36,'REQ_LIQUIDEZ_CTA_TERCEROS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (37,'TOTAL_REQ_LIQUIDEZ',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (38,'HAURCUT_EXCESOS_MONEDA',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (39,'DIFERENCIA_1_7_DIAS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (40,'DIFERENCIA_1_30_DIAS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (41,'INDICADOR_1_7_DIAS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (42,'INDICADOR_1_30_DIAS',@w_proceso,'03',40,'N','04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_columnas values (43,'UC',@w_proceso,'04',2,'N','03')
if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

select * from cob_conta_super..sb_columnas where co_proceso = @w_proceso
---------------------------------------------------------------
print 'INSERTANDO FILAS'

select * from cob_conta_super..sb_filas where fi_proceso = @w_proceso

if @@rowcount = 0
   print 'NO EXISTEN FILAS ASOCIADAS AL PROCESO'
   
   
   -- UC 1
delete from cob_conta_super..sb_filas where fi_proceso = @w_proceso

if @@error <>0 
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end
   
insert into cob_conta_super..sb_filas values(1,@w_proceso,1,'000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(2,@w_proceso,1,'001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(3,@w_proceso,1,'002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(4,@w_proceso,1,'003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(5,@w_proceso,1,'004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(6,@w_proceso,1,'005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(7,@w_proceso,1,'006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(8,@w_proceso,1,'007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(9,@w_proceso,1,'008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(10,@w_proceso,1,'009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(11,@w_proceso,1,'010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(12,@w_proceso,1,'011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(13,@w_proceso,1,'012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(14,@w_proceso,1,'013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(15,@w_proceso,1,'014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(16,@w_proceso,1,'015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(17,@w_proceso,1,'016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(18,@w_proceso,1,'017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(19,@w_proceso,1,'018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(20,@w_proceso,1,'019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(21,@w_proceso,1,'020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(22,@w_proceso,1,'021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(23,@w_proceso,1,'022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(24,@w_proceso,1,'023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(25,@w_proceso,1,'024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(26,@w_proceso,1,'025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(27,@w_proceso,1,'026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(28,@w_proceso,1,'999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

 
 --UC2insert into cob_conta_super..sb_filas values(29,  @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(30, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(31, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(32, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(33, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(34, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(35, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(36, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(37, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(38, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(39, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(40, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(41, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(42, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(43, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(44, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(45, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(46, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(47, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(48, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(49, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(50, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(51, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(52, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(53, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(54, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(55, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(56, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

 
--UC3insert into cob_conta_super..sb_filas values(57, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(58, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(59, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(60, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(61, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(62, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(63, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(64, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(65, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(66, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(67, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(68, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(69, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(70, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(71, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(72, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(73, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(74, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(75, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(76, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(77, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(78, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(79, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(80, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(81, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(82, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(83, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(84, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC4
insert into cob_conta_super..sb_filas values(85,  @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(86,  @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(87,  @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(88,  @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(89,  @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(90,  @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(91,  @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(92,  @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(93,  @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(94,  @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(95,  @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(96,  @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(97,  @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(98,  @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(99,  @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(100, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(101, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(102, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(103, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(104, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(105, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(106, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(107, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(108, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(109, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(110, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(111, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(112, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(113, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC5
insert into cob_conta_super..sb_filas values(114, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(115, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(116, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(117, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(118, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(119, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(120, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(121, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(122, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(123, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(124, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(125, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(126, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(127, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(128, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(129, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(130, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(131, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(132, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(133, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(134, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(135, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(136, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(137, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(138, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(139, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(140, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(141, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(142, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC6
insert into cob_conta_super..sb_filas values(143, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(144, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(145, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(146, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(147, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(148, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(149, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(150, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(151, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(152, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(153, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(154, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(155, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(156, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(157, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(158, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(159, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(160, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(161, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(162, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(163, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(164, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(165, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(166, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(167, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(168, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(169, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(170, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(171, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC7
insert into cob_conta_super..sb_filas values(172, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(173, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(174, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(175, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(176, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(177, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(178, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(179, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(180, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(181, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(182, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(183, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(184, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(185, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(186, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(187, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(188, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(189, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(190, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(191, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(192, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(193, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(194, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(195, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(196, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(197, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(198, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(199, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(200, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC8
insert into cob_conta_super..sb_filas values(201, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(202, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(203, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(204, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(205, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(206, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(207, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(208, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(209, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(210, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(211, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(212, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(213, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(214, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(215, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(216, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(217, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(218, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(219, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(220, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(221, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(222, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(223, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(224, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(225, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(226, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(227, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(228, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(229, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC9
insert into cob_conta_super..sb_filas values(230, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(231, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(232, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(233, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(234, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(235, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(236, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(237, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(238, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(239, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(240, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(241, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(242, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(243, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(244, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(245, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(246, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(247, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(248, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(249, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(250, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(251, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(252, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(253, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(254, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(255, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(256, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(257, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(258, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC10
insert into cob_conta_super..sb_filas values(259, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(260, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(261, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(262, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(263, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(264, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(265, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(266, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(267, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(268, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(269, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(270, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(271, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(272, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(273, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(274, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(275, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(276, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(277, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(278, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(279, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(280, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(281, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(282, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(283, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(284, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(285, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(286, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(287, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC11
insert into cob_conta_super..sb_filas values(288, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(289, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(290, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(291, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(292, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(293, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(294, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(295, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(296, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(297, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(298, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(299, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(300, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(301, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(302, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(303, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(304, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(305, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(306, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(307, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(308, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(309, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(310, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(311, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(312, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(313, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(314, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(315, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(316, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC12
insert into cob_conta_super..sb_filas values(317, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(318, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(319, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(320, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(321, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(322, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(323, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(324, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(325, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(326, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(327, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(328, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(329, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(330, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(331, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(332, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(333, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(334, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(335, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(336, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(337, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(338, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(339, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(340, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(341, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(342, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(343, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(344, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(345, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC13
insert into cob_conta_super..sb_filas values(346, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(347, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(348, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(349, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(350, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(351, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(352, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(353, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(354, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(355, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(356, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(357, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(358, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(359, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(360, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(361, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(362, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(363, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(364, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(365, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(366, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(367, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(368, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(369, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(370, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(371, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(372, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(373, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(374, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC14
insert into cob_conta_super..sb_filas values(375, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(376, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(377, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(378, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(379, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(380, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(381, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(382, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(383, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(384, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(385, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(386, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(387, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(388, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(389, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(390, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(391, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(392, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(393, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(394, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(395, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(396, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(397, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(398, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(399, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(400, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(401, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(402, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(403, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC15
insert into cob_conta_super..sb_filas values(404, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(405, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(406, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(407, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(408, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(409, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(410, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(411, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(412, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(413, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(414, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(415, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(416, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(417, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(418, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(419, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(420, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(421, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(422, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(423, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(424, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(425, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(426, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(427, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(428, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(429, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(430, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(431, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(432, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC16
insert into cob_conta_super..sb_filas values(433, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(434, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(435, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(436, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(437, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(438, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(439, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(440, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(441, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(442, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(443, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(444, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(445, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(446, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(447, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(448, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(449, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(450, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(451, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(452, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(453, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(454, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(455, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(456, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(457, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(458, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(459, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(460, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(461, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC17
insert into cob_conta_super..sb_filas values(462, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(463, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(464, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(465, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(466, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(467, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(468, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(469, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(470, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(471, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(472, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(473, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(474, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(475, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(476, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(477, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(478, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(479, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(480, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(481, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(482, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(483, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(484, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(485, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(486, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(487, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(488, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(489, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(490, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC18
insert into cob_conta_super..sb_filas values(491, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(492, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(493, @w_proceso, 1, '002')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(494, @w_proceso, 1, '003')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(495, @w_proceso, 1, '004')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(496, @w_proceso, 1, '005')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(497, @w_proceso, 1, '006')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(498, @w_proceso, 1, '007')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(499, @w_proceso, 1, '008')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(500, @w_proceso, 1, '009')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(501, @w_proceso, 1, '010')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(502, @w_proceso, 1, '011')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(503, @w_proceso, 1, '012')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(504, @w_proceso, 1, '013')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(505, @w_proceso, 1, '014')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(506, @w_proceso, 1, '015')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(507, @w_proceso, 1, '016')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(508, @w_proceso, 1, '017')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(509, @w_proceso, 1, '018')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(510, @w_proceso, 1, '019')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(511, @w_proceso, 1, '020')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(512, @w_proceso, 1, '021')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(513, @w_proceso, 1, '022')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(514, @w_proceso, 1, '023')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(515, @w_proceso, 1, '024')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(516, @w_proceso, 1, '025')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(517, @w_proceso, 1, '026')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(518, @w_proceso, 1, '998')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(519, @w_proceso, 1, '999')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC19
insert into cob_conta_super..sb_filas values(520, @w_proceso, 1, '000')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(521, @w_proceso, 1, '001')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

/****DESCRIPCIONES*****/if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC1
insert into cob_conta_super..sb_filas values(1,@w_proceso,2,'INDICADOR INDIVIDUAL POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(2,@w_proceso,2,'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(3,@w_proceso,2,'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(4,@w_proceso,2,'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(5,@w_proceso,2,'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(6,@w_proceso,2,'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(7,@w_proceso,2,'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(8,@w_proceso,2,'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(9,@w_proceso,2,'GURANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(10,@w_proceso,2,'CORDOBA NICARAGUENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(11,@w_proceso,2,'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(12,@w_proceso,2,'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(13,@w_proceso,2,'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(14,@w_proceso,2,'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(15,@w_proceso,2,'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(16,@w_proceso,2,'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(17,@w_proceso,2,'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(18,@w_proceso,2,'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(19,@w_proceso,2,'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(20,@w_proceso,2,'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(21,@w_proceso,2,'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(22,@w_proceso,2,'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(23,@w_proceso,2,'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(24,@w_proceso,2,'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(25,@w_proceso,2,'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(26,@w_proceso,2,'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(27,@w_proceso,2,'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(28,@w_proceso,2,'IEI INDIVIDUAL')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC2
insert into cob_conta_super..sb_filas values(29, @w_proceso, 2, 'INDICADOR INDIVIDUAL PARA EL CÁLCULO DEL CONSOLIDADO, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(30, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(31, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(32, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(33, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(34, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(35, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(36, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(37, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(38, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(39, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(40, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(41, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(42, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(43, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(44, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(45, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(46, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(47, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(48, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(49, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(50, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(51, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(52, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(53, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(54, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(55, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(56, @w_proceso, 2, 'IEI INDIVIDUAL PARA EL CALCULO DEL CONSOLIDADO')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC3
insert into cob_conta_super..sb_filas values(57, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN COLOMBIA, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(58, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(59, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(60, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(61, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(62, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(63, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(64, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(65, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(66, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(67, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(68, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(69, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(70, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(71, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(72, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(73, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(74, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(75, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(76, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(77, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(78, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(79, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(80, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(81, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(82, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(83, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(84, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES EN COLOMBIA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC4
insert into cob_conta_super..sb_filas values(85,  @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 1, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(86,  @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(87,  @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(88,  @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(89,  @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(90,  @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(91,  @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(92,  @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(93,  @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(94,  @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(95,  @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(96,  @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(97,  @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(98,  @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(99,  @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(100, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(101, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(102, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(103, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(104, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(105, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(106, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(107, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(108, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(109, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(110, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(111, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(112, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(113, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC5
insert into cob_conta_super..sb_filas values(114, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 2, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(115, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(116, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(117, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(118, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(119, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(120, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(121, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(122, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(123, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(124, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(125, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(126, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(127, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(128, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(129, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(130, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(131, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(132, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(133, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(134, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(135, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(136, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(137, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(138, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(139, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(140, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(141, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(142, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC6
insert into cob_conta_super..sb_filas values(143, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 3, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(144, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(145, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(146, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(147, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(148, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(149, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(150, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(151, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(152, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(153, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(154, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(155, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(156, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(157, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(158, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(159, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(160, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(161, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(162, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(163, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(164, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(165, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(166, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(167, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(168, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(169, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(170, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(171, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 3')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC7
insert into cob_conta_super..sb_filas values(172, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 4, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(173, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(174, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(175, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(176, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(177, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(178, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(179, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(180, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(181, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(182, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(183, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(184, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(185, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(186, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(187, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(188, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(189, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(190, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(191, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(192, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(193, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(194, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(195, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(196, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(197, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(198, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(199, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(200, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 4')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC8
insert into cob_conta_super..sb_filas values(201, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 5, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(202, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(203, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(204, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(205, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(206, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(207, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(208, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(209, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(210, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(211, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(212, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(213, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(214, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(215, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(216, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(217, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(218, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(219, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(220, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(221, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(222, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(223, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(224, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(225, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(226, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(227, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(228, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(229, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 5')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC9
insert into cob_conta_super..sb_filas values(230, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 6, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(231, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(232, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(233, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(234, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(235, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(236, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(237, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(238, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(239, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(240, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(241, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(242, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(243, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(244, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(245, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(246, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(247, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(248, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(249, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(250, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(251, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(252, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(253, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(254, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(255, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(256, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(257, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(258, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 6')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC10
insert into cob_conta_super..sb_filas values(259, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 7, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(260, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(261, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(262, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(263, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(264, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(265, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(266, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(267, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(268, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(269, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(270, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(271, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(272, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(273, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(274, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(275, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(276, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(277, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(278, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(279, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(280, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(281, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(282, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(283, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(284, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(285, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(286, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(287, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 7')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC11
insert into cob_conta_super..sb_filas values(288, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 8, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(289, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(290, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(291, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(292, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(293, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(294, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(295, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(296, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(297, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(298, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(299, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(300, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(301, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(302, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(303, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(304, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(305, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(306, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(307, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(308, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(309, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(310, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(311, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(312, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(313, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(314, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(315, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(316, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 8')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC12
insert into cob_conta_super..sb_filas values(317, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 9, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(318, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(319, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(320, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(321, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(322, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(323, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(324, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(325, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(326, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(327, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(328, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(329, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(330, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(331, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(332, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(333, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(334, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(335, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(336, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(337, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(338, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(339, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(340, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(341, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(342, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(343, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(344, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(345, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 9')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC13
insert into cob_conta_super..sb_filas values(346, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 10, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(347, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(348, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(349, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(350, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(351, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(352, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(353, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(354, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(355, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(356, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(357, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(358, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(359, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(360, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(361, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(362, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(363, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(364, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(365, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(366, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(367, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(368, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(369, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(370, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(371, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(372, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(373, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(374, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC14
insert into cob_conta_super..sb_filas values(375, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 11, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(376, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(377, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(378, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(379, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(380, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(381, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(382, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(383, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(384, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(385, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(386, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(387, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(388, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(389, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(390, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(391, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(392, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(393, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(394, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(395, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(396, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(397, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(398, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(399, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(400, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(401, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(402, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(403, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC15
insert into cob_conta_super..sb_filas values(404, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 12, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(405, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(406, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(407, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(408, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(409, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(410, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(411, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(412, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(413, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(414, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(415, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(416, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(417, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(418, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(419, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(420, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(421, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(422, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(423, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(424, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(425, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(426, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(427, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(428, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(429, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(430, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(431, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(432, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC16
insert into cob_conta_super..sb_filas values(433, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 13, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(434, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(435, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(436, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(437, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(438, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(439, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(440, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(441, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(442, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(443, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(444, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(445, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(446, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(447, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(448, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(449, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(450, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(451, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(452, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(453, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(454, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(455, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(456, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(457, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(458, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(459, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(460, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(461, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC17
insert into cob_conta_super..sb_filas values(462, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 14, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(463, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(464, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(465, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(466, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(467, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(468, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(469, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(470, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(471, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(472, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(473, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(474, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(475, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(476, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(477, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(478, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(479, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(480, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(481, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(482, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(483, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(484, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(485, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(486, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(487, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(488, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(489, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(490, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC18
insert into cob_conta_super..sb_filas values(491, @w_proceso, 2, 'CÁLCULO DE EXCESOS O DEFECTOS DE LIQUIDEZ DE LAS SUBORDINADAS EN EL PAÍS 15, POR MONEDA')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(492, @w_proceso, 2, 'PESO COLOMBIANO (COP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(493, @w_proceso, 2, 'DOLAR ESTADOUNIDENSE (USD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(494, @w_proceso, 2, 'EURO (EUR)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(495, @w_proceso, 2, 'LEMPIRA HONDUREÑO (HNL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(496, @w_proceso, 2, 'COLON COSTARRICENSE (CRC)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(497, @w_proceso, 2, 'QUETZAL GUATEMALTECO (GTQ)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(498, @w_proceso, 2, 'NUEVO SOL PERUANO (PEN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(499, @w_proceso, 2, 'GUARANI PARAGUAYO (PYG)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(500, @w_proceso, 2, 'CORDOBA NICARAGÜENSE (NIO)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(501, @w_proceso, 2, 'PESO MEXICANO (MXN)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(502, @w_proceso, 2, 'YEN JAPONES (JPY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(503, @w_proceso, 2, 'LIBRA ESTERLINA (GBP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(504, @w_proceso, 2, 'DOLAR CANADIENSE (CAD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(505, @w_proceso, 2, 'REAL BRASILERO (BRL)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(506, @w_proceso, 2, 'FRANCO SUIZO (CHF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(507, @w_proceso, 2, 'DOLAR AUSTRALIANO (AUD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(508, @w_proceso, 2, 'CORONA SANESA (DKK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(509, @w_proceso, 2, 'CORONA SUECA (SEK)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(510, @w_proceso, 2, 'BOLIVAR VENEZOLANO (VEF)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(511, @w_proceso, 2, 'PESO ARGENTINO (ARS)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(512, @w_proceso, 2, 'YUAN CHINO (CNY)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(513, @w_proceso, 2, 'DOLAR DE HONG KONG (HKD)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(514, @w_proceso, 2, 'PESO CHILENO (CLP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(515, @w_proceso, 2, 'PESO DOMINICANO (DOP)')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(516, @w_proceso, 2, 'OTRA MONEDA 1')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(517, @w_proceso, 2, 'OTRA MONEDA 2')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(518, @w_proceso, 2, 'CODIGO PAIS')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(519, @w_proceso, 2, 'EXCESO O DEFECTO DE LIQUIDEZ DE LAS FILIALES DEL PAIS 15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC19
insert into cob_conta_super..sb_filas values(520, @w_proceso, 2, 'INDICADOR CONSOLIDADO')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(521, @w_proceso, 2, 'INDICADOR DE EXPOSICIÓN CONSOLIDADO')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

/******UNIDADES DE CAPTURA*******/
--UC1
insert into cob_conta_super..sb_filas values(1,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(2,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(3,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(4,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(5,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(6,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(7,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(8,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(9,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(10,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(11,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(12,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(13,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(14,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(15,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(16,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(17,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(18,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(19,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(20,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(21,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(22,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(23,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(24,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(25,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(26,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(27,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(28,@w_proceso,43,'01')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC2
insert into cob_conta_super..sb_filas values(29,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(30,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(31,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(32,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(33,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(34,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(35,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(36,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(37,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(38,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(39,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(40,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(41,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(42,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(43,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(44,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(45,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(46,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(47,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(48,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(49,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(50,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(51,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(52,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(53,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(54,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(55,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(56,@w_proceso,43,'02')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC3
insert into cob_conta_super..sb_filas values(57, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(58, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(59, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(60, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(61, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(62, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(63, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(64, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(65, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(66, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(67, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(68, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(69, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(70, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(71, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(72, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(73, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(74, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(75, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(76, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(77, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(78, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(79, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(80, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(81, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(82, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(83, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(84, @w_proceso, 43, '03')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC4
insert into cob_conta_super..sb_filas values(85,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(86,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(87,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(88,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(89,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(90,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(91,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(92,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(93,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(94,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(95,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(96,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(97,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(98,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(99,  @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(100, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(101, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(102, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(103, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(104, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(105, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(106, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(107, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(108, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(109, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(110, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(111, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(112, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(113, @w_proceso, 43, '04')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC5
insert into cob_conta_super..sb_filas values(114, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(115, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(116, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(117, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(118, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(119, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(120, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(121, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(122, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(123, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(124, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(125, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(126, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(127, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(128, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(129, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(130, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(131, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(132, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(133, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(134, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(135, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(136, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(137, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(138, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(139, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(140, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(141, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(142, @w_proceso, 43, '05')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC6
insert into cob_conta_super..sb_filas values(143, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(144, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(145, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(146, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(147, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(148, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(149, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(150, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(151, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(152, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(153, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(154, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(155, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(156, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(157, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(158, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(159, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(160, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(161, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(162, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(163, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(164, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(165, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(166, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(167, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(168, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(169, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(170, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(171, @w_proceso, 43, '06')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC7
insert into cob_conta_super..sb_filas values(172, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(173, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(174, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(175, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(176, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(177, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(178, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(179, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(180, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(181, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(182, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(183, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(184, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(185, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(186, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(187, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(188, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(189, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(190, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(191, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(192, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(193, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(194, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(195, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(196, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(197, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(198, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(199, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(200, @w_proceso, 43, '07')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC8
insert into cob_conta_super..sb_filas values(201, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(202, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(203, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(204, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(205, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(206, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(207, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(208, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(209, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(210, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(211, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(212, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(213, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(214, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(215, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(216, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(217, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(218, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(219, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(220, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(221, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(222, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(223, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(224, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(225, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(226, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(227, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(228, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(229, @w_proceso, 43, '08')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC9
insert into cob_conta_super..sb_filas values(230, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(231, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(232, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(233, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(234, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(235, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(236, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(237, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(238, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(239, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(240, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(241, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(242, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(243, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(244, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(245, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(246, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(247, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(248, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(249, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(250, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(251, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(252, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(253, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(254, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(255, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(256, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(257, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(258, @w_proceso, 43, '09')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC10
insert into cob_conta_super..sb_filas values(259, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(260, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(261, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(262, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(263, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(264, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(265, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(266, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(267, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(268, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(269, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(270, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(271, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(272, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(273, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(274, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(275, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(276, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(277, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(278, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(279, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(280, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(281, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(282, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(283, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(284, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(285, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(286, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(287, @w_proceso, 43, '10')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC11
insert into cob_conta_super..sb_filas values(288, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(289, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(290, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(291, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(292, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(293, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(294, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(295, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(296, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(297, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(298, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(299, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(300, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(301, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(302, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(303, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(304, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(305, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(306, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(307, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(308, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(309, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(310, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(311, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(312, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(313, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(314, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(315, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(316, @w_proceso, 43, '11')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC12
insert into cob_conta_super..sb_filas values(317, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(318, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(319, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(320, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(321, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(322, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(323, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(324, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(325, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(326, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(327, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(328, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(329, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(330, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(331, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(332, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(333, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(334, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(335, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(336, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(337, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(338, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(339, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(340, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(341, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(342, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(343, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(344, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(345, @w_proceso, 43, '12')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC13
insert into cob_conta_super..sb_filas values(346, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(347, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(348, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(349, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(350, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(351, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(352, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(353, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(354, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(355, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(356, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(357, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(358, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(359, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(360, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(361, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(362, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(363, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(364, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(365, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(366, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(367, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(368, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(369, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(370, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(371, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(372, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(373, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(374, @w_proceso, 43, '13')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC14
insert into cob_conta_super..sb_filas values(375, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(376, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(377, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(378, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(379, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(380, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(381, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(382, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(383, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(384, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(385, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(386, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(387, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(388, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(389, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(390, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(391, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(392, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(393, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(394, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(395, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(396, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(397, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(398, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(399, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(400, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(401, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(402, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(403, @w_proceso, 43, '14')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC15
insert into cob_conta_super..sb_filas values(404, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(405, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(406, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(407, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(408, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(409, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(410, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(411, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(412, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(413, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(414, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(415, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(416, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(417, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(418, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(419, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(420, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(421, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(422, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(423, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(424, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(425, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(426, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(427, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(428, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(429, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(430, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(431, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(432, @w_proceso, 43, '15')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC16
insert into cob_conta_super..sb_filas values(433, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(434, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(435, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(436, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(437, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(438, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(439, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(440, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(441, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(442, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(443, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(444, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(445, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(446, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(447, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(448, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(449, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(450, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(451, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(452, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(453, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(454, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(455, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(456, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(457, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(458, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(459, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(460, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(461, @w_proceso, 43, '16')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC17
insert into cob_conta_super..sb_filas values(462, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(463, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(464, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(465, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(466, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(467, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(468, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(469, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(470, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(471, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(472, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(473, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(474, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(475, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(476, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(477, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(478, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(479, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(480, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(481, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(482, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(483, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(484, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(485, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(486, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(487, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(488, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(489, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(490, @w_proceso, 43 , '17')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC18
insert into cob_conta_super..sb_filas values(491, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(492, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(493, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(494, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(495, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(496, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(497, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(498, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(499, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(500, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(501, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(502, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(503, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(504, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(505, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(506, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(507, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(508, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(509, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(510, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(511, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(512, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(513, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(514, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(515, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(516, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(517, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(518, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(519, @w_proceso, 43, '18')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

--UC19
insert into cob_conta_super..sb_filas values(520, @w_proceso, 43, '19')if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend
insert into cob_conta_super..sb_filas values(521, @w_proceso, 43, '19')
if @@error <>0beginselect @w_mensaje = '[15000]: ERROR EN INSERCION'goto FINend

select * from cob_conta_super..sb_filas where fi_proceso = @w_proceso
-------------------------------------------------------

PRINT '----------------------------------------------------------------------'
print 'INGRESANDO PARAMETRIZACION EN SB_TIPO_SALDO PARA FORMATO 531'
PRINT '----------------------------------------------------------------------'

select @w_proceso  = @w_proceso, 
  @w_max_fila = 0 , 
  @w_max_col  = 0

delete from cob_conta_super..sb_tipo_saldo where ts_proceso = @w_proceso

if @@error <>0 
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end
   
select @w_max_fila = max(fi_num_fila)
from cob_conta_super..sb_filas
where fi_proceso = @w_proceso
and fi_num_col   = 1

select @w_max_col = max(co_num_columna) 
from sb_columnas
where co_proceso = @w_proceso

select @w_fil = 1
select @w_col = 3

while @w_fil <= @w_max_fila
begin
    while @w_col < @w_max_col
    begin     
        insert into cob_conta_super..sb_tipo_saldo (
                    ts_empresa,   ts_proceso,  ts_fila, 
                    ts_columna,   ts_tipo)
        values     (1,            @w_proceso,  @w_fil, 
                    @w_col,       0)
					
       if @@error <>0 
        begin
           select @w_mensaje = '[15000]: ERROR EN INSERCION'
           goto FIN
        end
   
        select @w_col  = @w_col  + 1
    end
    select @w_col = 3
    select @w_fil  = @w_fil  + 1
end
-----------------------------------------------------------
print 'CELDAS O SUBCUENTAS QUE SFC SOLICITA EN CERO COLUMNAS 8 A LA 19'
 
   update cob_conta_super..sb_tipo_saldo
   set   ts_reporta_cero = 'S'
   where ts_proceso = @w_proceso
   and   ts_fila in (2)
   and   ts_columna in (8, 12, 13, 24, 25, 26, 34, 35, 36)
   
  if @@error <>0 
   begin
      select @w_mensaje = '[15001]: ERROR EN ACTUALIZACION'
      goto FIN
   end   
  
select * from cob_conta_super..sb_tipo_saldo where ts_proceso = @w_proceso
and ts_reporta_cero = 'S'
 
   update cob_conta_super..sb_tipo_saldo
   set   ts_reporta_cero = 'S'
   where ts_proceso = @w_proceso
   and   ts_fila in (3)
   and   ts_columna in (8,9,10,12,13,14,15,18,19,21,22,24,25,26,28,29,31,32,34,35,36)
  
  if @@error <>0 
   begin
      select @w_mensaje = '[15001]: ERROR EN ACTUALIZACION'
      goto FIN
   end
  
select * from cob_conta_super..sb_tipo_saldo where ts_proceso = @w_proceso
and ts_reporta_cero = 'S'
 
print 'SCRIPT FINALIZADO'

FIN:
   print @w_mensaje
   
set nocount off
go
