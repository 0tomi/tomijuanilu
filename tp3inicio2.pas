type
    Clientes=record
        DNI:interger;
        nombre:string[30];
        mail:string[30];
    end;

    Productos=record
        etapa:char;
        tipo:char;
        codigod:interger;
        codigoy:interger;
        
    ArchivoClientes=file of Clientes;
    ArchivoProductos=file of Productos;
    
var
    C:ArchivoClientes;
    Cl:Clientes;
    
    D:ArchivoProductos;
    Pd:Productos;
    
    idni:interger;
    imail,inombre:string[30];
    opcion,opcion2:char;
    opcion3:interger;
    SN:char;

begin
    Writeln('Ingrese DNI: ');
    Readln(idni);
    Reset(C);
    Seek(C,0);
    repeat
        read(C,Cl);
    until eof(C) or (idni=Cl.DNI);
    if idni=Cl.DNI then
        begin
            Writeln('Bienvenido.');
        end;
    else
        begin
            x:=0;
            repeat
                Writeln('Ingrese mail: ');
                Readln(imail);
                Seek(C,0);
                repeat
                    read(C,Cl);
                until eof(C) or (imail=Cl.mail);
                if imail=Cl.mail then
                    begin
                    Writeln('Este mail ya ha sido utilizado, ingrese uno distinto');
                    end;
                else x=2;
            until x=2;
                Writeln('Ingrese su nombre: '); 
                Readln(inombre);
                Seek(C,filesize(C));
                Cl.mail:=imail;
                Cl.nombre:=inombre;
                Cl.DNI:=idni;
                Write(C,Cl);         
        end;
    repeat
    ClrScr;
    Writeln('A- Consultar Proyectos.'); //lo incluyo en un repetir hasta para que pueda seguir eligiendo?
    Writeln('B- Comprar Producto');
    Readln(opcion);
    until (opcion='A') or (opcion='B');
    case opcion of
        'A':begin
                repeat
                ClrScr;
                Writeln('C- Casa.');
                Writeln('D- Departamento.');
                Writeln('O- Oficina.');
                Writeln('L- Lotes.');
                Readln(opcion2);
                until (opcion2='C') or (opcion2='D') or (opcion2='O') or (opcion2='L');
                Seek(P,0);
                repeat
                    Read(P,Py);
                    if Py.tipo=opcion2 then 
                    begin
                        Writeln ('El código del procducto es: ',Py.codigo);
                        case Py.etapa of
                            'P': begin Writeln('Etapa Preventa.')end;
                            'O': begin Writeln('Etapa en Obra.')end;
                            'T': begin Writeln('Etapa Terminado.')end;
                        //buscar y mostrar nombre empresa   
                    end;
                until eof(ArchivoProyectos);//no sé el nombre de la variable del archivo
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
            Writeln('Ingrese el código de producto: ');
            Readln(opcion4);
            Seek(D,0);
            repeat
                Read(D,Pd);
            until eof(D) or (opcion4=Pd.codigod);
            if opcion4=Pd.codigod then
                begin
                    if Pd.estado='N' then
                        begin
                            Writeln('El precio del producto es: ',Pd.precio);
                            Writeln('Desea continuar?');
                            repeat
                                Readln(SN);
                            until SN='S' or SN='N';
                            if SN='S' then
                            begin
                                Writeln('La venta le llegará al mail ',Cl.mail);
                                Pd.estado:='S';
                                //lo del acumulador
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
end.
