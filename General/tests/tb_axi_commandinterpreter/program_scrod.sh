echo "prgramming SCROD with $1" 

scp $1 lab_xilinx:/home/ise/Desktop/new_bitfiles/

ssh lab_xilinx "mv /home/ise/Desktop/new_bitfiles/$1 /home/ise/Desktop/new_bitfiles/dummy.bit"
ssh lab_xilinx "impact -batch dummy.cmd"