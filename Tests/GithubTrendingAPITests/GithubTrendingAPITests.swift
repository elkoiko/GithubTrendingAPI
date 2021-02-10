//
//  GithubTrendingAPITests.swift
//  
//
//  Created by Thomas Couacault on 09/02/2021.
//

import XCTest
import GithubTrendingAPI

final class GithubTrendingAPITests: XCTestCase {

    // MARK: makeURL

    func testMakeURL_Repositories() {
        let githubURL: URL = URL(string: "https://github.com")!
        
        // All 
        XCTAssertEqual(URL(string: "/trending", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .repositories))
        
        // Per language
        XCTAssertEqual(URL(string: "/trending/Swift", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .repositories, language: "Swift"))

        // Per date
        XCTAssertEqual(URL(string: "/trending?since=weekly", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .repositories, dateRange: .weekly))

        // Per date and language
        XCTAssertEqual(URL(string: "/trending/Swift?since=daily", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .repositories, language: "Swift", dateRange: .daily))
    }

    func testMakeURL_Developers() {
        let githubURL: URL = URL(string: "https://github.com")!
        
        // All
        XCTAssertEqual(URL(string: "/trending/developers", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .developers))
        
        // Per language
        XCTAssertEqual(URL(string: "/trending/developers/Swift", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .developers, language: "Swift"))

        // Per date
        XCTAssertEqual(URL(string: "/trending/developers?since=monthly", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .developers, dateRange: .monthly))

        // Per date and language
        XCTAssertEqual(URL(string: "/trending/developers/Swift?since=daily", relativeTo: githubURL), GithubTrendingAPI.makeURL(for: .developers, language: "Swift", dateRange: .daily))
    }
    
    static var allTests = [
        ("testMakeURL_Repositories", testMakeURL_Repositories),
        ("testMakeURL_Developers", testMakeURL_Developers),
    ]
}
