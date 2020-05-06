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


`ifndef SKY130_FD_SC_HS__SDFBBP_BEHAVIORAL_V
`define SKY130_FD_SC_HS__SDFBBP_BEHAVIORAL_V

/**
 * sdfbbp: Scan delay flop, inverted set, inverted reset, non-inverted
 *         clock, complementary outputs.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_dfb_setdom_notify_pg/sky130_fd_sc_hs__u_dfb_setdom_notify_pg.v"
`include "../u_mux_2/sky130_fd_sc_hs__u_mux_2.v"

`celldefine
module sky130_fd_sc_hs__sdfbbp (
    Q      ,
    Q_N    ,
    D      ,
    SCD    ,
    SCE    ,
    CLK    ,
    SET_B  ,
    RESET_B,
    VPWR   ,
    VGND
);

    // Module ports
    output Q      ;
    output Q_N    ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  CLK    ;
    input  SET_B  ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;

    // Local signals
    wire RESET          ;
    wire SET            ;
    wire buf_Q          ;
    reg  notifier       ;
    wire D_delayed      ;
    wire SCD_delayed    ;
    wire SCE_delayed    ;
    wire CLK_delayed    ;
    wire SET_B_delayed  ;
    wire RESET_B_delayed;
    wire mux_out        ;
    wire awake          ;
    wire cond0          ;
    wire cond1          ;
    wire condb          ;
    wire cond_D         ;
    wire cond_SCD       ;
    wire cond_SCE       ;

    //                                      Name                     Output   Other arguments
    not                                     not0                    (RESET  , RESET_B_delayed                                       );
    not                                     not1                    (SET    , SET_B_delayed                                         );
    sky130_fd_sc_hs__u_mux_2_1              u_mux_20                (mux_out, D_delayed, SCD_delayed, SCE_delayed                   );
    sky130_fd_sc_hs__u_dfb_setdom_notify_pg u_dfb_setdom_notify_pg0 (buf_Q  , SET, RESET, CLK_delayed, mux_out, notifier, VPWR, VGND);
    assign awake = ( VPWR === 1'b1 );
    assign cond0 = ( awake && ( RESET_B_delayed === 1'b1 ) );
    assign cond1 = ( awake && ( SET_B_delayed === 1'b1 ) );
    assign condb = ( cond0 & cond1 );
    assign cond_D = ( ( SCE_delayed === 1'b0 ) && condb );
    assign cond_SCD = ( ( SCE_delayed === 1'b1 ) && condb );
    assign cond_SCE = ( ( D_delayed !== SCD_delayed ) && condb );
    buf                                     buf0                    (Q      , buf_Q                                                 );
    not                                     not2                    (Q_N    , buf_Q                                                 );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__SDFBBP_BEHAVIORAL_V