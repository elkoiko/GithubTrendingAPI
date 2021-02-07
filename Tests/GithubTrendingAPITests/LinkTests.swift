//
//  LinkTests.swift
//  
//
//  Created by Thomas Couacault on 07/02/2021.
//

import XCTest
@testable import GithubTrendingAPI

final class LinkTests: XCTestCase {
    func testLinkDescription_ValidURL() {
        var expected, actual: String
        let link: Link = Link(url: URL(string: "https://example.com"), text: "Example website")
        
        expected = "[Example website](https://example.com)"
        actual = link.description
        
        XCTAssertEqual(expected, actual)
    }

    func testLinkDescription_InvalidURL() {
        var expected, actual: String
        let link: Link = Link(url: nil, text: "Example website")
        
        expected = "[Example website]()"
        actual = link.description
        
        XCTAssertEqual(expected, actual)
    }
    
    static var allTests = [
        ("testLinkDescription_ValidURL", testLinkDescription_ValidURL),
        ("testLinkDescription_InvalidURL", testLinkDescription_InvalidURL),
    ]
}
