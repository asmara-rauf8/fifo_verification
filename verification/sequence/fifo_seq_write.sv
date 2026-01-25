////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_seq_write.sv
// Author : Asmara Rauf
// Creation Date : 07/24/2024
//
// Description
// ===========
// This module contains fifo write sequence for simulation extended from uvm_sequence base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_seq_write extends uvm_sequence #(fifo_tx);

  // factory registration
  `uvm_object_utils(fifo_seq_write)

  // constructor
  function new(string name="fifo_seq_write");
    super.new(name);
  endfunction

  // declarations
  fifo_tx   tx;
  
  // main task of the sequence
  virtual task body();
    tx  = fifo_tx  :: type_id :: create("tx");
    start_item(tx);
    tx.set_write();
    finish_item(tx);
  endtask

endclass

