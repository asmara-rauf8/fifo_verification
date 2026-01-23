////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_monitor.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// No portions of this material may be reproduced in any form without
// the written permission of CoMira solutions Inc.
//
// All information contained in this document is CoMira solutions
// private, proprietary and trade secret.
//
// Description
// ===========
// This module contains fifo monitor extended from uvm_monitor base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_monitor extends uvm_monitor;

  // factory registration
  `uvm_component_utils(fifo_monitor)

  //constructor
  function new(string name="fifo_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction

  // declarations
  fifo_tx      txx_read;
  fifo_tx      txx_write;
  
  virtual fifo_intf #(DATA_WIDTH, FIFO_SIZE) vif;
  
  uvm_analysis_port  #(fifo_tx)     rd_monitor_analysis_port;
  uvm_analysis_port  #(fifo_tx)     wr_monitor_analysis_port;

  // build_phase
  function void build_phase(uvm_phase phase);
    if (!(uvm_config_db #(virtual fifo_intf #(DATA_WIDTH, FIFO_SIZE))::get(this,"","vif",vif))) begin
      `uvm_fatal("monitor","unable to get interface")
    end
    txx_read  = fifo_tx ::type_id::create("txx_read",this);
    txx_write = fifo_tx ::type_id::create("txx_write",this);
    
    rd_monitor_analysis_port  = new("rd_monitor_analysis_port",this);
    wr_monitor_analysis_port  = new("wr_monitor_analysis_port",this);
  endfunction

  // run_phase
  task run_phase(uvm_phase phase);
  @(posedge vif.clk);
    forever begin
      @(posedge vif.clk);
      fork
        begin
          read_data();
        end
        begin
         // @(posedge vif.clk); //for read write synchronization
          write_data();
        end
      join_none      
    end
  endtask
  
  
  task read_data;
    @(posedge vif.clk);
    if (vif.reset) begin
      txx_read.reset      = vif.reset;
      txx_read.fifo_empty = vif.fifo_empty;
      rd_monitor_analysis_port.write(txx_read);
    end
    else if (vif.rd_en == 1) begin
      @(posedge vif.clk);   //observe output on next clock cycle
      txx_read.reset      = vif.reset;
      txx_read.rd_en      = vif.rd_en;
      txx_read.rd_data    = vif.rd_data;
      txx_read.fifo_empty = vif.fifo_empty;   
      rd_monitor_analysis_port.write(txx_read);
    end
  endtask
  
  task write_data;
    if (vif.reset) begin
      txx_write.reset     = vif.reset;
      txx_write.fifo_full = vif.fifo_full;
      wr_monitor_analysis_port.write(txx_write); 
    end
    else if (vif.wr_en == 1) begin
      txx_write.reset     = vif.reset;
      txx_write.wr_en     = vif.wr_en;
      txx_write.wr_data   = vif.wr_data;
      txx_write.fifo_full = vif.fifo_full;
      wr_monitor_analysis_port.write(txx_write); 
    end   
  endtask
  
endclass
