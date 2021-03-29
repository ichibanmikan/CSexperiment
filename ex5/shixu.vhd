-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- Generated by Quartus II Version 9.0 Build 184 04/29/2009 Service Pack 1 SJ Web Edition
-- Created on Sun Mar 21 12:18:33 2021

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shixu IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        qd : IN STD_LOGIC := '0';
        dp : IN STD_LOGIC := '0';
        tj : IN STD_LOGIC := '0';
        t1 : OUT STD_LOGIC;
        t2 : OUT STD_LOGIC;
        t3 : OUT STD_LOGIC;
        t4 : OUT STD_LOGIC
    );
END shixu;

ARCHITECTURE BEHAVIOR OF shixu IS
    TYPE type_fstate IS (idle,s_st2,st1,st3,st2,s_st3,st4,s_st4);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,qd,dp,tj)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= idle;
            t1 <= '0';
            t2 <= '0';
            t3 <= '0';
            t4 <= '0';
        ELSE
            t1 <= '0';
            t2 <= '0';
            t3 <= '0';
            t4 <= '0';
            CASE fstate IS
                WHEN idle =>
                    IF (NOT((qd = '1'))) THEN
                        reg_fstate <= st1;
                    ELSE
                        reg_fstate <= idle;
                    END IF;

                    t3 <= '0';

                    t1 <= '0';

                    t2 <= '0';

                    t4 <= '0';
                WHEN s_st2 =>
                    IF ((tj = '1')) THEN
                        reg_fstate <= s_st2;
                    ELSE
                        reg_fstate <= s_st3;
                    END IF;

                    t3 <= '0';

                    t1 <= '0';

                    t2 <= '1';

                    t4 <= '0';
                WHEN st1 =>
                    IF (((dp = '1') AND NOT((tj = '1')))) THEN
                        reg_fstate <= s_st2;
                    ELSIF (((tj = '1') AND NOT((dp = '1')))) THEN
                        reg_fstate <= st1;
                    ELSE
                        reg_fstate <= st2;
                    END IF;

                    t3 <= '0';

                    t1 <= '1';

                    t2 <= '0';

                    t4 <= '0';
                WHEN st3 =>
                    IF (((dp = '1') AND NOT((tj = '1')))) THEN
                        reg_fstate <= s_st4;
                    ELSIF (((tj = '1') AND NOT((dp = '1')))) THEN
                        reg_fstate <= st3;
                    ELSE
                        reg_fstate <= st4;
                    END IF;

                    t3 <= '1';

                    t1 <= '0';

                    t2 <= '0';

                    t4 <= '0';
                WHEN st2 =>
                    IF (((tj = '1') AND NOT((dp = '1')))) THEN
                        reg_fstate <= st2;
                    ELSIF (((dp = '1') AND NOT((tj = '1')))) THEN
                        reg_fstate <= s_st3;
                    ELSE
                        reg_fstate <= st3;
                    END IF;

                    t3 <= '0';

                    t1 <= '0';

                    t2 <= '1';

                    t4 <= '0';
                WHEN s_st3 =>
                    IF ((tj = '1')) THEN
                        reg_fstate <= s_st3;
                    ELSE
                        reg_fstate <= s_st4;
                    END IF;

                    t3 <= '1';

                    t1 <= '0';

                    t2 <= '0';

                    t4 <= '0';
                WHEN st4 =>
                    IF (((dp = '1') AND NOT((tj = '1')))) THEN
                        reg_fstate <= idle;
                    ELSIF (((tj = '1') AND NOT((dp = '1')))) THEN
                        reg_fstate <= st4;
                    ELSE
                        reg_fstate <= st1;
                    END IF;

                    t3 <= '0';

                    t1 <= '0';

                    t2 <= '0';

                    t4 <= '1';
                WHEN s_st4 =>
                    IF ((tj = '1')) THEN
                        reg_fstate <= s_st4;
                    ELSE
                        reg_fstate <= idle;
                    END IF;

                    t3 <= '0';

                    t1 <= '0';

                    t2 <= '0';

                    t4 <= '1';
                WHEN OTHERS => 
                    t1 <= 'X';
                    t2 <= 'X';
                    t3 <= 'X';
                    t4 <= 'X';
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;