`define WIDTH 3
//Synchronous FIFO Test bench

module FIFO_tb();

	reg clk, rst, wr_en, rd_en ;
	reg[7:0] in;
	reg[7:0] tempdata;
	wire [7:0] out;
	wire [`WIDTH :0] fifo_counter;
	wire empty, full, part_empty, part_full;

	FIFO DUT( .clk(clk), .rst(rst), .in(in), .out(out), 
			 .wr_en(wr_en), .rd_en(rd_en), .empty(empty), 
			 .full(full), .part_empt(part_empty),
			 .part_full(part_full), .fifo_counter(fifo_counter) );

	//clock generation
	initial begin
	clk = 0;
	forever
	#1 clk=~clk;
	end
	
	//simulation
	initial
	begin
	      rst = 1;
			rd_en = 0;
			wr_en = 0;
			tempdata = 0;
			in = 0;
			#15 rst = 0;
            $dumpfile("FIFO_tb.vcd");  // Waveform file
            $dumpvars(0, FIFO_tb);         // signals to plot (everything)
			push(1);
			//push and pop together
			fork
			   push(2);
			   pop(tempdata);
			join  
			
			//pushing values
			push(10);
			push(20);
			push(30);
			push(40);
			push(50);
			push(60);
			push(70);
			push(80);
			push(90);
			push(100);
			push(110);
			push(120);
			push(130);
            
         //popping values
			pop(tempdata);
			push(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			push(140);
			pop(tempdata);
			push(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			pop(tempdata);
			push(5);
			pop(tempdata);
			@(negedge clk) rst = 1;			
			#1 $finish;
	end

	//task to push data in FIFO
	task push(input[7:0] data);
	begin
	   if( full )
		$display("---Cannot push: Memory Full---");
		
	   else
	   begin
		$display("Pushed ",data );
		in = data;
		wr_en = 1;
		@(negedge clk)
		#1 wr_en = 0;
		end
    end
	endtask

	//task to pop data from FIFO
	task pop (output [7:0] data);
    begin
	   if( empty )
		$display("---Cannot Pop: Memory Empty---");
		
	   else begin
    	rd_en = 1;
		@(negedge clk);
    	#1 rd_en = 0;
		data = out;
		$display("Poped : %d ", data);
		end
	end
	endtask

endmodule