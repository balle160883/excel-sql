
import urllib.request
import json
import sys

url = "http://localhost:8001/tables"
print(f"Testing connection to {url}...")

try:
    with urllib.request.urlopen(url) as response:
        status = response.code
        data = response.read().decode()
        print(f"Status: {status}")
        print(f"Response: {data}")
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
