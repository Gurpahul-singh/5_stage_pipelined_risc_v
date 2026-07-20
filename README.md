# RV32I Single-Cycle RISC-V Processor

A 32-bit **Single-Cycle RISC-V (RV32I)** processor designed and implemented in **Verilog HDL**. The processor executes one instruction per clock cycle and supports the complete RV32I base integer instruction set.

## Features

- ✅ 32-bit RV32I ISA
- ✅ Single-cycle datapath
- ✅ Harvard architecture
- ✅ Modular Verilog implementation
- ✅ Complete instruction decoding
- ✅ Register File (32 × 32-bit registers)
- ✅ Immediate Generator
- ✅ ALU Control Unit
- ✅ Main Control Unit
- ✅ ALU
- ✅ Program Counter
- ✅ Branch and Jump Unit
- ✅ Instruction Memory
- ✅ Data Memory
- ✅ Load and Store support
- ✅ Verified using custom testbenches

---

## Supported RV32I Instructions

### Arithmetic & Logical

- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT
- SLTU

### Immediate Instructions

- ADDI
- ANDI
- ORI
- XORI
- SLTI
- SLTIU
- SLLI
- SRLI
- SRAI

### Load Instructions

- LB
- LH
- LW
- LBU
- LHU

### Store Instructions

- SB
- SH
- SW

### Branch Instructions

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

### Jump Instructions

- JAL
- JALR

### Upper Immediate Instructions

- LUI
- AUIPC

---

## Processor Datapath

The processor follows the standard **single-cycle datapath**, where every instruction completes in one clock cycle.

Major components include:

- Program Counter
- Instruction Memory
- Control Unit
- Register File
- Immediate Generator
- ALU Control
- ALU
- Data Memory
- Branch & Jump Unit
- Write Back Multiplexer

---

## Project Structure

```
├── rtl/
│   ├── alu.v
│   ├── alu_control.v
│   ├── branch_jump_unit.v
│   ├── control_unit.v
│   ├── data_memory.v
│   ├── immediate_generator.v
│   ├── instruction_memory.v
│   ├── muxes.v
│   ├── pc.v
│   ├── register_file.v
│   └── riscv_top.v
│
├── testbench/
│   └── riscv_tb.v
│
├── waveforms/
│   └── *.vcd
│
├── images/
│   └── datapath.png
│
└── README.md
```

*(Modify the folder names if your repository structure differs.)*

---

## Datapath

Add your datapath image here.

```markdown
![Datapath](images/datapath.png)
```

---

## Simulation

The design can be simulated using **Icarus Verilog** or **ModelSim**.

### Compile

```bash
iverilog -o riscv *.v
```

### Run

```bash
vvp riscv
```

### Generate Waveform

```bash
gtkwave top.vcd
```

---

## Design Highlights

- Modular architecture for easy debugging and extension.
- Supports signed and unsigned arithmetic.
- Byte and half-word load/store operations with proper sign and zero extension.
- Implements all RV32I branch conditions.
- Clean separation of datapath and control logic.
- Synthesizable Verilog implementation.

---

## Future Improvements

- 5-stage Pipelined RV32I Processor
- Hazard Detection Unit
- Data Forwarding Unit
- Branch Prediction
- CSR Instructions
- Exception and Interrupt Handling
- Instruction & Data Cache
- RV32M Extension (Multiply/Divide)

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code

---

## Learning Resources

- RISC-V Unprivileged ISA Specification
- Computer Organization and Design (Patterson & Hennessy)
- Digital Design and Computer Architecture (Harris & Harris)

---

## Author

**Your Name**

Electronics & Communication Engineering

---

## License

This project is released under the MIT License.