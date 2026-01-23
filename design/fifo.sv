////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo.sv
// Author : Asmara Rauf
// Creation Date : 12/06/2024
//
// No portions of this material may be reproduced in any form without
// the written permission of CoMira s0lutions Inc.
//
// All information contained in this document is CoMira s0lutions
// private, proprietary and trade secret.
//
// Description
// ===========
// This module contains the design of a generic FIFO( first in, first out) which is used for the storage of data.
//
// ///////////////////////////////////////////////////////////////////////////////

module fifo #(
  parameter FIFO_SIZE  = 101,
  parameter DATA_WIDTH = 32
)
(
  input logic                   clk,
  input logic                   reset,
  input logic                   rd_en,
  input logic                   wr_en,
  input logic  [DATA_WIDTH-1:0] wr_data,
  output logic [DATA_WIDTH-1:0] rd_data,
  output logic                  fifo_empty,
  output logic                  fifo_full
);
         
         
  logic [DATA_WIDTH-1:0]         buffer [FIFO_SIZE];  
  logic [$clog2(FIFO_SIZE)-1:0]  rd_ptr;
  logic [$clog2(FIFO_SIZE)-1:0]  wr_ptr;
  logic [$clog2(FIFO_SIZE)-1:0]  counter;
  logic  empty;
  logic  empty_delayed;
 
 
// Write data
  always @(*) begin
    if (wr_en & ~fifo_full) begin
      buffer[wr_ptr] = wr_data;
    end 
    fifo_full = (counter == FIFO_SIZE -1) && ~reset;
  end
  
// Read data
  always @(posedge clk) begin
    if (reset) begin
      rd_data <= 0;
    end
    else if (rd_en && wr_en) begin 
      rd_data <= buffer[rd_ptr];
    end
    else if (rd_en & !empty) begin
      rd_data <= buffer[rd_ptr];
    end
    else begin 
      rd_data <= 0;  
    end
  end
  
// Write pointer
  always @(posedge clk) begin
    if (reset) begin
      wr_ptr   <= 0;
    end 
    else begin
      if (wr_en && ~fifo_full) begin
        wr_ptr <= (wr_ptr + 1 == FIFO_SIZE)? 0 : (wr_ptr + 1);
      end 
    end
  end
  
// Read pointer
  always @(posedge clk) begin
    if (reset) begin
      rd_ptr   <= 0;
    end 
    else begin
      if(rd_en && wr_en) begin
        rd_ptr <= rd_ptr + 1;
      end
      else if (rd_en && !empty) begin
        rd_ptr <= rd_ptr + 1;
        if (rd_ptr == FIFO_SIZE - 1) begin   
          rd_ptr <= 0;
        end
      end
    end
  end
  

// counter for empty and full signals
  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
    end 
    else if (rd_en && wr_en) begin     
      counter <= counter;
    end
    else if (wr_en && !fifo_full) begin
      counter <= counter + 1;
    end
    else if (rd_en && counter>0) begin  
      counter <= counter - 1;    
    end
  end
 
 // Empty signal update
  always @(*) begin
    empty = reset? 1 : wr_en? 0 : rd_en? (counter == 0) : !(counter > 0);
  end
  
  always@(posedge clk) begin
    empty_delayed <= empty;
  end
  
  assign fifo_empty = empty & empty_delayed || empty & !empty_delayed;

endmodule        
