#  FIR Filter Implementation and Verification

This project showcases the complete flow of designing, implementing, and verifying a 15th-order low-pass FIR filter with cut-off frequency of 10MHz and sampling rate of 100MHz. It involves MATLAB-based filter design and modeling, Verilog RTL implementation, and functional verification using Vivado and Xilinx's CORDIC IP core for sinusoidal inputs generation.

---

##  Table of Contents

- [Project Flow](#project-flow)
  - [1. Filter Design in MATLAB](#1-filter-design-in-matlab)
  - [2. Coefficient Generation & Conversion](#2-coefficient-generation--conversion)
  - [3. MATLAB Golden Model](#3-matlab-golden-model)
  - [4. Verilog RTL Implementation](#4-verilog-rtl-implementation)
  - [5. Testbench & Verification in Vivado](#5-testbench--verification-in-vivado)
- [Project Files](#project-files)
- [Results](#results)
- [Author](#author)

---


##  Project Flow

### 1. Filter Design in MATLAB

The FIR filter was designed using MATLAB’s `fir1` function with a Hamming window. The following design parameters were used:

- **Filter Order:** 15  
- **Cutoff Frequency (Fc):** 10 MHz  
- **Sampling Frequency (Fs):** 100 MHz
  
![mag_response](https://github.com/user-attachments/assets/902a585a-550e-4360-a385-d23722de5566)


### 2. Coefficient Generation & Conversion
As the filter is 15th order, it has 16 coefficients.
The filter coefficients were:
- Exported from MATLAB.
- Scaled and converted to a fixed-point representation for the RTL.

### 3. MATLAB Golden Model

A behavioral model of the FIR filter was created in MATLAB for reference and verification. It simulates the response of:

- A 2 MHz sinusoidal signal
- A 30 MHz sinusoidal signal
- A composite signal combining a 2 MHz signal along with 30 MHz and 45 MHz noise


### 4. Verilog RTL Implementation

The FIR filter was implemented in a modular way using five Verilog files:

- **`dff.v`** – A simple D flip-flop module for pipelining and register stages  
- **`multiplier.v`** – Performs signed multiplication of the input sample with a filter coefficient  
- **`adder.v`** – Adds two signed input values, forming part of the accumulation path  
- **`fir_block.v`** – Represents a single FIR tap including delay, coefficient multiplication, and accumulation  
- **`FIR.v`** – Top-level module instantiating all FIR taps and handling the data flow through the filter stages

### 5. Testbench & Verification in Vivado

To verify the filter's functionality:

- A custom testbench [`my_tb.v`](./my_tb.v) was created.
- Sinusoidal test signals were generated using **Xilinx CORDIC IP cores** at:
  - 2 MHz (in-band signal)
  - 30 MHz (out-of-band noise)
  - 45 MHz (additional noise)
- Test scenarios included:
  - Pure 2 MHz sine
  - 30 MHz sine
  - Composite input (signal at 2 MHz + noise at (30 MHz & 45 MHz))

-> Simulation results confirmed proper filter operation, with high-frequency noise significantly attenuated and the in-band signal preserved.
-> Plots from MATLAB simulation (`fir.m`) confirm that the filter meets its frequency response targets.
