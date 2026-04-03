module shiftrow(
  input  logic [127:0] state_in,
  output logic [127:0] state_out
);
  logic [7:0] bin[15:0];
  logic [7:0] bout[15:0];
  genvar i;
  generate
    for (i = 0; i < 16; i++) begin : gen_shift
      assign bin[i] = state_in[127 - i*8 -: 8];
      assign state_out[127 - i*8 -: 8] = bout[i];
    end
  endgenerate

  assign bout[0] = bin[0];
  assign bout[1] = bin[5];
  assign bout[2] = bin[10];
  assign bout[3] = bin[15];
  assign bout[4] = bin[4];
  assign bout[5] = bin[9];
  assign bout[6] = bin[14];
  assign bout[7] = bin[3];
  assign bout[8] = bin[8];
  assign bout[9] = bin[13];
  assign bout[10] = bin[2];
  assign bout[11] = bin[7];
  assign bout[12] = bin[12];
  assign bout[13] = bin[1];
  assign bout[14] = bin[6];
  assign bout[15] = bin[11];
endmodule : shiftrow

// module shiftrow_tb;
//   logic [127:0] state_in;
//   logic [127:0] state_out;

//   shiftrow dut (
//     .state_in (state_in),
//     .state_out(state_out)
//   );

//   initial begin
//     $display("Starting subbytes testbench...");

//     // Test 1: all zeros
//     state_in = 128'h00_01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f;
//     #10;
//     $display("T1 state_in  = %h", state_in);
//     $display("T1 state_out = %h", state_out);

//     $display("Finished.");
//     $finish;
//   end
// endmodule
