//Integrantes: Juani Croci, Lucas Rodriguez, Lucia Gelmetti, Tomás Schlotahuer

Program tp3inicio;
uses crt;

//ARCHIVO MAIN V.3 (DEFINITIVA) EDITADO ULTIMO POR: tomi
										//Fecha: 10/10 16:55 

Type
	   //CLIENTES
	   Clientes=record
	        DNI:string[15];
	        nombre:string[30];
	        mail:string[30];
	    end;
	   ArchivoClientes= file of Clientes;

		//CIUDADES
		Ciudades = record
			COD_ciudad : string [3];
			NombreCiudad : string [25];
			Contador: integer;
		end;
		
		//EMPRESAS
		Empresa = record
			CODEMP: string;
			CODCIU: string[3];
			Nombre: string[50];
			Direccion: string;
			Mail: string[50];
			Telefono: string[15];
			Contador: integer;
		end;
		ArchivoEmpresas= FILE of Empresa;

		aux= array [1..3] of string;

		//PROYECTOS
		Proyectos = record      
			COD_PROY: string;                
			COD_EMP: string;
	 		COD_ciudad: string [3];          
			Etapa: char;   //(P - O - T)
			Tipo: char;    //(C - D - O - L)
			Cantidades : array [1..4] of integer; 
		end;
		ArchivoProyectos= file of Proyectos;

		//PRODUCTOS
		Productos = record      
			COD_Proyecto : string;                
			COD_Producto : string;
	 		Precio : string;          
			Estado : char;   //(Vendido S/N)
			Detalle : String[50];  // (casa, depto, oficina, loteos)  	
		end;

Var
	C: ArchivoClientes;
	Cl: Clientes;

	Py: ArchivoProyectos;
	Pys: Proyectos;

  	ArchivoProducto : file of Productos;
  	CargaProducto : Productos; 

	ax: aux;
	E: ArchivoEmpresas;
	Emp: Empresa;	

	ArchivoCiudad: file of Ciudades;
	CargaCiudad: Ciudades;

	MENU: String[3];
	op: integer;
	//contador: array [0..3] of integer;
	option, mez:char;
	optao: string;
	x, y, acceso,i,op1:integer;

//----------------------------------CERRAR/ABRIR ARCHIVOS------------------------------------------//
	Procedure CERRAR();
		begin
		  close(ArchivoCiudad);
		  close(E);
		  close(ArchivoProducto);
	       close(Py);
		  close(C);
		end;

	Procedure ABRIR();
		begin 
			assign(ArchivoCiudad, 'C:\TP3\CIUDADES.dat'); 
			assign(E, 'C:\TP3\EMPRESAS-CONSTRUCTORAS.dat');
			assign(ArchivoProducto, 'C:\TP3\PRODUCTOS.dat');
			assign(Py, 'C:\TP3\PROYECTOS.dat');
			assign(C, 'C:\TP3\CLIENTES.dat');

			{$I-}
			reset(ArchivoCiudad);
			If ioresult=2 then rewrite(ArchivoCiudad); 
			reset(E);
			If ioresult=2 then rewrite(E);
			reset(ArchivoProducto);
			If ioresult=2 then rewrite(ArchivoProducto);
			reset(Py);
			If ioresult=2 then rewrite(Py);
			reset(C);
			If ioresult=2 then rewrite(C);
			{$I+}

			{reset(Py);
		 	seek(Py,0);
		 	Pys.COD_PROY:= '44035156';
		 	Cl.nombre:= 'Schlotahuer Tomás';
		 	Cl.mail:= 'tomss@hola.com';
		 	write(C,Cl);}

			{reset(C);
		 	seek(C,0);
		 	Cl.DNI:= '44035156';
		 	Cl.nombre:= 'Schlotahuer Tomás';
		 	Cl.mail:= 'tomss@hola.com';
		 	write(C,Cl);}

		end;

//------------------------------------ESTADISTICAS--------------------------------------------------//

//------------------------- FUNCION VALIDAR EMPRESAS Y PROYECTOS -----------------------------------//

	function ValidarE(ax:aux): Integer;											//Si es igual vale 1, sino vale 0.
		var
		inf,sup,medio: Integer;
		begin
			ValidarE:=0;
			case ax[2] of
				'1': begin reset (ArchivoCiudad);									// Si ax[2]=1, compara dicotómicamente el array ax[1] con el codigo de ciudad de Ciudades.
						inf:= 0;
						sup:= fileSize(ArchivoCiudad)-1;
						while (inf<=sup) and (ValidarE=0) do
						begin
							medio:=(inf+sup) div 2;
							seek (ArchivoCiudad, medio);
							read (ArchivoCiudad,CargaCiudad);
							writeln('Está acá: ', CargaCiudad.COD_ciudad);
							delay(100);
							if ax[1]=CargaCiudad.COD_ciudad then ValidarE:=1
							else if ax[1]<CargaCiudad.COD_ciudad then sup:=medio-1
							else inf:=medio+1;
						end;
						writeln('Termino acá: ', CargaCiudad.COD_ciudad);
						readkey();
					 end;
				'2': begin 															//Si ax[2]=2, compara secuencialmente si el archivo se encuentra en Emp.CODEMP
					  Reset(E);
					  repeat
					 	 read(E,Emp);
					  Until eof(E) or (ax[1] = Emp.CODEMP);
					  if (ax[1]=Emp.CODEMP) then ValidarE:=1
					  else ValidarE:=0;  
					 end;
				'3': begin 
					  Reset(E);
					  repeat
					 	 read(E,Emp);
					  Until eof(E) or (ax[1] = Emp.Nombre);
					  if (ax[1]=Emp.Nombre) then ValidarE:=1
					  else ValidarE:=0;  
					 end;
				'4': begin 
					  Reset(E);
					  repeat
					 	 read(E,Emp);
					  Until eof(E) or (ax[1] = Emp.Direccion);
					  if (ax[1]=Emp.Direccion) then ValidarE:=1
					  else ValidarE:=0;  
					 end;
				'5': begin 
					  Reset(E);
					  repeat
					 	 read(E,Emp);
					  Until eof(E) or (ax[1] = Emp.Mail);
					  if (ax[1]=Emp.Mail) then ValidarE:=1
					  else ValidarE:=0;  
					 end;
				'6': begin 
					  Reset(E);
					  repeat
					 	 read(E,Emp);
					  Until eof(E) or (ax[1] = Emp.Telefono);
					  if (ax[1]=Emp.Telefono) then ValidarE:=1
					  else ValidarE:=0;  
					 end;
			end;
		end;

	function ValidarP(ax:aux): Integer;											//Si es igual vale 1, sino vale 0.
		begin
			ValidarP:=0;
			case ax[2] of
				'1':begin 														//Si ax[2] es '1' compara Pys.COD_PROY con el array ax[1]
						  Reset(Py);
						  repeat
						 		read(Py,Pys);
						  Until eof(Py) or (ax[1] = Pys.COD_PROY);
						  if (ax[1]=Pys.COD_PROY) then ValidarP:=1
						  else ValidarP:=0;  
					 end; 							
			end;
		end;

//-----------------------------------CIUDADES-------------------------------------------------------//

	Procedure MuestraCiudades();
		var 
			h:integer;
		begin
			clrscr;
			h:=0;
			reset(ArchivoCiudad);
			for i:= 0 to filesize(ArchivoCiudad) -1 do 
			 begin
			  Read (ArchivoCiudad, CargaCiudad);
			  writeln('Puesto nr: ',h);
			  writeln('Codigo ciudad: ',CargaCiudad.COD_ciudad);
			  writeln('Nombre ciudad: ',CargaCiudad.NombreCiudad);
			  h:=h+1;
			 end;
			readKey();
		end;

	Procedure OrdenarCiudades();
		var
			i,j:integer;
			A,B:Ciudades;
		begin
		  Reset(ArchivoCiudad);
		  For i := 0 to filesize(ArchivoCiudad)-2 do 
		  	For j := i+1 to filesize(ArchivoCiudad) -1 do 
  				seek (ArchivoCiudad,i);
  				read(ArchivoCiudad,A);
  				seek (ArchivoCiudad,j);
  				read(ArchivoCiudad,B);
  				if (A.COD_ciudad) > (B.COD_ciudad) THEN
  				 begin
			 		seek (ArchivoCiudad,i);
			 		Write (ArchivoCiudad,B);
			 		seek (ArchivoCiudad,j);
			 		write (ArchivoCiudad,A);
  				 end;
		  	end; 

	Procedure VerificarCiudades();
		Var 
			op1:integer;
		begin
			Reset(ArchivoCiudad);
		repeat
			if ValidarE(ax)=1 then begin
						textcolor(red); 
			 		  writeln('Codigo ya existente' );	
			 		  textcolor(lightblue); 
			 		  readkey();
			 		  op1:=0;
			 	   end
			   else
			 	   begin
			      	seek (ArchivoCiudad, filesize(ArchivoCiudad));
			 		CargaCiudad.COD_ciudad:= ax[1];
			 		writeln ('Ingrese el nombre de la ciudad: ');												
					readln (CargaCiudad.NombreCiudad);
					CargaCiudad.Contador:=0;
					write(ArchivoCiudad,CargaCiudad);
					op1:=0;
			 	   end;
	 	until op1=0;
		end;

	Procedure CargarCiudades();
		var
			op1: integer;
		Begin
		  clrscr; 
		  seek(ArchivoCiudad,filesize(ArchivoCiudad));
			repeat
			   repeat
			  	ClrScr;
			  	writeln('[Alta de ciudades]');
			  	writeln('');
			   	writeln('Ingrese el codigo ');
					Readln(ax[1]);
		     until (ax[1]>='A') and (ax[1]<='Z') and (length(ax[1])<=3);
		        ax[2]:='1';
		    		VerificarCiudades();
		    		OrdenarCiudades();
		    		repeat
			    	   ClrScr;
			    	   writeln('<0> Salir'); 
			    	   writeln('<1> Mostrar Ciudades ya cargadas y salir');
			    	   writeln('<2> Cargar otro codigo');
				   readln(op1);
				until ((op1=1) or (op1=0) or (op1=2));
				if op1=1 then
				  begin
				   MuestraCiudades();
				   op1:=0;
				  end;
		     until op1=0;
		end;

	procedure CargarNormal(); //Por primera vez(opcion 1, dsps lo quitamos)
		begin
		 	Reset(E);
	    		reset(Py);
	    		Reset(ArchivoProducto);
	      	seek(E,filesize(E));
	          seek(ArchivoCiudad,filesize(ArchivoCiudad));
	          seek(Py,filesize(Py));
	          seek(ArchivoProducto,filesize(ArchivoProducto));
	          writeln ('CODIGO CIUDAD');
	     	readln (CargaCiudad.COD_ciudad);                   
	     	writeln ('NOMBRE CIUDAD');                                                             
		     readln (CargaCiudad.NombreCiudad); 
		     writeln('CODIGO EMPRESA');     
		     readln(emp.CODCIU);            
		     writeln('CODIGO PROYECTO');    
		     readln(Pys.COD_PROY);  
		     writeln('CODIGO PRODUCTO');
		     readln(CargaProducto.COD_Producto);
		     Write(ArchivoCiudad,CargaCiudad);
		     write(Py,Pys); 
		     write(ArchivoProducto,CargaProducto); 
		     write(E,Emp);
		     writeln(); 
	          readKey();
		end;

	Procedure AltaCiudad();  // MENU para control(dsps lo quitamos)
	  var
		op1:char;
	  Begin
		   repeat
		    ClrScr();
		    writeln('MENU Ciudades:'+#13+#10+'1. Cargar (por primera vez) '+#13+#10+'2. Alta Ciudades controlado '+#13+#10+'0. Volver');
		    repeat
			op1 := readKey();
		    until ((op1 = '1') or (op1 = '2')  or (op1 = '0'));
	  	    case op1 of
		    	 '1': CargarNormal();
		    	 '2': CargarCiudades();       
		    end; 
		   until (op1='0');
	  end;

	procedure ACIU();
		begin
			repeat
				textcolor(red); 
				writeln('');
				writeln('El codigo de ciudad ingresado no existe');
				writeln('Presione <2> para ver la lista de ciudades registradas');
				writeln('Presione <1> para registrar una nueva ciudad');
				writeln('Presione <0> para volver a ingresar un codigo nuevamente');
				mez:=readkey();
				textcolor(lightblue); 
			until (mez='1') or (mez='0') or (mez='2'); 
			if mez='1' then begin 
			CargarCiudades();
			end
			else if mez='2' then MuestraCiudades(); 
		end;

//-----------------------------------EMPRESAS--------------------------------------------------------//

	Procedure MostrarEmpresas();
		var 
			h:integer;
		begin
			clrscr;
			h:=0;
				 reset(E);
					for i:= 0 to filesize(E) -1 do 
					  Read (E, Emp);
					  writeln('Puesto nr: ',h);
					  writeln('Codigo Ciudad: ',Emp.CODCIU);
					  writeln('Codigo Empresa: ',Emp.CODEMP);
					  h:=h+1;
		end;

	Procedure AltaEmpresa();
		var
			M: Empresa;

		begin
			MENU:='NO';
			reset(E);
		repeat
			op1:=1;
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese el c', #243,'digo de la ciudad');					
				readln(ax[1]);
				ax[2]:='1';
				if ValidarE(ax)=0 then begin
					ACIU();
					end
				else begin 
				op1:=0;
				readKey();
				end;
			until op1=0;
			op1:=1;
			M.CODCIU:= ax[1];
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese el c', #243,'digo de la empresa.');
				readln(ax[1]);
				ax[2]:='2';
				if ValidarE(ax)=0 then op1:=0
				else begin
				textcolor(red); 
				writeln ('El código ingresado esta repetido');
				readKey();
				textcolor(lightblue); 
				end;
			until op1=0;
			op1:=1;
			M.CODEMP:= ax[1];
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese el nombre de la empresa.');
				readln(ax[1]);
				ax[2]:='3';
				if ValidarE(ax)=0 then op1:=0
				else begin 
				textcolor(red); 
				writeln ('El nombre ingresado esta repetido');
				textcolor(lightblue); 
				readKey();
				end;
			until op1=0;
			op1:=1;
			M.Nombre:= ax[1];
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese la direcci', #243,'n de la empresa.');
				readln(ax[1]);
				ax[2]:='4';
				if ValidarE(ax)=0 then op1:=0
				else begin 
				textcolor(red); 
				writeln ('La direccion ingresada esta repetida');
				readKey();
				textcolor(lightblue); 
				end;
			until op1=0;
			op1:=1;
			M.Direccion:= ax[1];
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese el mail de la empresa.');
				readln(ax[1]);
				ax[2]:='5';
				if ValidarE(ax)=0 then op1:=0
				else begin 
				textcolor(red);  
				writeln ('El mail ingresado esta repetido');
				readKey();
				textcolor(lightblue); 
				end;
			until op1=0;
			op1:=1;
			M.Mail:= ax[1];
			repeat
				ClrScr;
				writeln('[Alta de EMPRESAS]');
			  writeln('');
				writeln('Ingrese el tel', #233,'fono de la empresa.');
				readln(ax[1]);
				ax[2]:='6';
				if ValidarE(ax)=0 then op1:=0
				else begin
				textcolor(red);  
				writeln ('El telefono ingresado esta repetido');
				readKey();
				textcolor(lightblue); 
				end;
			until op1=0;
			op1:=1;
			M.Telefono:= ax[1];
			M.Contador:= 0;
			seek(E,filesize(E));
			write(E,M);

			writeln('¿Desea ver las Empresas Ingresadas? <1>SI - <0>NO ');
			repeat
				readln(op1);
			until (op1=0) or (op1=1);
			if op1=1 then
			 begin MostrarEmpresas();
			  readKey();
			   end
			else op1:=0;
					  begin
					   op1:=0;
					   readKey();
					  end;
			repeat
				ClrScr;
				writeln('¿Desea ingresar nuevamente una Empresa?');
				writeln('<1>SI - <0>NO');
				readln(MENU);
			until ((MENU='1') or (MENU='0'));
		until MENU='0';
		end;

	Procedure AEMP();
		begin
			repeat
				textcolor(red); 
				writeln('');
				writeln('El codigo de empresa ingresado no existe');
				writeln('Presione <1> para registrar una nueva ciudad');
				writeln('Presione <0> para volver a ingresar un codigo nuevamente');
				mez:=readkey();
				textcolor(lightblue); 
			until (mez='1') or (mez='0'); 
			if mez='1' then AltaEmpresa(); 
		end;

//-----------------------------------PROYECTOS--------------------------------------------------------//

	Procedure AltaProyecto();
			var
				p: Proyectos;
			begin
				reset(Py);
				op1:=1;
				op:=0;

				repeat
					repeat 																		//Código de proyecto
						ClrScr;
						writeln('[Alta de PROYECTOS]');
			 			writeln('');
						writeln('Ingrese el c', #243,'digo del proyecto');
						readln(ax[1]);
						ax[2]:='1';
						if ValidarP(ax)=0 then op1:=0
						else begin
						textcolor(red); 
						writeln ('El codigo ingresado esta repetido');
						textcolor(blue);
						readKey(); 
						end;         													
					until op1=0; 
					P.COD_PROY:= ax[1];
					op1:=1;

					repeat 																		//Código de ciudad
						ClrScr;
						writeln('[Alta de PROYECTOS]');
			 			writeln('');
						writeln('Ingrese el c', #243,'digo de ciudad');
						readln(ax[1]);
						ax[2]:='1';
						if ValidarE(ax)=1 then op1:=0
						else ACIU();
					until op1=0;

					repeat   																	//Código de empresa
						ClrScr;
						writeln('[Alta de PROYECTOS]');
			 			writeln('');
						writeln('Ingrese el c', #243,'digo de empresa');
						readln(ax[1]);
						ax[2]:='2';
						if ValidarE(ax)=1 then op1:=0
						else AEMP();
					until op1=0;
					P.COD_EMP:= ax[1];

					repeat 																		//Etapa
						ClrScr;
						writeln('[Alta de PROYECTOS]');
			 			writeln('');
						writeln('Ingrese la etapa del proyecto');
						writeln('[P] Preventa');
						writeln('[O] Obra');
						writeln('[T] Terminado');
						readln(P.Etapa);
					until ((P.Etapa='P') or (P.Etapa='T') or (P.Etapa='O')); 

					repeat 																		//Tipo
						ClrScr;
						writeln('[Alta de PROYECTOS]');
			 			writeln('');
						writeln('Ingrese el tipo de proyecto');
						writeln('[C] Casa');
						writeln('[D] Edifcio Departamento');
						writeln('[O] Edificio Oficina');
						writeln('[L] Loteos');
						readln(P.Tipo);
					until ((P.Tipo='C') or (P.Tipo='D') or (P.Tipo='O') or (P.Tipo='L')); 

		 																		//Cantidad de productos
					ClrScr;
					writeln('[Alta de PROYECTOS]');
		 			writeln('');
					writeln('Cantidad máxima de productos que pueden entrar en el proyecto:');
					readln(P.Cantidades[1]);
					op1:=1;

					P.COD_ciudad:= ax[1];
					P.Cantidades[2]:= 0;
					P.Cantidades[3]:= 0;
					P.Cantidades[4]:= 0;
					seek(Py,filesize(Py));
					write(Py,P);

					repeat
						ClrScr;
						writeln('¿Desea ingresar nuevamente un proyecto?');
						textcolor(red); 
						writeln('<1> SI / <0> NO');
						textcolor(lightblue); 
						readln(MENU);
					until ((MENU='1') or (MENU='0'));
					if MENU='0' then op:=1
				until op=1;
			end;

	procedure APROY();
		begin
			repeat
				textcolor(red); 
				writeln('');
				writeln('El codigo de proyecto ingresado no existe');
				writeln('Presione <1> para registrar una nueva ciudad');
				writeln('Presione <0> para volver a ingresar un codigo nuevamente');
				textcolor(lightblue); 
				mez:=readkey();
			until (mez='1') or (mez='0'); 
			if mez='1' then AltaProyecto(); 
		end;

//-----------------------------------PRODUCTOS------------------------------------------------------//

	Procedure ProductoCantidad();
		begin                      
			Pys.Cantidades[4]:= Pys.Cantidades[4]+1;
			If Pys.Cantidades[4]>Pys.Cantidades[1] then begin
			textcolor(red);
			writeln('Cantidad de productos maxima de productos en el proyecto alcanzado');
			textcolor(lightblue);
			end
			else x:=1; 
		end;

	Procedure MuestraProductos();
		var 
		h:integer;
		begin
		clrscr;
		h:=0;
	     reset(ArchivoProducto);
		for i:= 0 to filesize(ArchivoProducto) -1 do 
		 begin
		  Read (ArchivoProducto, CargaProducto);
		  writeln('Puesto nr: ',h);
		  writeln('Codigo PRODUCTO: ',CargaProducto.COD_Producto);
		  writeln('Codigo PROYECTO: ',CargaProducto.COD_Proyecto);
		  writeln('Precio: ',CargaProducto.Precio);
		  writeln('Estado: ',CargaProducto.Estado);
		  writeln('Detalle: ',CargaProducto.Detalle);
		  h:=h+1;
		 end;
		end;

	Procedure VerificarProductos();
		Var 
			op1:integer;
			PROD: Productos;
		begin
			x:=0;
			Reset(ArchivoProducto);
		repeat
		   repeat
		 	  read(ArchivoProducto,PROD);
		   Until eof(ArchivoProducto) or (ax[1] = PROD.COD_Producto);	
		   If (ax[1] = PROD.COD_Producto) then
		 	   begin
		 		  writeln('Codigo ya existente, ingrese <0> para salir: ' );	
		 		  Repeat	
		 		  	readln(op1);
		 		  until op1=0;
		 	   end
		   else	begin
			    seek (ArchivoProducto, filesize(ArchivoProducto));       
			 	  PROD.COD_Producto:= ax[1];
				  repeat 
						ClrScr;
						writeln('Ingrese el codigo del proyecto');    //Validacion Proyecto
						readln(ax[1]);
						ax[2]:='1';
						if ValidarP(ax)=1 then begin 
							op1:=0;
							Pys.Cantidades[4]:=Pys.Cantidades[4]+1;
							ProductoCantidad();				                       //Si ax[1] es mayor, ValidarP = 1;
						end
						else APROY();         													
				  until op1=0;
			  end;  
			  ///////////////////REGISTRAR PRODUCTO/////////////// 
			  if x=1 then begin 
			  (PROD.COD_Proyecto):= ax[1];
		       writeln('Ingrese el precio del producto');
			  repeat
			    readln(PROD.Precio);
			    ClrScr;
			  until (PROD.Precio>='0') and (PROD.Precio<='9');
			  writeln('Ingrese el estado del producto [S/N]');
			  repeat
			 	readln(PROD.Estado);
			  until (PROD.Estado='S') or (PROD.Estado='N');
			  writeln('Ingrese el detalle del producto'); 
			  readln(PROD.Detalle);
			  seek(Py,filePos(Py)-1);
			  write(Py,Pys);
			  write(ArchivoProducto,PROD);
			  op1:=0;
			  end;
			  /////////////////////////////////////////////////
	 	until op1=0;
		end;

	Procedure AltaProducto();
		begin 
		op:=1;
			repeat	
				ClrScr;
				repeat
					writeln('Ingrese el codigo del producto');
					readln(ax[1]);
					VerificarProductos();
					op1:=0;
				until op1=0;
				repeat
					ClrScr;
					writeln('Ingrese un <0> para salir, o un <1> para mostrar datos y luego salir');
					readln(op);
				until ((op = 0) or (op = 1));
				if op=1 then begin
					   MuestraProductos();
					   op:=0;
					   readKey();
					  end 
				else op:=0;
			until op = 0;
		end;
		  
//-----------------------------------CLIENTES-------------------------------------------------------//

	Procedure MOSTRARPROYECTOS();
	 begin
	  	Seek(Py,0);
	 	ClrScr;
		writeln('################################################################################################################');
		gotoxy(9, 2);
		writeln('ETAPA');
		gotoxy(30, 2);
		writeln('EMPRESA');
		gotoxy(60, 2);
		writeln('CIUDAD');
		gotoxy(90, 2);
		writeln('CODIGO DE PROYECTO');
		writeln('################################################################################################################');
		gotoxy(20,2);
		writeln('|');
		gotoxy(50,2);
		writeln('|');
		gotoxy(80,2);
		writeln('|');
		gotoxy(112,2);
		writeln('|');
		i:=4;
	      repeat
	          Read(Py,Pys);
	          if Pys.Tipo=ax[1] then 
	          begin
	              gotoxy(90, i);
	              Writeln (Pys.COD_PROY);
	              case Pys.Etapa of
	                  'P': begin
	                  			gotoxy(9, i); 
	                  			Writeln('Preventa.');
	                  		 end;
	                  'O': begin 
	                  			gotoxy(9, i); 
	                  			Writeln('Obra.');
	                  		 end;
	                  'T': begin
	                  			gotoxy(9, i); 
	                  			Writeln('Terminado.');
	                  		 end;
	         		 end;
			//buscar y mostrar nombre empresa
				  ax[1]:=Pys.COD_EMP;
				  ax[2]:='2';
				  ValidarE(ax);
				  gotoxy(30, i);
				  writeln(Emp.Nombre);
	          //ciudad del proyecto
	          	  ax[1]:=Pys.COD_ciudad;
				  ax[2]:='1';
				  ValidarE(ax);
				  gotoxy(60, i);
				  writeln(CargaCiudad.NombreCiudad);
				  gotoxy(1, i+1);
				  writeln('----------------------------------------------------------------------------------------------------------------');
				  i:=i+2;
	          end;
	      until eof(Py);
	 end;

	PROCEDURE MOSTRARPRODCUTOS();
		begin
			repeat 
			    Writeln('Ingrese código del proyecto: ');
			    Readln(ax[1]);
			    ////////SUMAR 1 PUNTO PROYECTO ////////////
			    ax[2]:='1';
			    if ValidarP(ax)=1 then begin
				    Pys.Cantidades[2]:= Pys.Cantidades[2]+1;

				    //SUMAR 1 PUNTO A CIUDAD
				    ax[3]:=ax[1];
				    ax[1]:= Pys.COD_ciudad;
				    ValidarE(ax);
				    CargaCiudad.Contador:= CargaCiudad.Contador+1;
				    seek(ArchivoCiudad,filePos(ArchivoCiudad)-1);
				    Write(ArchivoCiudad,CargaCiudad);

				    seek(Py,filePos(Py)-1);
				    Write(Py,Pys);

				 //SUMAR 1 PUNTO EMPRESA//
				 	ax[2]:='2';
				 	ax[1]:=ax[3];
				 	ValidarE(ax);
				 	Emp.Contador:= Emp.Contador+1;
				 	seek(E,filePos(E)-1);
				 	Write(E,Emp);
				end;

			    //SUMAR 1 PUNTO CIUDAD//

			    Seek (ArchivoProducto,0);
			    ClrScr;
			    writeln('################################################################################################################');
					gotoxy(3, 2);
					writeln('CODIGO DE PRODUCTO');
					gotoxy(32, 2);
					writeln('PRECIO');
					gotoxy(70, 2);
					writeln('DETALLE');
					writeln('################################################################################################################');
					gotoxy(25,2);
					writeln('|');
					gotoxy(45,2);
					writeln('|');
					gotoxy(112,2);
					writeln('|');
					i:=4;
			    repeat
			        Read(ArchivoProducto,CargaProducto);
			        if CargaProducto.COD_Proyecto=ax[1] then
			        begin
			            if CargaProducto.Estado='N' then
			              begin
			              	gotoxy(4, i);
				          Writeln(CargaProducto.COD_Producto);
				          gotoxy(25,i);
						writeln('|');
						gotoxy(33, i);
			               Writeln(CargaProducto.Precio);
			               gotoxy(45,i);
						writeln('|');
						gotoxy(47, i);
				          Writeln(CargaProducto.Detalle);
						gotoxy(112,i);
						writeln('|');	              
			              end;
			        end;
			    until eof(ArchivoProducto);
			 repeat
			    writeln('<0> Para salir');
			    writeln('<1> Para consultar otro proyecto');
			    readln(op1);
			 until (op1=0) or (op1=1);
			until op1=0;
			end;

	Procedure LCLIENTE();
		var 
			CC:Clientes;
			letras: integer;

		begin
			repeat
				repeat
					op:=0;
					letras:=0; 
					ClrScr;
				     Writeln('Ingrese DNI: ');
				     Readln(optao);
				     for i:=1 to length(optao) do
					 	if ((optao[i]>='0') and (optao[i]<='9')) then letras:=letras+1
					 	else letras:=letras-1;
					 if letras=length(optao) then op:=1
					 else 
					 begin 
						writeln('Debe introducir unicamente numeros en el DNI');
						readKey();
					 end;
			  until op=1;
			  Reset(C);
			  Seek(C,0);
		    repeat
		        read(C,Cl);
		    until (eof(C) or (optao=Cl.DNI));
		    if optao=Cl.DNI then begin
		            Writeln('Bienvenido ', Cl.Nombre);
		            readKey();
		        end
		   	else
		      begin
			      repeat
			      	textcolor(red);
			      	ClrScr();
			      	writeln ('');
			      	writeln ('El DNI ingresado no está registrado en la base de datos');
			      	writeln ('<1> Para registrar un DNI');
			      	writeln ('<2> Para volver a ingresar un DNI nuevamente');
			      	option:=readKey();
			      until (option='1') or (option='2');
		      	if option='1' then
		      		begin
			          x:=0;
			          CC.DNI:=optao;
			          repeat
			              Writeln('Ingrese mail: ');
			              Readln(ax[1]);
			              Seek(C,0);
			              repeat
			                  read(C,Cl);
			              until (eof(C) or (ax[1]=Cl.mail));
			              if ax[1]=Cl.mail then
			                  begin
			                  	Writeln('Este mail ya ha sido utilizado, ingrese uno distinto');
			                  end
			              else begin 
			              	x:=2;
			              	CC.mail:=ax[1];
			              	end;
			          until x=2;
			              Writeln('Ingrese su nombre: ');
			              MENU:='SI'; 
			              Readln(CC.nombre);
			              Seek(C,filesize(C));
			              Write(C,CC);     
			        end     	
	        end;
	    until MENU='SI';
	  end;      

	Procedure MODA();
		begin
		    repeat
		      ClrScr;
		      writeln('[Consulta de PROYECTOS]');
		      writeln('');
		      Writeln('C- Casa.');
		      Writeln('D- Departamento.');
		      Writeln('O- Oficina.');
		      Writeln('L- Lotes.');
		      Readln(ax[1]);
		    until (ax[1]='C') or (ax[1]='D') or (ax[1]='O') or (ax[1]='L');
		    	MOSTRARPROYECTOS();
		    	MOSTRARPRODCUTOS();
		 end;

	Procedure MODB();
	 var SN:char;
	 begin
	  SN:='K';
	  reset(ArchivoProducto);
	  writeln('[Compra de PRODUCTOS]');
	  writeln('');
	  Writeln('Ingrese el código de producto: ');
	  Readln(ax[1]);
	  Seek(ArchivoProducto,0);
	  repeat
	      Read(ArchivoProducto,CargaProducto);
	  until eof(ArchivoProducto) or (ax[1]=CargaProducto.COD_Producto);

	  if (ax[1]=CargaProducto.COD_Producto) then
	      begin
	          if CargaProducto.Estado='N' then
	              begin
	                  Writeln('El precio del producto es: ',CargaProducto.Precio);
	                  Writeln('Desea continuar? <S/N>');
	                  repeat
	                      Readln(SN);
	                  until (SN='S') or (SN='N');
	                  if SN='S' then
		                  begin
		                    Writeln('La venta le llegará al mail ',Cl.mail);
		                    CargaProducto.Estado:='S';
		                    seek(ArchivoProducto,Filepos(ArchivoProducto)-1);
		                    Write(ArchivoProducto, CargaProducto);
		                    reset(Py);              
		                    repeat
		                    	read(Py,Pys);
		                    until eof (Py) or (Pys.COD_PROY=CargaProducto.COD_Proyecto);

		                    if (Pys.COD_PROY=CargaProducto.COD_Proyecto) then
		                      begin
		                     	 	Pys.Cantidades[3]:=Pys.Cantidades[3] + 1;
		                      	seek(Py,Filepos(Py)-1);
		                     	 	write(Py,Pys);
		                      end;
		                  end;
	              end
	          else
	              begin
	             	 Writeln('Producto no disponible.');
	             	 readkey();
	              end;
	      end   
	  else
	      begin
	      	repeat
	      		ClrScr;
	      		textcolor(red);
	          Writeln('El código de producto ingresado es erroneo.');
	          writeln('¿Desea consultar la lista de proyectos disponibles?');
	          writeln('<1> Ir al menu de consultas');
	          writeln('<0> Volver a ingresar el código');
	          textcolor(lightblue);
	          mez:=readkey();
	        until (mez='0') or (mez='1');
	        if mez='1' then MODA();
	      end;
	 end;

//-------------------------------------MENUS--------------------------------------------------------//

	Procedure MODEmp();
			var
			op1: char;
		begin
			i:=100;
	    repeat
	        CLRSCR;
	        gotoxy(i+1, 1);
	        writeln('[Menu de EMPRESAS] ');
	        gotoxy(i, 2);
	        writeln('1. Alta de Ciudades ');
	        gotoxy(i, 3);
	        writeln('2. Alta de Empresas ');
	        gotoxy(i, 4);
	        writeln('3. Alta de Proyectos ');
	        gotoxy(i, 5);
	        writeln('4. Alta de Productos ');
	        gotoxy(i, 6);
	        writeln('0. Volver al Menu');
	        delay (1);
	        i:=i-1;
	    until (i=1) or (KeyPressed);
			repeat
					ClrScr();
	        gotoxy(2, 1);
	        writeln('[Menu de EMPRESAS] ');
	        gotoxy(1, 3);
	        writeln('1. Alta de Ciudades ');
	        gotoxy(1, 4);
	        writeln('2. Alta de Empresas ');
	        gotoxy(1, 5);
	        writeln('3. Alta de Proyectos ');
	        gotoxy(1, 6);
	        writeln('4. Alta de Productos ');
	        gotoxy(1, 7);
	        writeln('0. Volver al Menu');
    			repeat
			    	op1 := readKey();
			    until ((op1 = '1') or (op1 = '2') or (op1 = '3') or (op1 = '4') or (op1 = '0'));
			    case op1 of
			    	'1': AltaCiudad();
			    	'2': AltaEmpresa();       
			    	'3': AltaProyecto();
			    	'4': AltaProducto();

			    end; 
			until(op1 = '0');
		end;				

	Procedure MODCli();
		begin
			repeat 
				LCLIENTE();
				i:=100;
	    repeat
	        CLRSCR;
	        gotoxy(i+1, 1);
	   		  Writeln('[Menu de CLIENTES]');
	        gotoxy(i, 3);
	        Writeln('1- Consultar Proyectos.');
	        gotoxy(i, 4);
	        Writeln('2- Comprar Producto');
	        gotoxy(i, 5);
	        writeln('0. Volver al Menu');
	        delay (1);
	        i:=i-1;
	    until (i=1) or (KeyPressed);
		    repeat
			    ClrScr;
			    gotoxy(2, 1);
			    Writeln('[Menu de CLIENTES]');
					gotoxy(1, 3);
			    Writeln('1- Consultar Proyectos.');
			    gotoxy(1, 4); 
			    Writeln('2- Comprar Producto');
			    gotoxy(1, 5);
			    writeln('0. Volver al Menu');
			    option:=readKey();
		    until ((option='1') or (option='2') or (option='3'));
		    case option of
		        '1': MODA();
		        '2': MODB();
		    end;
	  	until option='0';
		end;

//----------------------------CONTRASEÑA Y MAIN-----------------------------------------------------// 

	Procedure login(tipo: char);
		var
		  attempts, kj: integer;
		  clave, empresa, cliente : string;
		  c:char;
		begin
		  attempts := 3;
		  clave := '';
		  empresa := 'admin';			
		  cliente := 'user';
		  acceso:=0;
		  while (attempts > 0) do
		    begin
		      ClrScr();
		      write('Ingrese la contrase', #241,'a: ');
		      repeat
		        c := readkey();
		        ClrScr();
		        write('Ingrese la contrase', #241,'a: ');
		        if(c = #08) then
		        	begin
			          delete(clave,length(clave),1);
			          for kj := 1 to length(clave) do
			            write('*');
		        	end
		        else
			        begin 
			        	if (c <> #13) then
			        	begin
				            clave := clave + c;
				            for kj := 1 to length(clave) do
				              write('*')
				        end;
			        end;
		      until(c = #13);
		      if (option = '1') then
		      begin
		        if (clave = empresa) then
		        	begin
		        	
		        	acceso:=acceso+1;
		          attempts:=0;
		          end
		        else if (clave<>empresa) then 
		        	begin
		        		ClrScr();
		       	  	clave := '';
		       	 	  attempts:=attempts-1;
		          	writeln('Contrase', #241,'a incorrecta, intentos restantes: ', attempts);
		          	writeln(#13+#10, 'Presione cualquier tecla para continuar...');
		          	readKey();
		          end;
		      end;
		      if (option='2') then
		      begin
		        if (clave = cliente) then
		        	begin
		        	acceso:=acceso+2;
		          attempts:=0;
		          end
		        else if (clave<>cliente) then 
		        	begin
		        		ClrScr();
		          	clave := '';
		          	attempts:=attempts-1;
								writeln('Contrase', #241,'a incorrecta, intentos restantes: ', attempts);
								writeln(#13+#10, 'Presione cualquier tecla para continuar...');
		          	readKey();
		          end;
		      end;
		    end;
		end;   //Contraseña

	Begin
		ABRIR();
	 	acceso:=0;
		//for x := 0 to 3 do 
			//contador[x]:=0;
		x:=0;
		y:=0;
		repeat
			ClrScr();
			textcolor(lightblue);
			i:=100;
			repeat
		  		ClrScr;
		  		gotoxy(i+3, 1);
	          	writeln('Menu: ');
	         		gotoxy(i, 2);
							writeln('1. Empresas ');
							gotoxy(i, 3);
		        	writeln('2. Clientes ');
		        	gotoxy(i, 4);
		        	writeln('0. Salir ');
		        	gotoxy(i, 5);
		          delay (1);
		          i:=i-1;
	          until (i=2) or (KeyPressed);							//ANIMACION DEL INICIO
			ClrScr;
		  gotoxy(5, 1);
    	writeln('Menu: ');
   		gotoxy(2, 2);
			writeln('1. Empresas ');
			gotoxy(2, 3);
    	writeln('2. Clientes ');
    	gotoxy(2, 4);
    	writeln('0. Salir ');
	    repeat
	          option := readKey();
			until ((option = '1') or (option = '2') or (option = '0'));
			if (option <> '0') then
			begin
					login(option);
			       case acceso of
			            1: MODEmp();       
			            2: MODCli();  
			       end;
			end;
		until (option = '0');
		CERRAR();
	End.