`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 09:50:32 PM
// Design Name: 
// Module Name: VGA
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


module VGA
    (
    input CLK_100MHz, RST,
    input [3:0] Metronome_Beat, Accent_Beat,
    output H_Sync, V_Sync,
    output [3:0] Red, Green, Blue
    );
    
    wire CLK_50MHz;
    reg [1:0] CLK_50MHz_Limit = 2;
    
    Clock_Divider #(2,50)Pixel_CLK(.CLK(CLK_100MHz),.RST(RST),.Counter_Limit(CLK_50MHz_Limit),.CLK_Slow(CLK_50MHz));
    
    VGA_Image VGA_Display(.Pixel_CLK(CLK_50MHz),.RST(RST),.Beat(Metronome_Beat),.Accent(Accent_Beat),.H_Sync(H_Sync),.V_Sync(V_Sync),
    .Red(Red),.Green(Green),.Blue(Blue));
    
endmodule
