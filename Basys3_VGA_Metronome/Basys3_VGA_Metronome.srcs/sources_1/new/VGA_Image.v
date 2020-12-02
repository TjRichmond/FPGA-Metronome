`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Tristan Richmond
// 
// Create Date: 11/03/2020 10:58:28 PM
// Design Name: 
// Module Name: VGA_Image
// Project Name: Basys3_VGA_Metronome
// Target Devices: Basys3 Discovery Board
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: A
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module VGA_Image
    (
    input Pixel_CLK, RST,
    input [3:0] Beat, Accent,
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
                        // If the selected beat doesn't have the accent switch indicated, display green
                        if((Beat == 4'b1000 && Accent[0] == 1'b0)||(Beat == 4'b0100 && Accent[1] == 1'b0)
                         ||(Beat == 4'b0010 && Accent[2] == 1'b0)||(Beat == 4'b0001 && Accent[3] == 1'b0))
                            begin
                                Red <= 4'h0;
                                Green <= 4'hF;
                                Blue <= 4'h0;
                            end
                        // If the selected beat has the accent switch indicated, display blue
                        else if((Beat == 4'b1000 && Accent[0] == 1'b1)||(Beat == 4'b0100 && Accent[1] == 1'b1)
                              ||(Beat == 4'b0010 && Accent[2] == 1'b1)||(Beat == 4'b0001 && Accent[3] == 1'b1))
                            begin
                                Red <= 4'h3;
                                Green <= 4'h0;
                                Blue <= 4'hF;
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
