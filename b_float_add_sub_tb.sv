`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2024 19:34:23
// Design Name: 
// Module Name: bfloat_add_sub_tb
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



module bfloat_add_sub_tb();

  logic [15:0] a, b;
  logic cntl, clk;
  logic [15:0] c;

  
  bfloat_add_sub dut (
    .a(a),
    .b(b),
    .c(c),
    .cntl(cntl),
    .clk(clk)
  );

 
  initial 
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  
  initial 
  begin
    logic [15:0] expected_c;

    // Test case 1: NaN detection
    a = 16'b1111111110000110; // NaN a
    b = 16'b0111111110000011; // NaN b
    cntl = 1'b0; 
    expected_c = 16'b1111111111111111; // Expected c: NaN
    #10;
    if (c == expected_c) 
      $display("Test case 1: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 1: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 2: Infinity handling
    a = 16'b0111111110000000; // +inf a
    b = 16'b0111111110000000; // +inf b
    cntl = 1'b0; 
    expected_c = 16'b0111111110000000; // Expected c: +inf
    #10;
    if (c == expected_c) 
    
      $display("Test case 2: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 2: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 3: Subnormal/zero addition and subtraction
    a = 16'b0000000000000000; // zero a
    b = 16'b0000000000000000; // zero b
    cntl = 1'b0; 
    expected_c = 16'b0; // Expected c: zero
    #10;
    if (c == expected_c) 
      $display("Test case 3: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
    
     else 
    
      $display("Test case 3: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    


    // Test case 4: Subtraction from zero
    a = 16'b0000000000000000; // zero a
    b = 16'b0111111110000000; // +inf b
    cntl = 1'b1; 
    expected_c = 16'b1111111110000000; // Expected c: -inf
    #10;
    if (c == expected_c) 
    
      $display("Test case 4: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 4: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    
    // Test case 5: Simple addition
    a = 16'b0100001101010000; // a = 6.5
    b = 16'b0100000101010000; // b = 5.5
    cntl = 1'b0; 
    expected_c = 16'b0100010000000000; // Expected c: 12.0
    #10;
    if (c == expected_c) 
    
      $display("Test case 5: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 5: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 6: Simple subtraction
    a = 16'b0100001101010000; // a = 6.5
    b = 16'b0100000101010000; // b = 5.5
    cntl = 1'b1; 
    expected_c = 16'b0011111010000000; // Expected c: 1.0
    #10;
    if (c == expected_c) 
    
      $display("Test case 6: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 6: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 7: Different signs addition
    a = 16'b0100001101010000; // a = 6.5 (positive)
    b = 16'b1100001101010000; // b = -6.5 (negative)
    cntl = 1'b0; 
    expected_c = 16'b0; // Expected c: zero
    #10;
    if (c == expected_c) 
    
      $display("Test case 7: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 7: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 8: Different signs subtraction
    a = 16'b0100001101010000; // a = 6.5 (positive)
    b = 16'b1100001101010000; // b = -6.5 (negative)
    cntl = 1'b1; 
    expected_c = 16'b0111111110000000; // Expected c: +inf
    #10;
    if (c == expected_c) 
    
      $display("Test case 8: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
    else 
      $display("Test case 8: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 9: Same exponent, different mantissas
    a = 16'b0100001101010000; // a = 6.5
    b = 16'b0100001101100000; // b = 6.75
    cntl = 1'b0; 
    expected_c = 16'b0100010000110000; // Expected c: 13.25
    #10;
    if (c == expected_c) 
    
      $display("Test case 9: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 9: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    // Test case 10: Different exponents, same mantissas
    a = 16'b0100001101010000; // a = 6.5
    b = 16'b0100000111010000; // b = 3.25
    cntl = 1'b0; 
    expected_c = 16'b0100010000000000; // Expected c: 9.75
    #10;
    if (c == expected_c)
    
      $display("Test case 10: PASS. a = %b, b = %b, cntl = %b -> c = %b", a, b, cntl, c);
     else 
      $display("Test case 10: FAIL. a = %b, b = %b, cntl = %b -> c = %b, expected: %b", a, b, cntl, c, expected_c);
    

    
    $finish;
  end

endmodule



