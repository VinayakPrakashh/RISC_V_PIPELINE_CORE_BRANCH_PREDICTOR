# 🚀 RISC_V_PIPELINE_CORE_BRANCH_PREDICTOR

An optimized **RISC-V RV32I** Pipeline CPU featuring **branch prediction**, built using **Verilog** and simulated in **Vivado 2023.1**.

![pipelined_branch_predictor](https://github.com/user-attachments/assets/20e39047-01be-47e0-92ae-46db6581dc51)

<sup>Final Architecture</sup>  

---

## 📜 Table of Contents
- [📜 Table of Contents](#-table-of-contents)
- [📌 About the Project](#-about-the-project)
- [🛠️ Features](#️-features)
- [🧠 Instruction Set Architecture (ISA)](#-instruction-set-architecture-isa)
- [📂 Project Structure](#-project-structure)
- [⚡ Getting Started](#-getting-started)
- [🚀 Simulation & Testing](#-simulation--testing)
- [📌 Roadmap](#-roadmap)
- [👨‍💻 Contributing](#-contributing)
- [📜 License](#-license)
- [📞 Contact](#-contact)

---

## 📌 About the Project
This project implements a **5-stage pipelined RISC-V CPU** based on the **RV32I instruction set**, featuring a **branch predictor** to enhance performance. The pipeline consists of the following stages:

1️⃣ **Instruction Fetch (IF):** Fetches the instruction from memory.  
2️⃣ **Instruction Decode (ID):** Decodes the instruction and reads registers.  
3️⃣ **Execute (EX):** Performs arithmetic or logic operations.  
4️⃣ **Memory Access (MEM):** Reads from or writes to memory (if needed).  
5️⃣ **Write Back (WB):** Writes the result back to the register file.  

🚀 **Key Features:**  
✅ **5-stage pipelining** for improved instruction throughput.  
✅ **Branch prediction** to reduce stalls and improve performance.  
✅ **Hazard handling** for data and control dependencies.  
✅ **Optimized forwarding logic** to minimize stalls.  
✅ **Vivado testbench & waveform simulation** for verification.  

This CPU efficiently executes **RISC-V RV32I instructions**, making it a **high-performance single-cycle processor with enhanced pipelining and prediction mechanisms**.


## 🧠 Instruction Set Architecture (ISA)
The CPU supports **all major RV32I instruction formats**:

| Type  | Format          | Description |
|-------|---------------|-------------|
| **R-Type** | `rd, rs1, rs2` | Register-to-register operations |
| **I-Type** | `rd, rs1, imm` | Immediate operations & loads |
| **S-Type** | `rs1, rs2, imm` | Store instructions |
| **B-Type** | `rs1, rs2, label` | Branch instructions |
| **U-Type** | `rd, imm` | Upper immediate instructions |
| **J-Type** | `rd, label` | Jump instructions |

✔ **Full instruction list can be found [here](docs/instructions.md)**  

---

## 📂 Project Structure

📦 RV32I_CPU
│── 📂 src               # Verilog source files
│   │── alu.v            # Arithmetic Logic Unit
│   │── control.v        # Control unit
│   │── datapath.v       # CPU data path
│   │── instr_mem.v      # Instruction memory
│   │── reg_file.v       # Register file
│   └── top.v            # Top-level CPU module
│
│── 📂 testbench         # Testbench for verification
│   │── cpu_tb.v         # CPU testbench
│   └── alu_tb.v         # ALU testbench
│
│── 📂 docs              # Documentation files
│   ├── architecture.md  # Detailed architecture explanation
│   ├── instructions.md  # Complete ISA documentation
│   └── waveforms.md     # Testbench waveforms
│
│── 📂 scripts           # Simulation and synthesis scripts
│── 📜 README.md         # This beautiful README
└── 📜 LICENSE           # License file

