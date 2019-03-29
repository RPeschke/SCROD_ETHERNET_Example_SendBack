import socket
#48128
UDP_PORT = 2001    #34588-91 occupied

serverSock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
serverSock.bind(('',UDP_PORT))      #uses local ip

while True:
    data, addr = serverSock.recvfrom(4096)      #1024 bytes
    print ("Received message:", data)