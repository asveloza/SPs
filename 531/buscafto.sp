/******************************************************************/
/*Archivo:            buscafto.sp                                 */
/*Stored procedure:   sp_busca_formato                            */
/*Base de datos:      cob_conta                                   */
/*Producto:           contabilidad                                */
/*Disenado por:                                                   */
/*Fecha de escritura:  3-Agosto-1993                              */
/******************************************************************/
/*                     IMPORTANTE                                 */
/*Este programa es parte de los paquetes bancarios propiedad de   */
/*"COBISCORP", representantes exclusivos para el Ecuador de la    */
/*"NCR CORPORATION".                                              */
/*Su uso no autorizado queda expresamente prohibido asi como      */
/*cualquier alteracion o agregado hecho por alguno de sus         */
/*usuarios sin el debido consentimiento por escrito de la         */
/*Presidencia Ejecutiva de COBISCORP o su representante.          */
/******************************************************************/
/*                       PROPOSITO                                */
/*Este programa extrae información para ser presentada en la      */
/*pantalla del estandar 003 SFC                                   */
/******************************************************************/
/*                    MODIFICACIONES                              */
/*  FECHA       AUTOR           RAZON                             */
/*24/11/2017    Rodrigo Prada   FORMATO 531 - Decimales X columna */
/******************************************************************/
use cob_conta_super
go
 
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'sp_busca_formato')
drop proc sp_busca_formato

go

create procedure sp_busca_formato(
	@s_ssn		    int = NULL,
	@s_user		    login = NULL,
	@s_sesn		    int = NULL,
	@s_term		    varchar(30) = NULL,
	@s_date		    datetime = NULL,
	@s_srv		    varchar(30) = NULL,
	@s_lsrv		    varchar(30) = NULL, 
	@s_rol		    smallint = NULL,
	@s_ofi		    smallint =  NULL,
	@s_org_err	    char(1) = NULL,
	@s_error	    int = NULL,
	@s_sev		    tinyint = NULL,
	@s_msg		    descripcion = NULL,
	@s_org		    char(1) = NULL,
	@t_trn          int = NULL,
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = NULL,
	@i_proceso	    int = 28590,
	@i_operacion	char(1) = NULL,
	@i_periodo	    smallint = NULL,
	@i_corte	    smallint = NULL,
	@i_empresa	    int = NULL,
	@i_modo	        int = NULL,
	@i_siguiente    int = NULL,
    @o_resultado    int =null  output
	)

as
declare  @w_sp_name 	    varchar(32),
	     @w_descripcion 	varchar(300),
	     @w_cadena          nvarchar(3000),
		 @w_comando         varchar(8000),
		 @w_alias       	varchar(600),
	     @w_filas           smallint,
		 @w_columnas        smallint,
		 @w_contador        smallint,
		 @w_tabla           varchar(200),
		 @w_colmin          int,
		 @w_num_col         int,
		 @w_num_pre         int,
		 @w_campos          varchar(8000),
		 @w_columna         varchar(8000),
		 @w_decimal         varchar(5)

select  @w_sp_name  = 'sp_busca_formato'

if not (@t_trn = 28850 and @i_operacion in ('S','P','C')  )
   

begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num = 2805023
        return 1
end

if @i_operacion = 'C'
begin
      select co_descripcion from cob_conta_super..sb_columnas where  co_proceso=@i_proceso  order by co_num_columna
 
	  select @w_tabla='sb_tmp_formato_' + convert(varchar,@i_proceso)+'_' + convert(varchar,@i_periodo) +'_' + convert(varchar,@i_corte)++'_' + convert(varchar,@i_empresa)
      select @w_cadena='select top 1 1 from sysobjects where type ='+ '''' + 'U' + ''''+ ' and name = ' + ''''+ @w_tabla +''''
      exec sp_executesql @w_cadena
      if @@RowCount  > 0
      begin	
	     select @w_cadena='drop table ' + @w_tabla 
	     execute( @w_cadena)
      end  
     
end  
if @i_operacion = 'P'
begin
  
      select @w_colmin   = min(co_num_columna)-1
      from   cob_conta_super..sb_columnas
      where  co_proceso  = @i_proceso
      and    co_tipo_col = '03'

      select co_proceso, co_num_columna,co_descripcion
	  into #tmp_columnas 
      from   sb_columnas  where co_proceso =@i_proceso
	  order by co_num_columna

	  select  
	  substring(eq_valor_cat,2,5)               as eq_proceso, 
	  substring(eq_valor_cat,7,2) + @w_colmin   as eq_columna,
	  substring(eq_valor_cat,9,2)               as eq_uc,
	  substring(eq_valor_cat,11,3)              as eq_subcta,
	  eq_valor_arch                             as eq_decimal
	  into #tmp_tipodato
	  from cob_conta_super..sb_equivalencias 
	  where eq_catalogo = 'EC_TIPDATO' 
	  and   substring(eq_valor_cat,2,5) = @i_proceso

      select @w_tabla='sb_tmp_formato_' + convert(varchar,@i_proceso)+'_' + convert(varchar,@i_periodo) +'_' + convert(varchar,@i_corte)++'_' + convert(varchar,@i_empresa)
      select @w_cadena='select top 1 1 from sysobjects where type ='+ '''' + 'U' + ''''+ ' and name = ' + ''''+ @w_tabla +''''
     
	  exec sp_executesql @w_cadena
   
      if @@RowCount  > 0
      begin	
	     select @w_cadena='drop table ' + @w_tabla 
	 	 execute( @w_cadena)
      end  
      select @w_cadena=''
   
      select @w_comando =' create table cob_conta_super..' + @w_tabla +'( fila  smallint null,'	 
      select @w_campos=''
      declare cursor_columna cursor for
         select distinct co_num_columna,co_descripcion, isnull(eq_decimal,2)
         from   #tmp_columnas left join #tmp_tipodato 
	     on    co_proceso     = eq_proceso
	     and   co_num_columna = eq_columna
		 and   co_proceso     = @i_proceso
      order by co_num_columna
      for read only
      open  cursor_columna  
      fetch cursor_columna  
      into  @w_num_col, @w_descripcion, @w_decimal

      while (@@fetch_status = 0)
      begin
      
	  select @w_descripcion='COLUMNA' + '_'+ convert(varchar,@w_num_col)
	     if @w_campos=''
		    select @w_campos=@w_descripcion+','
         else
		    select @w_campos=@w_campos + @w_descripcion+','
	     select @w_comando=@w_comando + @w_descripcion + ' varchar (200) null ,' 
         fetch cursor_columna  
         into  @w_num_col,@w_descripcion, @w_decimal 
      end 
      close cursor_columna 
 
      select @w_comando= substring (@w_comando,1,len(@w_comando)-1) + ')'
      select @w_campos= substring (@w_campos,1,len(@w_campos)-1)
	  
	  execute(@w_comando)  
     
      select @w_filas=max(fi_num_fila) from  sb_filas  where fi_proceso=@i_proceso
      select @w_columnas=max(co_num_columna) from  sb_columnas  where co_proceso=@i_proceso
      select  @w_contador
      select @w_cadena='insert into cob_conta_super..' + @w_tabla + ' (fila)  select fi_num_fila from cob_conta_super..sb_filas  where fi_proceso=' + convert(varchar,@i_proceso) + ' and fi_num_col=1'
      execute( @w_cadena)
      select @w_contador=1
      
      open  cursor_columna  
      fetch cursor_columna  
      into @w_num_col,@w_descripcion, @w_decimal   
      while (@@fetch_status = 0)
      begin
     	 select @w_descripcion='COLUMNA' + '_'+ convert(varchar,@w_num_col)
		 if exists (select top 1 * from cob_conta_super..sb_filas where  fi_proceso=@i_proceso and fi_num_col=@w_contador)   
            select @w_cadena 	='update  cob_conta_super..' + @w_tabla + ' set ' + @w_descripcion + '=fi_descripcion  from cob_conta_super..sb_filas  where fila=fi_num_fila and  fi_num_col=' + convert(VARCHAR, @w_contador) +  ' and fi_proceso=' +convert(varchar,@i_proceso)
	     else
	         if exists (select top 1 * from cob_conta_super..sb_hist_saldo where  hs_proceso=@i_proceso and hs_periodo=@i_periodo and hs_corte=@i_corte and hs_columna=@w_contador)   
         		select @w_cadena 	='update  cob_conta_super..' + @w_tabla + ' set ' + @w_descripcion + '=CONVERT(varchar, convert(decimal(20,'+@w_decimal+'), hs_saldo), 1)  from sb_hist_saldo  where hs_proceso= ' + convert(varchar,@i_proceso)+ ' and hs_periodo=' + convert(varchar,@i_periodo) + '  and hs_corte= ' + convert(varchar,@i_corte) + ' and hs_empresa=' + convert(varchar,@i_empresa) + ' and fila=hs_fila and  hs_columna=' + convert(VARCHAR, @w_contador)  
		 execute(@w_cadena)
		     
		 select @w_contador=@w_contador+1
         fetch cursor_columna  
         into @w_num_col,@w_descripcion, @w_decimal  
      end 
      close cursor_columna 
      deallocate cursor_columna 
    
      select @o_resultado =count(1) from cob_conta_super..sb_hist_saldo where  hs_proceso=@i_proceso and hs_periodo=@i_periodo  and hs_corte=@i_corte

end


if @i_operacion = 'S'
begin
   
   
   if @i_modo=0
   begin 
      select @w_campos=''
      declare cursor_columna cursor for
      select co_num_columna,co_descripcion 
      from   sb_columnas  where co_proceso =@i_proceso 
      order by co_num_columna
      for read only
      open  cursor_columna  
      fetch cursor_columna  
      into  @w_num_col,@w_descripcion  
      while (@@fetch_status = 0)
      begin
   
         if @w_num_col<=1
		    select @w_num_pre=0
		 else
		     select @w_num_pre=@w_num_col-2
		 select @w_descripcion='COLUMNA' + '_'+ convert(varchar,@w_num_col)

		 if @w_campos=''
		    select @w_campos=@w_descripcion+','
         else
		  select @w_campos=@w_campos + @w_descripcion+','
	     fetch cursor_columna  
         into  @w_num_col,@w_descripcion  
      end 
      close cursor_columna 
      deallocate cursor_columna 
      set rowcount 10
      select @w_tabla='sb_tmp_formato_' + convert(varchar,@i_proceso)+'_' + convert(varchar,@i_periodo) +'_' + convert(varchar,@i_corte)++'_' + convert(varchar,@i_empresa)
	  select @w_campos= substring (@w_campos,1,len(@w_campos)-1)
	  select @w_comando = 'select ' + @w_campos +  ' from '  + @w_tabla
	  
      execute( @w_comando)
      set rowcount 0
   end
   
   if @i_modo=1
   begin 
      
	  select @w_campos=''
      declare cursor_columna cursor for
      select co_num_columna,co_descripcion 
      from   sb_columnas  where co_proceso =@i_proceso 
      order by co_num_columna
      for read only
      open  cursor_columna  
      fetch cursor_columna  
      into  @w_num_col,@w_descripcion  
      while (@@fetch_status = 0)
      begin
        
	     select @w_descripcion =dbo.CaracteresEspeciales_dian(@w_descripcion )
	     if @w_num_col<=1
		    select @w_num_pre=0
		 else
		     select @w_num_pre=@w_num_col-2
		 select @w_descripcion='COLUMNA' + '_'+ convert(varchar,@w_num_col)
		 if @w_campos=''
		    select @w_campos=@w_descripcion+','
         else
		  select @w_campos=@w_campos + @w_descripcion+','
         fetch cursor_columna  
         into  @w_num_col,@w_descripcion  
      end 
      close cursor_columna 
      deallocate cursor_columna 
  
      set rowcount 10
      select @w_tabla='sb_tmp_formato_' + convert(varchar,@i_proceso)+'_' + convert(varchar,@i_periodo) +'_' + convert(varchar,@i_corte)++'_' + convert(varchar,@i_empresa)
	  select @w_campos= substring (@w_campos,1,len(@w_campos)-1)
	  select @w_comando = 'select ' + @w_campos +  ' from '  + @w_tabla
	  select @w_comando = @w_comando + ' where fila>' + convert(varchar,@i_siguiente)
	
	  execute( @w_comando)
      set rowcount 0
      end
   
  
end

go
