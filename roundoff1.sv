`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 18:26:22
// Design Name: 
// Module Name: roundoff1
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


module roundoff1(input logic[15:0]a, output logic[15:0] b);
  //round subnormals to zero
  wire sign;
  reg [6:0]man;
  wire [7:0]exp;
  
 assign exp = a[14:7];
 assign sign = a[15];

  
  always @(*)
    begin
    
      if(exp == 8'b0)
        man = 7'b0;
      else 
        man = a[6:0];
        
      b[15] = sign;
      b[14:7] = exp;
      b[6:0] = man;
    end 

  
endmodule
