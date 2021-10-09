Program tp3inicio;
uses crt;

var
	srt: string[30];
	i: Integer;

begin
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
		gotoxy(9, i);
		writeln('holi');
		gotoxy(1, i+1);
		writeln('----------------------------------------------------------------------------------------------------------------');
		gotoxy(20,i);
		writeln('|');
		gotoxy(50,i);
		writeln('|');
		gotoxy(80,i);
		writeln('|');
		gotoxy(112,i);
		writeln('|');

		i:=i+2;
	until i=20;
	readkey();
	{repeat
		repeat
			readln(srt)
		until ((srt>'1') and (srt<'9'));
		for i:=1 to length(srt) do
			if ((srt[i]>='a') and (srt[i]<='z') or (srt[i]>='A') and (srt[i]<='Z')) then 
			begin
				writeln ('caracteres detectados: ', srt[i]);
			end
			else begin writeln('nope');
			end;
		readKey();
	until i=10329210;}
end.