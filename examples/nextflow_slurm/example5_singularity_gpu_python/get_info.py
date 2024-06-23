import json
import math
import os
import platform
import socket
import sys

import click
import cpuinfo
import GPUtil
import psutil
from loguru import logger

log_to_print = " Info> Using python version: {}\n Executable: {}".format(
    sys.version, sys.executable
)


logger.info("Hello world Yolo SLURMY")
logger.info("{}".format(log_to_print))





def get_cpu_info():
    info = cpuinfo.get_cpu_info()
    cpu_info = {}
    cpu_info['cpu_count'] = psutil.cpu_count(logical=True)
    cpu_info['cpu_name'] = info['brand_raw']
    cpu_info['architecture'] = platform.architecture()[0]
    cpu_info['bits'] = platform.architecture()[0]
    cpu_info['vendor_id'] = info['vendor_id_raw']
    cpu_info['model_name'] = info['brand_raw']
    cpu_info['flags'] = info['flags']
    return cpu_info

def get_memory_info():
    memory_info = {}
    memory_info['total_memory'] = round(psutil.virtual_memory().total /  1024 / 1024, 2)
    memory_info['available_memory'] = round(psutil.virtual_memory().available / 1024 / 1024, 2)
    return memory_info

def get_gpu_info():
    try:
        gpu_info = []
        gpus = GPUtil.getGPUs()
        for gpu in gpus:
            gpu_info.append({
                'gpu_name': gpu.name,
                'gpu_memory_total': gpu.memoryTotal,
                'gpu_memory_used': gpu.memoryUsed
            })
        return gpu_info
    except Exception as e:
        logger.warning(" Error> there are no GPUs in here, {}".format(e))
        return None

def get_system_info():
    system_info = {
        'OS': platform.system(),
        'OS Version': platform.version(),
        'Kernel': platform.release(),
        'Uptime': round(psutil.boot_time()),
    }
    return system_info


def get_os_release_info():
    os_release_info = {}
    try:
        with open('/etc/os-release', 'r') as f:
            for line in f:
                if line.strip() and not line.startswith('#'):
                    key, value = line.strip().split('=', 1)
                    os_release_info[key] = value.replace('"', '')
    except FileNotFoundError:
        pass
    return os_release_info


def get_general_info():
    system_info = {}
    system_info['Hostname'] = socket.gethostname()
    system_info['Username'] = os.getenv('USER')
    system_info['Current Directory'] = os.getcwd()
    system_info['Home Directory'] = os.path.expanduser('~')
    system_info['Python Version'] = f"{os.sys.version_info.major}.{os.sys.version_info.minor}.{os.sys.version_info.micro}"
    return system_info



@click.command()
@click.option("--output", help="json output", required=True)
def start_program(output):
    
    try:
        cpu_info = get_cpu_info()
        memory_info = get_memory_info()
        gpu_info = get_gpu_info()
        system_info = get_system_info()
        os_info = get_os_release_info()
        general = get_general_info()

        system_info = {
            "General": general,
            'OS': os_info,
            'system': system_info,
            'cpu': cpu_info,
            'memory': memory_info,
            'gpu': gpu_info
            
        }

        with open(output, 'w') as f:
            json.dump(system_info, f, indent=4)
            
        exit(0) #-- ! Make sure there is an exit code
    except Exception as e:
        logger.error(" Error> {}".format(e))
        exit(1) #-- ! Make sure there is an exit code

if __name__ == "__main__":
    start_program()
