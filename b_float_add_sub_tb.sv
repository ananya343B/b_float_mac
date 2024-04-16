`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 11:01:02
// Design Name: 
// Module Name: b_float_add_sub_tb
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


module b_float_add_sub_tb();

    
    reg [15:0] a;
    reg [15:0] b;
    reg cntl;
    reg clk;


    wire [15:0] c;

    
    bfloat_add_sub dut (
        .a(a),
        .b(b),
        .c(c),
        .cntl(cntl),
        .clk(clk)
    );

  
    always #5 clk = ~clk;
    
    initial begin
    #100
        // Initialize inputs
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
        cntl = 0;
        clk = 0;
        #100
        // Wait for some time
    

       
        a = 16'b0011111110111001; // 1.45
        b = 16'b0011111110100010; // 1.27
        cntl = 0;
        #100;

        /* Test Case 2: Subtraction of two positive numbers
        a = 16'b0100000000000000; // 2.0
        b = 16'b0100000000000000; // 2.0
        cntl = 1;
        #10;*/

       #100 $finish;
    end
  
endmodule
