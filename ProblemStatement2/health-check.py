#!/usr/bin/env python3

import requests

try:
    r = requests.head("http://k8s.skinatro.tech", timeout=5)
    if 200 <= r.status_code < 400:
        print(f"Up! Status: {r.status_code}")
    else:
        print(f"Down! Status: {r.status_code}")
except requests.RequestException as e:
    print(f"Down! Error: {e}")
