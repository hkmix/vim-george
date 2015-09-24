" Vim syntax file
" Language: George
" Maintainer: Jack Zhou (hkmix)
" Latest Revision: 2015-09-24

if exists("b:current_syntax")
    finish
endif

" Basic Matching
syn keyword basicLanguageKeywordsBy by
syn keyword basicLanguageKeywordsOn on contained nextgroup=stepId

syn match logicOperators '&'
syn match logicOperators  '|'
syn match logicOperators '=>'
syn match logicOperators '<=>'
syn match logicOperators '|='
syn match logicOperators '!'

syn keyword basicLanguageConstants true false

" Predicate Logic Matching
syn keyword predicateLogicKeywords forall exists
syn match predicateLogicOperators '=='
syn match predicateLogicOperators '!='

" Transformational Proof Matching
syn keyword transformationalProofCommands comm assoc contr lem
syn keyword transformationalProofCommands impl contrapos simp1 simp2
syn keyword transformationalProofCommands distr dm neg equiv
syn keyword transformationalProofCommands idemp
syn keyword transformationalProofCommands forall_over_and exists_over_or
syn keyword transformationalProofCommands swap_vars move_exists move_forall
syn match transformationalProofOperators '<==>'

" Natural Deduction Matching
syn keyword naturalDeductionCommands and_i and_e or_i lem
syn keyword naturalDeductionCommands imp_e not_e not_not_i not_not_e
syn keyword naturalDeductionCommands iff_i iff_e trans iff_mp
syn keyword naturalDeductionCommands exists_i forall_e
syn keyword naturalDeductionCommands eq_i eq_e
syn keyword naturalDeductionCommands premise

syn keyword NDSubproofCommands raa cases imp_i forall_i exists_e
syn keyword NDSubproofCommands disprove case assume
syn match NDSubproofCommands 'for every'
syn match NDSubproofCommands 'for some'

" Set Matching
syn keyword setCommands set
syn keyword setConstants empty univ
syn keyword setFunctions in sube sub pow union inter
syn keyword setFunctions card gen_U dom ran id iter
syn match setOperators '|>'
syn match setOperators '|->'
syn match setOperators '<|'
syn match setOperators '<-|'
syn match setOperators '(+)'
syn match setOperators ';'

" Semantic Tableaux Matching
syn keyword semanticTableauxCommands and_nb not_and_br
syn keyword semanticTableauxCommands or_br not_or_nb
syn keyword semanticTableauxCommands imp_br not_imp_nb
syn keyword semanticTableauxCommands not_not_nb
syn keyword semanticTableauxCommands iff_br not_iff_br
syn keyword semanticTableauxCommands forall_nb not_forall_nb
syn keyword semanticTableauxCommands exists_nb not_exists_nb
syn keyword semanticTableauxCommands closed

" Arithmetic Matching
syn keyword arithmeticCommands arith

" Z Language Matching
syn keyword zDeclarations schema begin pred end
syn keyword zTypes Delta Xi
syn keyword zConstants N
syn keyword zFunctions seq
syn match zOperators '::='
syn match zOperators '[<-]->'
syn match zOperators '>-->'
syn match zOperators '-->>'
syn match zOperators '>-->>'
syn match zOperators '-|->'
syn match zOperators '>-|->'
syn match zOperators '-|->>'
syn match zOperators '>-|->>'
syn match zNextLine ';;'

" Program Correctness Matching
syn keyword programCorrectnessKeywords proc assert
syn keyword programCorrectnessKeywords if else then while do

syn match numericalConstants '\<\d\+\>'

" Metadata Matching
syn match stepId '\<\d\+\>' contained
syn match stepNumber '^\s*\d\+)'

syn match commandIncl '#\(check\|u\|a\|q\)' contained
syn match commands '#\(check\|u\|a\|q\)' nextgroup=commandParam

" Comments
syn match comments '%.*$' contains=commentCommands,propositions
syn match commentCommands contained '\(where\|means\)' nextgroup=meanings
syn match meanings ' .*$' contained
syn match propositions contained ' [a-z] '

" Regions
syn region commandParam start=' \<' end='$' contained contains=commandIncl
syn region proofOn start='\<on\>' end='$' contains=stepId,basicLanguageKeywordsOn,comments keepend

" Syntax Highlighting
let b:current_syntax = "george"

" META: Comments and George commands
hi def link comments Comment
hi def link commentCommands Keyword
hi def link commands PreProc
hi def link commandParam Identifier
hi def link meanings String
hi def link propositions Constant

" NUMBERING: Line numbers for proofs
hi def link stepNumber Identifier
hi def link stepId Identifier

" KEYWORDS: Special labels for structuring proofs like by and forall
hi def link basicLanguageKeywordsBy Keyword
hi def link basicLanguageKeywordsOn Keyword
hi def link predicateLogicKeywords Keyword

" COMMANDS: Proof procedures like assume, and_nb, imp_i, and arith
hi def link naturalDeductionCommands Type
hi def link NDSubproofCommands Type
hi def link semanticTableauxCommands Type
hi def link transformationalProofCommands Type
hi def link setCommands Type
hi def link arithmeticCommands Type

" FUNCTIONS: Meaningful labels like union, seq, and ran
hi def link setFunctions Special
hi def link zFunctions Special

" CONSTANTS: Defined variables such as N, true, and univ
hi def link basicLanguageConstants Constant
hi def link setConstants Constant
hi def link zConstants Constant

" OPERATORS: Special symbols like !, ==, and <==>
hi def link logicOperators Special
hi def link predicateLogicOperators Special
hi def link transformationalProofOperators Special
hi def link setOperators Special
hi def link zOperators Special

" Z: Special keywords for the Z specification
hi def link zDeclarations Keyword
hi def link zTypes Type

" Program Correctness: Special keywords for program correctness
hi def link programCorrectnessKeywords Keyword

" MISC: Special symbols like ;;, which have no good meaning
hi def link numericalConstants Constant
"hi def link zNextLine Comment
