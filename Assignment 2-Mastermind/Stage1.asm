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
 23|      HALT
 24|msg1: .ASCIZ "Codebreaker is "
 25|codebreaker: .BLOCK 128
 26|msg2: .ASCIZ "Codemaker is "
 27|codemaker: .BLOCK 128
 28|msg3: .ASCIZ "Maximum number of guesses: "
 29|readnum: .BLOCK 128