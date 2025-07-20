1|//R0 used for writing messages
  2|//R2 is the dedicated register to store the number of allowed guesses
  3|      MOV R0, #msg1
  4|      STR R0, .WriteString
  5|      MOV R0, #codebreaker //Stores codebreaker's name
  6|      STR R0, .ReadString
  7|      MOV R1, #codebreaker
  8|      STR R1, .WriteString
  9|      MOV R0, #0x0A     //New line character code
 10|      STRB R0, .WriteChar
 11|      MOV R0, #msg2
 12|      STR R0, .WriteString
 13|      MOV R0, #codemaker //Stores codemaker's name
 14|      STR R0, .ReadString
 15|      MOV R1, #codemaker
 16|      STR R1, .WriteString
 17|      MOV R0, #0x0A     //New line character code
 18|      STRB R0, .WriteChar
 19|      MOV R0, #msg3
 20|      STR R0, .WriteString
 21|      LDR R2, .InputNum
 22|      STR R2, .WriteUnsignedNum //store amount of guesses
 23|      MOV R0, #0x0A     //New line character code
 24|      STRB R0, .WriteChar
 25|      MOV R1, #codemaker
 26|      STR R1, .WriteString //rewrite codemaker's name
 27|      MOV R0, #msg5     // display message asking for secretcode
 28|      STR R0, .WriteString
 29|      MOV R0, #secretcode
 30|      MOV R0, #0x0A     //New line character code
 31|      STRB R0, .WriteChar
 32|      BL getcode        //loop to label in getcode function to process secret code
 33|loop1:
 34|      MOV R0, #0x0A     //New line character code
 35|      STRB R0, .WriteChar
 36|      MOV R0, #msg6     // display message asking for querycode
 37|      STR R0, .WriteString
 38|      MOV R0, #querycode
 39|      MOV R0, #0x0A     //New line character code
 40|      STRB R0, .WriteChar
 41|      BL getcode        //loop to label in getcode function to process secret code
 42|      MOV R0, #0x0A     //New line character code
 43|      STRB R0, .WriteChar
 44|      MOV R1, #codebreaker
 45|      STR R1, .WriteString
 46|      MOV R0, #msg7
 47|      STR R0, .WriteString
 48|      STR R2, .WriteUnsignedNum //store amount of guesses
 49|comparecodes:
 50|      PUSH {R4, R5, R6, R7, R8, R9, R10}
 51|      MOV R0, #secretcode
 52|      MOV R1, #querycode
 53|      AND R8, R4, R5
 54|      CMP R8, R4
 55|      BEQ equal
 56|      ADD R10, R10, #1
 57|      MOV R1, R10
 58|      RET
 59|equal:
 60|      ADD R9,R9,#1 
 61|      MOV R0, R9
 62|      POP {R4, R5, R6, R7, R8, R9, R10}
 63|      SUB R2, R2, #1
 64|      CMP R2, #0
 65|      BGT loop1
 66|      HALT
 67|getcode:
 68|      MOV R0, #msg4
 69|      STR R0, .WriteString
 70|      MOV R0, #code
 71|      STR R0, .ReadString // read in input
 72|rgbypc:                 // start of loop
 73|      PUSH {R4}
 74|      MOV R1, #0        // initialise index
 75|      LDRB R4, [R0+R1]  // read byte from array
 76|      CMP R4, #98       //b
 77|      BEQ pass
 78|      CMP R4, #99       //c
 79|      BEQ pass
 80|      CMP R4, #103      //g
 81|      BEQ pass
 82|      CMP R4, #112      //p
 83|      BEQ pass
 84|      CMP R4, #114      //r
 85|      BEQ pass
 86|      CMP R4, #121      //y
 87|      BNE getcode
 88|pass:                   //will loop to this label if all conditions are satisfied
 89|      STRB R4, [R0+R1]  // write it back to the array
 90|      POP {R4}
 91|      ADD R1,R1,#1      // increment index
 92|      STR R0, .WriteString // write appropriate satisfied code to output
 93|      RET
 94|msg1: .ASCIZ "Codebreaker is "
 95|codebreaker: .BLOCK 128
 96|msg2: .ASCIZ "Codemaker is "
 97|codemaker: .BLOCK 128
 98|msg3: .ASCIZ "Maximum number of guesses: "
 99|readnum: .BLOCK 128
100|msg4: .ASCIZ "Enter a code "
101|code: .BLOCK 4
102|msg5: .ASCIZ ", please enter a 4-character secret code "
103|secretcode: .BLOCK 4
104|msg6: .ASCIZ "Enter query code "
105|querycode: .BLOCK 4
106|msg7: .ASCIZ ", this is guess number: "