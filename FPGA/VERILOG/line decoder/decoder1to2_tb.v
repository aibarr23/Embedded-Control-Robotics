`timescale 1ns/1ns
`include "decoder.v"

module decoder1to2_tb;

reg A;
wire [1:0] D;

decoder1to2 UUT(A, D);

initial begin
    $dumpfile("decoder1to2.vcd");
    $dumpvars(0, decoder1to2_tb);

    A = 0; #20;
    A = 1; #20;

    $display("end of test.");
end


endmodule