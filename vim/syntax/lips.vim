" Vim syn file
" Language: lips assembly
" Maintainer:   notwa
" Last Change:  2016-04-07

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn region lipsString start=/"/ skip=/\\"/ end=/"/
syn region lipsComment start="/\*" end="\*/"
syn match lipsComment /\(\/\/\|;\).*/

syn sync ccomment lipsComment

syn match lipsNumber /\<[+-]\?\d\+\>/ " Decimal numbers
syn match lipsNumber /\<[+-]\?0x[0-9a-f]\+\>/ " Hex numbers
syn match lipsNumber /\<[+-]\?0[0-7]\+\>/ " Octal numbers

syn match lipsColon  /:/ contained
syn match lipsLabel  /[a-z_][a-z0-9_]*:/ contains=lipsColon
syn match lipsLabel  /[+-]:/ contains=lipsColon
syn match lipsDefine /\[[a-z0-9_]\+\]:/ contains=lipsColon
syn match lipsDefine /@[a-z0-9_]\+/

" Registers
syn keyword lipsRegister zero
syn keyword lipsRegister v0 v1
syn keyword lipsRegister a0 a1 a2 a3
syn keyword lipsRegister t0 t1 t2 t3 t4 t5 t6 t7 t8 t9
syn keyword lipsRegister s0 s1 s2 s3 s4 s5 s6 s7
syn keyword lipsRegister at
syn keyword lipsRegister k0 k1
syn keyword lipsRegister gp sp fp
syn keyword lipsRegister ra

" Register aliases
syn keyword lipsRegister s8

" Register numeric aliases and FPU registers
let i = 0
while i < 32
    execute 'syn keyword lipsRegister r'.i
    execute 'syn keyword lipsRegister f'.i
    let i = i + 1
endwhile

" Coprocessor 0 registers
syn keyword lipsRegister index     random    entrylo0  entrylo1
syn keyword lipsRegister context   pagemask  wired     reserved0
syn keyword lipsRegister badvaddr  count     entryhi   compare
syn keyword lipsRegister status    cause     epc       previd
syn keyword lipsRegister config    lladdr    watchlo   watchhi
syn keyword lipsRegister xcontext  reserved1 reserved2 reserved3
syn keyword lipsRegister reserved4 reserved5 perr      cacheerr
syn keyword lipsRegister taglo     taghi     errorepc  reserved6

" Directives
syn match lipsDirective "\.align\>"
syn match lipsDirective "\.skip\>"
syn match lipsDirective "\.space\>"
syn match lipsDirective "\.ascii\>"
syn match lipsDirective "\.asciiz\>"
syn match lipsDirective "\.byte\>"
syn match lipsDirective "\.half\(word\)\?\>"
syn match lipsDirective "\.word\>"
syn match lipsDirective "\.float\>"
syn match lipsDirective "\.inc\>"
syn match lipsDirective "\.incasm\>"
syn match lipsDirective "\.include\>"
syn match lipsDirective "\.incbin\>"
syn match lipsDirective "\.org\>"

syn match lipsDirective "\<HEX\>"

" Instructions

" Handle a bunch of stuff at once so vim doesn't get confused
syn match lipsInstruction /\<ADD\(IU\|[IU]\|\.[SD]\)\?\>/
syn match lipsInstruction /\<SUB\(IU\|[IU]\|\.[SD]\)\?\>/
syn match lipsInstruction /\<ABS\(\.[SD]\)\?\>/
syn match lipsInstruction /\<MOV\(\.[SD]\)\?\>/
syn match lipsInstruction /\<MUL\(\.[SD]\)\?\>/
syn match lipsInstruction /\<NEG\(\.[SD]\)\?\>/
syn match lipsInstruction /\<DIV\(\.[DS]\)\?\>/

syn keyword lipsInstruction LB LBU
syn keyword lipsInstruction LD
syn keyword lipsInstruction LDL LDR
syn keyword lipsInstruction LH LHU
syn keyword lipsInstruction LL LLD
syn keyword lipsInstruction LUI
syn keyword lipsInstruction LW LWU
syn keyword lipsInstruction LWL LWR

syn keyword lipsInstruction SB
syn keyword lipsInstruction SC SCD
syn keyword lipsInstruction SD
syn keyword lipsInstruction SDL SDR
syn keyword lipsInstruction SH
syn keyword lipsInstruction SW
syn keyword lipsInstruction SWL SWR

syn keyword lipsInstruction AND ANDI
syn keyword lipsInstruction MULT MULTU
syn keyword lipsInstruction NOR
syn keyword lipsInstruction OR ORI
syn keyword lipsInstruction SLL SLLV
syn keyword lipsInstruction SRA SRAV
syn keyword lipsInstruction SRL SRLV
syn keyword lipsInstruction XOR XORI

syn keyword lipsInstruction DADD DADDI DADDIU DADDU
syn keyword lipsInstruction DDIV DDIVU
syn keyword lipsInstruction DIVU
syn keyword lipsInstruction DMULT DMULTU
syn keyword lipsInstruction DSLL DSLL32 DSLLV
syn keyword lipsInstruction DSRA DSRA32 DSRAV
syn keyword lipsInstruction DSRL DSRL32 DSRLV
syn keyword lipsInstruction DSUB DSUBU

syn keyword lipsInstruction J JR
syn keyword lipsInstruction JAL JALR

syn keyword lipsInstruction SLT SLTI SLTIU SLTU

syn keyword lipsInstruction BEQ BEQL
syn keyword lipsInstruction BGEZ BGEZAL BGEZALL BGEZL
syn keyword lipsInstruction BGTZ BGTZL
syn keyword lipsInstruction BLEZ BLEZL
syn keyword lipsInstruction BLTZ BLTZAL BLTZALL BLTZL
syn keyword lipsInstruction BNE BNEL

" Coprocessor-related instructions, etc.

syn keyword lipsInstruction BC1F BC1FL
syn keyword lipsInstruction BC1T BC1TL

syn keyword lipsInstruction CFC1 CTC1
syn keyword lipsInstruction DMFC1 DMTC1
syn keyword lipsInstruction LDC1 LWC1
syn keyword lipsInstruction MFC0 MTC0
syn keyword lipsInstruction MFC1 MTC1
syn keyword lipsInstruction MFHI MFLO
syn keyword lipsInstruction MTHI MTLO
syn keyword lipsInstruction SDC1 SWC1

syn keyword lipsInstruction BREAK
syn keyword lipsInstruction CACHE
syn keyword lipsInstruction ERET
syn keyword lipsInstruction SYNC
syn keyword lipsInstruction SYSCALL

syn keyword lipsInstruction TEQ TEQI
syn keyword lipsInstruction TGE TGEI TGEIU TGEU
syn keyword lipsInstruction TLBP TLBR
syn keyword lipsInstruction TLBWI TLBWR
syn keyword lipsInstruction TLT TLTI TLTIU TLTU
syn keyword lipsInstruction TNE TNEI

syn match lipsInstruction /\<SQRT\.[DS]\>/

syn match lipsInstruction /\<CVT\.D\.[LSW]\>/
syn match lipsInstruction /\<CVT\.L\.[DS]\>/
syn match lipsInstruction /\<CVT\.S\.[DSW]\>/
syn match lipsInstruction /\<CVT\.W\.[DS]\>/

syn match lipsInstruction /\<CEIL\.L\.[DS]\>/
syn match lipsInstruction /\<CEIL\.W\.[DS]\>/
syn match lipsInstruction /\<FLOOR\.L\.[DS]\>/
syn match lipsInstruction /\<FLOOR\.W\.[DS]\>/
syn match lipsInstruction /\<ROUND\.L\.[DS]\>/
syn match lipsInstruction /\<ROUND\.W\.[DS]\>/
syn match lipsInstruction /\<TRUNC\.L\.[DS]\>/
syn match lipsInstruction /\<TRUNC\.W\.[DS]\>/

syn match lipsInstruction /\<C\.EQ\.[DS]\>/
syn match lipsInstruction /\<C\.F\.[DS]\>/
syn match lipsInstruction /\<C\.LE\.[DS]\>/
syn match lipsInstruction /\<C\.LT\.[DS]\>/
syn match lipsInstruction /\<C\.NGE\.[DS]\>/
syn match lipsInstruction /\<C\.NGLE\.[DS]\>/
syn match lipsInstruction /\<C\.NGL\.[DS]\>/
syn match lipsInstruction /\<C\.NGT\.[DS]\>/
syn match lipsInstruction /\<C\.OLE\.[DS]\>/
syn match lipsInstruction /\<C\.OLT\.[DS]\>/
syn match lipsInstruction /\<C\.SEQ\.[DS]\>/
syn match lipsInstruction /\<C\.SF\.[DS]\>/
syn match lipsInstruction /\<C\.UEQ\.[DS]\>/
syn match lipsInstruction /\<C\.ULE\.[DS]\>/
syn match lipsInstruction /\<C\.ULT\.[DS]\>/
syn match lipsInstruction /\<C\.UN\.[DS]\>/

" Pseudo-instructions

syn keyword lipsInstruction B BAL
syn keyword lipsInstruction BEQZ BNEZ
syn keyword lipsInstruction CL
syn keyword lipsInstruction NOP
syn keyword lipsInstruction NOT

syn keyword lipsInstruction LI LA

syn keyword lipsInstruction PUSH
syn keyword lipsInstruction POP JPOP

syn keyword lipsInstruction REM
syn keyword lipsInstruction NAND NANDI
syn keyword lipsInstruction NORI
syn keyword lipsInstruction ROL ROR

syn keyword lipsInstruction SEQ SEQI SEQIU SEQU
syn keyword lipsInstruction SGE SGEI SGEIU SGEU
syn keyword lipsInstruction SGT SGTI SGTIU SGTU
syn keyword lipsInstruction SLE SLEI SLEIU SLEU
syn keyword lipsInstruction SNE SNEI SNEIU SNEU

syn keyword lipsInstruction BEQI
syn keyword lipsInstruction BNEI
syn keyword lipsInstruction BGE BGEI
syn keyword lipsInstruction BLE BLEI
syn keyword lipsInstruction BLT BLTI
syn keyword lipsInstruction BGT BGTI

hi def link lipsComment     Comment
hi def link lipsNumber      Number
hi def link lipsString      String
hi def link lipsLabel       Type
hi def link lipsRegister    Identifier
hi def link lipsDirective   Special
hi def link lipsInstruction Statement
hi def link lipsDefine      Define

let b:current_syntax = "lips"
