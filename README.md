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

Design script: [`designed_filter.m`](./designed_filter.m)

### 2. Coefficient Generation & Conversion

The resulting filter coefficients were:

- Generated in MATLAB using the `fir1` function
- Scaled and converted to integer representation to be used in digital logic

This enabled their use within the RTL design for efficient hardware implementation.

### 3. MATLAB Golden Model

A behavioral model of the FIR filter was created in MATLAB for reference and verification. It simulates the response of:

- A 2 MHz sinusoidal signal
- A 30 MHz sinusoidal signal
- A composite signal combining a 2 MHz signal with 30 MHz and 45 MHz noise

Script: [`fir.m`](./fir.m)  
It visually compares the filtered and unfiltered waveforms to validate the frequency response.

### 4. Verilog RTL Implementation

The FIR filter was implemented in a modular way using five synthesizable Verilog files:

- **`dff.v`** – A simple D flip-flop module for pipelining and register stages  
- **`multiplier.v`** – Performs signed multiplication of the input sample with a filter coefficient  
- **`adder.v`** – Adds two signed input values, forming part of the accumulation path  
- **`fir_block.v`** – Represents a single FIR tap including delay, coefficient multiplication, and accumulation  
- **`FIR.v`** – Top-level module instantiating all FIR taps and handling the data flow through the filter stages

The design was structured for clarity, reusability, and ease of scaling to different filter orders.

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
  - Composite input (2 MHz + 30 MHz + 45 MHz)

Simulation results confirmed proper filter operation, with high-frequency noise significantly attenuated and the in-band signal preserved.

##  Results

The filter was verified against three types of inputs:

- ✅ Passed: 2 MHz signal retained with minimal distortion  
- ✅ Passed: 30 MHz and 45 MHz signals were highly attenuated  
- ✅ Passed: Composite input (2 MHz + noise) was effectively filtered

Plots from MATLAB simulation (`fir.m`) confirm that the filter meets its frequency response targets.
