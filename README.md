# Asynchronous-FIFO-Buffer

A robust, hardware-synthesizable Asynchronous FIFO (First-In, First-Out) Buffer design implemented in Verilog. This repository contains the full digital design cycle: from human-readable Register-Transfer Level (RTL) code to functional simulation validation, clock domain crossing (CDC) pointer synchronization, and gate-level logic synthesis using open-source EDA tools.


🚀 Key Architectural Features
-> Dual Clock Domain (CDC): Decoupled read (rclk) and write (wclk) timing domains for cross-clock data transfer.
-> Gray Code Pointer Synchronization: Multi-bit pointers mapped to Gray code to eliminate multi-bit transition sampling errors.
-> 2-Stage Flip-Flop Synchronizers: Cascaded registers to prevent metastability during domain boundary transfers.
-> Fully Parameterized: Easily adjust DSIZE (data bus width) and ASIZE (address width/queue depth) at instantiation.
-> Combinatorial Unregistered Read: Instantaneous memory access on read pointer matching for low-latency operations.


🛠️ Toolchain & Requirements
This project is built entirely using open-source VLSI engineering tools:
Simulation Compiler: Icarus Verilog (iverilog)
Waveform Viewer: GTKWave
Logic Synthesis Engine: Yosys Open SYNthesis Suite


