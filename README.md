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
git clone https://github.com/Anmol-S314/iiitb_sfifo.git
cd iiitb_sfifo
iverilog iiitb_sfifo.v iiitb_sfifo_tb.v
vvp a.out
gtkwave FIFO_tb.vcd
```
## Functional Characteristics
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/185180587-6ec8ecae-640a-4bf4-963b-7a9253ec57a0.png" width="700" alt="accessibility text">
</p>
<p align="center">
    <em>Simulation Results of FIFO</em>
</p>

## Synthesis of Verilog Code
### Synthesis
Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates. We can realize this with a Synthesizer, in our case Yosys is used.

Synthesis takes place in multiple steps:

- Converting RTL into simple logic gates.
- Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
- Optimizing the mapped netlist keeping the constraints set by the designer intact.

### About Yosys
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.
To install yosys follow the instructions in this github repository

https://github.com/YosysHQ/yosys

Now simply run the ```yosys_run.sh``` file which creates the synthesized version of the verilog code.

**To synthesize:**
```
yosys
yosys>  script yosys_run.sh
```
**To obtain different cell types:**
```
yosys>  stat
```
**To generate schematic:**
```
yosys>  show
```
### Printing Statistics
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/185193728-2cea97a5-c2a5-406a-bbff-dc6ad67af0eb.png" width="300" alt="accessibility text">
</p>
<p align="center">
    <em>Gate Level Description of Verilog Code</em>
</p>

Now the synthesized netlist is written in ```iiitb_sfifo_synth.v``` file.

## Gate Level Simulation
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.
We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met. Folllowing are the commands to run the GLS simulation:
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 ../iiitb_sfifo/verilog_model/primitives.v ../iiitb_sfifo/verilog_model/sky130_fd_sc_hd.v iiitb_sfifo_synth.v iiitb_sfifo_tb.v
./a.out
gtkwave dump.vcd
```
The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.
The output of the synthesized netlist is given below:
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/185180920-e2caf509-1c0e-4ab8-8f8a-b95de4023cce.png" width="700" alt="accessibility text">
</p>
<p align="center">
    <em>Waveform of Synthesized Netlist</em>
</p>



## Contributors
- **Anmol J Shetty**
- **Kunal Ghosh**

## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information
- Anmol J Shetty, Student at International Institute
of Information Technology Bangalore.
_Email_: Anmol.Shetty@iiitb.ac.in
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
_Email_: kunalghosh@gmail.com

## References
- https://www.fpga4student.com/2017/01/verilog-code-for-fifo-memory.html
- https://esrd2014.blogspot.com/p/first-in-first-out-buffer.html

