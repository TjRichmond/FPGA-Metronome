`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 10:58:28 PM
// Design Name: 
// Module Name: VGA_Image
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


module VGA_Image
    (
    input Pixel_CLK, RST,
    output H_Sync, V_Sync,
    output reg [3:0] Red, Green, Blue
    );
    
    wire [9:0] X_Pos, Y_Pos;
    wire Draw_Flag;
    
    VGA_Timing Display_Timing(.Pixel_CLK(Pixel_CLK),.RST(RST),.H_Sync(H_Sync),.V_Sync(V_Sync),.Draw_Image(Draw_Flag)
    ,.X_Pos(X_Pos),.Y_Pos(Y_Pos));
    
    always @ *
    begin
        if(RST)
            begin
                Red <= 4'h0;
                Green <= 4'h0;
                Blue <= 4'h0;
            end
            
        else if(Draw_Flag)
            begin
                Red <= 4'h0;
                Green <= 4'hF;
                Blue <= 4'h0;
            end
    end
    
endmodule
