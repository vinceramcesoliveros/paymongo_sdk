# paymongo_sdk
 
![PayMongo](https://raw.githubusercontent.com/paymongo/phlogos/master/logos/paymongo/paymongo.svg)
<center><h1>A dart implementation of PayMongo Client SDK.<h1></center>

## Flutter package for paymongo

The flutter package for paymongo will be in separate package. This is to separate
what endpoints to use in the frontend or backend APIs.

**Release date: TBD**. I'm not quite sure if there is a timeline for this. But if there
are problems facing from our end, we'll fix it immediately.

## Installation

There are two instances of PayMongo SDK.

### Public Key
Use for e-Wallet payment and/or obtaining payment logs from the PayMongo Dashboard.

### Secret Key
Use for creating payment in paymongo


### Create Account
you can register your account here https://dashboard.paymongo.com/login.

### API Keys
Go to Developers and locate the _Public Key_ and _Secret Key_. 
copy the key and use it in your project.

## Usage

full [**example**](./example/lib/main.dart) project.

```dart
/// for dart standalone project usage
import 'package:paymongo_sdk/paymongo_sdk.dart'

void main() async {
    /// apiKey can be either public key or secret key.
    /// but do not use secret key in your front-end.
    final sdk = PayMongoSDK(apiKey);

    final data = Source(
    type: 'gcash',
    amount: amount,
    currency: 'PHP',
    redirect: const Redirect(
        success: "https://google.com/success",
        failed: "https://google.com/failed",
    ),
    billing: billing,
    );

    final result = await sdk.createSource(data)
}

```

