
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
  use work.CSV_UtilityPkg.all;  
  
  



package eth_axi_command_receiver_r_e_pgk is

type eth_axi_command_receiver_r_e_rec is record 
rxData : slv(31 downto 0); 
rxDataValid : sl; 
rxDataLast : sl; 
txDataReady : sl; 

end record eth_axi_command_receiver_r_e_rec; 

constant  eth_axi_command_receiver_r_e_rec_null: eth_axi_command_receiver_r_e_rec := (rxData => (others => '0'),
rxDataValid => sl_null,
rxDataLast => sl_null,
txDataReady => sl_null);

end eth_axi_command_receiver_r_e_pgk;


package body eth_axi_command_receiver_r_e_pgk is
end package body eth_axi_command_receiver_r_e_pgk;

