`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 18:27:35
// Design Name: 
// Module Name: roundoff1_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module roundoff1_tb();
  logic [15:0] a;
  wire [15:0] b;
    roundoff1 dut(.a(a),.b(b));
    
    initial begin
    
        #100
        a = 16'b0000000000010010;
        #100; 
        a = 16'h0039;
        #100;
        a = 16'h1234;
        #100
        a = 16'h0208; 
        #100;
        a = 16'hA010;
        #100;
        
        a = 16'h3B20; 
        #100
       $finish;
    end   
endmodule
