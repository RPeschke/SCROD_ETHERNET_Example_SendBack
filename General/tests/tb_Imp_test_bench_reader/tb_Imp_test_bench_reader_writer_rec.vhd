
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package tb_Imp_test_bench_reader_writer_pgk is

type tb_Imp_test_bench_reader_writer_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 
rxDataReady : sl; 
clk_out : sl; 
data_out_0 : slv(31 downto 0); 
data_out_1 : slv(31 downto 0); 
data_out_2 : slv(31 downto 0); 
data_out_3 : slv(31 downto 0); 
data_out_4 : slv(31 downto 0); 
data_out_5 : slv(31 downto 0); 
data_out_6 : slv(31 downto 0); 
data_out_7 : slv(31 downto 0); 
data_out_8 : slv(31 downto 0); 
data_out_9 : slv(31 downto 0); 
data_out_10 : slv(31 downto 0); 

end record tb_Imp_test_bench_reader_writer_rec; 

constant  tb_Imp_test_bench_reader_writer_rec_null: tb_Imp_test_bench_reader_writer_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null,
rxDataReady => sl_null,
clk_out => sl_null,
data_out_0 => (others => '0'),
data_out_1 => (others => '0'),
data_out_2 => (others => '0'),
data_out_3 => (others => '0'),
data_out_4 => (others => '0'),
data_out_5 => (others => '0'),
data_out_6 => (others => '0'),
data_out_7 => (others => '0'),
data_out_8 => (others => '0'),
data_out_9 => (others => '0'),
data_out_10 => (others => '0'));

end tb_Imp_test_bench_reader_writer_pgk;


package body tb_Imp_test_bench_reader_writer_pgk is
end package body tb_Imp_test_bench_reader_writer_pgk;

