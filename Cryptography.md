# Cryptography {#cryptography}

**Cryptography** is the art and science of keeping information secure through the use of mathematical concepts and techniques.

Goals of Cryptography - P.A.I.N.



* **Privacy** (Confidentiality) keeps data secure from unauthorized parties
* **Authentication** is used to confirm the identities of the sender and receiver of data.
* **Integrity **ensures a message isn’t altered in transit
* **Non-Repudiation **prevents the original sender from denying they were the sender.

[Cryptography [Wikibooks - Comprehensive Resource]](https://en.wikibooks.org/wiki/Cryptography)

[Practical Cryptography [Online Book]](https://cryptobook.nakov.com/)

[KhanAcademy - Cryptography](https://www.khanacademy.org/computing/computer-science/cryptography)

[Transposition Cipher Solver](https://tholman.com/other/transposition/)

[Cryptanalysis of numerous classical ciphers](http://practicalcryptography.com/cryptanalysis/)

[“Security Level”](https://en.wikipedia.org/wiki/Security_level) is the strength of the [cryptographic primitive](https://en.wikipedia.org/wiki/Cryptographic_primitive) 

**Plaintext** Information in human-readable form.

**Ciphertext** Plaintext message that has been encrypted into an unreadable form

**Encryption** The process of converting plaintext to ciphertext.

**Decryption** The process of converting ciphertext to plaintext.

**Cipher** A method of performing encryption or decryption.

**Key** A parameter specifying how plaintext is converted to ciphertext and vice versa.

**Caesar Cipher **A type of cipher that shifts the letters in the alphabet by a fixed number.

**Enigma Cipher** A type of cipher used by Germany in World War II to encrypt messages.


## OpenSSL

[Heartbleed Vulnerability](https://heartbleed.com/)

openssl Initializes the OpenSSL program.

enc Stands for “encryption.”

-pbkdf2 Specifies the encryption key type.

-nosalt Specifies that salting will not be applied.

-aes-256-cbc Is the name of the cipher used

-k KEY Defines the encryption key (“KEY” is the key)

-iv INITIAL Defines the initialisation vector (IV) (“INITIAL” is the IV)

-P > key_iv.txt Prints the key and IV to “key_iv.txt”

<span style="text-decoration:underline;">Creating a key and IV</span>  \
openssl enc -pbkdf2 -nosalt -aes-256-cbc -k mypassword -P > key_and_IV.txt

<span style="text-decoration:underline;">Encrypting</span>

openssl enc -pbkdf2 -nosalt -aes-256-cbc -in plaintextmsg.txt -out encodedmsg.txt.enc -base64 -K KEY_HERE -iv IV_HERE

<span style="text-decoration:underline;">Decrypting</span>

openssl enc -pbkdf2 -nosalt -aes-256-cbc -in encodedmsg.txt.enc -d -base64 -K KEY_HERE -iv IV_HEREdf


## Asymmetric Encryption {#asymmetric-encryption}

[Symmetric vs Asymmetric Encryption](https://www.101computing.net/symmetric-vs-asymmetric-encryption/)

**RSA** is the asymmetric algorithm standard used around the world. It works by employing the complexity of factoring large numbers. [(Wikipedia)](https://en.wikipedia.org/wiki/RSA_(cryptosystem))



* [What is RSA Encryption (NordVPN)](https://nordvpn.com/blog/rsa-encryption/)
* [Miller-Rabin Primality Test](https://planetcalc.com/8995/) - checks whether or not a number is prime
* [RSA Problem](https://en.wikipedia.org/wiki/RSA_problem) - Cracking RSA with only the Public Key
    * [RSA Factoring Challenge](https://en.wikipedia.org/wiki/RSA_Factoring_Challenge)
    * [Integer Factorisation](https://en.wikipedia.org/wiki/Integer_factorization)

**Diffie-Hellman Key Exchange** is a mathematical method of securely exchanging cryptographic keys over a public channel [(Wikipedia)](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)



* [Diffie-Hellman Explainer (Youtube)](https://www.youtube.com/watch?v=NmM9HA2MQGI)


## Using GPG {#using-gpg}

[Quick and Easy GPG Cheetsheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)

gpg --gen-key Generate a new GPG key (requires name, email, comment & passphrase)

gpg --list-keys List Public GPG keys on the system

gpg --list-secret-keys List Secret GPG keys on the system

gpg --edit-key &lt;targetemail> Edit key with adduid, trust, deluid and save

gpg --delete-key &lt;UID or Public Key> Delete Public Key of UID (or Public Key listed)

gpg --delete-secret-key &lt;UID or Public Key> Delete Secret Key of UID (or Public Key listed)

gpg --import &lt;targetname>.gpg Import someone’s Public Key

gpg --output &lt;yourname>.gpg --export &lt;youremail> Export your Public Key

gpg --decrypt yourmsg.txt Decrypt yourmsg.txt sent by someone using your Public key

gpg --output secret.txt.enc --encrypt --recipient &lt;target> msg.txt  

Create encrypted file _secret.txt.enc_ for target using their Public key and _message.txt_

gpg --sign yourmsg.txt Sign a file with GPG for verification (creates file _yourmsg.txt.gpg_)

	--default-key specifies default key if you have multiple keys on the system

gpg --verify yourmsg.txt.gpg Verify the signature of the document

gpg --output yourmsg.txt --decrypt yourmsg.txt.gpg Decrypt signed document

gpg --clearsign yourmsg.txt Wrap file with ASCII-armored signature (no file modification)

gpg --output Signed.sig --detach-sig yourmsg.txt Create detached signature with signed file


## Hashing  {#hashing}

**Hashing** is a cryptographic method used to verify the integrity of data. It is also a way of storing password data without storing the passwords in plaintext.

[Illustrated Guide to Cryptographic Hashes](http://www.unixwiz.net/techtips/iguide-crypto-hashes.html) [[Excellent Resource]](http://www.unixwiz.net/techtips/iguide-crypto-hashes.html)

[Lifetimes of cryptographic hash functions](https://valerieaurora.org/hash.html)

[Wide variety of Hash Functions](https://learn.saylor.org/mod/book/view.php?id=36370&chapterid=20509)

[Merkle–Damgård construction](https://justcryptography.com/merkle-damgard-construction/) (Used in MD5, SHA-1 & SHA-2)

[Breaking Hash Algorithms [Book]](https://en.wikibooks.org/wiki/Cryptography/Breaking_Hash_Algorithms)



* [Hashing Tools](https://emn178.github.io/online-tools/index.html) 
* [Hash Toolkit](https://hashtoolkit.com/) 
    * Generate [MD5](https://hashtoolkit.com/generate-md5-hash/), [SHA1](https://hashtoolkit.com/generate-sha1-hash/), [SHA256](https://hashtoolkit.com/generate-sha256-hash/), [SHA384](https://hashtoolkit.com/generate-sha384-hash/), [SHA512](https://hashtoolkit.com/generate-sha512-hash/)
    * Decrypt [MD5](https://hashtoolkit.com/decrypt-md5-hash/), [SHA1](https://hashtoolkit.com/decrypt-sha1-hash/), [SHA256](https://hashtoolkit.com/decrypt-sha256-hash/), [SHA384](https://hashtoolkit.com/decrypt-sha384-hash/), [SHA512](https://hashtoolkit.com/decrypt-sha512-hash/) 

[Comparison of SHA Functions](https://en.wikipedia.org/wiki/SHA-3#Comparison_of_SHA_functions)



* [Secure Hashing Algorthims (SHA)](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms)
    * [SHA-1](http://en.wikipedia.org/wiki/SHA-1) is **[broken](https://www.secpod.com/blog/broken-sha-1-algorithm-a-twist-in-the-cryptography-world/)**. Based on MD5 and produces a hash digest of 160 bits (20 bytes)
    * [SHA2](https://en.wikipedia.org/wiki/SHA-2) is based on MD5 and includes SHA-224, SHA-256, SHA-384, SHA-512, SHA-512/224, SHA-512/256
    * [SHA3](https://en.wikipedia.org/wiki/SHA-3) is based on Keccak and includes SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE-128, and SHAKE-256
* MD5 - Broken
    * [Online MD5 Decryptor](https://md5decrypt.net/) (French)
* LM and NTLM
* RIPEMD-160
* BLAKE
    * Includes BLAKE, BLAKE2, and BLAKE3 

md5sum * > hashes.txt

md5sum -c hashes.txt


## Passwords



* [How Passwords Work](https://delinea.com/blog/how-do-passwords-work)
* [Using Ubuntu Keyring](https://itsfoss.com/ubuntu-keyring/)
* [OWASP - Password Storage Cheet Sheet [Excellent Resource]](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)


## Digital Forensics

**Forensic examiner** is a cybersecurity professional who captures and investigates digital evidence from computers, cell phones, and other devices containing digital data.



* Forensic examiners make a hash of a device when it is initially collected for investigation. This hash can be later used to verify that the digital data was not modified during the investigation.

**Steganography** is the cryptographic technique of placing hidden messages within files, images, or videos.


### Using Steghide

`steghide embed –ef alpha.txt –cf image.jpeg` embed alpha.txt into image.jpeg

`steghide extract –sf image.jpeg` extract embedded message from image.jpeg


## Cryptographic Attacks

**Statistical Attack** exploits weakness in cryptographic algorithms by attempting to determine if the “random” values produced are actually predictable. 



* **Frequency analysis** is a method for cracking substitution algorithms in a statistical attack.

**Brute Force Attack** involves attackers using many passwords or user and password combinations until one eventually works.

**Birthday Attack** exploits the probability that two separate plaintexts that use the same hash algorithm will produce the same ciphertext (aka **collision** and **hashing collision**)



* [What is the birthday paradox?](https://justcryptography.com/the-birthday-paradox/)
* [Merkle-Damgård construction to develop to design collision-resistant cryptographic hash functions](https://justcryptography.com/merkle-damgard-construction/)
* [Merkle–Damgård construction](https://en.wikipedia.org/wiki/Merkle%E2%80%93Damg%C3%A5rd_construction) [Wikipedia]

**Replay Attack** invovles an attacker intercepting an encrypted message and replaying it to the receiving party to get access. (eg. detecting a car’s remote locking & rebroadcasting it)

**Rainbow tables** are resources that contain precomputed hashes with the associated plaintext passwords. Mitigated by salting stored hashes.



* [Understanding Rainbow Table Attacks](https://www.geeksforgeeks.org/understanding-rainbow-table-attack/)
* [What are Salted Password Hashes?](https://www.okta.com/blog/2019/03/what-are-salted-passwords-and-password-hashing/) 
* [Rainbow Tables are still a threat](https://www.itprotoday.com/identity-management-and-access-control/why-rainbow-tables-are-still-threat) (when integrated with Mimikatz)
* [Five Most Popular Password Cracking Tools](https://delinea.com/blog/5-most-popular-password-cracking-tools-and-how-to-protect-your-enterprise)
