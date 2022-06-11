[1.6.0]
- Added **Links** API
- Fix lints
- update sdk version

[1.5.1] Fix `enums` affecting flutter projects
- use describeEnum as extension rather than a function
- fix refunds api instance

[1.5.0] Refunds API
- Added Refunds API(experimental)
- Added `fromTimeStamp` for createdAt and updatedAt properties
- 
[1.4.0] ADDED WEBHOOKS API
- initialize example project for web
- added webhooks API
- update dependencies

[1.3.3] Update GET request for all payments
- fix `listAll` method from Payment API.
- Added Payments Page Example
- Added `onSerializeCallback` to return specific data of a json.
- Added return type for Payment list.
[1.3.2] Update JSON serialization for payment
- Remove default DEVELOPER PAYMONGO KEY
- Fix `Payment` JSON Serialization
- Fix Example for 3D Security listener

[1.3.1] Update Pub score
- Remove `dart:io` import
- update version
[1.3.0] Paymaya Payment Method, BUG FIXES
- Fix Paymaya Payment Method option
- Fix example project running with paymaya
- Fix iframes for card payment that requires 3DS authentication(BETA)
## [1.1.1] Update Dependencies & Add Documentation
- Added docs for Payment Intent Attach
- Update http dependency
- Update README for PayMaya implementation timeline
- Update Headline logo
## [1.1.0] Beta version
- Allow credit/debit payment
> Note: You should create a payment method id so that you can reuse it for every payment intent.
> For any 3DS authentication be sure to query the payment intent before you proceed to the next line.
## [1.0.3]
- Update Dependencies
- Added Payment Intent API


## [1.0.1]
- added documentation for `Source`
