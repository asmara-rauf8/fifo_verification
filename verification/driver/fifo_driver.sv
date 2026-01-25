////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_driver.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// Description
// ===========
// This module contains fifo driver extended from uvm_driver base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_driver extends uvm_driver #(fifo_tx);

  //factory registration
  `uvm_component_utils(fifo_driver)

  //constructor
  function new(string name="fifo_driver",uvm_component parent);
    super.new(name,parent);
  endfunction

  //declarations
  virtual fifo_intf #(DATA_WIDTH, FIFO_SIZE) vif;
  fifo_tx   tx;

  //build phase
  function void build_phase(uvm_phase phase);
    if (!(uvm_config_db #(virtual fifo_intf #(DATA_WIDTH, FIFO_SIZE))::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface")
    end
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    vif.rd_en   <= 0;
    vif.wr_en   <= 0;
    forever begin
      seq_item_port.get_next_item(tx);
      @(posedge vif.clk);
      if (tx.reset == 1) begin 
        vif.reset   <= tx.reset;
        @(posedge vif.clk);
        @(posedge vif.clk);
        vif.reset <= 0;
      end
      else begin
        vif.rd_en   <= tx.rd_en;
        vif.wr_en   <= tx.wr_en;
        vif.wr_data <= tx.wr_data;
      end
      seq_item_port.item_done();     
    end
  endtask
  
endclass
