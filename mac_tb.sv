`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 21:22:30
// Design Name: 
// Module Name: mac_tb
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


module mac_tb();

reg [15:0]a,b;
reg clk,cntl;
wire [15:0]out;

always begin
#5;
clk = ~clk;
end 

initial clk=1;

bfloat_mac2 test(.a(a),.b(b),.cntl(cntl),.clk(clk),.out(out));

initial
begin 

// here nor a or b is given so out = 0(initial value)
#17; 

a = 16'b0011110111001101; //0.1
b = 16'b0011111110000000; //1.0
cntl = 0; //addition
//for this out = 16'b0011110111001101
#20;

a = 16'b0011111100000000; //0.5
b = 16'b0011111100000000; //0.5
// 0.1 + 0.25 = 1.25 => out = 16'b0011111110100000
#20;

a = 16'b1011110111001101; //-0.1
// 1.25 + 0.5*-0.1 = 0.75 => out = 16'b0011111101000000
#20;


$finish;
end 

endmodule
