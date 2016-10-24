//                              -*- Mode: Verilog -*-
// Filename        : tb_fifo.v
// Description     : testbench for fifo
// Author          : 
// Created On      : Mon Jun 22 17:06:48 2015
// Last Modified By: 
// Last Modified On: Mon Jun 22 17:06:48 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!
//////////////////////////////////////////////////

`include "fifo.v"
module tb_fifo();

   reg [7:0]data;
   reg rd;
   reg wr;
   reg reset;
   reg clk;

   wire [7:0]data_out;
   wire full;
   wire empty;
   wire[7:0] temp0;
    wire[7:0] temp1;
    wire[7:0] temp2;
    wire[7:0] temp3;
    wire[7:0] temp4;
    wire[7:0] temp5;
    wire[7:0] temp6;
    wire[7:0] temp7;
  


   initial
     begin
	clk=1'b0;
	reset=1'b0;
	wr=1'b0;
	rd=1'b0;
	data=8'b0;
	
	#5 reset=1'b1;
	#5 reset=1'b0;
	#5 reset=1'b1;

	#10 wr=1'b1;
	#10 rd=1'b1;
	#30 wr=1'b0;
	rd=1'b0;
	#10 wr = 1'b1;
	#200 wr = 1'b0;
	rd = 1'b1;
	#40 rd=1'b0;
	#10 wr=1'b1;
	#60 wr=1'b0;
	#10 rd=1'b1;
     
   /*	#10 wr=1'b1;
	#10 wr=1'b0;
	#10 wr=1'b1;
	#10 wr=1'b0;
	#10 rd=1'b1;
	#10 rd=1'b0;
	#10 rd=1'b1;
	#10 rd=1'b0;
	
	#10 wr=1'b1;
	rd=1'b1;
	#30 wr=1'b0;
	 rd=1'b0;	
	*/

/*	#10 wr=1'b1;

	rd=1'b1;
	#100 rd=1'b0;
	wr=1'b0;
*/

   
     end // initial begin

   always
	
     #5 clk=~clk;
   /*always @(posedge clk)
     
     {wr,rd}=$random;
*/   
   always @(posedge clk)	
     data=$random;

   fifo ff1(data,
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
   initial
     begin
	$monitor($time, "data=%b,rd=%b,wr=%b,reset=%b,clk=%b,data_out=%b,full=%b,empty=%b,temp0=%b,temp1=%b,temp2=%b,temp3=%b,temp4=%b,temp5=%b,temp6=%b,temp7=%b", data,rd,wr,reset,clk,data_out,full,empty,temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7);

	$dumpfile("fifo.vcd");
	$dumpvars;
	$dumpon;
	#1000 $dumpoff;
	$finish;

     end // initial begin
   
   
   
endmodule // tb_fifo

	      
	
	     
