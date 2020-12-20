`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Tristan Richmond
// 
// Create Date: 11/18/2020 10:28:36 PM
// Design Name: 
// Module Name: Metronome_Info
// Project Name: Basys3_VGA_Metronome
// Target Devices: Basys3 Discovery Board
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Generates display for BPM and accent marks
// Format keycode for display 0CBA
// Decimal points on each segment column represent if that beat is accented
// For example, if beats 2 and 4 are accented, then the 2nd leftmost decimal and rightmost decimal will be lit on
//////////////////////////////////////////////////////////////////////////////////


module Metronome_Info
    (
    input CLK_100MHz, RST,
    input [3:0] BPM_Select, Accent_Indicator,
    output [7:0] Digit_Cathode,
    output [3:0] Select_Anode
    );
    
    reg [19:0] Segment_Counter = 500000;
    wire Segment_CLK;
    
    reg [3:0] BPM_Value_A, BPM_Value_B, BPM_Value_C;
    
    
    
    // Generate 250Hz clock for refreshing 7segment display
    Clock_Divider #(19,50) Segment_Refresh(.CLK(CLK_100MHz),.RST(RST),.Counter_Limit(Segment_Counter),.CLK_Slow(Segment_CLK));
    
    always @(posedge Segment_CLK or posedge RST)
    begin
        if(RST)
            begin
                BPM_Value_C <= 0;
                BPM_Value_B <= 0;
                BPM_Value_A <= 0;
            end
         else
            begin
                // When the BPM is odd display 5 in A segment
                // Otherwise display 0 in A segment
                if(BPM_Select[0]==1) BPM_Value_A <= 5;
                else BPM_Value_A <= 0;
                
                // When the BPM is greater than 100, display 1 in C segment
                // Otherwise display 0 in C segmnet
                if(BPM_Select[3]==1) BPM_Value_C <= 1;
                else BPM_Value_C <= 0;
                
                // When the BPM is greater than 100, the 2 bits represent the tenths value of post 100 BPM
                //     For example, 0->100 1->110 2->120 etc.
                // Otherwise, the 2 bits represent the tenths value of post 60 BPM
                //     For example, 0->60 1->70 2->80 etc.
                if(BPM_Value_C==1) BPM_Value_B <= {2'b00,BPM_Select[2:1]};
                else BPM_Value_B <= BPM_Select[2:1] + 3'b110;
            end
    end
    
    Seven_Segment Metronome_Info_Display(.CLK(CLK_100MHz),.RST(RST),.Refresh_Rate(Segment_CLK),.Data_A(BPM_Value_A),.Data_B(BPM_Value_B),.Data_C(BPM_Value_C)
    ,.Data_D(0),.Dec_A(Accent_Indicator[3]),.Dec_B(Accent_Indicator[2]),.Dec_C(Accent_Indicator[1])
    ,.Dec_D(Accent_Indicator[0]),.Digit_Cathode(Digit_Cathode),.Select_Anode(Select_Anode));
    
endmodule
