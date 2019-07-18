# A

import requests
from aip import AipOcr

image = requests.get('https://res.pandateacher.com/python_classic.png').content

APP_ID = '16149264'
API_KEY = 'yxYg9r40uAs4fYvfcl8tqCYd'
SECRET__KEY = 'yWg3KMds2muFsWs7MBSSFcgMQl8Wng4s'

client = AipOcr(APP_ID,API_KEY,SECRET_KEY)
res = client.basicGeneral(image)

if 'words_result' in res.keys():
    for item in res['words_result']:
        print(item['words'].)
else:
    print(res)
