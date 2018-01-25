/************************************************************************/
/*  Archivo:                         ecforma_cel531.sp                  */
/*  Stored procedure:                sp_formato_celdas_531              */
/*  Base de datos:                   cob_conta_super                    */
/*  Producto:                        REC                                */
/*  Fecha de escritura:              08.11.17                           */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP",                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Ingresar valores de cero a celdas del formato 531                   */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  08.11.17             Ana Viera            Emision inicial           */
/************************************************************************/
use cob_conta_super
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_formato_celdas_531')
   drop proc sp_formato_celdas_531
go

create proc sp_formato_celdas_531(
   @i_param1        int      = null, --Empresa
   @i_param2        datetime = null, --Fecha de Proceso
   @i_param3        char(1)  = null, --Opcion F: Formatos
   @i_param4        int      = null, --Formato
   @i_param5        char(1)  = 'S' , --Generacion Archivo PLano de Parametrizaciones
   @i_param6        char(1)  = null  --Periodicidad
)
as
   declare
   @w_empresa               int,
   @w_fecha_ingreso         datetime,
   @w_opcion                char(1),
   @w_fto_ingreso           int,
   @w_gen_plano_par         char(1),
   @w_periodicidad          char(1),
   @w_sp_name               varchar(50),
   @w_factor                float,
   @w_fila_001              int,
   @w_fila_002              int,
   @w_saldo                 money,
   @w_periodo               int,
   @w_proceso               int,
   @w_corte                 int,
   @w_columna               int,
   @w_fila                  int,
   @w_return                int,
   @w_mensaje               varchar(250),
   @w_error                 int,
   @w_valor                 float,
   @w_curfil                int

   select
   @w_empresa       = @i_param1,
   @w_fecha_ingreso = @i_param2,
   @w_opcion        = @i_param3,
   @w_fto_ingreso   = @i_param4,
   @w_gen_plano_par = @i_param5,
   @w_periodicidad  = @i_param6,
   @w_sp_name       = 'sp_formato_celdas_531',
   @w_factor        = 0.05,
   @w_saldo         = 0


   select @w_periodo  = co_periodo,
          @w_corte    = co_corte
   from  cob_conta..cb_corte
   where co_fecha_ini = @w_fecha_ingreso
   and   co_empresa   = @w_empresa

   select @w_proceso = cr_proceso
   from   cob_conta_super..sb_configurar_reportes
   where  cr_formato = @w_fto_ingreso
   and    cr_estado  = 'V'
   and   (cr_periodicidad = @w_periodicidad or cr_periodicidad is null)


----------------------------------------------------------------------------------------------
------------------------------INGRESO DE VALORES 0 EN LAS COLUMNAS----------------------------
----------------------------------------------------------------------------------------------

   begin tran

   -- Busca celdas definidas que reportan cero --
   declare cursor_celdas    cursor for
   select ts_columna, ts_fila
   from cob_conta_super..sb_tipo_saldo
   where ts_proceso = @w_proceso
   and ts_empresa = @w_empresa
   and ts_reporta_cero = 'S'
   for read only

   open  cursor_celdas
   fetch cursor_celdas
   into  @w_columna, @w_fila

   while (@@fetch_status = 0)
   begin

         if ( @w_periodicidad='E' and (@w_columna < 28 or @w_columna in (38 , 39 , 41 )))
         begin

            delete from cob_conta_super..sb_hist_saldo where hs_proceso = @w_proceso and hs_periodo = @w_periodo and hs_corte = @w_corte and hs_columna = @w_columna and hs_fila = @w_fila

            exec @w_return=cob_conta_super..sp_ingresa_saldo_531
                @i_empresa    =   @w_empresa,
                @i_periodo    =   @w_periodo,
                @i_corte      =   @w_corte,
                @i_proceso    =   @w_proceso,
                @i_fila       =   @w_fila ,
                @i_columna    =   @w_columna,
                @i_saldo      =   @w_saldo,
                @i_fecha_proc =   @w_fecha_ingreso

            if @w_return<>0
            begin
              select @w_error   = 360040,
              @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO'
              rollback tran
              goto ERRORFIN
            end
         end

         if ( @w_periodicidad='M' and (@w_columna < 18 or @w_columna between 28 and 38 or @w_columna in (40 , 42)))
         begin

            delete from cob_conta_super..sb_hist_saldo where hs_proceso = @w_proceso and hs_periodo = @w_periodo and hs_corte = @w_corte and hs_columna = @w_columna and hs_fila = @w_fila

            exec @w_return=cob_conta_super..sp_ingresa_saldo_531
                @i_empresa    =   @w_empresa,
                @i_periodo    =   @w_periodo,
                @i_corte      =   @w_corte,
                @i_proceso    =   @w_proceso,
                @i_fila       =   @w_fila ,
                @i_columna    =   @w_columna,
                @i_saldo      =   @w_saldo,
                @i_fecha_proc =   @w_fecha_ingreso


            if @w_return<>0
            begin
              select @w_error   = 360040,
              @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO'
              rollback tran
              goto ERRORFIN
            end
         end

      if @w_return<>0
      begin
        select @w_error   = 360040,
        @w_mensaje  = 'ERROR INSERTANDO DATOS EN SB_HIST_SALDO'
        goto ERRORFIN
      end

      fetch cursor_celdas
      into  @w_columna, @w_fila
   end
   close cursor_celdas
   deallocate cursor_celdas

   commit tran

----------------------------------------------------------------------------------------------
------------------ELIMINACION DE REGISTROS CUANDO NO CUMPLE CON EL VALOR----------------------
----------------------------------------------------------------------------------------------

   declare cursor_del_531 cursor for
      select distinct hs_fila
      from cob_conta_super..sb_hist_saldo
      where hs_proceso = @w_proceso
      and   hs_periodo = @w_periodo
      and   hs_corte   = @w_corte
      and   hs_fila    > '2'
   for read only

   open  cursor_del_531
   fetch cursor_del_531
   into  @w_curfil

   while (@@fetch_status = 0)
   begin

      select @w_valor = convert(float,isnull(hs_saldo,0))
      from cob_conta_super..sb_hist_saldo
      where hs_proceso = @w_proceso
      and   hs_fila    = @w_curfil
      and   hs_periodo = @w_periodo
      and   hs_corte   = @w_corte
      and   hs_columna = 5

      if @w_valor < @w_factor
      begin
         delete from cob_conta_super..sb_hist_saldo
         where hs_fila    = @w_curfil
         and   hs_proceso = @w_proceso
         and   hs_periodo = @w_periodo
         and   hs_corte   = @w_corte
         and   hs_columna <> 5

         if @@error <>0
         begin
            select @w_error   = 150004,
                   @w_mensaje = 'ERROR ELIMINANDO REGISTROS EN SB_HIST_SALDO'
            goto ERRORFIN
         end
      end

   fetch cursor_del_531
   into  @w_curfil
   end

   close cursor_del_531
   deallocate cursor_del_531

   ------------------------------------------------------------


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
