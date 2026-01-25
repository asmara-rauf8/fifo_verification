////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_seq_reset.sv
// Author : Asmara Rauf
// Creation Date : 07/24/2024
//
// Description
// ===========
// This module contains fifo reset sequence for simulation extended from uvm_sequence base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_seq_reset extends uvm_sequence #(fifo_tx);

  // factory registration
  `uvm_object_utils(fifo_seq_reset)

  // constructor
  function new(string name="fifo_seq_reset");
    super.new(name);
  endfunction

  // declarations
  fifo_tx   tx;
  
  // main task of the sequence
  virtual task body();
    tx  = fifo_tx  :: type_id :: create("tx");
    start_item(tx);
    tx.set_reset;
    finish_item(tx);
  endtask

endclass

