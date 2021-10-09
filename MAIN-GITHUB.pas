//Integrantes: Juani Croci, Lucas Rodriguez, Lucia Gelmetti, Tomás Schlotahuer

Program tp3inicio;
uses crt;

//ARCHIVO MAIN V.1 (DEFINITIVA) EDITADO ULTIMO POR: TOMI
										//Fecha: 09/10 0:04 

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
	aux= array [1..2] of string;

	//PROYECTOS
	Proyectos = record      
		COD_PROY: string;                
		COD_EMP: string;
 		COD_ciudad: string [3];          
		Etapa: char;   //(P - O - T)
		Tipo: char;    //(C - D - O - L)
		Cantidades : array [1..3] of integer; 
		Contador: integer;
	end;
	ArchivoProyectos= file of Proyectos;

	//PRODUCTOS
	Productos = record      
		COD_Proyecto : string;                
		COD_Producto : string;
 		Precio : integer;          
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
	AUXI: string;

	MENU: String[3];
	op: integer;
	contador: array [0..3] of integer;
	option:char;
	optao: string;
	x, y, acceso, salir,i,o1,op1:integer;

//---------------------------------------------------------------------------------------
//CERRAR ARCHIVOS
Procedure CERRAR();
	begin
	   close(ArchivoCiudad);
		close(E);
		close(ArchivoProducto);
		close(Py);
		close(C);
	end;


//------------------------- FUNCION VALIDAR EMPRESAS Y PROYECTOS -------------------------//

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
						readKey();
						if ax[1]=CargaCiudad.COD_ciudad then ValidarE:=1
						else if ax[1]<CargaCiudad.COD_ciudad then sup:=medio-1
						else inf:=medio+1;
					end;
					writeln('Terminó acá: ', CargaCiudad.COD_ciudad);
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
			'1': begin 														//Si ax[2] es '1' compara Pys.COD_PROY con el array ax[1]
				  Reset(Py);
				  repeat
				 	 read(Py,Pys);
				  Until eof(Py) or (ax[1] = Pys.COD_PROY);
				  if (ax[1]=Emp.CODEMP) then ValidarP:=1
				  else ValidarP:=0;  
				 end;
		end;
	end;

//------------------------------------------------------------------------------------------
//PARTE PRODUCTOS

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
	   else
	 	   begin
	      seek (ArchivoProducto, filesize(ArchivoProducto));       
	 			PROD.COD_Producto:= ax[1];
				 repeat 
					ClrScr;
					writeln('Ingrese el codigo del proyecto');    //Validacion Proyecto
					readln(ax[1]);
					ax[2]:='1';
					if ValidarP(ax)=0 then op1:=0
					else begin writeln ('El código ingresado esta repetido');
					readKey(); 
					end;         													
				until op1=0;   
				(PROD.COD_Proyecto):= ax[1];
				 writeln('Ingrese el precio del producto');
				 readln(PROD.Precio);
				 writeln('Ingrese el estado del producto');
			 	 readln(PROD.Estado);
				 writeln('Ingrese el detalle del producto'); 
				 readln(PROD.Detalle);
			   write(ArchivoProducto,PROD);
			   op1:=0;
	 	   end;
 	until op1=0;
	end;

Procedure AltaProducto();
	begin 
	op:=1;
		repeat	
			repeat
				writeln('Ingrese el codigo del producto');
				readln(ax[1]);
				VerificarProductos();
				op1:=0;
			until op1=0;
			repeat
				ClrScr;
				writeln('Ingrese un <0> para salir, o un <1> para mostrar datos y salir, <2> para volver a registrar un producto');
				readln(op);
			until ((op = 0) or (op = 1) or (op=2)) ;
			if op=1 then
				  begin
				   MuestraProductos();
				   op1:=0;
				   readKey();
				  end 
		until op = 0;
	end;

//-------------------------------------------------------------------------------------------
//PARTE PROYECTOS

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
				writeln('Ingrese el c', #243,'digo del proyecto');
				readln(ax[1]);
				ax[2]:='1';
				if ValidarP(ax)=0 then op1:=0
				else begin writeln ('El código ingresado esta repetido');
				readKey(); 
				end;         													
			until op1=0; 
			P.COD_PROY:= ax[1];
			op:=1;

			repeat   																	//Código de empresa
				ClrScr;
				writeln('Ingrese el c', #243,'digo de empresa');
				readln(ax[1]);
				ax[2]:='2';
				if ValidarE(ax)=1 then op1:=0
				else begin writeln ('La empresa ingresada no existe.');
				readKey(); 
				end;
			until op1=0;
			P.COD_EMP:= ax[1];
			op:=1;

			repeat 																		//Etapa
				writeln('Ingrese la etapa del proyecto');
				writeln('[P] Preventa');
				writeln('[O] Obra');
				writeln('[T] Terminado');
				readln(P.Etapa);
			until ((P.Etapa='P') or (P.Etapa='T') or (P.Etapa='O')); 
			op:=1;

			repeat 																		//Tipo
				writeln('Ingrese el tipo de proyecto');
				writeln('[C] Casa');
				writeln('[D] Edifcio Departamento');
				writeln('[O] Edificio Oficina');
				writeln('[L] Loteos');
				readln(P.Tipo);
			until ((P.Tipo='C') or (P.Tipo='D') or (P.Tipo='O') or (P.Tipo='L')); 
			op:=1;

			repeat 																		//Código de ciudad
				ClrScr;
				writeln('Ingrese el c', #243,'digo de ciudad');
				readln(ax[1]);
				ax[2]:='1';
				if ValidarE(ax)=0 then op1:=0
				else begin writeln ('La ciudad ingresada no existe.');
				readKey(); 
				end;
			until op1=0;
			P.COD_ciudad:= ax[1];
			op:=1;

			seek(Py,filesize(Py));
			write(Py,P);

			repeat
				ClrScr;
				writeln('¿Desea ingresar nuevamente un proyecto?');
				writeln('[SI] / [NO]');
				readln(MENU);
			until ((MENU='SI') or (MENU='NO'));
			if MENU='SI' then op:=1
		until op=1;
	end;
		
//-------------------------------------------------------------------------------------------
//PARTE EMPRESAS

Procedure MostrarEmpresas();
	 var 
	h:integer;
	begin
	clrscr;
	h:=0;
		 reset(E);
			for i:= 0 to filesize(E) -1 do 
			 begin
			  Read (E, Emp);
			  writeln('Puesto nr: ',h);
			  writeln('Codigo ciudad: ',Emp.CODCIU);
			  writeln('Nombre ciudad: ',Emp.CODEMP);
			  h:=h+1;
			 end;
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
			writeln('Ingrese el c', #243,'digo de la ciudad');					
			readln(ax[1]);
			ax[2]:='1';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('El código ingresado esta repetido');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.CODCIU:= ax[1];
		repeat
			ClrScr;
			writeln('Ingrese el c', #243,'digo de la empresa.');
			readln(ax[1]);
			ax[2]:='2';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('El código ingresado esta repetido');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.CODEMP:= ax[1];
		repeat
			ClrScr;
			writeln('Ingrese el nombre de la empresa.');
			readln(ax[1]);
			ax[2]:='3';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('El nombre ingresado esta repetido');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.Nombre:= ax[1];
		repeat
			ClrScr;
			writeln('Ingrese la direcci', #243,'n de la empresa.');
			readln(ax[1]);
			ax[2]:='4';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('La direccion ingresada esta repetida');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.Direccion:= ax[1];
		repeat
			ClrScr;
			writeln('Ingrese el mail de la empresa.');
			readln(ax[1]);
			ax[2]:='5';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('El mail ingresado esta repetido');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.Mail:= ax[1];
		repeat
			ClrScr;
			writeln('Ingrese el tel', #233,'fono de la empresa.');
			readln(ax[1]);
			ax[2]:='6';
			if ValidarE(ax)=0 then op1:=0
			else begin writeln ('El teléfono ingresado esta repetido');
			readKey();
			end;
		until op1=0;
		op1:=1;
		M.Telefono:= ax[1];
		seek(E,filesize(E));
		write(E,M);

		writeln('¿Desea ver las Empresas Ingresadas? <1>SI-<0>NO ');
		repeat
			readln(op1);
		until (op1=0) or (op1=1);
		if op1=1 then
		 begin MostrarEmpresas();
		  readKey();
		   end
		else op1:=0;
				  begin
				   MostrarEmpresas();
				   op1:=0;
				   readKey();
				  end;
		repeat
			ClrScr;
			writeln('¿Desea ingresar nuevamente una Empresa?');
			writeln('[SI] / [NO]');
			readln(MENU);
		until ((MENU='SI') or (MENU='NO'));
	until MENU='NO';
	end;

//-------------------------------------------------------------------------------------------
//PARTE CIUDADES
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
	end;

Procedure OrdenarCiudades();
	var
	i,j:integer;
	A,B:Ciudades;
	begin
  Reset(ArchivoCiudad);
  For i := 0 to filesize(ArchivoCiudad)-2 do 
  	begin
  		For j := i+1 to filesize(ArchivoCiudad) -1 do 
  			begin
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
  		end;
  	end; 

Procedure VerificarCiudades();
	Var 
		op1:integer;
	begin
		Reset(ArchivoCiudad);
	repeat
	   {repeat
	 	  read(ArchivoCiudad,CargaCiudad);
	   Until eof(ArchivoCiudad) or (ax[1] = CargaCiudad.COD_ciudad);}	

	   {If (ax[1] = CargaCiudad.COD_ciudad) then
	 	   begin
	 		  writeln('Codigo ya existente, ingrese <0> para salir: ' );	
	 		  Repeat	
	 		  readln(op1);
	 		  until op1=0;
	 	   end}
	 writeln('holi');
	 readkey();
	if ValidarE(ax)=1 then begin
	 		  writeln('Código ya existente' );	
	 		  readkey();
	 	   end
	   else
	 	   begin
	      	seek (ArchivoCiudad, filesize(ArchivoCiudad));
	 		  	CargaCiudad.COD_ciudad:= ax[1];
	 		 	  writeln ('Ingrese el nombre de la ciudad: ');												
			  	readln (CargaCiudad.NombreCiudad);
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
	    		writeln('<2> Cargar otro código');
				readln(op1);
			until ((op1=1) or (op1=0) or (op1=2));
			if op1=1 then
			  begin
			   MuestraCiudades();
			   op1:=0;
			   readKey();
			  end;
    until op1=0;
    writeln();
   end;

procedure CargarNormal(); //Por primera vez(opcion 1, dsps lo quitamos)
	begin
	  seek(E,filesize(E));
		seek(ArchivoCiudad,filesize(ArchivoCiudad));
     writeln ('CODIGO CIUDAD');
     readln (CargaCiudad.COD_ciudad);                   
     writeln ('NOMBRE CIUDAD');																
     readln (CargaCiudad.NombreCiudad);	
     writeln('CODIGO EMPRESA');		
     readln(emp.CODCIU);						
     Write(ArchivoCiudad,CargaCiudad);
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

//-------------------------------------------------------------------------------------------
Procedure MODEmp();
		var
		op1: char;
	begin
		repeat
			ClrScr();
		    writeln('MENU EMPRESAS DESARROLLADORAS:'+#13+#10+'1. Alta de CIUDADES '+#13+#10+'2. Alta de EMPRESAS '+#13+#10+'3. Alta de PROYECTOS'+#13+#10+'4. Alta de Productos '+#13+#10+'0. Volver al men', #250,' principal');
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
	var CC:Clientes;
	begin 
		op:=0;
		repeat 
			repeat 
	    	Writeln('Ingrese DNI: ');
	    	Readln(optao);
	    until ((optao>'1') and (optao<'9'));
	    for i:=1 to length(optao) do
			if ((optao[i]>='a') and (optao[i]<='z') or (optao[i]>='A') and (optao[i]<='Z')) then
			begin
				writeln('Debe introducir únicamente números en el DNI');
			end
			else op:=1;
	  until op=1;
    Reset(C);
    Seek(C,0);
    repeat
        read(C,Cl);
    until (eof(C) or (optao=Cl.DNI));
    if optao=Cl.DNI then begin
            Writeln('Bienvenido.');
        end
   	else
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
              Readln(CC.nombre);
              Seek(C,filesize(C));
              Write(C,CC);         
        end;
    repeat
	    ClrScr;
	    Writeln('A- Consultar Proyectos.'); //lo incluyo en un repetir hasta para que pueda seguir eligiendo?
	    Writeln('B- Comprar Producto');
	    Readln(optao);
    until ((optao='A') or (optao='B'));
    case optao of
        'A':begin
                repeat
	                ClrScr;
	                Writeln('C- Casa.');
	                Writeln('D- Departamento.');
	                Writeln('O- Oficina.');
	                Writeln('L- Lotes.');
	                Readln(ax[1]);
                until (ax[1]='C') or (ax[1]='D') or (ax[1]='O') or (ax[1]='L');
                Seek(Py,0);
                repeat
                    Read(Py,Pys);
                    if Pys.Tipo=ax[1] then 
                    begin
                        Writeln ('El código del proyecto es: ',Pys.COD_PROY);
                        case Pys.Etapa of
                            'P': begin Writeln('Etapa Preventa.');
                            		 end;
                            'O': begin Writeln('Etapa en Obra.');
                            		 end;
                            'T': begin Writeln('Etapa Terminado.');
                            		 end;
                        end;

                        //buscar y mostrar nombre empresa

                        //ciudad del proyecto


                    end;
                until eof(Py);
                Writeln('Ingrese código del proyecto: ');
                Readln(opcion3);
                Seek (D,0);
                repeat
                    Read(D,Pd);
                    if Pd.codigoy=opcion3 then
                    begin
                        if Pd.estado='N' then
                        begin
                        Writeln(Pd.codigod);
                        Writeln(Pd.precio);
                        Writeln(Pd.detalle);
                        end;
                    end;
                until eof(D);
            end;
            //lo de actualizar en 1 más los archivos
        'B':begin
        		reset(ArchivoProducto);
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
                            until SN='S' or SN='N';
                            if SN='S' then
                            begin
                                Writeln('La venta le llegará al mail ',Cl.mail);
                                CargaProducto.Estado:='S';
                                seek(ArchivoProducto,Filepos(ArchivoProducto)-1)
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
                        end;
                    else
                        begin
                        Writeln('Producto no disponible.');
                        end;
                end;   
            else
                begin
                    Writeln('Producto no disponible.');
                end;

end;

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

 	acceso:=0;
 	acceso:=0;
	for x := 0 to 3 do 
		contador[x]:=0;
	x:=0;
	y:=0;
	repeat
		//repeat
		  ClrScr();
		  textcolor(lightblue);
		  i:=100;
		  	repeat
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
        until i=1;
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