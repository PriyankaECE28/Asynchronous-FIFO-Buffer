module async_fifo #(
    parameter DSIZE = 8,
    parameter ASIZE = 4
)(
    input  wire             wclk,
    input  wire             wrst_n,
    input  wire             w_en,
    input  wire [DSIZE-1:0] wdata,
    output wire             full,
    
    input  wire             rclk,
    input  wire             rrst_n,
    input  wire             r_en,
    output wire [DSIZE-1:0] rdata,
    output wire             empty
);

    localparam DEPTH = 1 << ASIZE;
    reg [DSIZE-1:0] mem [0:DEPTH-1];
    reg [ASIZE:0] wptr_bin, rptr_bin;
    reg [ASIZE:0] wptr_gray, rptr_gray;
    reg [ASIZE:0] wq2_rptr, rq2_wptr;
    reg [ASIZE:0] wq1_rptr, rq1_wptr;

    // WRITE DOMAIN LOGIC 
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wptr_bin  <= 0;
            wptr_gray <= 0;
        end else if (w_en && !full) begin
            mem[wptr_bin[ASIZE-1:0]] <= wdata;
            wptr_bin                 <= wptr_bin + 1'b1;
            wptr_gray                <= (wptr_bin + 1'b1) ^ ((wptr_bin + 1'b1) >> 1);
        end
    end

    // Synchronize rptr into wclk domain
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wq1_rptr <= 0;
            wq2_rptr <= 0;
        end else begin
            wq1_rptr <= rptr_gray;
            wq2_rptr <= wq1_rptr;
        end
    end

    //  READ DOMAIN LOGIC
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rptr_bin  <= 0;
            rptr_gray <= 0;
        end else if (r_en && !empty) begin
            rptr_bin  <= rptr_bin + 1'b1;
            rptr_gray <= (rptr_bin + 1'b1) ^ ((rptr_bin + 1'b1) >> 1);
        end
    end

    // Synchronize wptr into rclk domain
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rq1_wptr <= 0;
            rq2_wptr <= 0;
        end else begin
            rq1_wptr <= wptr_gray;
            rq2_wptr <= rq1_wptr;
        end
    end

    // Output Data & Flags
    assign rdata = mem[rptr_bin[ASIZE-1:0]];
    assign empty = (rptr_gray == rq2_wptr);
    assign full  = (wptr_gray == {~wq2_rptr[ASIZE:ASIZE-1], wq2_rptr[ASIZE-2:0]});

endmodule
