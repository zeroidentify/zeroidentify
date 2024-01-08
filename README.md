# ZeroIDentify https://zeroidentify.com

## Abstract
ZeroIDentify is an identity service designed for the web. The core principle of ZeroIDentify is to ensure no personal data is disclosed during the process of signing up for any website or online service. The emphasis is on safeguarding end-users' privacy and confidentiality.

## Problem Statement
 ### UserSide Problem
 Traditionally, signing up for a service online involves providing personal details. For example, google identify service requires you to provide an email address, even if you are trying to sign in to an untrusted site you are about to visit first.
 This poses risks as such information can be mishandled, sold, or accessed by malicious entities. ZeroIDentify promises to allow sign-ups without the disclosure of any personal data.
 ### WebSite Problem
 Digital service providers face the risk of cyber-attacks, which might involve hackers creating multiple fake accounts or using bots for data scraping. ZeroIDentify provides a mechanism (akin to bitcoin mining) that requires computational effort, deterring such attacks.
## Solution
 ### How Does ZeroIDentify Work?
  ZeroIDentify employs a unique cryptographic methodology that operates with a root-private key and derived private keys to authenticate users while maintaining their anonymity.
  #### The Root-private Key
   Every user will create a random root-private key. This is the primary key that underpins their online identity and forms the basis for creating derived private keys. Users will only need to remember this one root-private key.
  #### Generation of Derived Private Keys
   Whenever a user signs up for a new service, they generate a derived private key using the root-private key and a special rule described later. Importantly, the server they're signing up for cannot reverse-calculate to find the root-private key or derived private key. In essence, no personal information is shared during the sign-up process.
## Technical Architecture
  ### Process of Creating Derived Private/Public Key
   Here's the protocol for generating derived keys:
   ```
    1. User has private/public root key pair (r, R) where R = r·G.
    2. Server has a domain name like domain.com
    for ( i = 0; i++; ){
        User can compute a derived private key d using the ECDH: d = H(r+H(i)).
        User can compute a temporary derived public key D = dG
        If the first two letters of the string D match the first two letters of domain.com, D is the derived public key for the User to sign in the site for Server
    }
   ```
## Build & Installation
 \# git clone https://github.com/zeroidentify/zeroidentify.git
 
 \# cd zeroidentify/server/seller
 
 \# ./demo_run.sh 443
 
 If your server IP address is 192.168.10.1, please acess https://192.168.10.1/sample.html
 If small window appears, the sample runs successfully.
## Demo Video

## Challenges
 I try to implement to use crypto currency wallet for the root private key, but I did not have time to implement. I will try to implement.
