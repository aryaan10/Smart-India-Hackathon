`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manav Shah
// 
// Create Date: 14.09.2023 08:12:42
// Design Name: 
// Module Name: Trojan_PLC
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


module Trojan_PLC(

    input CLK100MHZ,
    input [7:0] water_lvl,
    input trigger,
    //input trend,                  // tells this module wether water level is rising (1) or falling (0)
    output reg pump1_ctrl, pump2_ctrl, [7:0]water_lvl_indicator,
    output reg L, M, H,
    output water_trend
    );
    reg trend;
    
    initial begin
    pump1_ctrl = 0;
    pump2_ctrl = 0;
    L = 0;
    M = 0;
    H = 0;
    trend = 1;
    end

    always @(posedge CLK100MHZ)begin
    if(!trigger)begin
        if(water_lvl == 8'b0)begin
           L <= 1;          // in the low lvl
           M <= 0;
           H <= 0;        
           pump1_ctrl <= 1; // pump water in
           pump2_ctrl <= 0; // dont pump it out
           trend = 1;       // water is filling
        end
        if(water_lvl < 8'b00010101 && trend == 0 )begin
          //start pumping water again 
          pump1_ctrl <= 1;
          pump2_ctrl <= 0;
          trend = 1;
        end
        if(water_lvl >= 8'b00010100 && water_lvl < 8'b00110010)begin       // lvl > 20 and <50
           L <= 1;          // in the low lvl
           M <= 0;
           H <= 0;
           if(trend)begin   // if level rising in 20 to 50, let it rise
           pump1_ctrl <= 1;    
           pump2_ctrl <= 0;  
           end
           else begin       // if level is falling in 50 to 20, let it fall 
           pump1_ctrl <= 0;
           pump2_ctrl <= 1;
           end 
        end
        if(water_lvl > 8'b00110010 && water_lvl < 8'b01011010) begin   // lvl >50 and <90
            L <= 0;  
            M <= 1;          // in the mid range 
            H <= 0;
            if(trend)begin   // if lvl is rising in 50 to 90 range let it rise  
            pump1_ctrl <= 1;                                             
            pump2_ctrl <= 0;  
            end     
            else begin       // if lvl was falling in this range then let it fall 
            pump1_ctrl <= 0;
            pump2_ctrl <= 1;
            end
        end
        if(water_lvl >= 8'b01011010)begin                               // level touches 90
        pump1_ctrl <= 0;                                                // pump 1 off and pump 2 on
        pump2_ctrl <= 1;
        trend <= 0;          // water level is falling 
        end 
      end 
      else begin
      pump1_ctrl <= 1;
      pump2_ctrl <= 0;
      trend <=1;
      end
     end
     
     
   assign water_trend = trend;
   assign water_lvl_indicator = water_lvl;
endmodule
