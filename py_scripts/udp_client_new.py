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

import numpy as np
UDP_IP = "192.168.1.33"
UDP_PORT = 2001
WORD_HEADER_C    =  0x00BE11E2
WORD_COMMAND_C   =  0x646F6974
wordScrodRevC    =  0x00000000 
Word_command_ID  =  0x00000012
WORD_PING_C      =  0x70696E67
WORD_READ_C      =  0x72656164
WORD_WRITE_C     =  0x72697465
WORD_ACK_C       =  0x6F6B6179
WORD_ERR_C       =  0x7768613F

proto_message = [ 0x00000017,0x00000017,0x00000017,0x00000017,0x00000017] #simple read
checksum = sum(proto_message[4:7])
proto_message.append(checksum)
s = str(sum(proto_message))

s= int(np.uint32(s))
proto_message.append(s)
#proto_message.append(WORD_HEADER_C)
proto_message.append(WORD_HEADER_C)

message = []
for x in proto_message:
    message+=(x.to_bytes(4,'little'))

ArrayToHex(message)

print("UDP Target Address:", UDP_IP)
print("UDP Target Port:", UDP_PORT)

clientSock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
str1=array.array('B', message).tostring()

print("Sent message...")
ArrayToHex(str1)
clientSock.sendto(str1, (UDP_IP, UDP_PORT))


data, addr = clientSock.recvfrom(4096)

print("\n\nrecv message...")
ArrayToHex(data)