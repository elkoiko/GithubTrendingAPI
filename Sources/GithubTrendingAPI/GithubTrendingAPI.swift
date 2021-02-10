//
//  GithubTrendingAPI.swift
//  
//
//  Created by Thomas Couacault on 09/02/2021.
//

import Foundation

public struct GithubTrendingAPI: TrendingAPI {

  /// makeURL returns a URL matching the given criterias.
  ///
  /// - Parameters:
  ///     - for: The trending item you want to get the URL for.
  ///     - language: The name of the language used to filter the results.
  ///     - dateRange: The date range used to filter the results.
  public static func makeURL(for item: TrendingItems, language: String = "", dateRange: DateRange? = nil) -> URL {
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

  /// getRepositories returns all the available trending repositories or an empty array when nothing available.
  ///
  /// - Parameters:
  ///     - language: The name of the language used to filter the repositories.
  ///     - dateRange: The date range used to filter the repositories.
  public static func getRepositories(language: String = "", dateRange: DateRange? = nil) -> [Repository] {
    var pageContent: String?
    var repositories: [Repository] = [Repository]()
    let trendingURL: URL = makeURL(for: .repositories, language: language, dateRange: dateRange)
    
    pageContent = try? String(contentsOf: trendingURL)
    if let content = pageContent {
      repositories = TrendsFetcher.fetchRepositories(content: content)
    }
    return repositories
  }

  /// getDevelopers returns all the available trending developers or an empty array when nothing available.
  ///
  /// - Parameters:
  ///     - language: The name of the language used to filter the developers.
  ///     - dateRange: The date range used to filter the developers.
  public static func getDevelopers(language: String = "", dateRange: DateRange? = nil) -> [Developer] {
    var pageContent: String?
    var developers: [Developer] = [Developer]()
    let trendingURL: URL = makeURL(for: .developers, language: language, dateRange: dateRange)
    
    pageContent = try? String(contentsOf: trendingURL)
    if let content = pageContent {
      developers = TrendsFetcher.fetchDevelopers(content: content)
    }
    return developers
  }

}

