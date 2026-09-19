module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] expected;
  integer    i, j, k, errors, total;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total  = 0;
    #1;  

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin   
          t_a  = i;
          t_b  = j;
          t_op = k;

         
          if (k == 0) expected = i + j;
          else        expected = i - j;

          #5;   
          total = total + 1;

          if (t_result !== expected) begin
            $display("FAIL at time %0t: a=%0d b=%0d op=%0d  got %0d  expected %0d",
                     $time, t_a, t_b, t_op, t_result, expected);
            errors = errors + 1;
          end
        end
      end
    end

    $write("SUMMARY: %0d/%0d passed", total - errors, total);
    if (errors == 0) $write(" - ALL PASS");
    else             $write(" - %0d FAILED", errors);
    $write("\n");

    $finish;
  end

endmodule