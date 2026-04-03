module subbytes(
  input  logic [127:0] state_in, 
  output logic [127:0] state_out
);
  genvar i;
  generate
    for (i = 0; i < 16; i++) begin : gen_sbox
      sbox dut (
        .a(state_in[127 - i*8 -: 8]),
        .c(state_out[127 - i*8 -: 8])
      );
    end
  endgenerate
  
endmodule : subbytes
