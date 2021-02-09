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
public func makeURL(for item: TrendingItem, language: String = "", dateRange: DateRange?) -> URL {
        // TODO: Implement makeURL
    return URL(string: "")!
}

/// getRepositories returns all the available trending repositories.
///
/// - Parameters:
///     - language: The name of the language used to filter the repositories.
///     - dateRange: The date range used to filter the repositories.
public func getRepositories(language: String = "", dateRange: DateRange?) -> [Repository] {
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
public func getDevelopers(language: String = "", dateRange: DateRange?) -> [Developer] {
    // TODO: Implement getDevelopers

    // let url: URL = makeURL(for: .repository, language: language, dateRange: dateRange)
    // Retrieve the string content of the web page with the URL
    // fetch all developers
    return [Developer]()
}


