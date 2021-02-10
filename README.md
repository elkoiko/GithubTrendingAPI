# Github Trending API

A simple API written in pure Swift that returns the trending repositories and developers on Github. It collects data by scraping the [Github trending page](https://github.com/trending).



## Installation

### Swift Package Manager

GithubTrendingAPI is available through the Swift Package Manager. To install it, you simply have to add the dependency to your  `Package.swift` file:

```swift
...
dependencies: [
    .package(url: "https://github.com/elkoiko/GithubTrendingAPI.git", from: "1.0.0"),
],
targets: [
    .target( name: "YourTarget", dependencies: ["GithubTrendingAPI"]),
]
... 
```

# How to use it

It's very simple ! You will need only one line to get what you want.

## Retrieve trending repositories or developers

```swift
let trendingRepositories: [Repository] = GithubTrendingAPI.getRepositories()
let trendingDevelopers: [Developer] = GithubTrendingAPI.getDevelopers()
```

## Filtering the results

You have the choice to filter either developers or repositories by programming language and/or date range.

```swift
let trendingSwiftRepos: [Repository] = GithubTrendingAPI.getRepositories(language: "Swift", dateRange: .weekly)
let trendingSwiftDevs: [Developer] = GithubTrendingAPI.getDevelopers(language: "Swift", dateRange: .monthly)
```

## Testing / Dependency injection

The GithubTrendingAPI structure conforms to the TrendingAPI protocol. This protocol is here to provide you a way to use dependency injection in order to test your code that uses the GithubTrendingAPI.

## Bonus

Since the GithubTrendingAPI does scrap the [Github trending page](https://github.com/trending), it generates the correct url to filter the data. Although you don't need to use it to get data, you have access to the method that generates the URL.

```swift
let url: URL = GithubTrendingAPI.makeURL(for: .developers, language: "Swift", dateRange: .daily)
print(url.absoluteString)
// Prints: https://github.com/trending/developers/Swift?since=daily
```

# Author

Thomas Couacault, [elkoiko](https://github.com/elkoiko).

# License

GithubTrendingAPI is under the MIT license. See the license file for more information.
