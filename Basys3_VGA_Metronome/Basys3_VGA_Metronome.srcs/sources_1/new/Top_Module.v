`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Tristan Richmond
// 
// Create Date: 10/28/2020 01:50:16 AM
// Design Name: 
// Module Name: Top_Module
// Project Name: Basys3_VGA_Metronome
// Target Devices: Basys3 Discovery Board
// Tool Versions: Vivado 2019.1.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_Module
    (
    input CLK, RST,
    input [3:0] BPM_Select, Accent_Select,
    output VGA_H_Sync, VGA_V_Sync,
    output [3:0] LED_Met, VGA_Red, VGA_Green, VGA_Blue, Select_Anode,
    output [7:0] Digit_Cathode
    );
    
    // Instantuate Metronome Clock module to compute BPM, generate Beat number, and Beat signal for other modules
    Metronome_Clock Met_Clock(.CLK(CLK),.RST(RST),.BPM_Select(BPM_Select),.Accent_Select(Accent_Select),.Beat_Out(LED_Met));
    
    // Display Image module to translate metronome singal into image for display
    VGA Metronome_Display(.CLK_100MHz(CLK),.RST(RST),.Metronome_Beat(LED_Met),.Accent_Beat(Accent_Select),.H_Sync(VGA_H_Sync)
    ,.V_Sync(VGA_V_Sync),.Red(VGA_Red),.Green(VGA_Green),.Blue(VGA_Blue));
    
     // 7-segment Display for showing BPM selected and Accent(s) selected
     Metronome_Info Segment_Display(.CLK_100MHz(CLK),.RST(RST),.BPM_Select(BPM_Select),.Accent_Indicator(Accent_Select)
     ,.Digit_Cathode(Digit_Cathode),.Select_Anode(Select_Anode));
       
    
endmodule
