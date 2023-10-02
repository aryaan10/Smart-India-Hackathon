`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manav Shah
// 
// Create Date: 14.09.2023 11:50:43
// Design Name: 
// Module Name: trojan_trigger_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module takes clock for input and is to act as a time bomb which will trigger the Trojan, thereby activating it 

// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module trojan_trigger_control(
    input CLK100MHZ,
    input ext_trigger,
    output reg trigger
    );
    
    reg [63:0] counter = 0;
    reg [63:0] waste = 0;
    reg [63:0] waste2 = 0; 
    //excess logic 
    initial begin 
    trigger = 0;
    end
    always @(posedge CLK100MHZ)begin
       counter <= counter + 1;
       if(counter == 2500)begin
       trigger <= 1;
       end
    end
    always @(posedge CLK100MHZ)begin
      if(trigger)begin
         trigger <= 1;
      end
    end
    always @(posedge CLK100MHZ)begin
      waste = waste + 1;
      if(waste[0] == 0)begin
         waste2 <= waste2 + 1;
      end
    end
    
endmodule
