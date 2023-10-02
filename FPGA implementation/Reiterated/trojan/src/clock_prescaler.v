`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2023 13:39:19
// Design Name: 
// Module Name: clock_prescaler
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


module clock_prescaler(
    input CLK100MHZ,
    output clk_new
    );
    reg [24:0]counter;
    reg out_clock;
    // input is 100 MHz clk
    // output - 1 water level is 200 mili Second 
    initial begin
    counter = 1;
    out_clock =0;
    end
    always @(posedge CLK100MHZ)begin
    counter = counter + 1;
    if(counter == 2000000)begin
    counter = 1;
    out_clock = ~ out_clock;
    end
    end
        assign clk_new = out_clock;

endmodule
