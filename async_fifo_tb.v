`timescale 1ns/1ps

module async_fifo_tb;
    reg wclk = 0, wrst_n = 0, w_en = 0;
    reg rclk = 0, rrst_n = 0, r_en = 0;
    reg [7:0] wdata = 0;
    wire [7:0] rdata;
    wire full, empty;

    // Instantiate UUT
    async_fifo #(.DSIZE(8), .ASIZE(4)) uut (
        .wclk(wclk), .wrst_n(wrst_n), .w_en(w_en), .wdata(wdata), .full(full),
        .rclk(rclk), .rrst_n(rrst_n), .r_en(r_en), .rdata(rdata), .empty(empty)
    );

    // Clock generation (100MHz wclk, 40MHz rclk)
    always #5  wclk = ~wclk;
    always #12.5 rclk = ~rclk;

    initial begin
        $dumpfile("async_fifo.vcd");
        $dumpvars(0, async_fifo_tb);

        #20 wrst_n = 1; rrst_n = 1;

        #20 push(8'h24); push(8'h81); push(8'h09); push(8'h63);

        #100 r_en = 1;
        #100 r_en = 0;

        #100 $finish;
    end

    task push(input [7:0] data);
        begin
            @(posedge wclk);
            w_en = 1; wdata = data;
            @(posedge wclk);
            w_en = 0;
        end
    endtask
endmodule
