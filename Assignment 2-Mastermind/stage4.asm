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
 49|      SUB R2, R2, #1
 50|      CMP R2, #0
 51|      BGT loop1
 52|      HALT
 53|getcode:
 54|      MOV R0, #msg4
 55|      STR R0, .WriteString
 56|      MOV R0, #code
 57|      STR R0, .ReadString // read in input
 58|      MOV R1, #0        // initialise index
 59|rgbypc:                 // start of loop
 60|      PUSH {R4}
 61|      LDRB R4, [R0+R1]  // read byte from array
 62|      CMP R4, #98       //b
 63|      BEQ pass
 64|      CMP R4, #99       //c
 65|      BEQ pass
 66|      CMP R4, #103      //g
 67|      BEQ pass
 68|      CMP R4, #112      //p
 69|      BEQ pass
 70|      CMP R4, #114      //r
 71|      BEQ pass
 72|      CMP R4, #121      //y
 73|      BNE getcode
 74|pass:                   //will loop to this label if all conditions are satisfied
 75|      STRB R4, [R0+R1]  // write it back to the array
 76|      POP {R4}
 77|      ADD R1,R1,#1      // increment index
 78|      CMP R1, #4
 79|      BNE rgbypc
 80|      STR R0, .WriteString // write appropriate satisfied code to output
 81|      RET
 82|msg1: .ASCIZ "Codebreaker is "
 83|codebreaker: .BLOCK 128
 84|msg2: .ASCIZ "Codemaker is "
 85|codemaker: .BLOCK 128
 86|msg3: .ASCIZ "Maximum number of guesses: "
 87|readnum: .BLOCK 128
 88|msg4: .ASCIZ "Enter a code "
 89|code: .BLOCK 128
 90|msg5: .ASCIZ ", please enter a 4-character secret code "
 91|secretcode: .BLOCK 128
 92|msg6: .ASCIZ "Enter query code "
 93|querycode: .BLOCK 128
 94|msg7: .ASCIZ ", this is guess number: "