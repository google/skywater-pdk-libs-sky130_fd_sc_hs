/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/


`ifndef SKY130_FD_SC_HS__FA_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HS__FA_FUNCTIONAL_PP_V

/**
 * fa: Full adder.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__fa (
    VPWR,
    VGND,
    COUT,
    SUM ,
    A   ,
    B   ,
    CIN
);

    // Module ports
    input  VPWR;
    input  VGND;
    output COUT;
    output SUM ;
    input  A   ;
    input  B   ;
    input  CIN ;

    // Local signals
    wire	CIN          or0_out              ;
    wire	CIN          and0_out             ;
    wire	CIN          and1_out             ;
    wire	csi_opt_276, nor0_out             ;
    wire	csi_opt_276, nor1_out             ;
    wire              or1_out_COUT         ;
    wire              u_vpwr_vgnd0_out_COUT;
    wire              and2_out             ;
    wire              or2_out_SUM          ;
    wire              u_vpwr_vgnd1_out_SUM ;

    //                           Name          Output                 Other arguments
    or                           or0          (or0_out              , CIN, B                  );
    and                          and0         (and0_out             , or0_out, A              );
    and                          and1         (and1_out             , B, CIN                  );
    or                           or1          (or1_out_COUT         , and1_out, and0_out      );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (u_vpwr_vgnd0_out_COUT, or1_out_COUT, VPWR, VGND);
    buf                          buf0         (COUT                 , u_vpwr_vgnd0_out_COUT   );
    and                          and2         (and2_out             , CIN, A, B               );
    nor                          nor0         (nor0_out             , A, or0_out              );
    nor                          nor1         (nor1_out             , nor0_out, COUT          );
    or                           or2          (or2_out_SUM          , nor1_out, and2_out      );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd1 (u_vpwr_vgnd1_out_SUM , or2_out_SUM, VPWR, VGND );
    buf                          buf1         (SUM                  , u_vpwr_vgnd1_out_SUM    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__FA_FUNCTIONAL_PP_V