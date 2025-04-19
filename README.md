#  FIR Filter Implementation and Verification

This project includes designing, implementing, and verifying a 15th-order low-pass FIR filter with a cut-off frequency of 10 MHz and a sampling rate of 100 MHz. It involves MATLAB-based filter design and modeling, Verilog RTL implementation, and functional verification using Vivado and Xilinx's CORDIC IP core for sinusoidal input generation.

---

##  Table of Contents

- [Project Flow](#project-flow)
  - [1. Filter Design in MATLAB](#1-filter-design-in-matlab)
  - [2. Coefficient Generation & Conversion](#2-coefficient-generation--conversion)
  - [3. MATLAB Golden Model](#3-matlab-golden-model)
  - [4. Verilog RTL Implementation](#4-verilog-rtl-implementation)
  - [5. Testbench & Verification in Vivado](#5-testbench--verification-in-vivado)
---


##  Project Flow

### 1. Filter Design in MATLAB

The FIR filter was designed using MATLAB filter designer. The filter specifications are as follows:

- **Filter Order:** 15  
- **Cutoff Frequency (Fc):** 10 MHz  
- **Sampling Frequency (Fs):** 100 MHz
- **Window:** Hamming
  
![mag_response](https://github.com/user-attachments/assets/902a585a-550e-4360-a385-d23722de5566)


### 2. Coefficient Generation & Conversion
As the filter is 15th order, it has 16 coefficients.
The filter coefficients were:
- Exported from MATLAB.
- Scaled and converted to a fixed-point representation to be used in the RTL.


![image](https://github.com/user-attachments/assets/341511e2-07f1-43b5-9206-85f6ac449ff2)


### 3. MATLAB Golden Model

A behavioral model of the FIR filter was created in MATLAB for reference and verification. The filter was tested against three types of signals:

- A 2 MHz sinusoidal signal
- A 30 MHz sinusoidal signal
- A composite signal combining a 2 MHz signal along with 30 MHz and 45 MHz noise

![matlab_results](https://github.com/user-attachments/assets/d7db255b-a4c7-45cc-9ac8-fbc64c830c02)

![composite_signal](https://github.com/user-attachments/assets/90695c99-5819-429a-a78d-ff093df952e2)

### 4. Verilog RTL Implementation

The FIR filter was implemented in a modular way based on the direct form using five Verilog files:

- **`dff.v`** – A simple D flip-flop module for pipelining and register stages  
- **`multiplier.v`** – Performs signed multiplication of the input sample with a filter coefficient  
- **`adder.v`** – Adds two signed input values, forming part of the accumulation path  
- **`fir_block.v`** – Represents a single FIR tap including delay, coefficient multiplication, and accumulation  
- **`FIR.v`** – Top-level module instantiating all FIR taps and handling the data flow through the filter stages

![image](https://github.com/user-attachments/assets/1c9de82b-efe5-4219-abf2-794f31429957)


### 5. Testbench & Verification in Vivado

To verify the filter's functionality:

- A custom testbench was created.
- Sinusoidal test signals were generated using **Xilinx CORDIC IP cores** at:
  - 2 MHz (in-band signal)
  - 30 MHz (out-of-band noise)
  - 45 MHz (additional noise)
- Test scenarios included:
  - Pure 2 MHz sine
  - 30 MHz sine
  - Composite input (signal at 2 MHz + noise at (30 MHz & 45 MHz))

## Results

The filter was verified against three types of inputs. Below are illustrative outcomes:

- ✅ Passed: 2 MHz signal retained with minimal distortion
  
  ![image](https://github.com/user-attachments/assets/3f5e2fec-f6cb-46b6-8401-ed1065447a1a)

- ✅ Passed: 30 MHz signals were highly attenuated
  

![image](https://github.com/user-attachments/assets/6cbea3a4-429a-49bf-bff8-3b6196e91739)


- ✅ Passed: Composite input (2 MHz + noise) , noise at 30MHz and 45MHz was effectively filtered.

![image](https://github.com/user-attachments/assets/71942c06-a742-4b9f-8af5-89eba1ee4204)


- Simulation results confirmed proper filter operation, with high-frequency noise significantly attenuated and the in-band signal preserved.
