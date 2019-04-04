
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package eth_axi_command_receiver_w_pgk is

type eth_axi_command_receiver_w_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 
rxDataReady : sl; 
txData : slv(31 downto 0); 
txDataValid : sl; 
txDataLast : sl; 
txDataReady : sl; 

end record eth_axi_command_receiver_w_rec; 

constant  eth_axi_command_receiver_w_rec_null: eth_axi_command_receiver_w_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null,
rxDataReady => sl_null,
txData => (others => '0'),
txDataValid => sl_null,
txDataLast => sl_null,
txDataReady => sl_null);

end eth_axi_command_receiver_w_pgk;


package body eth_axi_command_receiver_w_pgk is
end package body eth_axi_command_receiver_w_pgk;

