`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 09:56:43 PM
// Design Name: 
// Module Name: VGA_Timing
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


module VGA_Timing
    (
    input Pixel_CLK, RST,
    output reg H_Sync, V_Sync, Draw_Image,
    output reg [10:0] X_Pos, Y_Pos
    );
    
    localparam H_Display_End = 799, H_Sync_Start = 855, H_Sync_End = 975, H_Period = 1039,
               V_Display_End = 599, V_Sync_Start = 636, V_Sync_End = 642, V_Period = 665;
               
    always @(posedge Pixel_CLK or posedge RST)
    begin
        if(RST)
            begin
                X_Pos <= 11'b0;
                Y_Pos <= 11'b0;
                H_Sync <= 1'b0;
                V_Sync <= 1'b0;
                Draw_Image <= 1'b0;
            end
        else
            begin
                // Horizontal Timings
                if(X_Pos == H_Period)
                    begin
                         X_Pos <= 1'b0;            // X position is reset to 0
                         Y_Pos <= Y_Pos + 1;    // Increment Y position because of the X position reset
                    end
                else if(X_Pos >= H_Sync_Start && X_Pos <= H_Sync_End)
                    begin
                        X_Pos <= X_Pos + 1;     // Increment X position and Output high for H_Sync only when
                        H_Sync <= 1'b1;            // X counter is in the porch sections of the screen
                    end
                else
                    begin
                        X_Pos <= X_Pos + 1;     // Increment X position and Output low for H_Sync only when
                        H_Sync <= 1'b0;            // Y counter is in displaying or syncing sections of the screen
                    end
                
                // Vertical Timings
                if(Y_Pos == V_Period) Y_Pos <= 1'b0; // Maximum Screen Timing reached
                else if(Y_Pos >= V_Sync_Start && Y_Pos <= V_Sync_End)
                    begin
                        V_Sync <= 1'b1;    // Output high for V_Sync only when Y counter is in the porch sections of the screen
                    end
                else
                    begin
                        V_Sync <= 1'b0;    // Output low for V_Sync only when Y counter is displaying or syncing of the screen
                    end
                
                // Draw Image Set
                if(X_Pos <= H_Display_End && Y_Pos <= V_Display_End) Draw_Image <= 1'b1; // Draw image flag high during
                                                                                         // Display seciton
                else Draw_Image <= 1'b0;   // Draw image flag low outside of display section
            end
    end
    
endmodule
