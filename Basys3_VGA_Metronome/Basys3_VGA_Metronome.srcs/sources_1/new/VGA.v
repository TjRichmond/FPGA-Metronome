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
    output H_Sync, V_Sync,
    output [3:0] Red, Green, Blue
    );
    
    wire CLK_25MHz;
    reg [1:0] CLK_25MHz_Limit = 2;
    
    Clock_Divider #(2,50)Pixel_CLK(.CLK(CLK_100MHz),.RST(RST),.Counter_Limit(CLK_25MHz_Limit),.CLK_Slow(CLK_25MHz));
    
    VGA_Image VGA_Display(.Pixel_CLK(CLK_25MHz),.RST(RST),.H_Sync(H_Sync),.V_Sync(V_Sync),.Red(Red),.Green(Green),.Blue(Blue));
    
    
endmodule
