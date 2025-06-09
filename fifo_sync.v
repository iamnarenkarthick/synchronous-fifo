`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 05:50:02 PM
// Design Name: 
// Module Name: fifo_sync
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


module fifo_sync
#(
    parameter FIFO_DEPTH = 8,
    parameter DATA_WIDTH = 32
)
(
    input wire clk,
    input wire rst_n,
    input wire cs,
    input wire wr_en,
    input wire rd_en,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output wire empty,
    output wire full
);

    localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH);

    // FIFO memory declaration
    reg [DATA_WIDTH-1:0] fifo [0:FIFO_DEPTH-1];

    // Read and write pointers (with wraparound logic)
    reg [FIFO_DEPTH_LOG:0] write_pointer;
    reg [FIFO_DEPTH_LOG:0] read_pointer;

    // Write operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_pointer <= 0;
        end else if (cs && wr_en && !full) begin
            fifo[write_pointer[FIFO_DEPTH_LOG-1:0]] <= data_in;
            write_pointer <= write_pointer + 1'b1;
        end
    end

    // Read operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_pointer <= 0;
            data_out <= 0;
        end else if (cs && rd_en && !empty) begin
            data_out <= fifo[read_pointer[FIFO_DEPTH_LOG-1:0]];
            read_pointer <= read_pointer + 1'b1;
        end
    end

    // Status flag logic
    assign empty = (read_pointer == write_pointer);
    assign full  = (write_pointer[FIFO_DEPTH_LOG]     != read_pointer[FIFO_DEPTH_LOG]) &&
                   (write_pointer[FIFO_DEPTH_LOG-1:0] == read_pointer[FIFO_DEPTH_LOG-1:0]);

endmodule

