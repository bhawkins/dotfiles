" VIM syntax file for Yorick
"
" @Regis Lachaume 2001
"
" Permission is granted to use, copy, distribute or modify this file provided
" that this notice is kept intact.
" Editted by Khosrow Hassani and Mark Sutton, McGill

" include directive

syn region yIncludeDirective start="^\s*#\s*include" end="$" contains=yString
hi  link   yIncludeDirective yPreProc

" ?:

syn region  yMulti      matchgroup=cStatement start="?" skip="::" end=":" contains=yMulti,yParen,yIdentifier,@yCommentzone,yString,yNumber
syn match   yErrInMulti contained "\(;\|{\|}\|%>\|<%\|??>\|??<\)"
hi  link    yErrInMulti yError

" reserved identifiers

syn keyword yType        int long short float double func pointer array
syn keyword yType        char complex string struct
"khosrow: add bookmark
syn keyword yType        bookmark
syn keyword yConditional if else
syn keyword yRepeat      while for do
syn keyword yStatement   break return continue goto local extern
syn cluster yFlowControl contains=yConditional,yRepeat,yStatement

" parentheses (extra parentheses are signaled as errors)

syn region yParen       transparent start="(" end=")" contains=yParen,yMulti,yBracketError,yBracket,@yCommentZone,yFunction,yString,yKeyword,yIdentifier,yErrInParen,yType,yNumber,yStatement,yKeyword
syn match  yParenError  "\(\]\|)\)"
hi  link   yParenError  yError
" khosrow: causes wrong error when two parentheses are written after each
" other even if the total number of them  match.
"syn match  yErrInParen contained "\(\]\|\|{\|}\)"
hi  link   yErrInParen  yError

" brackets (extra brackets are signaled as errors)

syn region yBracket      transparent start="\[" end="\]" contains=yParen,yBracket,yMulti,yNumber,@yCommentZone,yFunction,yKeyword,yIdentifier,yErrInBracket,yStatement,yString,yKeyword
syn match  yErrInBracket contained "\()\|;\|{\|}\|??\)"
hi  link   yErrInBracket yError
syn match  yBracketError "\]"
hi  link   yBracketError yError   

" curly braces

syn match   yCurly      "\({\|}\)"
hi  link    yCurly yStatement

" string litterals (highlight read/write format specifiers)

syn match   yFormat "%\(\d\+\$\)\=\(-\|+\|'\| \|#\|??=\|0\|\*\)*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([diuoxXfeEgGcCsSpn]\|\[^\=.[^]]*\]\)" contained
syn match   yFormat "%%" contained
hi  link    yFormat ySpecial
syn region  yString matchgroup=transparent start=+"+ skip=+"\"+ end=+"+ contains=yFormat

" comments (C and C++ comments)

syn match   yTodo             contained "\<\(TO\s*DO\|FIX\s*\(ME\|IT\)\)\>"
syn keyword yDocument         contained DOCUMENT
" khosrow: add more:
syn keyword yDocument         contained SEE ALSO KEYWORD KEYWORDS             
hi  link    yDocument         ySpecial
syn region  yOneLineComment   start="//" skip="\\$" end="$" keepend contains=yTodo
hi link     yOneLineComment   yComment
syn region  yMultiLineComment start="/\*" end="\*/" skip="?" keepend contains=yTodo,yDocument
hi link     yMultiLineComment yComment
syn match   yCommentError     "\*/"
hi link     yCommentError     yError 
syn cluster yCommentZone      contains=yOneLineComment,yMultiLineComment

" most common build-in functions

syn keyword yFunction system cd get_cwd get_home get_env get_argv
syn keyword yFunction min max sum avg rms ptp mnx mxx cum psum zcen pcen dif
syn keyword yFunction abs sign sqrt floor ceil conj exp log log10 random pi sin
syn keyword yFunction cos tan asin acos atan sinh cosh tanh asinh acosh atanh
syn keyword yFunction print info dimsof orgsof typeof numberof typeof structof
syn keyword yFunction is_array is_func is_void is_range is_stream am_subroutine
syn keyword yFunction reshape allof anyof noneof where where2 uncp
syn keyword yFunction digitize interp integ sort median transpose
syn keyword yFunction strlen strmatch strpart strtok span hcp_file
syn keyword yFunction read read_n open close rdline sread backup
syn keyword yFunction openb updateb createb show get_vars save restore
syn keyword yFunction jt get_times get_ncycs add_record set_filesize
syn keyword yFunction install_struct add_variable data_align struct_align
syn keyword yFunction add_next_file dump_clog include require pause quit
syn keyword yFunction plg plm plc plf plfc plv pli pldj plt plmesh fma hcp hcps
syn keyword yFunction hcpon hcpoff hcp_out animate logxy limits range window
syn keyword yFunction palette plq pledit pldefault fft roll indgen
syn keyword yFunction help info spanl grow exit error xytitles pltitle

" khosrow: add more:
syn keyword yFunction write swrite _read interp2 plmk

"khosrow: add contrib functions:
" fit section:
syn keyword yContFunc curvefit fitplot fit2dgauss gaussian gauss2 erf fitline
syn keyword yContFunc gaussian  lorentz lorentz1 polyfit voigt1 voigt2
syn keyword yContFunc vls fitexy chixy chixy2 gammp gcf gser khisq_d kk 
syn keyword yContFunc find_khisq linfit
" plot section:
syn keyword yContFunc box centre pic kilbox turnbox fixbox bullseye drawboxes
syn keyword yContFunc drawbox dlable mousez plin scaleplot plsh underscore
syn keyword yContFunc noplsys sd winsize circle mouslable pleb pltstamp 
syn keyword yContFunc swin owin nwin 
syn keyword yContFunc fma numplots plsys lbl matplots mkplvp make_bgcol
" xray section:
syn keyword yContFunc rotmat setlat setspacegroup crystalvol callat calB
syn keyword yContFunc calQ atomfs genhkl genatompos initfstable addatom
syn keyword yContFunc Btousq fsatoms powder transmat bragg det3 runbp
syn keyword yContFunc prxtal  prbragg othercols othercols1 othercols2
syn keyword yContFunc othercols3 fpxtal critangle murho abslength rdcmp
syn keyword yContFunc abscmp mucrystal fpcrystal fppcrystal mucmp fpcmp
syn keyword yContFunc fppcmp xrayinit
" math section:
syn keyword yContFunc fresnel oldfresnel kummer kseries klargep klargen
syn keyword yContFunc prmat v2rot vmag vnorm vproj vcross vdot vangle
syn keyword yContFunc drawvec mdrawvec
" spec section:
syn keyword yContFunc findpeak getpeak selpeak wrpeak rdpeak 
syn keyword yContFunc rdzxsc plzxsc mergescan normalize_ms 
syn keyword yContFunc plspec plscan rdspec wrspec slit_fit get_fwhm
syn keyword yContFunc get_col_num gauss_line interpol Amptek_Correction
syn keyword yContFunc rdmesh rdscaninfo rdmotornames showscaninfo
" misc section:
syn keyword yContFunc get_f 
hi  link yContFunc Macro
" identifiers

syn match yIdentifier "\<[A-Za-z_][A-Za-z0-9_]*\>"

" most common keywords

syn match yKeyword "\<\(legend\|hide\|type\|width\|color\|marks\|marker\)="
syn match yKeyword "\<\(mspace\|mphase\|msize\|rays\|rspace\|rphase\|arroww\)="
syn match yKeyword "\<\(arrowl\|closed||smooth\|font\|height\|opaque\|path\)="
syn match yKeyword "\<\(justify\|hollow\|aspect\|im\|re\|format\|levs\|ps\)="
syn match yKeyword "\<\(legends\|style\|square\)="
" khosrow: add more
syn match yKeyword "\<\(xgap\|ygap\|tgap\|cmin\|cmax\)="

hi  link  yKeyword  Identifier

" number litterals

syn match yNumber "\(+\|-\|\)\([0-9]\+\)\(.[0-9]\+\|\.\|\)\([Ee]\(+\|-\|\)[0-9]\+\|\)"
syn match yNumber "\(+\|-\|\)\.[0-9]\+\([Ee]\(+\|-\|\)[0-9]\+\|\)"

" link to VIM word categories

hi  link    yString      String
hi  link    ySpecial     Special
hi  link    yTodo        Todo
hi  link    yType        Type
hi  link    yRepeat      Repeat
hi  link    yConditional Conditional
hi  link    yError       Error
hi  link    yStatement   Statement
hi  link    yFunction    Function
hi  link    yIdentifier  None
hi  link    yNumber      Number
hi  link    yComment     Comment
hi  link    yPreProc     PreProc

" Number of lines to consider when parsing for (), [], /* */
" It may be lowered on slow computers

syn sync    minlines=100 
