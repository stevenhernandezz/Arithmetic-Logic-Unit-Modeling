/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #10                 Steven Hernandez, Fall, 2023 ***
***                                                                      ***
*** Experiment #10 Arithmetic-Logic Unit Modeling                        ***
***                                                                      ***
****************************************************************************
*** Filename: ALU_tb.sv       Created by Steven Hernandez, 11/20/23 	       ***
***                                                                      ***
****************************************************************************
*** This is a testbench for my ALU which will test various inputs for A  ***
*** and B inputs for each arithmetic operation. ***I testing and showing ***
*** each output                                                          ***
****************************************************************************/

`timescale 1 ns / 100 ps
`define MONITOR_STR_1  "%d: ALU_OUT = %b, A = %b, B = %b, CF = %b, OF = %b, SF = %b, ZF = %b, EN = %b, OE = %b"
module ALU_tb;
	      //parameter 
	          parameter WIDTH = 8;
	 
	      //I.O
	        reg [3:0] OPCODE;
	        reg [WIDTH-1:0] A, B;
	        reg clk, en, oe;
	        wire [WIDTH-1:0] ALU_OUT_S;
                
	        wire CF, OF, SF, ZF;    //carry, overfow, signed, zero
        
         ALU uut(.OPCODE(OPCODE), .A(A), .B(B), .clk(clk), .en(en), .oe(oe), .ALU_OUT(ALU_OUT_S), .CF(CF), .OF(OF), .SF(SF), .ZF(ZF));
        

         //monitoring from main code
         initial begin 
		        $monitor(`MONITOR_STR_1, $time, ALU_OUT_S, A, B, CF, OF, SF, ZF, en, oe);
	        end	    

         //init clock
            initial begin
               clk = 0;
               forever begin
               #5 clk = ~clk;  
         end
   end
   
       initial begin
       $vcdpluson;
       
       //unsigned value test for addition 
          en = 1;
          oe = 1;
          OPCODE = 4'b0010;      //result: OF, SF
          A = 8'b01111111;
          B = 8'b00000001;
          #40;
          
       //subtraction test unsigned
          en = 1;
          oe = 1;
          OPCODE = 4'b0011;      //result:  OF, SF
          A = 8'b11011010;
          B = 8'b01100100;
          #40;
        
       //and test unsigned
          en = 1;
          oe = 1;
          OPCODE = 4'b0100;  // result: SF
          A = 8'b10101010;
          B = 8'b11001100;
          #40;
       
       //or test unsigned
          en = 1;
          oe = 1;
          OPCODE = 4'b0101;  //result: SF
          A = 8'b11110000;
          B = 8'b00111100;
          #40;
       
       //xor test unsigned
          en = 1;
          oe = 1;
          OPCODE = 4'b0110;  //result: ZF
          A = 8'b01010101;
          B = 8'b01010101;
          #40;
       
       //not test unsigned
          en = 1;
          oe = 1;
          OPCODE = 4'b0111;    //01010101
          A = 8'b10101010;
          B = 8'b00000000;
           #40;
       
       
       //signed tests 
       $display(" SIGNED TESTING");
       //addition signed
         en = 1;
          oe = 1;
          OPCODE = 4'b0010;      //result: OF, SF
          A = 8'sb01111111; 
          B = 8'sb00000001;
          #40;
          
       //subtraction test signed
          en = 1;
          oe = 1;
          OPCODE = 4'b0011;      //result: OF SF
          A = 8'sb01011010;
          B = 8'sb11011001;
          #40;
        
       //and test signed
          en = 1;
          oe = 1;
          OPCODE = 4'b0100;  //result: CF, SF
          A = 8'sb11011011;
          B = 8'sb10101010;
          #40;
       
       //or test signed
          en = 1;
          oe = 1;
          OPCODE = 4'b0101;  // result: 11111111, sf
          A = 8'sb00000000;
          B = 8'sb00000000;
          #40;
       
       //xor test signed
          en = 1;
          oe = 1;
          OPCODE = 4'b0110;  //result: SF
          A = 8'sb11011011;
          B = 8'sb10101010;
          #40;
       
       //not test signed
          en = 1;
          oe = 1;
          OPCODE = 4'b0111;    //result: 00100100
          A = 8'sb11011011;
           #40;
          
       //High impedance test 
          oe = 0;
          en = 1;    //result: zzzzzzzz
          #40;
       
 #20 $finish;
  end
endmodule 