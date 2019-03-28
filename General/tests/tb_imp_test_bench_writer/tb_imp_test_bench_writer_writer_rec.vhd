
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package tb_imp_test_bench_writer_writer_pgk is

type tb_imp_test_bench_writer_writer_rec is record 
txData : slv(31 downto 0); 
txDataValid : sl; 
txDataLast : sl; 
txDataReady : sl; 
valid : sl; 
data_in_0 : slv(31 downto 0); 
data_in_1 : slv(31 downto 0); 
data_in_2 : slv(31 downto 0); 
data_in_3 : slv(31 downto 0); 
data_in_4 : slv(31 downto 0); 
data_in_5 : slv(31 downto 0); 
data_in_6 : slv(31 downto 0); 
data_in_7 : slv(31 downto 0); 
data_in_8 : slv(31 downto 0); 
data_in_9 : slv(31 downto 0); 
data_in_10 : slv(31 downto 0); 

end record tb_imp_test_bench_writer_writer_rec; 

constant  tb_imp_test_bench_writer_writer_rec_null: tb_imp_test_bench_writer_writer_rec := (txData => (others => '0'),
txDataValid => sl_null,
txDataLast => sl_null,
txDataReady => sl_null,
valid => sl_null,
data_in_0 => (others => '0'),
data_in_1 => (others => '0'),
data_in_2 => (others => '0'),
data_in_3 => (others => '0'),
data_in_4 => (others => '0'),
data_in_5 => (others => '0'),
data_in_6 => (others => '0'),
data_in_7 => (others => '0'),
data_in_8 => (others => '0'),
data_in_9 => (others => '0'),
data_in_10 => (others => '0'));

end tb_imp_test_bench_writer_writer_pgk;


package body tb_imp_test_bench_writer_writer_pgk is
end package body tb_imp_test_bench_writer_writer_pgk;

