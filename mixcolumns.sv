module mixcolumns(
  input  logic [127:0] state_in,
  output logic [127:0] state_out
);
  function logic [7:0] mult2(input logic [7:0] x);
    begin
      mult2 = x[7] ? ((x << 1) ^ 8'h1b) : (x << 1);
    end
  endfunction

  function logic [7:0] mult3(input logic [7:0] x);
    begin
      mult3 = mult2(x) ^ x;
    end
  endfunction

  logic [7:0] bin [15:0];
  logic [7:0] bout[15:0];

  genvar i;
  generate
    for (i = 0; i < 16; i++) begin : gen_bytes
      assign bin[i] = state_in[127 - i*8 -: 8];
      assign state_out[127 - i*8 -: 8] = bout[i];
    end
  endgenerate

  // column 0
  assign bout[0] = mult2(bin[0]) ^ mult3(bin[1]) ^ bin[2] ^ bin[3];
  assign bout[1] = bin[0] ^ mult2(bin[1]) ^ mult3(bin[2]) ^ bin[3];
  assign bout[2] = bin[0] ^ bin[1] ^ mult2(bin[2]) ^ mult3(bin[3]);
  assign bout[3] = mult3(bin[0]) ^ bin[1] ^ bin[2] ^ mult2(bin[3]);

  // column 1
  assign bout[4] = mult2(bin[4]) ^ mult3(bin[5]) ^ bin[6] ^ bin[7];
  assign bout[5] = bin[4] ^ mult2(bin[5]) ^ mult3(bin[6]) ^ bin[7];
  assign bout[6] = bin[4] ^ bin[5] ^ mult2(bin[6]) ^ mult3(bin[7]);
  assign bout[7] = mult3(bin[4]) ^ bin[5] ^ bin[6] ^ mult2(bin[7]);

  // column 2
  assign bout[8]  = mult2(bin[8])  ^ mult3(bin[9])  ^ bin[10] ^ bin[11];
  assign bout[9]  = bin[8]  ^ mult2(bin[9])  ^ mult3(bin[10]) ^ bin[11];
  assign bout[10] = bin[8]  ^ bin[9]  ^ mult2(bin[10]) ^ mult3(bin[11]);
  assign bout[11] = mult3(bin[8]) ^ bin[9] ^ bin[10] ^ mult2(bin[11]);

  // column 3
  assign bout[12] = mult2(bin[12]) ^ mult3(bin[13]) ^ bin[14] ^ bin[15];
  assign bout[13] = bin[12] ^ mult2(bin[13]) ^ mult3(bin[14]) ^ bin[15];
  assign bout[14] = bin[12] ^ bin[13] ^ mult2(bin[14]) ^ mult3(bin[15]);
  assign bout[15] = mult3(bin[12]) ^ bin[13] ^ bin[14] ^ mult2(bin[15]);
  
endmodule : mixcolumns