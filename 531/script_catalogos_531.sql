/************************************************************************/
/*  Archivo:              script_catalogos_531.sql                      */
/*  Base de datos:        cobis                                         */
/*  Producto:             REC                                           */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP", representantes exclusivos para el Ecuador de la        */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*                        PROPOSITO                                     */
/* Script creacion de los productos del mercado de portafolio  TV       */
/*                                                                      */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA             AUTOR                RAZON                        */
/*  9/NOV/2017     Rodrigo Prada         Emision Inicial                */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

declare
@w_cod_prod smallint,
@w_cod_uvr  smallint,
@w_cod_fwd  smallint

-----------------------------------------------------------------
---------------------CATALOGO DE PRODUCTOS-----------------------
-----------------------------------------------------------------
print '************************************************'
print '***** INSERCION PARAMETRIZACION           ******'
print '************************************************'
print ''
print '------creando catalogo de Productos'

begin tran

select @w_cod_prod  = codigo
from   cobis..cl_tabla
where  tabla = 'cl_productos_531'

if @w_cod_prod  is null
begin
   select @w_cod_prod  = max(codigo) + 1
   from   cobis..cl_tabla
end

delete cobis..cl_tabla
where  tabla  = 'cl_productos_531'
and    codigo = @w_cod_prod

delete cobis..cl_catalogo
where  tabla = @w_cod_prod

delete cl_catalogo_pro
where  cp_tabla = @w_cod_prod

insert into cobis..cl_tabla
(codigo      , tabla             , descripcion)
values
(@w_cod_prod ,'cl_productos_531' , 'PRODUCTOS 531')

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_tabla '
   rollback tran
   goto FIN
end

update cobis..cl_seqnos set
siguiente = @w_cod_prod
where tabla = 'cl_tabla'

if @@error <> 0 begin
   print '[ERROR]: Al actualizar cl_seqnos'
   rollback tran
   goto FIN
end

commit tran

print '--------------- se crea la tabla de catalogo cl_productos_531'

insert into cobis..cl_catalogo
(tabla       , codigo , valor          , estado)
values
(@w_cod_prod , '0'    , 'TDA CLASE A' , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos'
   goto FIN
end

insert into cobis..cl_catalogo
(tabla       , codigo , valor          , estado)
values
(@w_cod_prod , '1'    , 'TDA CLASE B' , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos'
   goto FIN
end

insert into cobis..cl_catalogo
(tabla       , codigo , valor       , estado)
values
(@w_cod_prod , '2'    , 'TES PESOS' , 'V'   )

insert into cobis..cl_catalogo
(tabla       , codigo , valor     , estado)
values
(@w_cod_prod , '3'    , 'TES UVR' , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos'
   goto FIN
end

insert into cobis..cl_catalogo
(tabla       , codigo , valor               , estado)
values
(@w_cod_prod , '4'    , 'TITULOS TES - TCO' , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos'
   goto FIN
end

print '------------ se ingresan los diferentes Productos'

insert into cobis..cl_catalogo_pro
(cp_producto, cp_tabla    )
values
('SUP'      , @w_cod_prod )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo pro'
   goto FIN
end

print '------------ Se termina creacion de catalogo de Productos'

-----------------------------------------------------------------
------------------------CATALOGO DE UVR--------------------------
-----------------------------------------------------------------
print ''

print '------creando catalogo de Productos UVR'

begin tran

select @w_cod_uvr = codigo
from   cobis..cl_tabla
where  tabla = 'cl_prod_uvr_531'

if @w_cod_uvr is null
begin
   select @w_cod_uvr = max(codigo) + 1
   from   cobis..cl_tabla
end

delete cl_tabla
where  tabla  = 'cl_prod_uvr_531'
and    codigo = @w_cod_uvr

delete cobis..cl_catalogo
where  tabla = @w_cod_uvr

delete cl_catalogo_pro
where  cp_tabla = @w_cod_uvr

insert into cobis..cl_tabla
(codigo      , tabla          , descripcion)
values
(@w_cod_uvr  , 'cl_prod_uvr_531' , 'PRODUCTOS UVR')

if @@error <> 0 begin
   print '[ERROR]: Al insertar en tabla productos UVR'
   goto FIN
end

update cobis..cl_seqnos set
siguiente = @w_cod_uvr
where tabla = 'cl_tabla'

if @@error <> 0 begin
   print '[ERROR]: Al actualizar cl_seqnos'
   rollback tran
   goto FIN
end

commit tran

print '--------------- se crea la tabla de catalogo cl_prod_uvr_531'

insert into cobis..cl_catalogo
(tabla       , codigo , valor    , estado)
values
(@w_cod_uvr , '0'    , 'TES UVR' , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos UVR'
   goto FIN
end

print '------------ se ingresan los diferentes Productos UVR'

insert into cobis..cl_catalogo_pro
(cp_producto, cp_tabla    )
values
('SUP'      , @w_cod_uvr )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Productos UVR'
   goto FIN
end

print '------------ Se termina creacion de catalogo de Productos UVR'

-----------------------------------------------------------------
------------------------CATALOGO FORWARDS------------------------
-----------------------------------------------------------------
print ''

begin tran

select @w_cod_fwd  = codigo
from   cobis..cl_tabla
where  tabla = 'cl_forward'

if @w_cod_fwd  is null
begin
   select @w_cod_fwd  = max(codigo) + 1
   from   cobis..cl_tabla
end

delete cobis..cl_tabla
where  tabla  = 'cl_forward'
and    codigo = @w_cod_fwd

delete cobis..cl_catalogo
where  tabla = @w_cod_fwd

delete cl_catalogo_pro
where  cp_tabla = @w_cod_fwd

insert into cobis..cl_tabla
(codigo      , tabla             , descripcion)
values
(@w_cod_fwd ,'cl_forward' , 'FORWARDS')

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_tabla '
   rollback tran
   goto FIN
end

update cobis..cl_seqnos set
siguiente = @w_cod_fwd
where tabla = 'cl_tabla'

if @@error <> 0 begin
   print '[ERROR]: Al actualizar cl_seqnos'
   rollback tran
   goto FIN
end

commit tran

print '--------------- Creando Productos Forwards'

insert into cobis..cl_catalogo
(tabla       , codigo , valor, estado)
values
(@w_cod_fwd , '0'    , 'C'  , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Forwards'
   goto FIN
end

insert into cobis..cl_catalogo
(tabla       , codigo , valor, estado)
values
(@w_cod_fwd , '1'    , 'V'  , 'V'   )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo Forwards'
   goto FIN
end
print '------------ se ingresan los diferentes Forwards'

insert into cobis..cl_catalogo_pro
(cp_producto, cp_tabla    )
values
('SUP'      , @w_cod_fwd )

if @@error <> 0 begin
   print '[ERROR]: Al insertar en cl_catalogo pro'
   goto FIN
end

print '------------ Se termina creacion de catalogo de Forwards'

FIN:
go
