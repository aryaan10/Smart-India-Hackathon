`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manav Shah
// 
// Create Date: 13.09.2023 12:06:36
// Design Name: 
// Module Name: water_lvl_sim
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


module water_lvl_sim(
    input CLK100MHZ,
    input water_trend, 
    output reg [7:0] water_lvl
    );
    
    initial begin
    water_lvl <= 8'b0;
    end
    
    always @(posedge CLK100MHZ)begin
    if(water_trend)begin
    water_lvl <= water_lvl + 8'b00000001;
    end
    else begin
    water_lvl <= water_lvl - 8'b00000001;
    end
    
    end
endmodule
