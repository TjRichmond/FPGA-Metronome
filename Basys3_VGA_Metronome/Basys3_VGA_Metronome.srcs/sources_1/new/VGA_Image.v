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
    input [3:0] Beat,
    output H_Sync, V_Sync,
    output reg [3:0] Red, Green, Blue
    );
    
    localparam Left_Square = 300, Right_Square = 500,
               Top_Square = 200, Bottom_Square = 400;
    
    wire [10:0] X_Pos, Y_Pos;
    wire Draw_Display;
    wire New_Frame;
    
    VGA_Timing Display_Timing(.Pixel_CLK(Pixel_CLK),.RST(RST),.H_Sync(H_Sync),.V_Sync(V_Sync),.Draw_Image(Draw_Display)
    ,.X_Pos(X_Pos),.Y_Pos(Y_Pos));
    
    always @ *
    begin
        if(RST)
            begin
                Red <= 4'hF;
                Green <= 4'hF;
                Blue <= 4'hF;
            end
        
        // Will only enter block when in display section of X & Y grid
        else if(Draw_Display)
            begin
                // If cursor is inside 200x200 square, then display purple or green square
                // Green if beat, purple otherwise
                if(X_Pos >= Left_Square && X_Pos < Right_Square && Y_Pos >= Top_Square && Y_Pos < Bottom_Square)
                    begin
                        if(Beat!=4'b0000)
                            begin
                                Red <= 4'h0;
                                Green <= 4'hF;
                                Blue <= 4'h0;
                            end
                        else
                            begin
                                Red <= 4'hF;
                                Green <= 4'h0;
                                Blue <= 4'hF;
                            end
                    end
                // Displays black if cursor is not within the metronome square
                else
                    begin
                        Red <= 4'h0;
                        Green <= 4'h0;
                        Blue <= 4'h0;    
                    end                             
            end
    end
endmodule
