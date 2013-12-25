" =============================================================================
" File:        plugin/thematic.vim
" Description: Theme Manager for the Vim text editor
" Maintainer:  Reed Esau <github.com/reedes>
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" =============================================================================
"
" TODO licensing
" TODO guioptions
" TODO screen capture
" TODO help file
" TODO command to support named theme, with custom completion
" TODO test from filetype

"for feature in ['autocmd',]
"    if !has(feature)
"        call syntastic#log#error("need Vim compiled with feature " . feature)
"        finish
"    endif
"endfor

if exists('g:loaded_thematic') || &cp | finish | endif
let g:loaded_thematic = 1

" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpo = &cpo
set cpo&vim

let g:thematic#theme_name = ''

" Preserve original settings {{{

let g:thematic#original = {
  \ 'laststatus': &laststatus,
  \ 'ruler': &ruler,
  \ }
" }}}

" Overrides {{{

" Take control of fullscreen behavior from Vim, specifically to
" override its default behavior of maximizing columns and lines
" in fullscreen Vim.
if has('fullscreen')
  let l_fuopts = split(&fuoptions, ',')
  if index(l_fuopts, 'maxvert') != -1
    let g:thematic#original.maxvert = 1
    " NOTE removing maxvert results in a screen redraw problem
    "      if Ctrl+Command+F hit before switching themes,
    "      so we'll remove it here.
    "set fuoptions-=maxvert
  endif
  if index(l_fuopts, 'maxhorz') != -1
    let g:thematic#original.maxhorz = 1
    set fuoptions-=maxhorz
  endif
  unlet l_fuopts
endif

" }}}

" Defaults {{{
if !exists('g:thematic#defaults')
  let g:thematic#defaults = {}
endif
if !exists('g:thematic#themes')
  let g:thematic#themes = {
  \ 'blue'       : { 'sign-column-color-fix': 1,
  \                  'fold-column-color-mute': 1,
  \                },
  \ 'desert'     : { 'sign-column-color-fix': 1,
  \                  'fold-column-color-mute': 1,
  \                },
  \ 'peachpuff'  : {
  \                },
  \ 'slate'      : {
  \                },
  \ }
endif
" }}}

" Commands {{{

command -nargs=0 ThematicNarrow call thematic#adjustColumns(-5)
command -nargs=0 ThematicWiden  call thematic#adjustColumns(5)

command -nargs=0 ThematicFirst    call thematic#load('#first')
command -nargs=0 ThematicNext     call thematic#load('#next')
command -nargs=0 ThematicPrevious call thematic#load('#previous')
command -nargs=0 ThematicRandom   call thematic#load('#random')
command -nargs=0 ThematicOriginal call thematic#load('#original')
"command! -nargs=1 MyCommand call s:MyFunc(<f-args>)

" }}}

" Plugin mappings {{{

noremap <silent> <Plug>ThematicNarrow :ThematicNarrow<CR>
noremap <silent> <Plug>ThematicWiden  :ThematicWiden<CR>

" Create mappings for the `Thematic` commands
noremap <silent> <Plug>ThematicFirst    :ThematicFirst<CR>
noremap <silent> <Plug>ThematicNext     :ThematicNext<CR>
noremap <silent> <Plug>ThematicPrevious :ThematicPrevious<CR>
noremap <silent> <Plug>ThematicRandom   :ThematicRandom<CR>
noremap <silent> <Plug>ThematicOriginal :ThematicOriginal<CR>

" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:ts=2:sw=2:sts=2
