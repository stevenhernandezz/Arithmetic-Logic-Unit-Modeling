/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #10                 Steven Hernandez, Fall, 2023 ***
***                                                                      ***
*** Experiment #10 Arithmetic-Logic Unit Modeling                        ***
 ***                                                                      ***
****************************************************************************
*** Filename: ALU.v       Created by Steven Hernandez, 11/20/23 	 ***
***                                                                      ***
****************************************************************************
*** This module is for my ALU which has various arithemtic tests and has  ***
*** carry, overflow, signed, and zero flag. I will be using this to test  ***
*** unsigned and signed inputs                                            ***
****************************************************************************/

`timescale 1 ns / 100 ps
 
module ALU(OPCODE, A, B, clk, en, oe, ALU_OUT, CF, OF, SF, ZF);
	      //parameter 
	          parameter WIDTH = 8;
	
	      //I.O
	        input [3:0] OPCODE;
	        input [WIDTH-1:0] A, B;
	        input clk, en, oe;
	        output [WIDTH-1:0] ALU_OUT;
	        output reg CF, OF, SF, ZF;    //carry, overfow, signed, zero
                 
          reg [WIDTH:0] ALU_OUT_RESULT;
	
         // opcode table
  always @(posedge clk)
    if (en) begin
      case (OPCODE)
        4'b0010: begin
          {CF, ALU_OUT_RESULT} = A + B;
          // Overflow check for addition
          if (A[WIDTH-1] & B[WIDTH-1] & ~ALU_OUT_RESULT[WIDTH-1] || ~A[WIDTH-1] & ~B[WIDTH-1] & ALU_OUT_RESULT[WIDTH-1])
            OF = 1'b1;
          else
            OF = 1'b0;
        end
        4'b0011: begin
          ALU_OUT_RESULT = A - B;
          // Carry check for subtraction
          if (A < B)
            CF = 1'b1;
          else
            CF = 1'b0;
          // Overflow check for subtraction
          if (A[WIDTH-1] & B[WIDTH-1] & ~ALU_OUT_RESULT[WIDTH-1] || ~A[WIDTH-1] & ~B[WIDTH-1] & ALU_OUT_RESULT[WIDTH-1])
            OF = 1'b1;
          else
            OF = 1'b0;
        end
        4'b0100: ALU_OUT_RESULT = A & B; // AND operation
        4'b0101: ALU_OUT_RESULT = A | B; // OR operation
        4'b0110: ALU_OUT_RESULT = A ^ B; // XOR operation
        4'b0111: ALU_OUT_RESULT = ~A;    // NOT operation
        default: ALU_OUT_RESULT = 8'b0;
      endcase

      // OF and CF reset
       if (OPCODE != 4'b0010 && OPCODE != 4'b0011) begin
         OF = 1'b0;
         CF = 1'b0;
       end

      // Zero flag result is all zeros
      ZF = (ALU_OUT_RESULT == 8'b0);

      // Signed flag
      SF = ALU_OUT_RESULT[7];
    end

  // OE disabled: data outputs high Z
  assign ALU_OUT = (oe ? ALU_OUT_RESULT : 8'bz);

endmodule

