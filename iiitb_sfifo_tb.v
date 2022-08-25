
`timescale 1 ns/ 1 ps
module iiitb_sfifo_tb();
	reg CLK;
	reg RSTn;
	reg write;
	reg read;
	reg [7:0] iData;
	
	wire [7:0] oData;
	wire full;
	wire empty;

initial
begin
	read=0;
	write=0;
end
initial
begin
	CLK <= 1'b0;
	forever #100 CLK <= ~CLK;
end


initial 
begin
	RSTn = 0;
	iData = 0;
	#10 RSTn = 1;
end
	
always @ (posedge CLK or negedge RSTn)
begin
	iData <= iData + 1'b1;
				  
end

always @ (posedge CLK or negedge RSTn)
begin
	if (!RSTn)
		write = 0;
	else if (!full)
	begin
		write = 1;
	end
	else 
		write = 0;
end

always @ (posedge CLK or negedge RSTn)
begin
	if (!RSTn)
		read = 0;
	else if (!empty)
		read = 1;
	else 
		read = 0;
end


iiitb_sfifo fifo (.CLK(CLK),
				  .RSTn(RSTn),
				  .write(write),
				  .read(read),
				  .iData(iData),
				  .full(full),
				  .empty(empty),
				  .oData(oData));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  initial
  #20000 $finish;
             
endmodule



