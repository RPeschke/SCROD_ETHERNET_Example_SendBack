
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package tb_Imp_test_bench_reader_reader_pgk is

type tb_Imp_test_bench_reader_reader_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 

end record tb_Imp_test_bench_reader_reader_rec; 

constant  tb_Imp_test_bench_reader_reader_rec_null: tb_Imp_test_bench_reader_reader_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null);

end tb_Imp_test_bench_reader_reader_pgk;


package body tb_Imp_test_bench_reader_reader_pgk is
end package body tb_Imp_test_bench_reader_reader_pgk;

