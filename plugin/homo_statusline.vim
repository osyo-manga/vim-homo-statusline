
function! s:resize(str, len)
	if  a:len <= 0
		return ""
	endif
	let list = split(a:str, '\zs')
	for n in range(a:len+1)
		let b = a:len < strwidth(join(list[ : n], ""))
		if b
			return n > 0 ? join(list[ : n-1], "") : ""
		endif
	endfor
	return a:str
endfunction


function! s:go()
	let s:count += 1
	if s:count > winwidth("%")+strwidth(s:homo)
		let s:count = -strwidth(s:homo)
	endif
	let s:homo = "三┌(┌ ＾o＾)┐ﾎﾓｫ…"
endfunction

function! s:back()
	let s:count -= 1
	if s:count < -strwidth(s:homo)
		let s:count = winwidth("%")+strwidth(s:homo)
	endif
	let s:homo = "ﾎﾓｫ…┌(＾o＾┐)┐三"
endfunction

function! s:move(str, x)
	let list = split(a:str, '\zs')
	if a:x < 0
		return join(list[a:x * -1 : len(list)], "")
	endif
	return repeat(" ", a:x).a:str
endfunction

function! HomoStatuslineFunc()
	return s:resize(s:move(s:homo, s:count), winwidth("%"))
endfunction

function! s:setup()
	let s:count = 0
	let s:homo = "三┌(┌ ＾o＾)┐ﾎﾓｫ…"
	nnoremap <silent> j :call <SID>go()<CR>j
	nnoremap <silent> l :call <SID>go()<CR>l
	nnoremap <silent> k :call <SID>back()<CR>k
	nnoremap <silent> h :call <SID>back()<CR>h
	set statusline=%{HomoStatuslineFunc()}
endfunction

command! -nargs=0 HomoStatusline :call <SID>setup()

