
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package tb_impl_test_read_write_writer_pgk is

type tb_impl_test_read_write_writer_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 
rxDataReady : sl; 
tXData : slv(31 downto 0); 
txDataValid : sl; 
txDataLast : sl; 
txDataReady : sl; 

end record tb_impl_test_read_write_writer_rec; 

constant  tb_impl_test_read_write_writer_rec_null: tb_impl_test_read_write_writer_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null,
rxDataReady => sl_null,
tXData => (others => '0'),
txDataValid => sl_null,
txDataLast => sl_null,
txDataReady => sl_null);

end tb_impl_test_read_write_writer_pgk;


package body tb_impl_test_read_write_writer_pgk is
end package body tb_impl_test_read_write_writer_pgk;

