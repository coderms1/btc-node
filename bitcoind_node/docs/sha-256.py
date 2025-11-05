# Simple cryptographic demo - takes some text ("block header"), runs it through SHA-256 twice,
# and prints the resulting hash — just like Bitcoin does when securing blocks.

import hashlib

data = "block header"
byte_d = data.encode()
hash_x1 = hashlib.sha256(byte_d).digest()
hash_x2 = hashlib.sha256(hash_x1).hexdigest()

print(hash_x2)