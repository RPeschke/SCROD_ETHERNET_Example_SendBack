library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.eth_axi_command_receiver_r_e_pgk.all;
use work.eth_axi_command_receiver_w_pgk.all;

entity eth_axi_command_receiver is 
port (
clk : in std_logic ;
txData : out std_logic_vector(31 downto 0) ;
txDataValid : out std_logic ;
txDataLast : out std_logic ;
txDataReady : in std_logic ;
rxData : in std_logic_vector(31 downto 0) ;
rxDataValid : in std_logic ;
rxDataLast : in std_logic ;
rxDataReady : out std_logic 
);
end entity;

architecture Behavioral of eth_axi_command_receiver is 

signal Eth_readr_data : eth_axi_command_receiver_r_e_rec  := eth_axi_command_receiver_r_e_rec_null  ;
signal Eth_readr_valid : std_logic  := '0'  ;
signal eth_writer_data : eth_axi_command_receiver_w_rec  := eth_axi_command_receiver_w_rec_null  ;
signal eth_writer_txData : std_logic_vector(31 downto 0)  := (others=>'0')  ;
signal eth_writer_txDataValid : std_logic  := '0'  ;
signal eth_writer_txDataLast : std_logic  := '0'  ;
signal eth_writer_txDataReady : std_logic  := '0'  ;
begin


  Eth_readr :entity  work.eth_axi_command_receiver_r  
       port map(
         rxData => rxData,
         rxDataValid=> rxDataValid,
         rxDataLast => rxDataLast,
         rxDataReady=> rxDataReady,
         clk => clk,
         data_out => Eth_readr_data,
         valid_out => Eth_readr_valid
       );



  eth_writer :entity  work.eth_axi_command_receiver_w  
       port map(
         txData => eth_writer_txData,
         txDataValid=> eth_writer_txDataValid,
         txDataLast => eth_writer_txDataLast,
         txDataReady=> eth_writer_txDataReady,
         clk => clk,
         data_in => eth_writer_data,
         valid_in => Eth_readr_valid
       );


       txDataValid <= eth_writer_txDataValid;
    

       txData <= eth_writer_txData;
    

       txDataLast <= eth_writer_txDataLast;
    

       eth_writer_txDataReady <= txDataReady;
    

       eth_writer_data.rxData <= Eth_readr_data.rxData;
    

       eth_writer_data.rxDataLast <= Eth_readr_data.rxDataLast;
    

       eth_writer_data.rxDataValid <= Eth_readr_data.rxDataValid;
    

       eth_writer_data.txDataReady <= Eth_readr_data.txDataReady;
    

       dut : entity work.Axi_CommandInterpreter port map ( 
         usrClk => clk,
         rxData => eth_writer_data.rxData,
         rxDataLast => eth_writer_data.rxDataLast,
         rxDataReady => eth_writer_data.rxDataReady,
         rxDataValid => eth_writer_data.rxDataValid,
         txData => eth_writer_data.txData,
         txDataLast => eth_writer_data.txDataLast,
         txDataReady => eth_writer_data.txDataReady,
         txDataValid => eth_writer_data.txDataValid
       );
     
end Behavioral;

