library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.tb_imp_test_bench_writer_reader_pgk.all;
use work.tb_imp_test_bench_writer_writer_pgk.all;

entity tb_imp_test_bench_writer is 
end entity;

architecture Behavioral of tb_imp_test_bench_writer is 

signal clk : std_logic  := '0'  ;
signal reader_data : tb_imp_test_bench_writer_reader_rec  := tb_imp_test_bench_writer_reader_rec_null  ;
signal writer_data : tb_imp_test_bench_writer_writer_rec  := tb_imp_test_bench_writer_writer_rec_null  ;
begin


clk_gen :entity  work.ClockGenerator
   generic map (
    CLOCK_period=> 10 ns) 
   port map( 
    clk => clk
   );



reader :entity  work.tb_imp_test_bench_writer_reader  
    generic map (
         FileName => "tb_imp_test_bench_writer.csv"
       ) 
       port map(
         clk => clk,
         data => reader_data
       );



writer :entity  work.tb_imp_test_bench_writer_writer 
    generic map (
         FileName => "tb_imp_test_bench_writer_out.csv"
       ) 
       port map(
         clk => clk,
         data => writer_data
       );

writer_data.data_in_0 <= reader_data.data_in_0;
writer_data.data_in_1 <= reader_data.data_in_1;
writer_data.data_in_10 <= reader_data.data_in_10;
writer_data.data_in_2 <= reader_data.data_in_2;
writer_data.data_in_3 <= reader_data.data_in_3;
writer_data.data_in_4 <= reader_data.data_in_4;
writer_data.data_in_5 <= reader_data.data_in_5;
writer_data.data_in_6 <= reader_data.data_in_6;
writer_data.data_in_7 <= reader_data.data_in_7;
writer_data.data_in_8 <= reader_data.data_in_8;
writer_data.data_in_9 <= reader_data.data_in_9;
writer_data.txDataReady <= reader_data.txDataReady;
writer_data.valid <= reader_data.valid;


  dut : entity work.Imp_test_bench_writer port map ( 
  clk => clk, 
  data_in(0) => writer_data.data_in_0,
data_in(1) => writer_data.data_in_1,
data_in(10) => writer_data.data_in_10,
data_in(2) => writer_data.data_in_2,
data_in(4) => writer_data.data_in_4,
data_in(3) => writer_data.data_in_3,
data_in(5) => writer_data.data_in_5,
data_in(6) => writer_data.data_in_6,
data_in(7) => writer_data.data_in_7,
data_in(8) => writer_data.data_in_8,
data_in(9) => writer_data.data_in_9,
txData => writer_data.txData,
txDataLast => writer_data.txDataLast,
txDataReady => writer_data.txDataReady,
txDataValid => writer_data.txDataValid,
valid => writer_data.valid
  );


end Behavioral;

