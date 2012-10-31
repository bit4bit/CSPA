BEGIN { code = 0; begin=0; incode = 0;}

/^@begin code/ { code = 1; }
/^@text \\LA/{
next
}
/^@text/ {
    if(code){
	gsub(/(@text *)|(\[|\])/,"");
	language="CSPA";
	print "\n@literal \\begin{lstlisting}{" language "}";
	begin = 1;
	code=0;
	next
    }
}

/^@end code/ {
    if (begin == 1){
	printf "@literal \\end{lstlisting}\n%s",$0
    }
begin = 0;

}

{ print }#
