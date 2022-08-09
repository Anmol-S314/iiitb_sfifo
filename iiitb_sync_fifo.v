`define WIDTH 3    // SIZE = 16 -> WIDTH = 4
`define SIZE ( 1<<`WIDTH )
//Synchronous FIFO 

module FIFO( 
			input  rst, clk, wr_en, rd_en,   
			input  [7:0] in,                   
			output reg [7:0] out,                  
			output reg empty, full, part_empt, part_full,      
			output reg [`WIDTH :0] fifo_counter);             
   
  reg [`WIDTH -1:0]  rd_ptr, wr_ptr; // pointer to read and write addresses  
  reg [7:0] mem [`SIZE -1 : 0]; 

    //setting full, partial full, empty, partial empty
	always @(fifo_counter)
	begin
	   empty     = (fifo_counter==0);   
	   full      = (fifo_counter== `SIZE); 
	   part_empt = (fifo_counter==2);
	   part_full = (fifo_counter==`SIZE-2);
	end

	//fifo counter operations
	always @(posedge clk or posedge rst)
	begin
	   if( rst )
		   fifo_counter <= 0;		

	   else if( (!full && wr_en) && ( !empty && rd_en ) ) 
		   fifo_counter <= fifo_counter;			

	   else if( !full && wr_en )			
		   fifo_counter <= fifo_counter + 1;

	   else if( !empty && rd_en )		
		   fifo_counter <= fifo_counter - 1;

	   else
		   fifo_counter <= fifo_counter;			
	end

	//read operation
	always @( posedge clk or posedge rst)
	begin
	   if( rst )
		  out <= 0;		
	   else
	   begin
		  if( rd_en && !empty )
			 out <= mem[rd_ptr];	

		  else
			 out <= out;		

	   end
	end


	//write opration
	always @(posedge clk)
	begin
	   if( wr_en && !full )
		  mem[ wr_ptr ] <= in;		

	   else
		  mem[ wr_ptr ] <= mem[ wr_ptr ];
	end

	//read and write pointer operation
	always@(posedge clk or posedge rst)
	begin
	   if( rst )
	   begin
		  wr_ptr <= 0;		
		  rd_ptr <= 0;		
	   end
	   else
	   begin
		  if( !full && wr_en )    
				wr_ptr <= wr_ptr + 1;		
		  else  
				wr_ptr <= wr_ptr;

		  if( !empty && rd_en )   
				rd_ptr <= rd_ptr + 1;		
		  else 
				rd_ptr <= rd_ptr;
	   end
	end
endmodule