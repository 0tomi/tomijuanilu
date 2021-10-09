Program tp3inicio;
uses crt;

var
	srt: string[30];
	i: Integer;

begin
	repeat
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
	until i=10329210;
end.