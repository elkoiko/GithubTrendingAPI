//
//  TrendsFetcherTests.swift
//  
//
//  Created by Thomas Couacault on 08/02/2021.
//

import Foundation
import XCTest
@testable import GithubTrendingAPI
import SwiftSoup

final class TrendsFetcherTests: XCTestCase {

    // MARK: makeLink
    
    func testMakeLink() throws {
        let linkBlockHTML: String =
        """
            <a href="/user/repo" class="muted-link d-inline-block mr-3">
                    <svg aria-label="fork" class="octicon octicon-repo-forked" height="16" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d=""></path></svg>
                    Link text
            </a>
        """
        let document: Document = try SwiftSoup.parse(linkBlockHTML)
        let linkBlock: Element = try document.select("a").first()!
        var expected: Link
        var actual: Link?
        let githubURL: URL = URL(string: "https://github.com")!
        
        expected = Link(url: URL(string: "/user/repo", relativeTo: githubURL), text: "Link text")
        actual = TrendsFetcher.makeLink(from: linkBlock)
                    
        XCTAssertTrue(actual != nil)
        XCTAssertEqual(expected, actual!)
    }
    
    // MARK: makeRepository
    func testMakeRepository_WithDescription() throws {
        let repoBlockHTML: String =
        """
            <article class="Box-row">
                <h1 class="h3 lh-condensed">
                    <a href="/user/repo">user / repo</a>
                </h1>
                <p class="col-9 text-gray my-1 pr-4">Description of the repo</p>
                <div class="f6 text-gray mt-2">
                    <span class="d-inline-block ml-0 mr-3">
                      <span class="repo-language-color" style="background-color: #FFFFFF"></span>
                      <span itemprop="programmingLanguage">Programming Language</span>
                    </span>
                    <a href="/user/repo/stargazers" class="muted-link d-inline-block mr-3">
                            <svg aria-label="star" class="octicon octicon-star" height="16" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d=""></path></svg>
                            3,397
                    </a>
                    <a href="/user/repo/network/members.repo" class="muted-link d-inline-block mr-3">
                            <svg aria-label="fork" class="octicon octicon-repo-forked" height="16" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d=""></path></svg>
                            1,698
                    </a>
                </div>
            </article>
        """
        let document: Document = try SwiftSoup.parse(repoBlockHTML)
        let repoBlock: Element = try document.select(".Box-row").first()!
        var expected: Repository
        var actual: Repository?
        let githubURL: URL = URL(string: "https://github.com")!
        
        expected = Repository(link: Link(url: URL(string: "/user/repo", relativeTo: githubURL), text: "user / repo"),
                              description: "Description of the repo",
                              language: "Programming Language",
                              stars: Link(url: URL(string: "/user/repo/stargazers", relativeTo: githubURL), text: "3,397"),
                              forks: Link(url: URL(string: "/user/repo/network/members.repo", relativeTo: githubURL), text: "1,698"))
        actual = TrendsFetcher.makeRepository(from: repoBlock)
                
        XCTAssertTrue(actual != nil)
        XCTAssertEqual(expected, actual!)
    }
    
    func testMakeRepository_WithoutDescription() throws {
        let repoBlockHTML: String =
        """
            <article class="Box-row">
                <h1 class="h3 lh-condensed">
                    <a href="/user/repo">user / repo</a>
                </h1>
                <div class="f6 text-gray mt-2">
                    <span class="d-inline-block ml-0 mr-3">
                      <span class="repo-language-color" style="background-color: #FFFFFF"></span>
                      <span itemprop="programmingLanguage">Programming Language</span>
                    </span>
                    <a href="/user/repo/stargazers" class="muted-link d-inline-block mr-3">
                            <svg aria-label="star" class="octicon octicon-star" height="16" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d=""></path></svg>
                            3,397
                    </a>
                    <a href="/user/repo/network/members.repo" class="muted-link d-inline-block mr-3">
                            <svg aria-label="fork" class="octicon octicon-repo-forked" height="16" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d=""></path></svg>
                            1,698
                    </a>
                </div>
            </article>
        """
        let document: Document = try SwiftSoup.parse(repoBlockHTML)
        let repoBlock: Element = try document.select(".Box-row").first()!
        var expected: Repository
        var actual: Repository?
        let githubURL: URL = URL(string: "https://github.com")!
        
        expected = Repository(link: Link(url: URL(string: "/user/repo", relativeTo: githubURL), text: "user / repo"),
                              description: "",
                              language: "Programming Language",
                              stars: Link(url: URL(string: "/user/repo/stargazers", relativeTo: githubURL), text: "3,397"),
                              forks: Link(url: URL(string: "/user/repo/network/members.repo", relativeTo: githubURL), text: "1,698"))
        actual = TrendsFetcher.makeRepository(from: repoBlock)
                
        XCTAssertTrue(actual != nil)
        XCTAssertEqual(expected, actual)
    }
    
    func testMakeRepository_InvalidBlock() throws {
        let repoBlockHTML: String =
        """
            <article class="Box-row">
                <h1 class="h3 lh-condensed">
                    <a href="/user/repo">user / repo</a>
                </h1>
                <p class="col-9 text-gray my-1 pr-4">Description of the repo</p>
            </article>
        """
        let document: Document = try SwiftSoup.parse(repoBlockHTML)
        let repoBlock: Element = try document.select(".Box-row").first()!
        var expected: Repository?
        var actual: Repository?
        
        expected = nil
        actual = TrendsFetcher.makeRepository(from: repoBlock)
                
        XCTAssertEqual(expected, actual)

    }

    static var allTests = [
        ("testMakeLink", testMakeLink),
        ("testMakeRepository_WithDescription", testMakeRepository_WithDescription),
        ("testMakeRepository_WithoutDescription", testMakeRepository_WithoutDescription),
        ("testMakeRepository_InvalidBlock", testMakeRepository_InvalidBlock),
    ]
}
