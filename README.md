# Asynchronous-FIFO-Buffer

A dual-clock Asynchronous FIFO (First-In, First-Out) buffer implementation written in Verilog HDL. This project demonstrates Clock Domain Crossing (CDC) handling using Gray-code pointer synchronization, full simulation verification, logic synthesis, and visual schematic generation using open-source EDA tools on Ubuntu Linux.

📌 Features

* Dual-Clock Architecture: Fully decoupled write clock (`wclk`) and read clock (`rclk`).
* Clock Domain Crossing (CDC): 2-stage flip-flop synchronizers to safely pass pointers across timing boundaries.
* Glitch-Free Flag Logic: Pointers converted to Gray code to eliminate multi-bit transition sampling errors.
* Combinatorial Read: Unregistered data output for low latency read operations.
* Open-Source EDA Integration: Verified using Icarus Verilog, GTKWave, Yosys.

