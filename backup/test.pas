Program tp3inicio;
uses crt;

var
	srt: string[30];
	i: Integer;
	Numero:String;

begin
	//writeln('#####################################################################################################################');
	gotoxy(3,2);
	writeln('Empresas con mas de 10 consultas');
	gotoxy(44, 2);
	writeln('Proyectos con todos los productos vendidos');
	gotoxy(93, 2);
	writeln('Ciudad mas consultada');
	//writeln('#####################################################################################################################');
	gotoxy(90,5);
	writeln('############################');
	gotoxy(38,2);
	writeln('|');
	gotoxy(90,2);
	writeln('|');
	gotoxy(117,2);
	writeln('|');
	gotoxy(117,4);
	writeln('|');
	gotoxy(93,4);
	writeln('holi');
	i:=4;
	repeat 
		gotoxy(12, i);
		writeln('holiiiiiiiiii');
		gotoxy(60, i);
		writeln('pinga');
		gotoxy(0, i+1);
		writeln('-------------------------------------|');
		gotoxy(38,i);
		writeln('|');
		{gotoxy(38,i);
		writeln('|');
		gotoxy(90,i);
		writeln('|');
		gotoxy(38, i+1);
		writeln('|---------------------------------------------------|');}

		i:=i+2;
	until i=20;
	readkey();
end.