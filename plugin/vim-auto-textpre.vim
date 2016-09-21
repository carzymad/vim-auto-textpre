" 文件预处理
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.html,*.php exec ":call AddTitle()"
func AddTitle()
	call append(0, "/*********************************************************")
	call append(1, " * Author           : ".g:author)
	call append(2, " * Last modified    : ".strftime("%Y-%m-%d %H:%M"))
	call append(3, " * Filename         : ".expand("%:t"))
	call append(4, " * Description      : ")
	call append(5, " *********************************************************/")
	call append(6, "")
		
	if expand("%:e") == 'cpp'
		call append(7, "#include <iostream>")
		call append(8, "")
		call append(9, "using namespace std;")
		call append(10, "")
	elseif expand("%:e") == 'c'
		call append(7, "#include <stdio.h>")
		call append(8, "#include <stdlib.h>")
		call append(9, "")
	elseif expand("%:e") == "h"
		call append(7, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(8, "#define _".toupper(expand("%:r"))."_H")
		call append(9, "")
		call append(10, "")
		call append(11, "")
		call append(12, "#endif")
	elseif expand("%:e") == 'sh'
		execute '1,$s/*/#/g'
		execute '1,$s/\//#/g'
		call append(7, "#!/bin/bash")
	elseif expand("%:e") == "php"
		call setline(1, "<!-- ----------------------------------------------------")
		call setline(6, " ----------------------------------------------------- -->")
		call append(7, "<?php")
		call append(8, "")
		call append(9, "?>")
	elseif expand("%:e") == 'html' 			
		call setline(1, "<!-- ----------------------------------------------------")
		call setline(6, " ----------------------------------------------------- -->")
		call append(7, "<html>")
		call append(8, "<meta content=\"text/html; charset=utf-8\" />")
		call append(9, "<title>titile</title>")
		call append(10, "")
		call append(11, "<head>")
		call append(12, "</head>")
		call append(13, "")
		call append(14, "<body>")
		call append(15, "")
		call append(16, "</body>")
		call append(17, "</html>")
	endif

	if expand("%:e") == 'c' || expand("%:e") == 'cpp'
		let lineNum=10
		if expand("%:e") == 'cpp'
			call append(10, "")
			let lineNum=11
		endif
		call setline(lineNum+1, "int main(int argc, char* argv[])")
		call setline(lineNum+2, "{")
		call setline(lineNum+3, "")
		call setline(lineNum+4, "")
		call setline(lineNum+5, "	return 0;")
		call setline(lineNum+6, "}")
	endif
endfunc
autocmd BufNewFile * normal G

autocmd BufWritePost *.cpp exec ":call UpdateTime()"
func UpdateTime()
	let n=1
	while n < 10
		let line = getline(n)
		if line =~ '^\s\*\s*\S*Last\smodified\S*.*$'
			normal m'
			execute 's/#Last modified/s@\=strftime(":\t%Y-%m-%d %H:%M")@'
			normal ''
			normal mk
			execute "noh"
			normal 'k
			echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
			echo "test"
		endif
		let n = n + 1
	endwhile
endfunc
autocmd BufWritePost * normal G

