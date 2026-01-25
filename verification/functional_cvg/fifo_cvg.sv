////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_cvg.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// Description
// ===========
// This module contains interface through which driver communicates wuth dut and dut communicates with monitor.
//
// ///////////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_rd_export_cvg)
`uvm_analysis_imp_decl(_wr_export_cvg)

class fifo_cvg extends uvm_component;

  //factory registration
  `uvm_component_utils(fifo_cvg)
  
  //declarations
  uvm_analysis_imp_rd_export_cvg #(fifo_tx, fifo_cvg) rd_cvg_export;
  uvm_analysis_imp_wr_export_cvg #(fifo_tx, fifo_cvg) wr_cvg_export;
  fifo_tx  txx_cov_rd;
  fifo_tx  txx_cov_wr;
  
  covergroup write_cvg;
    wr_en_cp: coverpoint txx_cov_wr.wr_en{
      bins wr_enable = {1'b1};
      bins wr_disable = {1'b0};
    }
    full_cp: coverpoint txx_cov_wr.fifo_full{
      bins full = {1'b1};
      bins not_full = {1'b0};
    }
    full_on_reset_cp: coverpoint txx_cov_wr.fifo_full && txx_cov_wr.reset{
      illegal_bins full_on_reset = {1'b1};
    }
  endgroup
  
  covergroup read_cvg;
    rd_en_cp: coverpoint txx_cov_rd.rd_en{
      bins rd_enable = {1'b1};
      bins rd_disable = {1'b0};
    }
    empty_cp: coverpoint txx_cov_rd.fifo_empty{
      bins empty = {1'b1};
      bins not_empty = {1'b0};
    }
    not_empty_on_reset_cp: coverpoint ~txx_cov_rd.fifo_empty && txx_cov_rd.reset{
      illegal_bins not_empty_on_reset = {1'b1};
    }
    cross txx_cov_rd.wr_en, txx_cov_rd.rd_en;
  endgroup
  
  covergroup data_cvg;
    data_cp: coverpoint txx_cov_wr.wr_data{
      bins min = {0};
      bins max = {32'hFFFF_FFFF};
      bins value = {[0:32'hFFFF_FFFF]};
    }
  endgroup
  
  covergroup combined_cvg;
    cross write_cvg.full_cp, read_cvg.empty_cp{
      illegal_bins both_full_and_empty = binsof (write_cvg.full_cp.full) && binsof(read_cvg.empty_cp.empty);
    }
  endgroup
  
  //constructor
  function new (string name="fifo_cvg",uvm_component parent);
    super.new(name,parent);
    txx_cov_rd = new();
    txx_cov_wr = new();
    write_cvg = new();
    read_cvg = new();
    data_cvg = new();
    combined_cvg = new();
    rd_cvg_export = new("rd_cvg_export", this);
    wr_cvg_export = new("wr_cvg_export", this);
  endfunction
  
  virtual function void write_wr_export_cvg(fifo_tx wr);
    txx_cov_wr = wr;
    write_cvg.sample();
    data_cvg.sample();
  endfunction
  
  virtual function void write_wr_export_cvg(fifo_tx rd);
    txx_cov_rd = rd;
    read_cvg.sample();
  endfunction

endclass
