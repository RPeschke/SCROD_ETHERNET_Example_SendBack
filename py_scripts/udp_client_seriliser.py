import socket
import array
def ToEventNumber(Data,Index):
    ret_h = 0
    
    ret_h += (Data[Index])
    ret_h += 0x100*(Data[Index+1])
    ret_h += 0x10000*(Data[Index+2])
    ret_h += 0x1000000*(Data[Index+3])
    return ret_h

def ToEventNumber1(Data,Index):
    ret_h = 0
    d = data[Index]
    ret_h += 256*256*256*(Data[Index])
    ret_h += 256*256*(Data[Index+1])
    ret_l =0 
    ret_h += 256*(Data[Index+2])
    ret_h += (Data[Index+3])
    return ret_h

def ToEventNumber2(Data,Index):
    ret_h = ''
    
    ret_h += chr(Data[Index+3])
    ret_h += chr(Data[Index+2])
    ret_h += chr(Data[Index+1])
    ret_h += chr(Data[Index])

    return ret_h


def ArrayToHex(Data):
    for j in range(0,len(Data),4):
        #print(str(Data[j]),str(Data[j+1]),str(Data[j+2]),str(Data[j+3]))
        #print(EventToHex(data,j))
        print(hex(ToEventNumber(Data,j)))
        
        
def EventToHex(Data,Index):
    return hex(Data[Index+3]),hex(Data[Index+2]),hex(Data[Index+1]),hex(Data[Index])


def To_little_endien(InData):
    message = []
    for x in InData:
        message+=(x.to_bytes(4,'little'))

    str1=array.array('B', message).tobytes()

    return str1

import numpy as np
UDP_IP = "192.168.1.33"
UDP_PORT = 2001




print("UDP Target Address:", UDP_IP)
print("UDP Target Port:", UDP_PORT)

clientSock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

print("Sent message...")


fileName = "data.csv"
import csv
with open(fileName, newline='') as csvfile:
    numberOfRows = len(csvfile.readlines()) -1


str1=To_little_endien( [ numberOfRows ,numberOfRows ,numberOfRows ] )
#ArrayToHex(str1)
clientSock.sendto(str1, (UDP_IP, UDP_PORT))


with open(fileName, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    fieldNames = reader.fieldnames
    #print(fieldNames)
    for row in reader:
        message = list()
        message.append(2)
        for coll in fieldNames:
            message.append(int(row[coll]))
        
        message1 = To_little_endien(message)
        
        #ArrayToHex(message1 )
        
        clientSock.sendto(message1 , (UDP_IP, UDP_PORT))


print("receiving")

with open(fileName.split(".")[0]+"_out.csv","w",newline="") as f:
    f.write(",".join(fieldNames)+"\n")
    for _ in range(numberOfRows ):
        data, addr = clientSock.recvfrom(4096)


#        ArrayToHex(data)
        
        data_list = list()
        for j in range(0,len(data),4):
            data_list.append(str(ToEventNumber(data,j)))
        
        f.write(",".join(data_list)+"\n")

print("done\n")