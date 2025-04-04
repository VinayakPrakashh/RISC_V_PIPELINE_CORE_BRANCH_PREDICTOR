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
This project implements a **single-cycle RISC-V CPU** based on the **RV32I instruction set**, featuring:

✅ A **fully functional ALU**  
✅ Support for **load, store, arithmetic, and branch** instructions  
✅ A **branch predictor** to improve performance  
✅ Simulation and testing in **Vivado 2023.1**  

The goal of this project is to **design and optimize a single-cycle processor** that follows the **RISC-V RV32I standard**, enabling efficient instruction execution with a branch predictor.

---

## 🛠️ Features
✔ **Fully implemented RV32I ISA** with all primary instructions  
✔ **Single-cycle execution** for all instructions  
✔ **Branch predictor** to minimize stalls  
✔ **Optimized data path** for high performance  
✔ **Vivado testbench & waveform simulation**  

---

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
