`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Tristan Richmond
// 
// Create Date: 10/28/2020 02:46:19 AM
// Design Name: 
// Module Name: Clock_Divider
// Project Name: Basys3_VGA_Metronome
// Target Devices: Basys3 Discovery Board
// Tool Versions: Vivado 2019.1.
// Description: 
// 
// Dependencies: 
// 
// Revision: A
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Clock_Divider
    #(parameter CLK_Size = 27, Duty_Cycle = 5)
    (
        input CLK, RST,
        input [CLK_Size-1:0] Counter_Limit,
        output reg CLK_Slow
    );
    
    reg [CLK_Size-1:0] Counter;
    initial Counter = 0;
    initial CLK_Slow = 1;
    
    
    // State Machine that adds to a counter that counts until a specifed limit
    // Once the computed duty cycle value of the maximumn is reached, the output signal turns 0
    // Once the maximumn counter value is reached, the output signal turns 1
    
    always @(posedge CLK or posedge RST)
    begin
        if(RST)
            begin
                 Counter <= 0;
                 CLK_Slow <= 1;
            end
        else
            begin   
                if(Counter >= Counter_Limit - 1) 
                    begin
                        Counter <= 0;
                        CLK_Slow <= 1;
                    end
                else if(Counter == (Counter_Limit*Duty_Cycle/100-1))
                    begin
                        CLK_Slow <= 0;
                        Counter <= Counter + 1;
                    end
                else Counter <= Counter + 1;
            end
    end
endmodule
