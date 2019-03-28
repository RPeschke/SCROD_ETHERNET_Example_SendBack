
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package tb_impl_test_read_write_reader_pgk is

type tb_impl_test_read_write_reader_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 
txDataReady : sl; 

end record tb_impl_test_read_write_reader_rec; 

constant  tb_impl_test_read_write_reader_rec_null: tb_impl_test_read_write_reader_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null,
txDataReady => sl_null);

end tb_impl_test_read_write_reader_pgk;


package body tb_impl_test_read_write_reader_pgk is
end package body tb_impl_test_read_write_reader_pgk;

