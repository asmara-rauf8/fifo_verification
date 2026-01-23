onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {New Group2} /top/pif/clk
add wave -noupdate -expand -group {New Group2} /top/pif/reset
add wave -noupdate -expand -group {New Group1} /top/pif/rd_en
add wave -noupdate -expand -group {New Group1} -radix unsigned /top/pif/rd_data
add wave -noupdate -expand -group {New Group} /top/pif/wr_en
add wave -noupdate -expand -group {New Group} -radix unsigned /top/pif/wr_data
add wave -noupdate -expand -group {New Group3} /top/DUT/fifo_empty
add wave -noupdate -expand -group {New Group3} /top/DUT/fifo_full
add wave -noupdate -expand -group {New Group3} -radix unsigned /top/DUT/buffer
add wave -noupdate -expand -group {New Group3} -radix unsigned /top/DUT/rd_ptr
add wave -noupdate -expand -group {New Group3} -radix unsigned /top/DUT/wr_ptr
add wave -noupdate -expand -group {New Group3} -radix unsigned /top/DUT/wr_counter
add wave -noupdate /top/DUT/empty
add wave -noupdate /top/DUT/empty_delayed
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 324
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {408 ps}
