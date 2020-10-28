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
    input [3:0] BPM_Select,
    output [3:0] LED_Met
    );
    
    // Instantuate Metronome Clock module to compute BPM, generate Beat number, and Beat signal for other modules
    Metronome_Clock Met_Clock(.CLK(CLK),.RST(RST),.BPM_Select(BPM_Select),.Beat_Out(LED_Met));
    
endmodule
