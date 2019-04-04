library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.tb_imp_test_bench_reader_reader_pgk.all;
use work.tb_imp_test_bench_reader_writer_pgk.all;

entity tb_Imp_test_bench_reader is 
end entity;

architecture Behavioral of tb_Imp_test_bench_reader is 

signal clk : std_logic  := '0'  ;
signal reader_data : tb_Imp_test_bench_reader_reader_rec  := tb_Imp_test_bench_reader_reader_rec_null  ;
signal writer_data : tb_Imp_test_bench_reader_writer_rec  := tb_Imp_test_bench_reader_writer_rec_null  ;
begin


clk_gen :entity  work.ClockGenerator
   generic map (
    CLOCK_period=> 10 ns) 
   port map( 
    clk => clk
   );



reader :entity  work.tb_Imp_test_bench_reader_reader  
    generic map (
         FileName => "tb_Imp_test_bench_reader.csv"
       ) 
       port map(
         clk => clk,
         data => reader_data
       );



writer :entity  work.tb_Imp_test_bench_reader_writer 
    generic map (
         FileName => "tb_Imp_test_bench_reader_out.csv"
       ) 
       port map(
         clk => clk,
         data => writer_data
       );

writer_data.rxData <= reader_data.rxData;
writer_data.rxDataLast <= reader_data.rxDataLast;
writer_data.rxDataValid <= reader_data.rxDataValid;


  dut : entity work.Imp_test_bench_reader 
    generic map (
      COLNum => 11
    ) port map ( 
    Clk => clk,
valid => writer_data.clk_out,
data_out(0) => writer_data.data_out_0,
data_out(1) => writer_data.data_out_1,
data_out(10) => writer_data.data_out_10,
data_out(2) => writer_data.data_out_2,
data_out(3) => writer_data.data_out_3,
data_out(4) => writer_data.data_out_4,
data_out(5) => writer_data.data_out_5,
data_out(6) => writer_data.data_out_6,
data_out(7) => writer_data.data_out_7,
data_out(8) => writer_data.data_out_8,
data_out(9) => writer_data.data_out_9,
rxData => writer_data.rxData,
rxDataLast => writer_data.rxDataLast,
rxDataReady => writer_data.rxDataReady,
rxDataValid => writer_data.rxDataValid
  );


end Behavioral;

