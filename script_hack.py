from request import requests

url = "http://127.0.0.1:5000/users/1"

data = {
    "bits": 99999999,
    "xp": 9999999
}

response = requests.put(
    url,
    json=data
)

print(response.json())