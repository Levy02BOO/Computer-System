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
 33|      STR R0, .ReadString // read in input
 34|      HALT
 35|getcode:
 36|      MOV R0, #msg4
 37|      STR R0, .WriteString
 38|      MOV R0, #code
 39|      STR R0, .ReadString // read in input
 40|      MOV R1, #0        // initialise index
 41|rgbypc:                 // start of loop
 42|      PUSH {R4}
 43|      LDRB R4, [R0+R1]  // read byte from array
 44|      CMP R4, #98       //b
 45|      BEQ pass
 46|      CMP R4, #99       //c
 47|      BEQ pass
 48|      CMP R4, #103      //g
 49|      BEQ pass
 50|      CMP R4, #112      //p
 51|      BEQ pass
 52|      CMP R4, #114      //r
 53|      BEQ pass
 54|      CMP R4, #121      //y
 55|      BNE getcode
 56|pass:                   //will loop to this label if all conditions are satisfied
 57|      STRB R4, [R0+R1]  // write it back to the array
 58|      POP {R4}
 59|      ADD R1,R1,#1      // increment index
 60|      CMP R1, #4
 61|      BNE rgbypc
 62|      STR R0, .WriteString // write appropriate satisfied code to output
 63|      HALT
 64|      RET
 65|msg1: .ASCIZ "Codebreaker is "
 66|codebreaker: .BLOCK 128
 67|msg2: .ASCIZ "Codemaker is "
 68|codemaker: .BLOCK 128
 69|msg3: .ASCIZ "Maximum number of guesses: "
 70|readnum: .BLOCK 128
 71|msg4: .ASCIZ "Enter a code "
 72|code: .BLOCK 128
 73|msg5: .ASCIZ ", please enter a 4-character secret code "
 74|secretcode: .BLOCK 128