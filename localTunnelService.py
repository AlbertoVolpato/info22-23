import subprocess
import time
import threading

def startLocalTunnel(port, subdomain):
    thread = threading.Thread(target=mainThreadLT, args=(port, subdomain), daemon=True)
    thread.start()


def mainThreadLT(port, subdomain):
    print("STARTING LOCAL TUNNEL")
    time.sleep(4)
    while True:
        subprocess.call(f'lt --port {port} --subdomain {subdomain}', shell=True)
        print("LOCAL TUNNEL ERROR - restart in 8 seconds")
        time.sleep(8)