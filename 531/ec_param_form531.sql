/**********************************************************************/
/*  Archivo:                         ec_param_form531.sql             */
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
/*  parametrizacion catalogos del formato 531                         */
/**********************************************************************/
/*                          MODIFICACIONES                            */
/*  FECHA         AUTOR                RAZON                          */
/*  16.10.17      Rodrigo Prada         Emision Inicial               */
/**********************************************************************/
use cob_conta_super
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

declare @w_mensaje    varchar(250),
        @w_tabla      smallint,
        @w_proceso    int,
        @w_max_fila   int,
        @w_col        int,
        @w_fil        int,
        @w_max_col    int,
        @w_error      int


-------------------------------------------------------------------
------ PARAMETRIZACION CATALOGOS Y EQUIVALENCIAS FORMATO 531 ------
-------------------------------------------------------------------

print 'Parametro de control para validacion de fecha'

if exists(select 1 from cobis..cl_parametro where pa_nemonico = 'FEC531')
begin
   delete cobis..cl_parametro where pa_nemonico = 'FEC531'
end

if @@error <>0
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end

insert into cobis..cl_parametro
values
('Control de fecha 531','FEC531','C','S',NULL,NULL,NULL,NULL,NULL,NULL,'REC')

if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end

print 'Parametro de factor'

if exists(select 1 from cobis..cl_parametro where pa_nemonico = 'FAC531')
begin
   delete cobis..cl_parametro where pa_nemonico = 'FAC531'
end

if @@error <>0
begin
   select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
   goto FIN
end

insert into cobis..cl_parametro
values
('Factor 531','FAC531','I',NULL,NULL,NULL,1000,NULL,NULL,NULL,'REC')

if @@error <>0
begin
   select @w_mensaje = '[15000]: ERROR EN INSERCION'
   goto FIN
end

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'ec_equivalencias'

if @w_tabla = null or @w_tabla =''
   print 'TABLA DE CATALOGO - ec_equivalencias NO EXISTE'
else
begin

   print 'Parametrizacion formato 531 Moneda'

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'MONEDA531')
   begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'MONEDA531'
   end

   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
      goto FIN
   end

   print 'Ingreso en el catalogo la parametrizacion de moneda formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'MONEDA531','PARAMETRIZACION PARA LAS MONEDAS 531','V',NULL,NULL,NULL)

   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end

   print 'Parametrizacion formato 531 Moneda'

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'MONEDA531')
   begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'MONEDA531'
   end

   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
      goto FIN
   end

   print 'Ingreso en equivalencias monedas formato 531'

   insert into cob_conta_super..sb_equivalencias values ('MONEDA531','001','0','PARAMETRIZACION MONEDA FORMATO 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('MONEDA531','002','1','PARAMETRIZACION MONEDA FORMATO 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   
   print 'Parametrizacion formato 531 Calendario'

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'CALSEM531')
   begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'CALSEM531'
   end

   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
      goto FIN
   end

   print 'Ingreso en el catalogo el calendario Semanal formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'CALSEM531','CALENDARIO SEMANAL PARA EL 531','V',NULL,NULL,NULL)

   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'CALSEM531')
   begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'CALSEM531'
   end

   if @@error <>0
   begin
      select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
      goto FIN
   end

   print 'Ingreso en equivalencias el calendario Semanal formato 531'

   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','13/01/2017','13/01/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','20/01/2017','20/01/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','27/01/2017','27/01/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','03/02/2017','03/02/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','10/02/2017','10/02/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','17/02/2017','17/02/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','24/02/2017','24/02/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','03/03/2017','03/03/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','10/03/2017','10/03/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','17/03/2017','17/03/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','24/03/2017','24/03/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','31/03/2017','31/03/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','07/04/2017','07/04/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','12/04/2017','12/04/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','21/04/2017','21/04/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','28/04/2017','28/04/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','05/05/2017','05/05/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','12/05/2017','12/05/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','19/05/2017','19/05/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','26/05/2017','26/05/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','02/06/2017','02/06/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','09/06/2017','09/06/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','16/06/2017','16/06/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','23/06/2017','23/06/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','30/06/2017','30/06/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','07/07/2017','07/07/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','14/07/2017','14/07/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','21/07/2017','21/07/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','28/07/2017','28/07/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','04/08/2017','04/08/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','11/08/2017','11/08/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','18/08/2017','18/08/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','25/08/2017','25/08/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','01/09/2017','01/09/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','08/09/2017','08/09/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','15/09/2017','15/09/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','22/09/2017','22/09/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','29/09/2017','29/09/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','06/10/2017','06/10/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','13/10/2017','13/10/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','20/10/2017','20/10/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','27/10/2017','27/10/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','03/11/2017','03/11/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','10/11/2017','10/11/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','17/11/2017','17/11/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','24/11/2017','24/11/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','01/12/2017','01/12/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','07/12/2017','07/12/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','15/12/2017','15/12/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','22/12/2017','22/12/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALSEM531','29/12/2017','29/12/2017','CALENDARIO SEMANAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'CALMEN531')
      begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'CALMEN531'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en el catalogo el CALENDARIO Mensual formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'CALMEN531','CALENDARIO MENSUAL PAR EL 531','V',NULL,NULL,NULL)

     if @@error <>0
      begin
            select @w_mensaje = '[15000]: ERROR EN INSERCION'
            goto FIN
      end

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'CALMEN531')
      begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'CALMEN531'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','13/01/17','13/01/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','27/01/17','27/01/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','10/02/17','10/02/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','24/02/17','24/02/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','10/03/17','10/03/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','31/03/17','31/03/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','12/04/17','12/04/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','28/04/17','28/04/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','12/05/17','12/05/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','26/05/17','26/05/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','09/06/17','09/06/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','30/06/17','30/06/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','14/07/17','14/07/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','28/07/17','28/07/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','11/08/17','11/08/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','25/08/17','25/08/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','08/09/17','08/09/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','29/09/17','29/09/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','13/10/17','13/10/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','27/10/17','27/10/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','10/11/17','10/11/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','24/11/17','24/11/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','07/12/17','07/12/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('CALMEN531','29/12/17','29/12/17','CALENDARIO MENSUAL FORMATO 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_CARG458')
      begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_CARG458'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en el catalogo formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'EC_CARG458','INFORMACION 458 VS 531','V',NULL,NULL,NULL)

     if @@error <>0
      begin
            select @w_mensaje = '[15000]: ERROR EN INSERCION'
            goto FIN
      end

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_CARG458')
      begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_CARG458'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en equivalencias Cargue de informacion desde el 458 al 531 subcuenta 001'

   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5310701001','A4580710016' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5310801001','E4580710016' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5311201001','A4580710017' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'F5311301001','F4580710017' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311601001','B4581505010' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311601001','B4581505045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311601001','B4581505060' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311601001','B4581505075' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5311701001','A4581505085' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581506010' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581506035' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581506040' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581506045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581506060' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801001','C4581502999' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5311901001','A4581506045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5312001001','A4581508015' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5312601001','B4581805010' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5312601001','B4581805045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5312601001','B4581805060' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5312601001','B4581805075' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5312701001','A4581805085' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581806010' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581806035' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581806040' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581806045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581806060' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801001','D4581802999' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5312901001','A4581806045' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5313001001','A4581808015' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   print 'Ingreso en equivalencias Cargue de informacion operando el 531 subcuenta 001'

   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901001','B5310501001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901001','B5310601001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901001','B5310701001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401001','B5311001001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401001','B5311101001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401001','B5311201001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'F5311501001','F5310901001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'F5311501001','F5311401001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101001','E5311601001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101001','E5311801001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101001','E5312001001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5312501001','A5312101001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101001','E5312601001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101001','E5312801001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101001','E5313001001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5313501001','A5313101001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313701001','C5311501001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313701001','C5312501001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313801001','C5311501001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313801001','C5313501001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5313901001','D5313701001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5313901001','D5313601001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5314001001','D5313801001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5314001001','D5313601001' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   print 'Ingreso en equivalencias Cargue de informacion desde el 458 al 531 subcuenta 002'

   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5311801002','C4581502999' ,'INFORMACION 458 VS 531','V')
   
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5312801002','D4581802999' ,'INFORMACION 458 VS 531','V')
   

   print 'Ingreso en equivalencias Cargue de informacion operando el 531 subcuenta 002'

   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901002','B5310501002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901002','B5310601002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5310901002','B5310701002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401002','B5311001002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401002','B5311101002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'B5311401002','B5311201002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'F5311501002','F5310901002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'F5311501002','F5311401002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101002','E5311601002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101002','F5311801002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5312101002','E5312001002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5312501002','A5312101002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101002','E5312601002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101002','E5312801002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'E5313101002','E5313001002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'A5313501002','A5313101002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313701002','C5311501002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313701002','C5312501002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313801002','C5311501002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'C5313801002','C5313501002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5313901002','D5313701002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5313901002','D5313601002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5314001002','D5313801002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'D5314001002','D5313601002' ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'T5313918999','T5310'       ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CARG458', 'T5314018999','T5310'       ,'INFORMACION 458 VS 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   print 'Parametrizacion Cuenta contable formato 531'

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_CC531')
      begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_CC531'
      end

   print 'Ingreso en el catalogo formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'EC_CC531','PARAMETRIZACION CUENTAS CONTABLES 531','V',NULL,NULL,NULL)

     if @@error <>0
      begin
            select @w_mensaje = '[15000]: ERROR EN INSERCION'
            goto FIN
      end

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_CC531')
      begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_CC531'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en equivalencias Cuentas contables'
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'A5310501002','ABAL+111510'    ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'B5310501001','ABAL+11'        ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'B5310501001','BBAL-111510'    ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','ABAL+1'         ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','BAL+110520900' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','BBAL+111510'    ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','BBAL+161695210' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','CBAL+2'         ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-243505050' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-250225005' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195921' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195922' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195927' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195929' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195930' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-251195931' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-275000901' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-275000902' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-281900921' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-281900922' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-281900923' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','DBAL-281900928' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'C5310301001','EBAL/1'         ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','ABAL+110520900' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','ABAL+111510'    ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','ABAL+161695210' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-243505050' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-250225005' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195921' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195922' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195927' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195929' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195930' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-251195931' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-275000901' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-275000902' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-281900921' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-281900922' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-281900923' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','CBAL-281900928' ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'D5310301002','DBAL/1'         ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end

   insert into cob_conta_super..sb_equivalencias values ('EC_CC531', 'F5311301001','FBAL+1302'     ,'PARAMETRIZACION CUENTAS CONTABLES 531','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end


   print 'Parametrizacion tipo dato columna'

   if exists(select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_TIPDATO')
      begin
      delete cobis..cl_catalogo where tabla = @w_tabla and codigo = 'EC_TIPDATO'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en el catalogo formato 531'

   insert into cobis..cl_catalogo
   values
   (@w_tabla,'EC_TIPDATO','PARAMETRIZACION TIPOS DE DATO FORMATO','V',NULL,NULL,NULL)

     if @@error <>0
      begin
            select @w_mensaje = '[15000]: ERROR EN INSERCION'
            goto FIN
      end

   if exists(select 1 from cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_TIPDATO')
      begin
      delete cob_conta_super..sb_equivalencias where eq_catalogo = 'EC_TIPDATO'
      end

     if @@error <>0
      begin
            select @w_mensaje = '[15004]: ERROR EN LA ELIMINACION'
            goto FIN
      end

   print 'Ingreso en equivalencias para el tipo de dato de las celdas del formato Mensual'

   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288570301001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288570301002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288570801001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288570801002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288571101001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288571101002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288571301001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288571301002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288573601001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A288573601002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')   if @@error <>0   begin      select @w_mensaje = '[15000]: ERROR EN INSERCION'      goto FIN   end
   
     print 'Ingreso en equivalencias para el tipo de dato de las celdas del formato Semanal'

   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285200301001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285200301002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285200801001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285200801002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285201101001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285201101002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285201301001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285201301002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285203601001' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end
   insert into cob_conta_super..sb_equivalencias values ('EC_TIPDATO', 'A285203601002' ,'6' ,'PARAMETRIZACION TIPOS DE DATO FORMATO','V')
   if @@error <>0
   begin
      select @w_mensaje = '[15000]: ERROR EN INSERCION'
      goto FIN
   end


   end

FIN:

go
