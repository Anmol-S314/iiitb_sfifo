
`timescale 1 ns/ 1 ps
module iiitb_sfifo(
	input        CLK,
	input        RSTn,
	input        write,
	input        read,
	input  [7:0] iData,
	
	output [7:0] oData,
	output       full,
	output       empty
);

reg [4:0] wp;          //write point should add 1 bit(N+1) 
reg [4:0] rp;          //read point
reg [7:0] RAM [15:0];  //deep16,8 bit RAM
reg [7:0] oData_reg;   //regsiter of oData

always @ ( posedge CLK or negedge RSTn )
begin                  //write to RAM
	if (!RSTn)
	begin
		wp <= 5'b0;
	end
	else if ( write )
	begin
		RAM[wp[3:0]] <= iData;
		wp <= wp + 1'b1;
	end
end

always @ ( posedge CLK or negedge RSTn )
begin                  // read from RAM
	if (!RSTn)
	begin
		rp <= 5'b0;
		oData_reg <= 8'b0;
	end
	else if ( read  )
	begin
		oData_reg <= RAM[rp[3:0]];
		rp <= rp + 1'b1;
	end
end


assign full = ( wp[4] ^ rp[4] & wp[3:0] == rp[3:0] );
assign empty = ( wp == rp );
assign oData = oData_reg;


endmodule

