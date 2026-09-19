// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
reg  [2:0] t_sel;
wire [7:0] t_dout; 
integer k;
  // TODO: instantiate DUT here
lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
for (k = 0; k < 8; k = k + 1) begin
      t_sel = k;
      #5;
      if (t_dout !== k*k)
        $display("FAIL: sel=%0d expected %0d got %0d", k, k*k, t_dout);
      else
        $display("PASS: sel=%0d dout=%0d", k, t_dout);
    end
    $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout); // change as required

endmodule
