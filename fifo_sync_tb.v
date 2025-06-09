`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 07:03:51 PM
// Design Name: 
// Module Name: fifo_sync_tb
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


module fifo_sync_tb;

    // Parameters
    parameter FIFO_DEPTH = 8;
    parameter DATA_WIDTH = 32;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg cs;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire empty;
    wire full;

    // Instantiate the FIFO
    fifo_sync #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .cs(cs),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Task to write data
    task fifo_write(input [DATA_WIDTH-1:0] data);
        begin
            @(posedge clk);
            if (!full) begin
                cs <= 1;
                wr_en <= 1;
                rd_en <= 0;
                data_in <= data;
            end
            @(posedge clk);
            cs <= 0;
            wr_en <= 0;
        end
    endtask

    // Task to read data
    task fifo_read;
        begin
            @(posedge clk);
            if (!empty) begin
                cs <= 1;
                wr_en <= 0;
                rd_en <= 1;
            end
            @(posedge clk);
            cs <= 0;
            rd_en <= 0;
        end
    endtask

    // Initial block
    initial begin
        // Enable waveform dump
        $dumpfile("fifo_sync_tb.vcd");
        $dumpvars(0, fifo_sync_tb);

        // Initialize
        clk = 0;
        rst_n = 0;
        cs = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Reset FIFO
        #10 rst_n = 1;

        // Write 8 data values into FIFO
        $display("Writing to FIFO...");
        repeat (FIFO_DEPTH) begin
            fifo_write($random);
        end

        // Try writing when full
        $display("Attempting write when FIFO is full...");
        fifo_write(32'hDEADBEEF);

        // Read 4 values from FIFO
        $display("Reading from FIFO...");
        repeat (4) begin
            fifo_read();
        end

        // Write 2 more values
        $display("Writing additional data...");
        fifo_write(32'hAABBCCDD);
        fifo_write(32'h11223344);

        // Read all values remaining in FIFO
        $display("Reading remaining values...");
        repeat (6) begin
            fifo_read();
        end

        // Try reading when empty
        $display("Attempting read when FIFO is empty...");
        fifo_read();

        // End simulation
        #20 $finish;
    end

endmodule

