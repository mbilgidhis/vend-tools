# Vend Tools
This apk helps you to get `Price Book` on every `sku`, since it's difficult for now to search item `Price Book` from VendHQ dashboard.

This apk will never save/log any information regarding store information you have. It uses SqlLite to save `personal token` on your device local storage.

## Getting Started

Before you can use this apk, you need to get `personal token` from VendHQ. Please read [this link](https://docs.vendhq.com/reference/introduction/authorization#personal-tokens) to get `personal token`.

Add new store from main page, which requires:
* Store Name (required), but you can fill any name.
* Personal Token (required), it's personal token you got from link above.
* URI (required), it's your store subdomain. If your store has address https://blabla.vendhq.com/, you need only to fill this field with only `blabla`.

## Limitations
This apk will never ever be updated to `create` or `update` any data from VendHQ. It will just provide tools to help user which VendHQ doesn't provide.

## Build on iOS
I don't have Apple devices, so I can't build it for Apple devices.