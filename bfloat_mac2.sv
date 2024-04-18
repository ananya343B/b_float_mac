`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2023 09:40:07 AM
// Design Name: 
// Module Name: bfloat_mac
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


module bfloat_mac2(a,b,cntl,clk,out);
input bit [15:0]a,b;
input bit  clk;
input bit  cntl;// cntl = 1, sub else add
output bit [15:0]out;
bit [15:0] fprod, fadd; // output for adder and multiplier
bit [15:0] data_a, data_b, fprod1;//dunno why fprod1 is here

always@(*)
begin
data_a<=a;
data_b<=b;
end

mul_1 mul(data_a,data_b,fprod,clk);
add_sub add(fprod,out,fadd,cntl,clk);

assign out=fadd;

endmodule