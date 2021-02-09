//
//  GithubTrendingAPI.swift
//  
//
//  Created by Thomas Couacault on 09/02/2021.
//

import Foundation

/// makeURL returns a URL matching the given criterias.
///
/// - Parameters:
///     - for: The trending item you want to get the URL for.
///     - language: The name of the language used to filter the results.
///     - dateRange: The date range used to filter the results.
public func makeURL(for item: TrendingItems, language: String = "", dateRange: DateRange? = nil) -> URL {
    let githubURL: URL = URL(string: "https://github.com")!
    var url: String
    
    switch item {
    case .repositories:
        url = "/trending"
    case .developers:
        url = "/trending/developers"
    }
    if !language.isEmpty {
        url += "/\(language)"
    }
    if let range = dateRange {
        url += "?since=\(range.rawValue)"
    }    
    return URL(string: url, relativeTo: githubURL)!
}

/// getRepositories returns all the available trending repositories.
///
/// - Parameters:
///     - language: The name of the language used to filter the repositories.
///     - dateRange: The date range used to filter the repositories.
public func getRepositories(language: String = "", dateRange: DateRange? = nil) -> [Repository] {
    // TODO: Implement getRepositories

    // let url: URL = makeURL(for: .repository, language: language, dateRange: dateRange)
    // Retrieve the string content of the web page with the URL
    // fetch all repositories
    return [Repository]()
}

/// getDevelopers returns all the available trending developers.
///
/// - Parameters:
///     - language: The name of the language used to filter the developers.
///     - dateRange: The date range used to filter the developers.
public func getDevelopers(language: String = "", dateRange: DateRange? = nil) -> [Developer] {
    // TODO: Implement getDevelopers

    // let url: URL = makeURL(for: .developer, language: language, dateRange: dateRange)
    // Retrieve the string content of the web page with the URL
    // fetch all developers
    return [Developer]()
}


