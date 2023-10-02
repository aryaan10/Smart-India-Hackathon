`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manav Shah
// 
// Create Date: 13.09.2023 19:38:10
// Design Name: 
// Module Name: Top_Pump_Plc
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


module Top_Pump_Plc(
    input   CLK100MHZ,
    output  Low,Mid,High,
    output  [7:0]water_indication,
    output pump1,pump2
    );
    
    wire w1,w2,w3;
    wire clocking;
    wire [7:0]w4;
    wire p1,p2;
    wire interconnect;
    wire [7:0]eight_bus;
   
    clock_prescaler prescale(.CLK100MHZ(CLK100MHZ),.clk_new(clocking));
    plc PLC(.clock(clocking),.L(w1),.M(w2),.H(w3), .pump1_ctrl(p1),.pump2_ctrl(p2),.water_lvl_indicator(w4),.water_trend(interconnect),.water_lvl(eight_bus));
    water_lvl_sim sim1(.CLK100MHZ(clocking), .water_trend(interconnect),.water_lvl(eight_bus));
   
    assign Low = w1;
    assign Mid = w2;
    assign High = w3;
    assign pump1 = p1;
    assign pump2 = p2;
    assign water_indication = w4;
endmodule
