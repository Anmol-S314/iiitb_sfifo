# read design

read_verilog iiitb_sync_fifo.v

# generic synthesis
synth -top iiitb_sync_fifo

# mapping to mycells.lib
dfflibmap -liberty /home/anmol/verilog/iiitb_sync_fifo/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/anmol/verilog/iiitb_sync_fifo/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_sync_fifo_synth.v
