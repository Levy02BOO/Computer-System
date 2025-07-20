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
 50|      MOV R0, #secretcode
 51|      MOV R1, #querycode
 52|      MOV R3, #0
 53|comparison:
 54|      PUSH {R4}
 55|      AND R1, R0, R1
 56|      LDRB R4, [R1+R3]
 57|      CMP R4, R0
 58|      BEQ equal
 59|      ADD R3,R3,#1
 60|      MOV R1, R3
 61|      CMP R1, R4
 62|      B equal
 63|equal:
 64|      ADD R3,R3,#1
 65|      MOV R0, R3
 66|      CMP R0, R4
 67|      MOV R0, #0x0A     //New line character code
 68|      STRB R0, .WriteChar
 69|      MOV R3, #msg8
 70|      STR R3, .WriteString
 71|      STR R0, .WriteUnsignedNum
 72|      MOV R3, #msg9
 73|      STR R3, .WriteString
 74|      STR R1, .WriteUnsignedNum
 75|      CMP R1, #4
 76|      BEQ win
 77|      POP {R4}
 78|      SUB R2, R2, #1
 79|      CMP R2, #0
 80|      BGT loop1
 81|      MOV R0, #0x0A     //New line character code
 82|      STRB R0, .WriteChar
 83|      MOV R1, #codebreaker
 84|      STR R1, .WriteString
 85|      MOV R3, #msg10
 86|      STR R3, .WriteString
 87|      MOV R0, #0x0A     //New line character code
 88|      STRB R0, .WriteChar
 89|      MOV R3, #msg12
 90|      STR R3, .WriteString
 91|      HALT
 92|win:
 93|      MOV R0, #0x0A     //New line character code
 94|      STRB R0, .WriteChar
 95|      MOV R1, #codebreaker
 96|      STR R1, .WriteString
 97|      MOV R3, #msg11
 98|      STR R3, .WriteString
 99|      MOV R0, #0x0A     //New line character code
100|      STRB R0, .WriteChar
101|      MOV R3, #msg12
102|      STR R3, .WriteString
103|      HALT
104|getcode:
105|      MOV R0, #msg4
106|      STR R0, .WriteString
107|      MOV R0, #code
108|      STR R0, .ReadString // read in input
109|      MOV R1, #0        // initialise index
110|rgbypc:                 // start of loop
111|      PUSH {R4}
112|      LDRB R4, [R0+R1]  // read byte from array
113|      CMP R4, #98       //b
114|      BEQ pass
115|      CMP R4, #99       //c
116|      BEQ pass
117|      CMP R4, #103      //g
118|      BEQ pass
119|      CMP R4, #112      //p
120|      BEQ pass
121|      CMP R4, #114      //r
122|      BEQ pass
123|      CMP R4, #121      //y
124|      BNE getcode
125|pass:                   //will loop to this label if all conditions are satisfied
126|      STRB R4, [R0+R1]  // write it back to the array
127|      POP {R4}
128|      ADD R1,R1,#1      // increment index
129|      cmp r1, #4
130|      STR R0, .WriteString // write appropriate satisfied code to output
131|      RET
132|msg1: .ASCIZ "Codebreaker is "
133|codebreaker: .BLOCK 128
134|msg2: .ASCIZ "Codemaker is "
135|codemaker: .BLOCK 128
136|msg3: .ASCIZ "Maximum number of guesses: "
137|readnum: .BLOCK 128
138|msg4: .ASCIZ "Enter a code "
139|code: .BLOCK 128
140|msg5: .ASCIZ ", please enter a 4-character secret code "
141|secretcode: .BLOCK 128
142|msg6: .ASCIZ "Enter query code "
143|querycode: .BLOCK 128
144|msg7: .ASCIZ ", this is guess number: "
145|msg8: .ASCIZ "Position matches: "
146|msg9: .ASCIZ ", Colour matches: "
147|msg10: .ASCIZ ", you LOSE!"
148|msg11: .ASCIZ ", you WIN!"
149|msg12: .ASCIZ "Game Over!"