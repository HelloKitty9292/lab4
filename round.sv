module round(
    input  logic [127:0] state_in,
    input  logic [127:0] round_key,
    output logic [127:0] state_out
);
  logic [127:0] sb_out;
  logic [127:0] sr_out;
  logic [127:0] mc_out;
  
  subbytes u_subbytes(
    .state_in(state_in),
    .state_out(sb_out)
  );

  shiftrow u_shiftrow(
    .state_in(sb_out),
    .state_out(sr_out)
  );

  mixcolumns u_mixcolumns(
    .state_in(sr_out),
    .state_out(mc_out)
  );

  assign state_out = mc_out ^ round_key;

endmodule : round