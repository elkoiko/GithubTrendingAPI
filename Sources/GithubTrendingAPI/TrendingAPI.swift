//
//  TrendingAPI.swift
//  
//
//  Created by Thomas Couacault on 10/02/2021.
//

import Foundation

protocol TrendingAPI {
  static func makeURL(for item: TrendingItems, language: String, dateRange: DateRange?) -> URL
  static func getRepositories(language: String, dateRange: DateRange?) -> [Repository]
  static func getDevelopers(language: String, dateRange: DateRange?) -> [Developer]
}
