
%define MAX_INPUT_LENGTH 65536
    
%include './lib/asm_macros.asm'
    
section .text
    global _start
    
_start:
    mov esi, 0
    call premalloc
    call _read_file_argument
    call _read_file
    push ebp
    mov ebp, esp
    call BTEST
    pop ebp
    mov edi, outbuff
    call print_mm32
    mov eax, 1
    mov ebx, 0
    int 0x80
    
BTEST:
    push ebp
    mov ebp, esp
    push esi
    print "#!/usr/bin/bash"
    print 0x0A
    print "suites=0"
    print 0x0A
    print "cases=0"
    print 0x0A
    print "cases_failed=0"
    print 0x0A
    print "suites_failed=0"
    print 0x0A
    print "start_time=$(date +%s%N | cut -b1-13)"
    print 0x0A
    print "bold_green=$(tput bold; tput setaf 2)"
    print 0x0A
    print "bold_red=$(tput bold; tput setaf 1)"
    print 0x0A
    print "reset=$(tput sgr0)"
    print 0x0A
    print "gray=$(tput setaf 8)"
    print 0x0A
    print 0x0A
    
LA1:
    error_store 'SUITE'
    call vstack_clear
    call SUITE
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA2
    
LA2:
    
LA3:
    cmp byte [eswitch], 0
    je LA1
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_0
    cmp byte [backtrack_switch], 1
    je LA4
    je terminate_program
LOOP_0:
    print "generate_postamble"
    print 0x0A
    
LA4:
    
LA5:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
SUITE:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "@suite"
    cmp byte [eswitch], 1
    je LA6
    error_store 'ID'
    call vstack_clear
    call ID
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA7
    
LA7:
    
LA8:
    cmp byte [eswitch], 1
    jne LOOP_1
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_1:
    print "# Suite "
    call copy_last_match
    print 0x0A
    print "suites=$((suites+1))"
    print 0x0A
    print "echo -e '\x1b[37;46;1m[SUITE]\x1b[0m "
    call copy_last_match
    test_input_string "describes"
    cmp byte [eswitch], 1
    jne LOOP_2
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_2:
    error_store 'RAW'
    call vstack_clear
    call RAW
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_3
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_3:
    print " - "
    call copy_last_match
    print "'"
    print 0x0A
    test_input_string "{"
    cmp byte [eswitch], 1
    jne LOOP_4
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_4:
    
LA9:
    error_store 'CASE'
    call vstack_clear
    call CASE
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA10
    
LA10:
    cmp byte [eswitch], 0
    je LA11
    error_store 'METHOD'
    call vstack_clear
    call METHOD
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA12
    
LA12:
    
LA11:
    cmp byte [eswitch], 0
    je LA9
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_5
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_5:
    test_input_string "}"
    cmp byte [eswitch], 1
    jne LOOP_6
    cmp byte [backtrack_switch], 1
    je LA6
    je terminate_program
LOOP_6:
    
LA6:
    
LA13:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
CASE:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "@case"
    cmp byte [eswitch], 1
    je LA14
    error_store 'RAW'
    call vstack_clear
    call RAW
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_7
    cmp byte [backtrack_switch], 1
    je LA14
    je terminate_program
LOOP_7:
    print "echo -e '\x1b[37;43;1m[TEST]\x1b[0m "
    call copy_last_match
    print "'"
    print 0x0A
    
LA15:
    test_input_string "alias"
    cmp byte [eswitch], 1
    je LA16
    error_store 'ID'
    call vstack_clear
    call ID
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_8
    cmp byte [backtrack_switch], 1
    je LA16
    je terminate_program
LOOP_8:
    
LA16:
    
LA17:
    cmp byte [eswitch], 1
    je LA18
    
LA18:
    cmp byte [eswitch], 0
    je LA19
    test_input_string "requires"
    cmp byte [eswitch], 1
    je LA20
    error_store 'ID'
    call vstack_clear
    call ID
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_9
    cmp byte [backtrack_switch], 1
    je LA20
    je terminate_program
LOOP_9:
    
LA20:
    
LA21:
    cmp byte [eswitch], 1
    je LA22
    
LA22:
    
LA19:
    cmp byte [eswitch], 0
    je LA15
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_10
    cmp byte [backtrack_switch], 1
    je LA14
    je terminate_program
LOOP_10:
    test_input_string "{"
    cmp byte [eswitch], 1
    jne LOOP_11
    cmp byte [backtrack_switch], 1
    je LA14
    je terminate_program
LOOP_11:
    
LA23:
    error_store 'COMMAND'
    call vstack_clear
    call COMMAND
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA24
    
LA24:
    
LA25:
    cmp byte [eswitch], 0
    je LA23
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_12
    cmp byte [backtrack_switch], 1
    je LA14
    je terminate_program
LOOP_12:
    test_input_string "}"
    cmp byte [eswitch], 1
    jne LOOP_13
    cmp byte [backtrack_switch], 1
    je LA14
    je terminate_program
LOOP_13:
    
LA14:
    
LA26:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
METHOD:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "@method"
    cmp byte [eswitch], 1
    je LA27
    error_store 'RAW'
    call vstack_clear
    call RAW
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_14
    cmp byte [backtrack_switch], 1
    je LA27
    je terminate_program
LOOP_14:
    error_store 'ID'
    call vstack_clear
    call ID
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_15
    cmp byte [backtrack_switch], 1
    je LA27
    je terminate_program
LOOP_15:
    test_input_string "{"
    cmp byte [eswitch], 1
    jne LOOP_16
    cmp byte [backtrack_switch], 1
    je LA27
    je terminate_program
LOOP_16:
    
LA28:
    error_store 'COMMAND'
    call vstack_clear
    call COMMAND
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA29
    
LA29:
    
LA30:
    cmp byte [eswitch], 0
    je LA28
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_17
    cmp byte [backtrack_switch], 1
    je LA27
    je terminate_program
LOOP_17:
    test_input_string "}"
    cmp byte [eswitch], 1
    jne LOOP_18
    cmp byte [backtrack_switch], 1
    je LA27
    je terminate_program
LOOP_18:
    
LA27:
    
LA31:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
COMMAND:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "execute"
    cmp byte [eswitch], 1
    je LA32
    error_store 'STRING'
    call vstack_clear
    call STRING
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_19
    cmp byte [backtrack_switch], 1
    je LA32
    je terminate_program
LOOP_19:
    print "stdout=$(execute "
    call copy_last_match
    print ")"
    print 0x0A
    print "exit_code=$?"
    print 0x0A
    
LA32:
    cmp byte [eswitch], 0
    je LA33
    test_input_string "@expect"
    cmp byte [eswitch], 1
    je LA34
    error_store 'RAW'
    call vstack_clear
    call RAW
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_20
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_20:
    mov esi, last_match
    mov edi, str_vector_8192
    call vector_push_string_mm32
    cmp byte [eswitch], 1
    jne LOOP_21
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_21:
    mov esi, last_match
    mov edi, str_vector_8192
    call vector_push_string_mm32
    cmp byte [eswitch], 1
    jne LOOP_22
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_22:
    test_input_string "{"
    cmp byte [eswitch], 1
    jne LOOP_23
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_23:
    
LA35:
    test_input_string "assert"
    cmp byte [eswitch], 1
    je LA36
    error_store 'EXPECT'
    call vstack_clear
    call EXPECT
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    jne LOOP_24
    cmp byte [backtrack_switch], 1
    je LA36
    je terminate_program
LOOP_24:
    
LA36:
    
LA37:
    cmp byte [eswitch], 0
    je LA35
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    jne LOOP_25
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_25:
    test_input_string "}"
    cmp byte [eswitch], 1
    jne LOOP_26
    cmp byte [backtrack_switch], 1
    je LA34
    je terminate_program
LOOP_26:
    
LA34:
    
LA38:
    cmp byte [eswitch], 1
    je LA39
    
LA39:
    
LA33:
    cmp byte [eswitch], 1
    je LA40
    
LA40:
    
LA41:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
EXPECT:
    push ebp
    mov ebp, esp
    push esi
    print "cases=$((cases+1))"
    print 0x0A
    print "if ! [ "
    error_store 'NUMBER'
    call vstack_clear
    call NUMBER
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA42
    
LA42:
    cmp byte [eswitch], 0
    je LA43
    error_store 'STRING'
    call vstack_clear
    call STRING
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA44
    
LA44:
    
LA43:
    cmp byte [eswitch], 1
    je LA45
    call copy_last_match
    
LA45:
    
LA46:
    cmp byte [eswitch], 1
    je LA47
    
LA47:
    cmp byte [eswitch], 0
    je LA48
    error_store 'VARIABLE'
    call vstack_clear
    call VARIABLE
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA49
    
LA49:
    
LA48:
    cmp byte [eswitch], 1
    jne LOOP_27
    cmp byte [backtrack_switch], 1
    je LA50
    je terminate_program
LOOP_27:
    test_input_string "equals"
    cmp byte [eswitch], 1
    je LA51
    print " -eq "
    
LA51:
    
LA52:
    cmp byte [eswitch], 1
    jne LOOP_28
    cmp byte [backtrack_switch], 1
    je LA50
    je terminate_program
LOOP_28:
    error_store 'NUMBER'
    call vstack_clear
    call NUMBER
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA53
    
LA53:
    cmp byte [eswitch], 0
    je LA54
    error_store 'STRING'
    call vstack_clear
    call STRING
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA55
    
LA55:
    
LA54:
    cmp byte [eswitch], 1
    je LA56
    call copy_last_match
    
LA56:
    
LA57:
    cmp byte [eswitch], 1
    je LA58
    
LA58:
    cmp byte [eswitch], 0
    je LA59
    error_store 'VARIABLE'
    call vstack_clear
    call VARIABLE
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA60
    
LA60:
    
LA59:
    cmp byte [eswitch], 1
    jne LOOP_29
    cmp byte [backtrack_switch], 1
    je LA50
    je terminate_program
LOOP_29:
    print " ]; then"
    print 0x0A
    print '    '
    print "echo -e '\r\t❌ expected "
    mov esi, str_vector_8192
    call vector_pop_string
    mov esi, eax
    mov edi, outbuff
    add edi, [outbuff_offset]
    call buffc
    add dword [outbuff_offset], eax
    print "'"
    print 0x0A
    print '    '
    print "cases_failed=$(($cases_failed+1))"
    print 0x0A
    print "else"
    print 0x0A
    print '    '
    print "echo -e '\r\t✔ expect "
    mov esi, str_vector_8192
    call vector_pop_string
    mov esi, eax
    mov edi, outbuff
    add edi, [outbuff_offset]
    call buffc
    add dword [outbuff_offset], eax
    print "'"
    print 0x0A
    print "fi"
    print 0x0A
    
LA50:
    
LA61:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
ARGUMENT:
    push ebp
    mov ebp, esp
    push esi
    error_store 'NUMBER'
    call vstack_clear
    call NUMBER
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA62
    
LA62:
    cmp byte [eswitch], 0
    je LA63
    error_store 'STRING'
    call vstack_clear
    call STRING
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA64
    
LA64:
    cmp byte [eswitch], 0
    je LA63
    error_store 'RAW'
    call vstack_clear
    call RAW
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA65
    
LA65:
    
LA63:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
VARIABLE:
    push ebp
    mov ebp, esp
    push esi
    error_store 'EXIT_CODE'
    call vstack_clear
    call EXIT_CODE
    call vstack_restore
    call error_clear
    cmp byte [eswitch], 1
    je LA66
    
LA66:
    
LA67:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
EXIT_CODE:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "$?"
    cmp byte [eswitch], 1
    je LA68
    print "$exit_code"
    
LA68:
    
LA69:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
COMMENT:
    push ebp
    mov ebp, esp
    push esi
    test_input_string "//"
    cmp byte [eswitch], 1
    je LA70
    match_not 10
    cmp byte [eswitch], 1
    jne LOOP_30
    cmp byte [backtrack_switch], 1
    je LA70
    je terminate_program
LOOP_30:
    
LA70:
    
LA71:
    pop esi
    mov esp, ebp
    pop ebp
    ret
    
; -- Tokens --
    
PREFIX:
    
LA72:
    mov edi, 32
    call test_char_equal
    cmp byte [eswitch], 0
    je LA73
    mov edi, 9
    call test_char_equal
    cmp byte [eswitch], 0
    je LA73
    mov edi, 13
    call test_char_equal
    cmp byte [eswitch], 0
    je LA73
    mov edi, 10
    call test_char_equal
    
LA73:
    call scan_or_parse
    cmp byte [eswitch], 0
    je LA72
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA74
    
LA74:
    
LA75:
    ret
    
NUMBER:
    call PREFIX
    cmp byte [eswitch], 1
    je LA76
    mov byte [tflag], 1
    call clear_token
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA76
    call DIGIT
    cmp byte [eswitch], 1
    je LA76
    
LA77:
    call DIGIT
    cmp byte [eswitch], 0
    je LA77
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA76
    mov byte [tflag], 0
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA76
    
LA76:
    
LA78:
    ret
    
DIGIT:
    mov edi, 48
    call test_char_greater_equal
    cmp byte [eswitch], 0
    jne LA79
    mov edi, 57
    call test_char_less_equal
    
LA79:
    
LA80:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA81
    
LA81:
    
LA82:
    ret
    
ID:
    call PREFIX
    cmp byte [eswitch], 1
    je LA83
    test_input_string_no_cursor_advance "import"
    mov al, byte [eswitch]
    xor al, 1
    mov byte [eswitch], al
    cmp byte [eswitch], 1
    je LA83
    mov byte [tflag], 1
    call clear_token
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA83
    call ALPHA
    cmp byte [eswitch], 1
    je LA83
    
LA84:
    call ALPHA
    cmp byte [eswitch], 1
    je LA85
    
LA85:
    cmp byte [eswitch], 0
    je LA86
    call DIGIT
    cmp byte [eswitch], 1
    je LA87
    
LA87:
    
LA86:
    cmp byte [eswitch], 0
    je LA84
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA83
    mov byte [tflag], 0
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA83
    
LA83:
    
LA88:
    ret
    
ALPHA:
    mov edi, 65
    call test_char_greater_equal
    cmp byte [eswitch], 0
    jne LA89
    mov edi, 90
    call test_char_less_equal
    
LA89:
    cmp byte [eswitch], 0
    je LA90
    mov edi, 95
    call test_char_equal
    cmp byte [eswitch], 0
    je LA90
    mov edi, 97
    call test_char_greater_equal
    cmp byte [eswitch], 0
    jne LA91
    mov edi, 122
    call test_char_less_equal
    
LA91:
    
LA90:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA92
    
LA92:
    
LA93:
    ret
    
STRING:
    call PREFIX
    cmp byte [eswitch], 1
    je LA94
    mov byte [tflag], 1
    call clear_token
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA94
    mov edi, 34
    call test_char_equal
    
LA95:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA94
    
LA96:
    mov edi, 13
    call test_char_equal
    cmp byte [eswitch], 0
    je LA97
    mov edi, 10
    call test_char_equal
    cmp byte [eswitch], 0
    je LA97
    mov edi, 34
    call test_char_equal
    
LA97:
    mov al, byte [eswitch]
    xor al, 1
    mov byte [eswitch], al
    call scan_or_parse
    cmp byte [eswitch], 0
    je LA96
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA94
    mov edi, 34
    call test_char_equal
    
LA98:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA94
    mov byte [tflag], 0
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA94
    
LA94:
    
LA99:
    ret
    
RAW:
    call PREFIX
    cmp byte [eswitch], 1
    je LA100
    mov edi, 34
    call test_char_equal
    
LA101:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA100
    mov byte [tflag], 1
    call clear_token
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA100
    
LA102:
    mov edi, 13
    call test_char_equal
    cmp byte [eswitch], 0
    je LA103
    mov edi, 10
    call test_char_equal
    cmp byte [eswitch], 0
    je LA103
    mov edi, 34
    call test_char_equal
    
LA103:
    mov al, byte [eswitch]
    xor al, 1
    mov byte [eswitch], al
    call scan_or_parse
    cmp byte [eswitch], 0
    je LA102
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA100
    mov byte [tflag], 0
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA100
    mov edi, 34
    call test_char_equal
    
LA104:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA100
    
LA100:
    
LA105:
    ret
    
DOLLAR_SIGN_VARS:
    call PREFIX
    cmp byte [eswitch], 1
    je LA106
    mov byte [tflag], 1
    call clear_token
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA106
    mov edi, "$"
    call test_char_equal
    
LA107:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA106
    call NUMBER
    cmp byte [eswitch], 1
    je LA108
    
LA108:
    cmp byte [eswitch], 0
    je LA109
    mov edi, "@"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "*"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "#"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "-"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "$"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "_"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "?"
    call test_char_equal
    cmp byte [eswitch], 0
    je LA110
    mov edi, "!"
    call test_char_equal
    
LA110:
    call scan_or_parse
    cmp byte [eswitch], 1
    je LA111
    
LA111:
    
LA109:
    cmp byte [eswitch], 1
    je LA106
    mov byte [tflag], 0
    mov byte [eswitch], 0
    cmp byte [eswitch], 1
    je LA106
    
LA106:
    
LA112:
    ret
    
