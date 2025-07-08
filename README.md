
---

## 🛠 Instructions

### ▶️ To Run the Simulation

1. Use a Verilog simulator (ModelSim, Vivado, or online like [EDAPlayground](https://www.edaplayground.com/))
2. Compile both files:
    ```
    vlog pipeline_processor.v tb_pipeline.v
    ```
3. Run the simulation:
    ```
    vsim tb_pipeline
    ```

### 🔍 Expected Register Output

After execution of the pipeline:
- `R1 = R2 + R3` = `10 + 5` = `15`
- `R4 = R1 - R0` = `15 - 3` = `12`
- `R2 = MEM[2]` = `99`
- `R5 = R4 + R1` = `12 + 15` = `27`

---

## 📷 Simulation Report (Optional)
Include screenshots of waveform or simulation output showing:
- Register values
- Each stage's pipeline register transitions
- Instruction progress

---

## 🎓 Internship Details

- **Intern Name:** Shreyansh Pandey  
- **Internship Program:** CODTECH – Pipeline Processor Design  
- **Completion Certificate:** Will be issued on internship end date  
- **Tools Used:** Verilog, ModelSim/Vivado, Notepad++/VS Code  


##  Project Overview
This project presents a functional design and simulation of a **4-stage pipelined processor** capable of executing basic instructions:
- `ADD`: Adds values from two registers
- `SUB`: Subtracts one register from another
- `LOAD`: Loads a value from memory into a register

The processor is implemented using **Verilog HDL**, simulating four pipeline stages:
1. **IF (Instruction Fetch)**
2. **ID (Instruction Decode)**
3. **EX (Execute)**
4. **MEM/WB (Memory Access / Writeback)**

---

##  Pipeline Stages Explained

| Stage | Name    | Description                              |
|-------|---------|------------------------------------------|
| IF    | Fetch   | Fetches the instruction from instruction memory |
| ID    | Decode  | Decodes the instruction and reads operands |
| EX    | Execute | Performs ALU operation or address calculation |
| MEM   | Memory/Writeback | Accesses memory (for LOAD) or writes result back to register |

---




