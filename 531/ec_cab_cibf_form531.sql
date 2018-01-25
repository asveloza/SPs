/**********************************************************************/
/*  Archivo:                            ec_cab_cibf_form531.sql       */
/*  Base de datos:                      cobis                         */
/*  Producto:                           CIBF                          */
/*  Fecha de escritura:                 01.11.2017                    */
/**********************************************************************/
/*                          IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  "COBISCORP", su uso no autorizado queda expresamente prohibido asi*/
/*  como cualquier alteracion o agregado hecho por alguno de sus      */
/*  usuarios sin el debido consentimiento por escrito de la           */
/*  presidencia Ejecutiva de COBISCORP o su representante.            */
/**********************************************************************/
/*                           PROPOSITO                                */
/*  Creacion de la parametrizacion del fomrato 4531                   */
/**********************************************************************/
/*                         MODIFICACIONES                             */
/*  FECHA         AUTOR                   RAZON                       */
/*  05.10.2017   Ana Viera         Emision Inicial                    */
/**********************************************************************/
use cobis
go

declare
@w_tabla   int,
@w_campo   int,
@w_mensaje varchar(250)

select @w_mensaje = '',
       @w_tabla = 0,
       @w_campo = 0

/*CABECERA*/


if exists(select 1 from  cl_arch_formato where af_archivo='FORMATO 531 INVENTARIO FORWARDS' and af_tabla = 'ex_dato_inventariofrwd' )
begin
   select @w_tabla=af_codigo from cl_arch_formato where af_archivo='FORMATO 531 INVENTARIO FORWARDS' and af_tabla = 'ex_dato_inventariofrwd'

   delete cl_arch_formato where af_codigo=@w_tabla
   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN ELIMINACION'
      goto FIN
   end

   delete cl_det_archivo where da_codigo=@w_tabla
   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN ELIMINACION'
      goto FIN
   end
end

if exists(select 1 from  cl_arch_formato where af_archivo='FORMATO 531 HAIRCUTS MONEDAS' and af_tabla = 'ex_dato_haircut_mon')
begin
   select @w_tabla=af_codigo from cl_arch_formato where af_archivo='FORMATO 531 HAIRCUTS MONEDAS' and af_tabla = 'ex_dato_haircut_mon'

   delete cl_arch_formato where af_codigo=@w_tabla
   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN ELIMINACION'
      goto FIN
   end

   delete cl_det_archivo where da_codigo=@w_tabla
   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN ELIMINACION'
      goto FIN
   end
end


--*************************************************************--
-- 1 --

    select @w_tabla = max(af_codigo) from  cl_arch_formato
    select @w_tabla  = @w_tabla  + 1

    insert into cobis..cl_arch_formato  (
    af_codigo,             af_archivo,          af_descripcion,
    af_delimitador ,       af_delimitador_reg , af_base,
    af_tabla,              af_proceso ,         af_campo_usr_carga,
    af_campo_sec_carga ,   af_tolerancia,       af_linea_inicial ,
    af_linea_final,        af_transaccion ,     af_estado,
    af_user_crea ,         af_fecha_crea ,      af_user_mod,
    af_fecha_mod,          af_longitud_fija ,   af_porcentaje,
    af_actualiza ,         af_cod_producto,     af_des_producto,
    af_tipo_plantilla)
    values(
    @w_tabla,                           'FORMATO 531 INVENTARIO FORWARDS',    'FORMATO 531 INVENTARIO FORWARDS',
    ';',                                'ENT',                                'cob_externos',
    'ex_dato_inventariofrwd',           NULL,                                 NULL,
    NULL,                               'N',                                  1,
    0,                                  NULL,                                 'V',
    'caruiz',                           getdate(),                            NULL,
    NULL,                               'N',                                  NULL,
    'N',                                NULL,                                 'REPORTES SUPER BANCARIA',
    'I')
     if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end
      -------------------------------------------------------
   
    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,          da_secuencia,        da_campo_arch,
    da_campo_tabla,     da_tipo,             da_catalogo,
    da_formato_fech,    da_cod_for_fech,     da_obligatoriedad,
    da_equivalencia,    da_cataloga,         da_operable,
    da_llave,           da_pos_ini,          da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,      'Tipo',
    'di_tipo',       'A',           null,
    null,            0,             'A',
    'N',             'N',           null,
    'N',             1,             0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Modalidad',
    'di_modalidad',  'A',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
     if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Portafolio',
    'di_portafolio', 'A',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,         @w_campo,    'Referencia',
    'di_referencia',  'A',         null,
    null,             0,           'A',
    'N',              'N',         null,
    'N',              1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Cliente',
    'di_cliente',    'A',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,             @w_campo,    'Identificacion',
    'di_identificacion',  'A',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Fecha_inv',
    'di_fecha_inv',  'D',         null,
    'YYYY/MM/DD',    111,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Fecha_apertura',
    'di_fecha_apertura',  'D',     null,
    'YYYY/MM/DD',       111,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Fecha_pago',
    'di_fecha_pago',  'D',         null,
    'YYYY/MM/DD',    111,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Fecha_venc',
    'di_fecha_venc',  'D',         null,
    'YYYY/MM/DD',     111,         'A',
    'N',             'N',          null,
    'N',             1,            0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Plazo',
    'di_plazo',     'I',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Dias_al_venc',
    'di_dias_al_venc',  'I',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Mon_nominal',
    'di_mon_nominal',  'A',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Mon_conv',
    'di_mon_conv',  'A',          null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Monto',
    'di_monto',      'M',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Valor_moneda',
    'di_valor_moneda',  'M',      null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Cot_spot',
    'di_cot_spot',  'M',          null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Cot_fwd',
    'di_cot_fwd',    'M',         null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Devaluacion',
    'di_devaluacion',  'F',         null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Tasa_me',
    'di_tasa_me',    'F',           null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Tasa_mp',
    'di_tasa_mp',    'F',          null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Derecho_ayer',
    'di_derecho_ayer',  'M',      null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Obligacion_ayer',
    'di_obligacion_ayer',  'M',    null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Derecho_hoy',
    'di_derecho_hoy',  'M',       null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Obligacion_hoy',
    'di_obligacion_hoy',  'M',    null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'PYG',
    'di_pyg',        'M',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Tasa_estimada',
    'di_tasa_estimada',  'F',     null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Tasa_Val_Usd',
    'di_tasa_val_usd',  'M',      null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Tasa_Val_Divisa',
    'di_tasa_val_divisa',  'M',   null,
    null,            0,           'N',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'PYG_dia',
    'di_pyg_dia',    'M',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,              @w_campo,     'Formula_derecho',
    'di_formula_derecho',  'M',          null,
    null,                  0,            'A',
    'N',                   'N',          null,
    'N',                   1,            0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,                 @w_campo,    'Formula_obligacion',
    'di_formula_obligacion',  'M',         null,
    null,                     0,           'A',
    'N',                      'N',         null,
    'N',                      1,           0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end
/**********************************************************************/
-- 2 --


    select @w_tabla = max(af_codigo) from  cl_arch_formato
    select @w_tabla  = @w_tabla  + 1

    insert into cobis..cl_arch_formato  (
    af_codigo,             af_archivo,          af_descripcion,
    af_delimitador ,       af_delimitador_reg , af_base,
    af_tabla,              af_proceso ,         af_campo_usr_carga,
    af_campo_sec_carga ,   af_tolerancia,       af_linea_inicial ,
    af_linea_final,        af_transaccion ,     af_estado,
    af_user_crea ,         af_fecha_crea ,      af_user_mod,
    af_fecha_mod,          af_longitud_fija ,   af_porcentaje,
    af_actualiza ,         af_cod_producto,     af_des_producto,
    af_tipo_plantilla)
    values(
    @w_tabla,                           'FORMATO 531 HAIRCUTS MONEDAS',       'FORMATO 531 HAIRCUTS MONEDAS',
    ';',                                'ENT',                                'cob_externos',
    'ex_dato_haircut_mon',              NULL,                                 NULL,
    NULL,                               'N',                                  1,
    0,                                  NULL,                                 'V',
    'caruiz',                           getdate(),                            NULL,
    NULL,                               'N',                                  NULL,
    'N',                                NULL,                                 'REPORTES SUPER BANCARIA',
    'I')
     if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end
      -------------------------------------------------------
    select @w_campo = 0
    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,          da_secuencia,        da_campo_arch,
    da_campo_tabla,     da_tipo,             da_catalogo,
    da_formato_fech,    da_cod_for_fech,     da_obligatoriedad,
    da_equivalencia,    da_cataloga,         da_operable,
    da_llave,           da_pos_ini,          da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,               @w_campo,      'Tipo_moneda',
    'hm_tipo_moneda',       'A',           null,
    null,                   0,             'A',
    'N',                    'N',           null,
    'N',                    1,             0,
    null)
    if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

    select @w_campo =@w_campo+1

    insert into cobis..cl_det_archivo(
    da_codigo,       da_secuencia,    da_campo_arch,
    da_campo_tabla,  da_tipo,         da_catalogo,
    da_formato_fech, da_cod_for_fech, da_obligatoriedad,
    da_equivalencia, da_cataloga,     da_operable,
    da_llave,        da_pos_ini,      da_longitud,
    da_tipo_equ)
    values (
    @w_tabla,        @w_campo,    'Haircut',
    'hm_haircut',   'F',         null,
    null,            0,           'A',
    'N',             'N',         null,
    'N',             1,           0,
    null)
     if @@error <>0
     begin
       select @w_mensaje = '[15000]: ERROR EN INSERCION'
       goto FIN
    end

FIN:
    print @w_mensaje

go
