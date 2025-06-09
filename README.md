# 📦 FIFO Buffer - Verilog Implementation

This project implements a **First-In First-Out (FIFO) Buffer** in Verilog HDL with a depth of 8 and a data width of 32 bits. FIFO buffers are essential components in digital systems to manage the orderly flow of data. A testbench is also included to validate the buffer functionality through simulation and waveform visualization.

---

## 🧠 Overview

A FIFO buffer is a queue structure that ensures the first data written into the buffer is the first data read out. This kind of buffer is particularly useful when data needs to be transferred between two hardware modules operating at different clock domains or speeds.

---

## 🌍 Real-World Applications

FIFO buffers are commonly used in various real-world systems:

- **Networking Devices:** Routers and switches use FIFO buffers to store and forward packets.
- **Audio/Video Streaming:** To buffer incoming media data and avoid glitches caused by varying data rates.
- **UART Communication:** FIFO is used to store incoming/outgoing data bytes to handle rate mismatch between CPU and peripheral.
- **DMA Transfers:** FIFO buffers help manage data between memory and I/O peripherals efficiently.
- **Embedded Systems:** Useful in sensor data acquisition and processing pipelines.

---

## ⚙️ Features

- ✅ Synchronous FIFO buffer
- ✅ Parameterized design  
  - `FIFO_DEPTH = 8`  
  - `DATA_WIDTH = 32`
- ✅ Read and write control with separate pointers
- ✅ Overflow and underflow protection
- ✅ Status Flags:
  - `empty` – buffer is empty
  - `full` – buffer is full

---

## 🧪 Files Included

| File Name         | Description                                |
|-------------------|--------------------------------------------|
| `fifo_sync.v`     | Verilog code for the FIFO buffer module    |
| `fifo_sync_tb.v`  | Testbench with read/write operations       |
| `fifo_sync_tb.vcd`| Waveform file generated after simulation   |

---

## ▶️ How to Simulate

### 📌 Add to Testbench

Make sure your testbench includes:

```verilog
$dumpfile("fifo_sync_tb.vcd");
$dumpvars(0, fifo_sync_tb);
```
---

### 💻 Run with Icarus Verilog


# Step 1: Compile the design and testbench
iverilog -o fifo_sim fifo_sync.v fifo_sync_tb.v

# Step 2: Run the simulation
vvp fifo_sim

# Step 3: View the waveform in GTKWave
gtkwave fifo_sync_tb.vcd

---

## 🧰 Dependencies

- [Icarus Verilog](http://iverilog.icarus.com/) – Used for compiling and running the Verilog simulation.
- [GTKWave](http://gtkwave.sourceforge.net/) – Used for viewing the waveform (`.vcd`) files generated during simulation.
