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
 25|getcode:
 26|      push {R4}
 27|      MOV R0, #msg4
 28|      STR R0, .WriteString
 29|      MOV R0, #code
 30|      STR R0, .ReadString // read in input
 31|      MOV R1, #0        // initialise index
 32|rgbypc:                 // start of loop
 33|      LDRB R4, [R0+R1]  // read byte from array
 34|      CMP R4, #98       //b
 35|      BEQ pass
 36|      CMP R4, #99       //c
 37|      BEQ pass
 38|      CMP R4, #103      //g
 39|      BEQ pass
 40|      CMP R4, #112      //p
 41|      BEQ pass
 42|      CMP R4, #114      //r
 43|      BEQ pass
 44|      CMP R4, #121      //y
 45|      BNE getcode
 46|pass:                   //will loop to this label if all conditions are satisfied
 47|      STRB R4, [R0+R1]  // write it back to the array
 48|      ADD R1,R1,#1      // increment index
 49|      CMP R1, #4
 50|      BNE rgbypc
 51|      POP {R4}
 52|      STR R0, .WriteString // write appropriate satisfied code to output
 53|      HALT
 54|      RET
 55|msg1: .ASCIZ "Codebreaker is "
 56|codebreaker: .BLOCK 128
 57|msg2: .ASCIZ "Codemaker is "
 58|codemaker: .BLOCK 128
 59|msg3: .ASCIZ "Maximum number of guesses: "
 60|readnum: .BLOCK 128
 61|msg4: .ASCIZ "Enter a code "
 62|code: .BLOCK 128