
echo "run $1"

scp  $1    labpc:/home/belle2/Documents/github/Emily/

ssh labpc "source ~/.bashrc && cd /home/belle2/Documents/github/Emily/ && /home/belle2/anaconda3/bin/python udp_client_serializer_tb_axi_comand__interp.py $1"



scp labpc:/home/belle2/Documents/github/Emily/$1* .