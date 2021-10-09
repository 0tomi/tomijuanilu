Program tp3inicio;
uses dos,crt;

var
	srt: string[30];
	i: Integer;




begin
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
		gotoxy(4, i);
		writeln('holi');
		gotoxy(33, i);
		writeln('holi');
		gotoxy(47, i);
		writeln('pinga');
		gotoxy(1, i+1);
		writeln('----------------------------------------------------------------------------------------------------------------');
		gotoxy(25,i);
		writeln('|');
		gotoxy(45,i);
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