`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 11:45:01 PM
// Design Name: 
// Module Name: tb_VGA
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


module tb_VGA;

parameter Clock_Period = 5;

reg CLK, RST;
wire VGA_H_Sync, VGA_V_Sync;
wire [3:0] VGA_Red, VGA_Green, VGA_Blue;

VGA Metronome_Display(.CLK_100MHz(CLK),.RST(RST),.H_Sync(VGA_H_Sync),.V_Sync(VGA_V_Sync),.Red(VGA_Red),.Green(VGA_Green),
    .Blue(VGA_Blue));

initial CLK = 0;
initial RST = 0;

always #(Clock_Period/2) CLK = ~CLK;
initial
    begin
        RST=1;
        repeat(2) @(posedge CLK);
        RST=0;
        repeat(1000) @(posedge CLK);
        $finish;
    end
endmodule
