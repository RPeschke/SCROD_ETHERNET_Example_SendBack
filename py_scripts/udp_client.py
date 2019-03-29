import socket
import array
def ToEventNumber(Data,Index):
    ret_h = 0
    
    ret_h += (data[Index])
    ret_h += 255*(data[Index+1])
    ret_l =0 
    ret_h += 255*255*(data[Index+2])
    ret_h += 255*255*255*(data[Index+3])
    return ret_h

def ToEventNumber1(Data,Index):
    ret_h = 0
    d = data[Index]
    ret_h += 255*255*255*(data[Index])
    ret_h += 255*255*(data[Index+1])
    ret_l =0 
    ret_h += 255*(data[Index+2])
    ret_h += (data[Index+3])
    return ret_h

def ToEventNumber2(Data,Index):
    ret_h = ''
    
    ret_h += chr(data[Index+3])
    ret_h += chr(data[Index+2])
    ret_h += chr(data[Index+1])
    ret_h += chr(data[Index])

    return ret_h

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


proto_message = [WORD_HEADER_C, 0x00000005,WORD_COMMAND_C,wordScrodRevC,Word_command_ID, WORD_PING_C]      #original
#proto_message = [WORD_PING_C, Word_command_ID, wordScrodRevC, WORD_COMMAND_C, 0x00000005, WORD_HEADER_C]    #flip, does not work in python 3
proto_message.append(sum(proto_message))
#MESSAGE = bytes([WORD_HEADER_C, 0x00000004,WORD_COMMAND_C,wordScrodRevC,Word_command_ID, WORD_PING_C, 0x70696E67, 0x00000000])

message = []
for x in proto_message:
    message+=(x.to_bytes(4,'little'))


WBig= WORD_ERR_C.to_bytes(4,'big')

print("UDP Target Address:", UDP_IP)
print("UDP Target Port:", UDP_PORT)
print("Message:", message)

clientSock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
str1=array.array('B', message).tostring()

clientSock.sendto(str1, (UDP_IP, UDP_PORT))
print("Sent message...")

data, addr = clientSock.recvfrom(4096)      #1024 bytes
for j in range(0,len(data),4):
    print(ToEventNumber(data,j)),

print(addr)