`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 18:52:41
// Design Name: 
// Module Name: mul_tb
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



module mul_tb();

  logic clk;
  logic [15:0] a, b;
  logic [15:0] c;
  
  // Instantiate mul
  mul dut (
    .a(a),
    .b(b),
    .c(c),
    .clk(clk)
  );
  
  // clk
  initial begin
    clk = 0;
    forever begin
      #5 clk = ~clk; 
    end
  end
  
  // Test procedure
  initial begin
    // Display the test case header
    $display("Test Case\t| a \t| b \t| Expected c\t| Observed c");
    #100;
    // Test Case 1
    a = 16'h3F80; // 1.0 
    b = 16'h3F80; // 1.0 
    #100; 
    $display("1\t\t| %h\t| %h\t| ???\t\t| %h", a, b, c);
    
    // Test Case 2
    a = 16'h3F00; // 0.5
    b = 16'h3F80; // 1.0 
    #100; 
    $display("2\t\t| %h\t| %h\t| ???\t\t| %h", a, b, c);
    
    // Test Case 3
    a = 16'h0000; // 0.0 
    b = 16'h3F80; // 1.0
    #100; 
    $display("3\t\t| %h\t| %h\t| 0\t\t| %h", a, b, c);
    
    // Test Case 4
    a = 16'h3F80; // 1.0 
    b = 16'h0000; // 0.0 
    #100; 
    $display("4\t\t| %h\t| %h\t| 0\t\t| %h", a, b, c);
    
    // Test Case 5
    a = 16'h3FC0; // 1.5 
    b = 16'h4000; // 2.0 
    #100; 
    $display("5\t\t| %h\t| %h\t| ???\t\t| %h", a, b, c);
    
    // Test Case 6
    a = 16'hC000; // -2.0
    b = 16'h3FC0; // 1.5 
    #100; 
    $display("6\t\t| %h\t| %h\t| ???\t\t| %h", a, b, c);
    
    $finish;
  end

endmodule

