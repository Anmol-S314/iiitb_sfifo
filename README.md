# iiitb_sfifo -> Synchronous First In First Out for Memory Storage and Processing
## Design Description
This project simulates a synchronous FIFO where data is written in a sequential manner into a memory buffer using a clock signal, and the data is read out in the same manner as it was entered from the memory array using the same clock signal.

_Note: Circuit requires further optimization to improve performance. Design yet to be modified._

## Introduction
FIFO is an approach for handling program work requests from queues or stacks so that the oldest request is processed first. In the hardware domain it stores data in an array of flops
in one clock cycle and can give the same data in another
cycle following FIFO logic.
<p align="center">
 <img src="https://3.bp.blogspot.com/-Gyz3LoRgf7c/VDLFsVpY-jI/AAAAAAAAAaE/lzCs73kne5M/s1600/Diagram.png" width="325" alt="accessibility text">
</p>
<p align="center">
    <em>Operation of FIFO</em>
</p>
The FIFO module is a variable-length buffer with a varying
data-width. It also has flags to specify the buffer state. Input port is controlled by write-clock and the data is written
into FIFO on every rising edge when it is asserted. Output port is controlled by read-clock and data
is read from FIFO on every rising edge when read-enable is asserted.  


## Applications
The main uses of FIFO are as follows
- Used to buffer data transfers.
- Used in circular buffers and FIR filters.
- FIFO memory chips.
- Increase BW and prevent data loss in high-speed communication.
- FIFOs find use in set-top box for HDTV/IPTV. 

## Block Diagram of FIFO
<p align="center">
<img src="https://cdn3.f-cdn.com//files/download/82622339/Sync_fifo_block.jpg" width="350" alt="accessibility text">
</p>
<p align="center">
    <em>Block Diagram of FIFO</em>
</p>

## About iverilog
Icarus Verilog is an implementation of the Verilog hardware description language.

## About GTKWave
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

## Installing iverilog and GTKWave
### For Ubuntu
```
sudo apt-get update
sudo apt-get install iverilog gtkwave
```

## Functional Simulation
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
sudo apt install -y git
git clone https://github.com/Anmol-S314/iiitb_sync_fifo.git
cd iiitb_sync_fifo
iverilog iiitb_sync_fifo.v iiitb_sync_fifo_tb.v
vvp a.out
gtkwave FIFO_tb.vcd
```
## Functional Characteristics
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/183829473-5327f50f-01a2-4e6f-8fb3-f1e1be99b2fd.png" width="700" alt="accessibility text">
</p>
<p align="center">
    <em>Simulation Results of FIFO</em>
</p>

## Synthesis of Verilog Code
### About Yosys
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

## Contributors
- **Anmol J Shetty**
- **Kunal Ghosh**

## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information
- Anmol J Shetty, Student at International Institute of Information Technology Bangalore.
_Email_: Anmol.Shetty@iiitb.ac.in
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
_Email_: kunalghosh@gmail.com

## References
- https://www.fpga4student.com/2017/01/verilog-code-for-fifo-memory.html
- https://esrd2014.blogspot.com/p/first-in-first-out-buffer.html

