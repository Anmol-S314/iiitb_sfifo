# iiitb_sfifo -> Synchronous First In First Out for Memory Storage and Processing
## Design Description
This project simulates a synchronous FIFO where data is written in a sequential manner into a memory buffer using a clock signal, and the data is read out in the same manner as it was entered from the memory array using the same clock signal.

_Note: Circuit requires further optimization to improve performance. Design yet to be modified._

## 1. Introduction
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


## 2. Applications
The main uses of FIFO are as follows
- Used to buffer data transfers.
- Used in circular buffers and FIR filters.
- FIFO memory chips.
- Increase BW and prevent data loss in high-speed communication.
- FIFOs find use in set-top box for HDTV/IPTV. 


## 3. Block Diagram of FIFO
<p align="center">
<img src="https://cdn3.f-cdn.com//files/download/82622339/Sync_fifo_block.jpg" width="350" alt="accessibility text">
</p>
<p align="center">
    <em>Block Diagram of FIFO</em>
</p>



## 4. Functional Simulation
### 4.1 About iverilog
Icarus Verilog is an implementation of the Verilog hardware description language.

### 4.2 About GTKWave
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

### 4.3 Installing iverilog and GTKWave
#### For Ubuntu
```
sudo apt-get update
sudo apt-get install iverilog gtkwave
```
### 4.4 Functional Simulation Process
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
sudo apt install -y git
git clone https://github.com/Anmol-S314/iiitb_sfifo.git
cd iiitb_sfifo
iverilog iiitb_sfifo.v iiitb_sfifo_tb.v
vvp a.out
gtkwave FIFO_tb.vcd
```
### 4.5 Functional Characteristics
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/185180587-6ec8ecae-640a-4bf4-963b-7a9253ec57a0.png" width="700" alt="accessibility text">
</p>
<p align="center">
    <em>Simulation Results of FIFO</em>
</p>

## 5. Synthesis of Verilog Code
### 5.1 About Synthesis
Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates. We can realize this with a Synthesizer, in our case Yosys is used.

Synthesis takes place in multiple steps:

- Converting RTL into simple logic gates.
- Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
- Optimizing the mapped netlist keeping the constraints set by the designer intact.

### 5.2 About Yosys
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
### 5.3 Printing Statistics
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/185193728-2cea97a5-c2a5-406a-bbff-dc6ad67af0eb.png" width="300" alt="accessibility text">
</p>
<p align="center">
    <em>Gate Level Description of Verilog Code</em>
</p>

Now the synthesized netlist is written in ```iiitb_sfifo_synth.v``` file.

## 6. Gate Level Simulation
### 6.1 About GLS
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.
We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met.

### 6.2 Running GLS
Folllowing are the commands to run the GLS simulation:
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

## 7. Physical Design
### 7.1 Overview of Physical Design Flow
Place and Route (PnR) is the core of any ASIC implementation and Openlane flow integrates into it several key open source tools which perform each of the respective stages of PnR. Below are the stages and the respective tools that are called by openlane for the functionalities as described:
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/188593942-17ed7d53-0b51-4da7-a081-4008c121288d.jpg" width="500" height="400" alt="accessibility text">
</p>

### 7.2 Opensource EDA Tools
OpenLANE utilises a variety of opensource tools in the execution of the ASIC flow:
Task | Tool/s
------------ | -------------
RTL Synthesis & Technology Mapping | [yosys](https://github.com/YosysHQ/yosys), abc
Floorplan & PDN | init_fp, ioPlacer, pdn and tapcell
Placement | RePLace, Resizer, OpenPhySyn & OpenDP
Static Timing Analysis | [OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA)
Clock Tree Synthesis | [TritonCTS](https://github.com/The-OpenROAD-Project/OpenLane)
Routing | FastRoute and [TritonRoute](https://github.com/The-OpenROAD-Project/TritonRoute) 
SPEF Extraction | [SPEF-Extractor](https://github.com/HanyMoussa/SPEF_EXTRACTOR)
DRC Checks, GDSII Streaming out | [Magic](https://github.com/RTimothyEdwards/magic), [Klayout](https://github.com/KLayout/klayout)
LVS check | [Netgen](https://github.com/RTimothyEdwards/netgen)
Circuit validity checker | [CVC](https://github.com/d-m-bailey/cvc)

#### **OpenLane Design Stages**

1. *Synthesis*

	- `yosys` - Performs RTL synthesis
	- `abc` - Performs technology mapping
	- `OpenSTA` - Performs static timing analysis on the resulting netlist to generate timing reports
 
2. *Floorplan and PDN*

	- `init_fp` - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
	- `ioplacer` - Places the macro input and output ports
	- `pdn` - Generates the power distribution network
	- `tapcell` - Inserts welltap and decap cells in the floorplan
 
3. *Placement*

	- `RePLace` - Performs global placement
	- `Resizer` - Performs optional optimizations on the design
	- `OpenDP` - Perfroms detailed placement to legalize the globally placed components
 
4. *CTS*

	- `TritonCTS` - Synthesizes the clock distribution network (the clock tree)
5. *Routing*

	- `FastRoute` - Performs global routing to generate a guide file for the detailed router
	- `CU-GR` - Another option for performing global routing.
	- `TritonRoute` - Performs detailed routing
	- `SPEF-Extractor` - Performs SPEF extraction
 
6. *GDSII Generation*

	- `Magic` - Streams out the final GDSII layout file from the routed def
	- `Klayout` - Streams out the final GDSII layout file from the routed def as a back-up
 
7. *Checks*

	- `Magic` - Performs DRC Checks & Antenna Checks
	- `Klayout` - Performs DRC Checks
	- `Netgen` - Performs LVS Checks
	- `CVC` - Performs Circuit Validity Checks

### 7.3 Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane
#### Installation instructions 
```
  apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

Note: This can be done in the `\home` directory
```
   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
   cd OpenLane/
   sudo make
```
To test OpenLane
```
 sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

### 7.4 Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
   sudo apt-get install m4
   sudo apt-get install tcsh
   sudo apt-get install csh
   sudo apt-get install libx11-dev
   sudo apt-get install tcl-dev tk-dev
   sudo apt-get install libcairo2-dev
   sudo apt-get install mesa-common-dev libglu1-mesa-dev
   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
   git clone https://github.com/RTimothyEdwards/magic
   cd magic/
   ./configure
   sudo make
   sudo make install
```
type **magic** terminal to check whether it installed succesfully or not. type **exit** to exit magic.

### 7.5 Generating Layout with existing library cells


Open terminal in home directory
```
   cd OpenLane/designs
   mkdir iiitb_sfifo
   cd iiitb_sfifo/
   wget https://raw.githubusercontent.com/Anmol-S314/iiitb_sfifo/main/config.json
   mkdir src
   cd src/
   wget https://raw.githubusercontent.com/Anmol-S314/iiitb_sfifo/main/iiitb_sfifo.v
   cd ../../../
   sudo make mount
  ./flow.tcl -design iiitb_sfifo
```
To see the layout we use a tool called magic which we installed earlier.

open terminal in home directory
```
$   cd OpenLane/designs/iiitb_sfifo/run
$   ls
```

run following instruction
```
$   cd results/final/def
```
Place the command in the folder
```
$   magic -T /home/anmol/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.max.lef def read iiitb_sfifo.def &
```
layout will be open in new window

### 7.6 Generating Layout with `sky130_vsdinv` cell

#### Invoking OpenLane

Goto OpenLane directory and open terminal there

```
$ sudo make mount
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/188602139-b206c8c4-8e9c-4d12-94fb-5e77cd242b9c.png" width="500"  alt="accessibility text">
</p>


run the flow in interactive mode using following command

```
$ ./flow.tcl -interactive
```

Loading the package file

```
% package require openlane 0.9
```

 preparing design to run

```
% prep -design iiitb_sfifo
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/188605460-c4e69262-1431-4dcd-a101-12f9b36e1b0b.png" width="500"  alt="accessibility text">
</p>



Include the below command to include the additional lef (i.e sky130_vsdinv) into the flow:

```
% set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
% add_lefs -src $lefs
```

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/188606148-5ad62e2f-923e-44e0-af82-3dce84857a8d.png" width="500"  alt="accessibility text">
</p>


#### Synthesis
Logic synthesis uses the RTL netlist to perform HDL technology mapping. The synthesis process is normally performed in two major steps:

- GTECH Mapping – Consists of mapping the HDL netlist to generic gates what are used to perform logical optimization based on AIGERs and other topologies created from the generic mapped netlist.

- Technology Mapping – Consists of mapping the post-optimized GTECH netlist to standard cells described in the PDK

to synthesize the code run the following command
```
% run_synthesis
```

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/188606274-f454be90-e552-47e5-807a-f6080cfe58c7.png" width="500"  alt="accessibility text">
</p>


#### Statistics after synthesis

> pre synthesis stat
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063338-9b459913-375c-4aa9-9650-006d37183e72.png" width="500"  alt="accessibility text">
</p>


> post synthesis stat
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063292-1d385148-981f-4b95-9b59-0f72dccddfc3.png" width="500"  alt="accessibility text">
</p>



#### Floorplan

Goal is to plan the silicon area and create a robust power distribution network (PDN) to power each of the individual components of the synthesized netlist. In addition, macro placement and blockages must be defined before placement occurs to ensure a legalized GDS file. In power planning we create the ring which is connected to the pads which brings power around the edges of the chip. We also include power straps to bring power to the middle of the chip using higher metal layers which reduces IR drop and electro-migration problem.

run the following command to run floorplan

```
% run_floorplan
```

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063525-5611fd6a-1011-4ff4-bb5e-b4f8e23b7960.png" width="500"  alt="accessibility text">
</p>

**Layout after Floorplan**

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063623-e50d04f6-d202-47f1-9ea9-005012fb2caf.png" width="850"  alt="accessibility text">
</p>

#### Placement
Place the standard cells on the floorplane rows, aligned with sites defined in the technology lef file. Placement is done in two steps: Global and Detailed. In Global placement tries to find optimal position for all cells but they may be overlapping and not aligned to rows, detailed placement takes the global placement and legalizes all of the placements trying to adhere to what the global placement wants.

run the following command to run the placement

```
% run_placement
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063735-11e2fee8-b1ac-4bd1-b35b-85bfe30d3774.png" width="500"  alt="accessibility text">
</p>


**Layout after Placement**

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189063883-6080b7ff-fa0c-4d17-9c1b-9a24a15eac63.png" width="850"  alt="accessibility text">
</p>



#### CTS

Clock tree synteshsis is used to create the clock distribution network that is used to deliver the clock to all sequential elements. The main goal is to create a network with minimal skew across the chip. H-trees are a common network topology that is used to achieve this goal.

run the following command to perform CTS
```
% run_cts
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189064758-55ca83c7-acd4-48e0-adde-2ec714ae97a0.png" width="500"  alt="accessibility text">
</p>


#### Routing

Implements the interconnect system between standard cells using the remaining available metal layers after CTS and PDN generation. The routing is performed on routing grids to ensure minimal DRC errors.

run the following command to run the routing

```
% run_routing
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189064130-a6fc41ac-800c-4120-8b10-698c1508c34f.png" width="500"  alt="accessibility text">
</p>


**Layout after Routing**

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189064307-571f880b-3062-47f9-90c0-60a20facee91.png" width="850"  alt="accessibility text">
</p>


### 7.7 Identifing custom made sky130_vsdinv

in tkcon type the follow command to check where sky130_vsdinv exist or not
```
% getcell sky130_vsdinv
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189065823-30bc6df7-69d8-49a2-b69b-5af2b4eb8789.png" width="500"  alt="accessibility text">
</p>

**Cell after Placement**
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189065255-bcbdcef0-2ab2-4cca-ac7a-370130db65da.png" width="500"  alt="accessibility text">
</p>


**Cell after Routing**
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189065049-86cdbd14-13b5-4a7f-a796-12713bb08bc5.png" width="500"  alt="accessibility text">
</p>

### 7.8 Reports
### Area
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189065559-9dbd7773-d146-4607-a895-01596d58843b.png" width="500"  alt="accessibility text">
</p>

#### Slack
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189065744-114ec046-ca39-4e78-bd29-fbc064d6fd26.png" width="500"  alt="accessibility text">
</p>

#### Die Area
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189066152-e87e7931-6941-40c6-a12d-8fa52c1f4846.png" width="400"  alt="accessibility text">
</p>

#### Core Area
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/189066162-58931d96-4c98-4ded-8f2a-6844805c0e85.png" width="400"  alt="accessibility text">
</p>

## Post-Layout Results
### 1. Post Layout Synthesis Gate Count

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/192711104-0468db72-b0e0-49be-8a7c-744099b6a7aa.png" width="700"  alt="accessibility text">
</p>

**Gate Count = 600**


### 2. Area (Box command)

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/192711437-cb4bbfba-a1d0-4d57-907d-32940e98f2a3.png" width="700"  alt="accessibility text">
</p>

**Area = 70,823.062 um2**

### 3. Performance
Copy the lib files along with the .v and .sdc files from /results/routing and /results/cts respectively in the `sky130_fd_sc_hd` sub-directory present in OpenLane and run the following commands in your working OpenLane directory.
```
sudo make mount
sta
% read_liberty -min /home/anmol/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/sky130_fd_sc_hd__slow.lib  
% read_liberty -max /home/anmol/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/sky130_fd_sc_hd__fast.lib 
% read_verilog /home/anmol/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_sfifo.resized.v
% link_design iiitb_sfifo
% read_sdc /home/anmol/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_sfifo.sdc
% read_spef /home/anmol/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_sfifo.nom.spef
% set_propagated_clock [all_clocks] 
% report_checks
% report_checks -from _0913_ -to full
```
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/192721419-b9212ab0-1ac5-434c-bdb2-686621c4fabd.png" width="700"  alt="accessibility text">
</p>



**Performance = 1/(clk_period - slack) = 1/(65.00 - 50.29)ns = 67.980 MHz.**

### 4. Flop/Standard Cell Ratio

<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/192714146-7f75e31e-e7b5-4da8-ac02-4e5a2a84032d.png" width="700"  alt="accessibility text">
</p>

**Flop Ratio = Total No of Flip Flops / Total No of Cells = 128/600 = 0.213**
Here we inspect the `sky130_fd_sc_hd__dfxtp_2` cell to get the Flop-Ratio.

### 5. Power (Total, Internal, Switching, Leakage)
<p align="center">
 <img src="https://user-images.githubusercontent.com/78084271/192721785-432ff87f-db1b-4b71-aa70-870d3dcef5d3.png" width="700"  alt="accessibility text">
</p>

**Internal Power = 142 uW (62.2%)**

**Switching Power = 86 mW (37.8%)**

**Leakage Power = 4.10 nW (0.00%)**

**Total Power = 228 uW (100%)** 





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

