module pipeline_processor (
    input clk,
    input reset
);

// Instruction memory (4 instructions for demo)
reg [15:0] instr_mem [0:3];

// Register file (16 registers of 8-bit)
reg [7:0] reg_file [0:15];

// Data memory for LOAD instruction
reg [7:0] data_mem [0:15];

// Pipeline registers
reg [15:0] IF_ID;
reg [15:0] ID_EX;
reg [7:0] EX_MEM_Result;
reg [3:0] EX_MEM_Dest;
reg [15:0] EX_MEM_Instruction;

// Wires
wire [3:0] opcode, rd, rs1, rs2;
assign opcode = IF_ID[15:12];
assign rd     = IF_ID[11:8];
assign rs1    = IF_ID[7:4];
assign rs2    = IF_ID[3:0];

initial begin
    // Instructions
    instr_mem[0] = 16'b0001_0001_0010_0011; // ADD R1 = R2 + R3
    instr_mem[1] = 16'b0010_0100_0001_0000; // SUB R4 = R1 - R0
    instr_mem[2] = 16'b0011_0010_0000_0010; // LOAD R2 = MEM[2]
    instr_mem[3] = 16'b0001_0101_0100_0001; // ADD R5 = R4 + R1

    // Register init
    reg_file[2] = 8'd10;
    reg_file[3] = 8'd5;
    reg_file[1] = 8'd0;
    reg_file[0] = 8'd3;
    data_mem[2] = 8'd99;
end

reg [1:0] pc = 0;

// Pipeline Stages
always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc <= 0;
        IF_ID <= 16'b0;
        ID_EX <= 16'b0;
        EX_MEM_Result <= 0;
        EX_MEM_Dest <= 0;
        EX_MEM_Instruction <= 0;
    end else begin
        // ------------------ IF ------------------
        IF_ID <= instr_mem[pc];
        pc <= pc + 1;

        // ------------------ ID ------------------
        ID_EX <= IF_ID;

        // ------------------ EX ------------------
        case (ID_EX[15:12])
            4'b0001: // ADD
                EX_MEM_Result <= reg_file[ID_EX[7:4]] + reg_file[ID_EX[3:0]];
            4'b0010: // SUB
                EX_MEM_Result <= reg_file[ID_EX[7:4]] - reg_file[ID_EX[3:0]];
            4'b0011: // LOAD
                EX_MEM_Result <= data_mem[ID_EX[3:0]];
        endcase

        EX_MEM_Dest <= ID_EX[11:8];
        EX_MEM_Instruction <= ID_EX;

        // ------------------ MEM / WB ------------------
        reg_file[EX_MEM_Dest] <= EX_MEM_Result;
    end
end

endmodule



module tb_pipeline;

reg clk;
reg reset;

pipeline_processor uut (
    .clk(clk),
    .reset(reset)
);

// Clock
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    #10;
    reset = 0;

    // Let it run for a few cycles
    #100;

    $finish;
end

endmodule


