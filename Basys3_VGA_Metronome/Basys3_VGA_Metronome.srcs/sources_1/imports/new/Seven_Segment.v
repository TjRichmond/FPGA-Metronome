`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2020 08:15:11 PM
// Design Name: 
// Module Name: Seven_Segment
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


module Seven_Segment
    (
    input CLK, RST, Refresh_Rate,
    input [3:0] Data_A, Data_B, Data_C, Data_D,
    input Dec_A, Dec_B, Dec_C, Dec_D,
    output reg [7:0] Digit_Cathode,
    output reg [3:0] Select_Anode
    );
    
    localparam Display_A = 2'b00, Display_B = 2'b01,
               Display_C = 2'b10, Display_D = 2'b11,
               Zero = 4'b0000, One = 4'b0001, Two = 4'b0010, Three = 4'b0011,
               Four = 4'b0100, Five = 4'b0101, Six = 4'b0110, Seven = 4'b0111,
               Eight = 4'b1000, Nine = 4'b1001, A = 4'b1010, B = 4'b1011,
               C = 4'b1100, D = 4'b1101, E = 4'b1110, F = 4'b1111;         
    
    reg [1:0] Segment_Select;
    
    always @(posedge Refresh_Rate or posedge RST)
    begin
        if(RST) Segment_Select <= 2'b00;
        else Segment_Select <= Segment_Select + 2'b01;
    end
    
    always @(posedge CLK)
    begin
        case(Segment_Select)
            Display_A:
                begin
                    Select_Anode <= 4'b1110;
                    if(Dec_A) Digit_Cathode[7] <= 1'b0;
                    else Digit_Cathode[7] <= 1'b1;
                    case(Data_A)
                        Zero: Digit_Cathode[6:0] <= 7'b1000000;
                        One: Digit_Cathode[6:0] <= 7'b1111001;
                        Two: Digit_Cathode[6:0] <= 7'b0100100;
                        Three: Digit_Cathode[6:0] <= 7'b0110000;
                        Four: Digit_Cathode[6:0] <= 7'b0011001;
                        Five: Digit_Cathode[6:0] <= 7'b0010010;
                        Six: Digit_Cathode[6:0] <= 7'b0000010;
                        Seven: Digit_Cathode[6:0] <= 7'b1111000;
                        Eight: Digit_Cathode[6:0] <= 7'b0000000;
                        Nine: Digit_Cathode[6:0] <= 7'b0010000;
                        A: Digit_Cathode[6:0] <= 7'b0001000;
                        B: Digit_Cathode[6:0] <= 7'b0000011;
                        C: Digit_Cathode[6:0] <= 7'b1000110;
                        D: Digit_Cathode[6:0] <= 7'b0100001;
                        E: Digit_Cathode[6:0] <= 7'b0000110;
                        F: Digit_Cathode[6:0] <= 7'b0001110;
                        default: Digit_Cathode[6:0] <= 7'b0011011;
                    endcase
                end
            Display_B:
                begin
                    Select_Anode <= 4'b1101;
                    if(Dec_B) Digit_Cathode[7] <= 1'b0;
                    else Digit_Cathode[7] <= 1'b1;
                    case(Data_B)
                        Zero: Digit_Cathode[6:0] <= 7'b1000000;
                        One: Digit_Cathode[6:0] <= 7'b1111001;
                        Two: Digit_Cathode[6:0] <= 7'b0100100;
                        Three: Digit_Cathode[6:0] <= 7'b0110000;
                        Four: Digit_Cathode[6:0] <= 7'b0011001;
                        Five: Digit_Cathode[6:0] <= 7'b0010010;
                        Six: Digit_Cathode[6:0] <= 7'b0000010;
                        Seven: Digit_Cathode[6:0] <= 7'b1111000;
                        Eight: Digit_Cathode[6:0] <= 7'b0000000;
                        Nine: Digit_Cathode[6:0] <= 7'b0010000;
                        A: Digit_Cathode[6:0] <= 7'b0001000;
                        B: Digit_Cathode[6:0] <= 7'b0000011;
                        C: Digit_Cathode[6:0] <= 7'b1000110;
                        D: Digit_Cathode[6:0] <= 7'b0100001;
                        E: Digit_Cathode[6:0] <= 7'b0000110;
                        F: Digit_Cathode[6:0] <= 7'b0001110;
                        default: Digit_Cathode[6:0] <= 7'b0011011;
                    endcase
                end
            Display_C:
                begin
                    Select_Anode <= 4'b1011;
                    if(Dec_C) Digit_Cathode[7] <= 1'b0;
                    else Digit_Cathode[7] <= 1'b1;
                    case(Data_C)
                        Zero: Digit_Cathode[6:0] <= 7'b1000000;
                        One: Digit_Cathode[6:0] <= 7'b1111001;
                        Two: Digit_Cathode[6:0] <= 7'b0100100;
                        Three: Digit_Cathode[6:0] <= 7'b0110000;
                        Four: Digit_Cathode[6:0] <= 7'b0011001;
                        Five: Digit_Cathode[6:0] <= 7'b0010010;
                        Six: Digit_Cathode[6:0] <= 7'b0000010;
                        Seven: Digit_Cathode[6:0] <= 7'b1111000;
                        Eight: Digit_Cathode[6:0] <= 7'b0000000;
                        Nine: Digit_Cathode[6:0] <= 7'b0010000;
                        A: Digit_Cathode[6:0] <= 7'b0001000;
                        B: Digit_Cathode[6:0] <= 7'b0000011;
                        C: Digit_Cathode[6:0] <= 7'b1000110;
                        D: Digit_Cathode[6:0] <= 7'b0100001;
                        E: Digit_Cathode[6:0] <= 7'b0000110;
                        F: Digit_Cathode[6:0] <= 7'b0001110;
                        default: Digit_Cathode[6:0] <= 7'b0011011;
                    endcase
                end
            Display_D:
                begin
                    Select_Anode <= 4'b0111;
                    if(Dec_D) Digit_Cathode[7] <= 1'b0;
                    else Digit_Cathode[7] <= 1'b1;
                    case(Data_D)
                        Zero: Digit_Cathode[6:0] <= 7'b1000000;
                        One: Digit_Cathode[6:0] <= 7'b1111001;
                        Two: Digit_Cathode[6:0] <= 7'b0100100;
                        Three: Digit_Cathode[6:0] <= 7'b0110000;
                        Four: Digit_Cathode[6:0] <= 7'b0011001;
                        Five: Digit_Cathode[6:0] <= 7'b0010010;
                        Six: Digit_Cathode[6:0] <= 7'b0000010;
                        Seven: Digit_Cathode[6:0] <= 7'b1111000;
                        Eight: Digit_Cathode[6:0] <= 7'b0000000;
                        Nine: Digit_Cathode[6:0] <= 7'b0010000;
                        A: Digit_Cathode[6:0] <= 7'b0001000;
                        B: Digit_Cathode[6:0] <= 7'b0000011;
                        C: Digit_Cathode[6:0] <= 7'b1000110;
                        D: Digit_Cathode[6:0] <= 7'b0100001;
                        E: Digit_Cathode[6:0] <= 7'b0000110;
                        F: Digit_Cathode[6:0] <= 7'b0001110;
                        default: Digit_Cathode[6:0] <= 7'b0011011;
                    endcase
                end
            default:
                begin
                    Select_Anode <=4'b0000;
                    Digit_Cathode <= 8'b10001110;
                end
        endcase
    end
endmodule
