# README 🔥

This architecture is split in differents layers/concepts 🏋️‍♀️: 
* `Context`
* `Coordinator`
* `ViewControllers`
* `ViewModels`
* `Repositories`
* `Network`
* `Tests`

## Intro

Since I've bin hired in my team I learned a lot of new concepts on clean architecture. This project is representing at this time my guideline for every workdays.

## Architecture

### Context

Context is the main object injected everywhere in the app. It has the responsability to provide dependencies injected first in the `AppDelegate`. Every new dependency should be injected through it 🙏.


#### Coordinator:

Coordinator is a separate entity responsible for navigation in application flows. With the help of the `Screens`, it creates, presents and dismisses `UIViewControllers`, by keeping them separate and independent.
Coordinator can, create and run child coordinators too.

Since a coordinator is responsible of the entire flow of a specific flow (or stack), do not create a coordinator per viewController ☝️.

The only way of using a coordinator, is to instanciate it (by injecting in it if necessary some specific ojetcs) and call the `start()` method, and **that's all**. The entire logic will be encapsulated by delegation for the rest of the navigation.

#### Network:

As indicated by it's name, this layer provide differents tools to make request in an efficient way. First you have to create a client `HTTPClient` and an `URLRequest` or an `HTTPRequest` (dependeing on the needs, this part should be improved). At this time `HTTPRequest` are used to fetch Json data and parsing their response in `Codable` objects. For much bigger data like audio or images, you'll need to use basical `URLRequest`. This logic is handled by the `URLSessionEngine`.

Since a request could be cancelled by many different operation (dequeuing a cell, dismissing a view etc..), each request should be sent with a token provided by the caller. If the caller is deinit, so the token too, and finally the request is cancelled ⚡️.

The most usefull things in this layer is the `Promise<T>` tool ; Which will helps you to make request, waiting for them to response and handle them as easy as you could imagine. The result will be directly provided by the next layer: `Repository`.

#### Repository:

This layer is responsible of calling the `Network` layer, and managing the data from it, in order to present it to the viewModel.

You can see that on the top of each repository, a protocol `RepositoryType` will allow us to test everything by dependency injection 💪.

#### ViewModel:

The `ViewModel` encapsulates the whole logic which doesn't have to be in the ViewController. It's divided in two parts :

* **Inputs**: Every event from the viewController needs to be implemented in the viewModel, since it's listening for them. The main event which always need to be added is `viewDidLoad()`.
* **Outputs**: After `viewDidLoad()`, the viewController is listening for some changes from the `viewModel`. For this, the `viewModel` needs to provide reactive var for each data/state needed. The main rule is to keep separate the UI logic between viewModel and viewController, so keep in mind that a viewModel can only `import Foundation` -> reactive var con't provide data from `UIKit` like `UIImage` for example ☝️.

If your viewModel needs a `Repository`, so you'll need to inject a `RepositoryType`, in order to mock it more easily in the tests 🏋️‍♀️

#### ViewController:

The last layer and not the less important 🙇‍♂️. But as it is mentioned in it's name, a `ViewController` only exists for **control**. So, if you want to test it, you'll only provide UI test, since the logic is extracted in the corresponding `ViewModel`. I recomand to add a custom snapshot to test it correctly. (Not provided in this project).


#### Tests

Please make sure you have an internet connection, since some of them needs to make direct requests, this parts should be for sure splited in a better way later (like launching network test only if the connection is available etc..).

Press `cmd+u` and let the magic green life be.

Thank you for you time to reading this, I hope that you'll have as pleasure as me to read it and understand the different parts. 
