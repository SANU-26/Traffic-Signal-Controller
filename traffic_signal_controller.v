`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2026 10:08:33
// Design Name: 
// Module Name: traffic_signal_controller
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
module traffic_signal_controller #(
    parameter integer CLK_FREQ = 100_000_000
)(
    input  wire clk,
    input  wire reset,
    input  wire pedestrian_request,
    input  wire emergency,

    output reg roadA_red,
    output reg roadA_yellow,
    output reg roadA_green,

    output reg roadB_red,
    output reg roadB_yellow,
    output reg roadB_green
);

    // ------------------------------------------------
    // State definitions
    // ------------------------------------------------

    parameter A_GREEN  = 3'b000;
    parameter A_YELLOW = 3'b001;
    parameter B_GREEN  = 3'b010;
    parameter B_YELLOW = 3'b011;
    parameter PED       = 3'b100;
    parameter EMERGENCY = 3'b101;

    reg [2:0] state;

    // Clock divider
    reg [26:0] counter;
    reg one_second;

    // ------------------------------------------------
    // Generate approximately 1 second pulse
    // ------------------------------------------------

    always @(posedge clk) begin

        if (reset) begin
            counter <= 0;
            one_second <= 0;
        end

        else begin

            if (counter == CLK_FREQ - 1) begin
                counter <= 0;
                one_second <= 1;
            end

            else begin
                counter <= counter + 1;
                one_second <= 0;
            end

        end

    end

    // ------------------------------------------------
    // FSM
    // ------------------------------------------------

    always @(posedge clk) begin

        if (reset) begin
            state <= A_GREEN;
        end

        else begin

            // Emergency has highest priority
            if (emergency) begin
                state <= EMERGENCY;
            end

            else if (one_second) begin

                case (state)

                    A_GREEN: begin

                        if (pedestrian_request)
                            state <= PED;
                        else
                            state <= A_YELLOW;

                    end

                    A_YELLOW: begin
                        state <= B_GREEN;
                    end

                    B_GREEN: begin
                        state <= B_YELLOW;
                    end

                    B_YELLOW: begin
                        state <= A_GREEN;
                    end

                    PED: begin
                        state <= A_GREEN;
                    end

                    EMERGENCY: begin
                        state <= A_GREEN;
                    end

                    default: begin
                        state <= A_GREEN;
                    end

                endcase

            end
        end
    end

    // ------------------------------------------------
    // Output logic
    // ------------------------------------------------

    always @(*) begin

        // Default all lights OFF
        roadA_red    = 0;
        roadA_yellow = 0;
        roadA_green  = 0;

        roadB_red    = 0;
        roadB_yellow = 0;
        roadB_green  = 0;

        case (state)

            // Road A GREEN
            A_GREEN: begin
                roadA_green = 1;
                roadB_red = 1;
            end

            // Road A YELLOW
            A_YELLOW: begin
                roadA_yellow = 1;
                roadB_red = 1;
            end

            // Road B GREEN
            B_GREEN: begin
                roadA_red = 1;
                roadB_green = 1;
            end

            // Road B YELLOW
            B_YELLOW: begin
                roadA_red = 1;
                roadB_yellow = 1;
            end

            // Pedestrian mode
            PED: begin
                roadA_red = 1;
                roadB_red = 1;
            end

            // Emergency mode
            EMERGENCY: begin
                roadA_red = 1;
                roadB_red = 1;
            end

            default: begin
                roadA_red = 1;
                roadB_red = 1;
            end

        endcase

    end

endmodule