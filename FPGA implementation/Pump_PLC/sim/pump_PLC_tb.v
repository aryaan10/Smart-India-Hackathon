`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manav Shah
// 
// Create Date: 13.09.2023 20:01:43
// Design Name: 
// Module Name: pump_PLC_tb
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


module pump_PLC_tb();

reg CLK100MHZ;
wire High,Low,Mid,pump1,pump2;
wire [7:0] water_indication;
Top_Pump_Plc PLC1(.CLK100MHZ(CLK100MHZ),.High(High),.Low(Low),.Mid(Mid),.pump1(pump1),.pump2(pump2),.water_indication(water_indication));

initial begin
CLK100MHZ=0;
end

always #5 CLK100MHZ = ~ CLK100MHZ;
endmodule
