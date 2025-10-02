`timescale 1ns/1ns
`include "greater_than.v"
module greater_than_tb;
reg [1:0] A, B;
wire F;

greater_than uut(A, B, F);

initial begin

    $dumpfile("greater_than_tb.vcd");
    $dumpvars(0, greater_than_tb);

    {A, B} = 4'd0; #20;
    {A, B} = 4'd1; #20;
    {A, B} = 4'd2; #20;
    {A, B} = 4'd3; #20;
    {A, B} = 4'd4; #20;
    {A, B} = 4'd5; #20;
    {A, B} = 4'd6; #20;
    {A, B} = 4'd7; #20;
    {A, B} = 4'd8; #20;
    {A, B} = 4'd9; #20;
    {A, B} = 4'd10; #20;
    {A, B} = 4'd11; #20;
    {A, B} = 4'd12; #20;
    {A, B} = 4'd13; #20;
    {A, B} = 4'd14; #20;
    {A, B} = 4'd15; #20;
    $display("Test is complete.");
end

endmodule