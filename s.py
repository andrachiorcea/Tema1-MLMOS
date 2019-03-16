import subprocess
import os

def get_value(string):
    return string.split("=")[1]

def main():
    my_file = "./config1.txt"
    if os.path.isfile(my_file):
        with open(my_file) as f:
            configs = f.readlines()
            configs = [x.strip() for x in configs]
            hostname = get_value(configs[0])
            interface = get_value(configs[1])
            memory = get_value(configs[2])
            cpu = get_value(configs[3])
            print ("---Installing git---")
            subprocess.call('yum -y install git', shell = True)
            print ("---Testing installation---")
            subprocess.call('git --version', shell = True)
            print ("---Delete repo if exists---")
            if os.path.exists(hostname):
                subprocess.call('rm -rf ' + hostname, shell = True)
                subprocess.call('mkdir ' + hostname, shell=True)
            print ("---Cloning git repo---")
            subprocess.call('git clone https://github.com/andrachiorcea/Tema1-MLMOS.git', shell=True)
            os.chdir("Tema1-MLMOS")
            print ("---Call boostrap.sh")
            subprocess.call('chmod +x bootstrap.sh', shell=True)
            logger = open('/var/log/system-bootstrap.log', "w+")
            subprocess.call('./bootstrap.sh', shell=True, stderr=logger, stdout=logger)
    else:
        print ("Config file does not exist")

main()



