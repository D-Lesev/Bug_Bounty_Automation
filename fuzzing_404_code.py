#!/usr/bin/python3

import argparse
import subprocess
from colorama import Fore, Back, Style


def init():

    banner = r"""
                 _______   _______    __________________  ___________________   ___  _______   ____       ____  __________  
                /  __   \ /  __   \  /______   _____   / /______   ______   /  /  /  ______/  /  _ \     / __ \    ______/  
               /  /_/   //  /__\  /        /  /    /  /        /  /     /  /__/  /  /___     /  / \ \   / / / /   /        
              /  __    //  _   __/        /  /    /  /        /  /     /  ___   /  ____/    /  /  | |  / / / /   /  _______ 
             /  /  /  //  / \  \         /  /    /  /        /  /     /  /  /  /  /        /  /  / /  / / / /   /  /____  /  
            /  /  /  //  /   \  \       /  /    /  /        /  /     /  /  /  /  /_____   /  /__/ /  / /_/ /   /_______/ /  
           /__/  /__//__/     \__\     /__/    /__/        /__/     /__/  /__/ _______/  /_______/   \____/ ___________ /  



    """

    print(Fore.RED,f"{banner}")




def get_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument("-f", "--file", help="Add the file with 404 Status code links", required=True, type=str)
    parser.add_argument("-r", "--rate", help="Rate Limiting", required=True, type=str)
    parser.add_argument("-o", "--output", help="File to save the output", required=False, type=str, default="fuzzing_resuls_404.txt")

    return parser.parse_args()


get_arguments()


def run_fuzzing(txt,rate_numb,output_file):

    result = []
    
    with open(txt, 'r') as f:
        content = f.readlines()

    count_urls = len(content)
    count = 0

    with open(output_file, "w") as out_file:

        for line in content:
            count += 1
            current_wordlist = ""
            wordlist = ""
            url = line.strip() + "/FUZZ"

            if "api" in url.lower():
                wordlist = "/usr/share/seclists/SecLists-master/Discovery/Web-Content/api/api-endpoints.txt"
                current_wordlist = "API"
            else:
                wordlist = "/usr/share/seclists/SecLists-master/Discovery/Web-Content/common.txt"
                current_wordlist = "COMMON"


            msg_1 = (f"\nChecking URL #{count} of total {count_urls}")
            print(Fore.WHITE,msg_1)
            out_file.write(msg_1)

            msg_2 = (f"\nRunning wordlist of {current_wordlist} for URL -> {line.strip()}\n")
            print(msg_2)
            out_file.write(msg_2)

            exec_command = ["ffuf", "-u", url, "-w", wordlist, "-c", "-rate", rate_numb, "-mc", "200", "-v", "0"]

            command = subprocess.Popen(exec_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            stdout,stderr = command.communicate()

            result.append(stdout.decode())
            check = stdout.decode()          
            
            msg_3 = (f"\n{check}")
            print(msg_3)
            out_file.write(msg_3)

            msg_4 = (45*'#')
            print(msg_4)
            out_file.write(msg_4)
            current_wordlist = ""
            


def main():

    args = get_arguments()

    text_file = args.file
    rate_limiting = args.rate
    output_file = args.output

    run_fuzzing(text_file,rate_limiting, output_file)

    print(f"\nResults saved to {output_file}")


init()
main()