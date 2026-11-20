`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2026 23:52:35
// Design Name: 
// Module Name: traffic_signal_controller_tb
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


`timescale 1ns / 1ps

module traffic_signal_controller_tb;

    reg clk;
    reg reset;
    reg pedestrian_request;
    reg emergency;

    wire roadA_red;
    wire roadA_yellow;
    wire roadA_green;
    wire roadB_red;
    wire roadB_yellow;
    wire roadB_green;

    traffic_signal_controller #(
        .CLK_FREQ(10)
    ) uut (
        .clk(clk),
        .reset(reset),
        .pedestrian_request(pedestrian_request),
        .emergency(emergency),
        .roadA_red(roadA_red),
        .roadA_yellow(roadA_yellow),
        .roadA_green(roadA_green),
        .roadB_red(roadB_red),
        .roadB_yellow(roadB_yellow),
        .roadB_green(roadB_green)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        pedestrian_request = 0;
        emergency = 0;

        #20;
        reset = 0;

        #200;
        pedestrian_request = 1;

        #100;
        pedestrian_request = 0;

        #30;
        emergency = 1;

        #50;
        emergency = 0;

        #150;
        reset = 1;

        #20;
        reset = 0;

        #100;
    end

endmodule
