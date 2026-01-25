////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_tx.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// Description
// ===========
// This module contains fifo transactions extended from uvm_sequence_item base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_tx extends uvm_sequence_item;
  
  // constructor
  function new(string name="fifo_tx");
    super.new(name);
  endfunction

  // declarations
  bit                   reset;
  bit                   rd_en;
  bit                   wr_en;
  bit  [DATA_WIDTH-1:0] wr_data;
  bit  [DATA_WIDTH-1:0] rd_data;
  bit                   fifo_full;
  bit                   fifo_empty;

  // factory registration & field macros
  `uvm_object_utils_begin(fifo_tx)
  `uvm_field_int (reset,   UVM_ALL_ON)
  `uvm_field_int (rd_en,   UVM_ALL_ON) 
  `uvm_field_int (wr_en,   UVM_ALL_ON)
  `uvm_field_int (wr_data, UVM_ALL_ON)
  `uvm_object_utils_end

  // custom randomization function
  function set_read();
    reset   = 0;
    rd_en   = 1;
    wr_en   = 0;
    wr_data = 0;
  endfunction

  function set_write();
    reset   = 0;
    rd_en   = 0;
    wr_en   = 1;
    wr_data = $random();
  endfunction
 
  function set_reset();
    reset   = 1;
    rd_en   = 0;
    wr_en   = 0;
    wr_data = 0;
  endfunction
 
  function set_rd_wr();
    reset   = 0;
    rd_en   = 1;
    wr_en   = 1;
    wr_data = $random();
  endfunction
endclass

