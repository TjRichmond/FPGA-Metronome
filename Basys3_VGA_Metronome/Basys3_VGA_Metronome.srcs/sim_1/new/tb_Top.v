`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2020 07:12:31 PM
// Design Name: 
// Module Name: tb_Top
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


module tb_Top;

parameter Clock_Period = 5;

reg CLK, RST;
reg [3:0] BPM_Sel;
wire H_Sync, V_Sync;
wire [3:0] LED, Red, Green, Blue;

Top_Module Top(.CLK(CLK),.RST(RST),.BPM_Select(BPM_Sel),.VGA_H_Sync(H_Sync),.VGA_V_Sync(V_Sync),.LED_Met(LED)
,.VGA_Red(Red),.VGA_Green(Green),.VGA_Blue(Blue));

initial CLK = 0;

always #(Clock_Period/2) CLK = ~CLK;
initial
    begin
        BPM_Sel <= 4'b1111;
        RST=1;
        repeat(2) @(posedge CLK);
        RST=0;
        repeat(10000) @(posedge CLK);
        $finish;
    end
endmodule
