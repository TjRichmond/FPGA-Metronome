`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State Univsersity
// Engineer: Tristan Richmond
// 
// Create Date: 10/28/2020 02:52:48 AM
// Design Name: 
// Module Name: Metronome_Clock
// Project Name: Basys3_VGA_Metronome
// Target Devices: Basys3 Discover Board
// Tool Versions: Vivado 2019.1.3
// Description: 
// 
// Dependencies: 
// 
// Revision: A
// Revision 0.01 - File Created
// Additional Comments:
// This metronome supports BPM values between 60 and 120 in increments of 5
//////////////////////////////////////////////////////////////////////////////////


module Metronome_Clock
    (
    input CLK, RST,
    input [3:0] BPM_Select,
    output reg [0:3] Beat_Out
    );
    
    // Met_Bit_Size sets allocates the necesary amount of bits for the counter variable
    // Met_Duty_Cycle sets the duty cycle of metronome waveform; supports options 0%-100%
    // Example: 5 -> 5%, 20 -> 20%, ... 100 -> 100%
    parameter Met_Bit_Size = 27, Met_Duty_Cycle = 10;
    
    // Configure the maximumn counter value for the metronome clock
    // Depending on inputed BPM selection, the BPM will multiply to a constant value which is equivalent to 5 BPM
    // This product will be subtracted from the base limit which is the equivalent for 60 BPM
    wire [Met_Bit_Size-1:0] Metronome_Counter_Limit;
    assign Metronome_Counter_Limit = 100000000 - (BPM_Select * 3125000);
    
    reg [1:0] Beat_Counter;
    initial Beat_Counter = 2'b0;
    
    Clock_Divider #(Met_Bit_Size,Met_Duty_Cycle) Metronome_Clock_Divider(.CLK(CLK),.RST(RST),.Counter_Limit(Metronome_Counter_Limit)
    ,.CLK_Slow(Met_CLK));
    
    // State Machine that adds to the Beat Counter each time a beat is reached
    // 4 beats total before it resets to the 1st beat
    always @(posedge Met_CLK or posedge RST)
    begin
        if(RST)
            begin
                Beat_Counter <= 2'b0;
            end
        else
            begin
                Beat_Counter <= Beat_Counter + 1;
            end
    end 
    
    // State Machine that displays the beat indication on the corresponding beat to LED
    // Four LEDs going left to right
    // Example: Beat 2 XOXX
    // X is OFF o is ON  
    always @(posedge CLK or posedge RST)
    begin
        if(RST)
            begin
                Beat_Out <= 4'b0;
            end
        else
            begin
                Beat_Out[Beat_Counter] <= Met_CLK;
                Beat_Out[Beat_Counter+1] <= 1'b0;
                Beat_Out[Beat_Counter+2] <= 1'b0;
                Beat_Out[Beat_Counter+3] <= 1'b0;
            end
    end
endmodule
