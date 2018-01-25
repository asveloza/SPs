/**********************************************************************/
/*  Archivo:              ec_estructura_contasuper_form531.sql        */
/*  Base de datos:        cob_conta_super                             */
/*  Producto:             REC                                         */
/*  Fecha de escritura:   01 de Noviembre de 2017                     */
/**********************************************************************/
/*                        IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  "COBISCORP", su uso no autorizado queda expresamente prohibido asi*/
/*  como cualquier alteracion o agregado hecho por alguno de sus      */
/*  usuarios sin el debido consentimiento por escrito de la           */
/*  presidencia Ejecutiva de COBISCORP o su representante.            */
/**********************************************************************/
/*                        PROPOSITO                                   */
/*  Creacion de estructuras cob_conta_super formato 531               */
/**********************************************************************/
/*                         MODIFICACIONES                             */
/*  FECHA         AUTOR                   RAZON                       */
/*  01/Nov/2017   Ana Viera           Emision Inicial                 */
/**********************************************************************/
use cob_conta_super
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE TABLAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Tablas para Formato 531 en cob_conta_super : ' + convert(varchar(60),getdate(),109)
print ''

if exists (select 1 from sysobjects where name = 'sb_dato_inventariofrwd' and type = 'U') 
   drop table sb_dato_inventariofrwd
go
print '-->Tabla: sb_dato_inventariofrwd'
   create table sb_dato_inventariofrwd(
   di_tipo                 char(1)      NOT NULL,
   di_modalidad            char(1)      NOT NULL,
   di_portafolio           varchar(20)  NOT NULL,
   di_referencia           varchar(20)  NOT NULL,
   di_cliente              varchar(150) NOT NULL,
   di_identificacion       varchar(30)  NOT NULL,
   di_fecha_inv            datetime     NOT NULL,
   di_fecha_apertura       datetime     NOT NULL,
   di_fecha_pago           datetime     NULL,
   di_fecha_venc           datetime     NOT NULL,
   di_plazo                int          NOT NULL,
   di_dias_al_venc         int          NOT NULL,
   di_mon_nominal          varchar(10)  NOT NULL,
   di_mon_conv             varchar(10)  NOT NULL,
   di_monto                money        NOT NULL,
   di_valor_moneda         money        NOT NULL,
   di_cot_spot             money        NULL,
   di_cot_fwd              money        NULL,
   di_devaluacion          float        NULL,
   di_tasa_me              float        NULL,
   di_tasa_mp              float        NULL,
   di_derecho_ayer         money        NULL,
   di_obligacion_ayer      money        NULL,
   di_derecho_hoy          money        NOT NULL,
   di_obligacion_hoy       money        NOT NULL,
   di_pyg                  money        NOT NULL,
   di_tasa_estimada        float        NOT NULL,
   di_tasa_val_usd         money        NULL,
   di_tasa_val_divisa      money        NULL,
   di_pyg_dia              money        NOT NULL,
   di_formula_derecho      money        NOT NULL,
   di_formula_obligacion   money        NOT NULL,
   di_aplicativo           smallint     NULL,
   di_fecha_proc           datetime     NULL,
   di_origen               varchar(5)   default 'B')
   
if exists (select 1 from sysobjects where name = 'sb_dato_haircut_mon' and type = 'U') 
   drop table sb_dato_haircut_mon
go
print '-->Tabla: sb_dato_haircut_mon'
   create table sb_dato_haircut_mon(
   hm_tipo_moneda   varchar(5)  NOT NULL,
   hm_haircut       float       NOT NULL,
   hm_aplicativo    smallint    NULL,
   hm_fecha_proc    datetime    NULL,
   hm_origen        varchar(5)  default 'B')

go


