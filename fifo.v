//                              -*- Mode: Verilog -*-
// Filename        : fifo.v
// Description     : fifo with width depth 8
// Author          : 
// Created On      : Mon Jun 22 17:00:06 2015
// Last Modified By: 
// Last Modified On: Mon Jun 22 17:00:06 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!
/////////////////////////////////////////////////////

module fifo(data,
	    rd,
	    wr,
	    reset,
	    clk,
	    data_out,
	    full,
	    empty,
	    temp0,
	    temp1,
	    temp2,
	    temp3,
	    temp4,
	    temp5,
	    temp6,
	    temp7);

   parameter q=7;
   input [q:0]data;
   input rd;
   input wr;
   input reset;
   input clk;
   
   output [q:0] data_out;
   output full;
   output empty;
   output [7:0] temp0;
   output [7:0] temp1;
   output [7:0] temp2;
   output [7:0] temp3;
   output [7:0] temp4;
   output [7:0] temp5;
   output [7:0] temp6;
   output [7:0] temp7;
   
   reg [3:0] 	fcount=4'b0;
   
   reg [2:0] 	wr_ptr=3'b0;
   
   reg [2:0] 	rd_ptr=3'b0;
   
   reg [q:0] 	fifo[q:0];
   reg 		full=1'b0;
   
   reg      empty=1'b0;
   
   reg [q:0] data_out;
   wire      wr_en;
   wire rd_en;
   assign wr_en=(wr&&(!full));
   assign rd_en=(rd&&(!empty));
 
   assign temp0=fifo[0];
   assign temp1=fifo[1];
   assign temp2=fifo[2];
   assign temp3=fifo[3];
   assign temp4=fifo[4];
   assign temp5=fifo[5];
   assign temp6=fifo[6];
   assign temp7=fifo[7];
/*   
 
 assign full=((wr_ptr>q)?1'b1:1'b0);
 assign empty=((rd_ptr==wr_ptr)?1'b1:1'b0);
 */
   always @(fcount)
     begin
	
	if(fcount>4'b0111)
	  full=1'b1;
	else full=1'b0;
     end
   
   always @(fcount)
     begin  
	if(fcount==4'b0)
	  empty=1'b1;
	else
	  empty=1'b0;
	
     end
   
   
   
   always @(posedge clk or negedge reset)
     begin
	if(~reset)
	  begin
	     wr_ptr<=3'b0;
	     rd_ptr<=3'b0;
	     fifo[0]<=8'b0;
	     fifo[1]<=8'b0;
	     fifo[2]<=8'b0;
	     fifo[3]<=8'b0;
	     fifo[4]<=8'b0;
	     fifo[5]<=8'b0;
	     fifo[6]<=8'b0;
	     fifo[7]<=8'b0;
	     
	     data_out<=8'b0; //..
	  end
	else if(wr_en&&(!rd_en))
	  begin
	     fcount=fcount+1'b1;
	     fifo[wr_ptr]<=data;
	     wr_ptr<=wr_ptr+1'b1;
	     
	  end
	
	else if(rd_en&&(!wr_en))
	  begin
	      fcount=fcount-1'b1;
	     data_out<=fifo[rd_ptr];
	     rd_ptr<=rd_ptr+1'b1;
	    
	     
	  end
	
	else if (wr_en&&rd_en)
	  begin
	  //   fcount<=fcount+1'b1;
	     fifo[wr_ptr]<=data;
	     wr_ptr<=wr_ptr+1'b1;
	     
	    // fcount=fcount-1'b1;
	     data_out<=fifo[rd_ptr];
	     rd_ptr<=rd_ptr+1'b1;
	 
	  end
	
	else
	  data_out<=data_out;
	
	
     end // always @ (posedge clk or negedge reset)
endmodule // fifo
