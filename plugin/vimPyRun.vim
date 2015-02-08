set updatetime=500
let g:testPath = expand('<sfile>:p:h')
let g:scriptPath = fnamemodify('vimPy.sh',expand('<sfile>:p:h'))
function! RunPython(winWidth)
	execute 'w'
	let filePath = expand('%:p')
	if !bufexists('python')
		execute a:winWidth.'vnew'
		execute 'silent file python'
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
	endif
	if bufwinnr('python') == -1
		execute a:winWidth.'vsplit python'
	endif
    "be aware that this uses gstdbuf wich is part of the gnu coreutils and is not standard on macs
    execute 'silent !~/vimPy.sh '.filePath.' &'
    execute 'redraw!'
    echo g:scriptPath
    autocmd CursorHold,CursorHoldI * call UpdatePython()
endfunction

function! UpdatePython()
    execute bufwinnr('python').'wincmd w'
	execute 'silent %d'
    execute 'silent 0r ~/pyout'
 	execute 'normal G|dd'
    if getline('.') == '~~finished running~~'
        autocmd! CursorHold,CursorHoldI
    endif
    call feedkeys("\<c-w>p")
endfunction

map <C-b> :call RunPython(90) <CR>
