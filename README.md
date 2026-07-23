# RV32I 5-Stage Pipelined RISC-V Processor

A Verilog implementation of a **32-bit RISC-V (RV32I) 5-stage pipelined processor** with forwarding, hazard detection, branch handling, and support for the complete RV32I base integer instruction set.

---

## Features

- ✅ RV32I Base Integer ISA
- ✅ 32-bit datapath
- ✅ 5-stage pipeline
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory Access (MEM)
  - Write Back (WB)
- ✅ Pipeline registers
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- ✅ Forwarding Unit
- ✅ Hazard Detection Unit
- ✅ Branch Flush Logic
- ✅ JAL and JALR support
- ✅ Immediate Generator
- ✅ ALU Control Unit
- ✅ Register File
- ✅ Instruction Memory
- ✅ Data Memory
- ✅ Verified through simulation using Icarus Verilog and GTKWave

---

# Architecture

The processor follows the classic 5-stage RISC-V pipeline.

```
                +----------------+
                | Instruction    |
                |    Memory      |
                +--------+-------+
                         |
                         v
                     IF / ID
                         |
                         v
                +----------------+
                | Register File  |
                | + Control Unit |
                +--------+-------+
                         |
                         v
                     ID / EX
                         |
                         v
                +----------------+
                |      ALU       |
                +--------+-------+
                         |
                         v
                    EX / MEM
                         |
                         v
                +----------------+
                | Data Memory    |
                +--------+-------+
                         |
                         v
                    MEM / WB
                         |
                         v
                  Register File
```

---

# Pipeline Stages

## Instruction Fetch (IF)

- Fetch instruction from instruction memory.
- Update Program Counter (PC).
- Pass instruction and PC to IF/ID register.

---

## Instruction Decode (ID)

- Decode instruction.
- Read source registers.
- Generate immediate.
- Generate control signals.
- Hazard detection.

---

## Execute (EX)

- Perform ALU operations.
- Calculate branch targets.
- Branch decision.
- Address calculation.
- Forward operands when required.

---

## Memory (MEM)

- Load instructions
- Store instructions

---

## Write Back (WB)

Write result back into register file from

- ALU Result
- Memory
- PC + 4

---

# Supported Instruction Set

## R-Type

- ADD
- SUB
- SLL
- SLT
- SLTU
- XOR
- SRL
- SRA
- OR
- AND

---

## I-Type

- ADDI
- SLTI
- SLTIU
- XORI
- ORI
- ANDI
- SLLI
- SRLI
- SRAI

---

## Load Instructions

- LB
- LH
- LW
- LBU
- LHU

---

## Store Instructions

- SB
- SH
- SW

---

## Branch Instructions

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

---

## Jump Instructions

- JAL
- JALR

---

## Upper Immediate

- LUI
- AUIPC

---

# Hazard Handling

## Forwarding Unit

The forwarding unit resolves data hazards without introducing unnecessary stalls.

Supported forwarding paths:

- EX/MEM → EX
- MEM/WB → EX

This allows dependent arithmetic instructions to execute correctly in consecutive cycles.

---

## Hazard Detection Unit

The hazard detection unit detects load-use hazards.

When a load instruction is immediately followed by an instruction requiring the loaded value:

- PC is stalled
- IF/ID register is stalled
- Control signals entering the pipeline are cleared to insert a bubble

---

## Control Hazard Handling

For taken branches and jumps:

- Incorrect instructions already fetched are flushed.
- PC is updated with the correct target address.

Supported instructions:

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU
- JAL
- JALR

---

# Project Structure

```
riscv32i-pipelined/
│
├── rtl/
│   ├── alu.v
│   ├── control_unit.v
│   ├── datapath.v
│   ├── forwarding_unit.v
│   ├── hazard_unit.v
│   ├── immediate_generator.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── register_file.v
│   ├── IF_ID.v
│   ├── ID_EX.v
│   ├── EX_MEM.v
│   ├── MEM_WB.v
│   └── top.v
│
├── testbench/
│   └── top_tb.v
│
├── results/
│   ├── program.hex
│   ├── results_photo1.png
│   ├── results_photo2.png   
│   └── results.txt ( result on terminal )
│
│
├── RISC-V32I_PIPELINED_DIAGRAM.png
│   
│
├── riscv32i_pipelined.vvd
│   
├── top.vcd
│
└── README.md
```

---

# Verification

The processor has been verified using dedicated assembly programs covering:

| Test | Status |
|------|--------|
| Arithmetic Instructions | ✅ |
| Logical Instructions | ✅ |
| Shift Instructions | ✅ |
| Comparison Instructions | ✅ |
| Forwarding | ✅ |
| Load-Use Hazard | ✅ |
| Register File Write-Back | ✅ |
| Branch Taken | ✅ |
| Branch Not Taken | ✅ |
| JAL | ✅ |
| JALR | ✅ |
| Memory Load/Store | ✅ |

---

# Simulation

Compile using Icarus Verilog

```bash
iverilog -o riscv32i rtl/*.v testbench/top_tb.v
```

Run simulation

```bash
vvp riscv32i
```

Open waveform

```bash
gtkwave top.vcd
```

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

---

# Future Improvements

Possible extensions include:

- Branch Prediction
- Instruction Cache
- Data Cache
- CSR Instructions
- RV32M Extension (Multiply/Divide)
- Exception and Interrupt Handling
- AXI/AHB Memory Interface

---
