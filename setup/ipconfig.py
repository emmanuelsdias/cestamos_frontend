import subprocess
import platform

if __name__ == "__main__":
  system = platform.system()
  if system == "Windows":
    res = subprocess.check_output("ipconfig", encoding='oem')
    lines = res.split('\n')
    filtered_lines = [line for line in lines if 'Endereço IPv4' in line]
    special_line = filtered_lines[-1]
    address = special_line.split(':')[-1].strip()
    
  elif system == "Linux":
    cmd = "hostname -I"
    res = subprocess.check_output(cmd.split(' '), encoding='utf-8')
    address = res.split(' ')[0]
    
    
  code = """
class BaseUrls {{
static const String baseBackEndUrl = "http://{0}:8000";
}}
  """.format(address)
  dart_url_file = open("../cestamos/lib/helpers/http-requests/base_urls.dart", "w")
  dart_url_file.write(code)
  dart_url_file.close()