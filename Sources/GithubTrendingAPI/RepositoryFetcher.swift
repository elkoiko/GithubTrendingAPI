//
//  RepositoryFetcher.swift
//  
//
//  Created by Thomas Couacault on 08/02/2021.
//

import Foundation
import SwiftSoup

/// Provides a set of methods to retrieve Github's trending repositories
struct RepositoryFetcher {

    /// fetchRepositories returns an array containing all the trending repositories.
    static func fetchRepositories() -> [Repository] {
        // TODO: Implement fetchRepositories
        return [Repository]()
    }
    
    // MARK: Factories
    
    /// makeLink creates a Link instance from the provided SwiftSoup link block element.
    ///
    /// Returns nil if the element does not provide the expected informations.
    ///
    /// - Parameter linkBlock: A SwiftSoup.Element object representing an HTML link block.
    static func makeLink(from linkBlock: Element) -> Link? {
        var link: Link?
        
        do {
            let linkText: String = try linkBlock.text()
            let linkURL: String = try linkBlock.attr("href")
            
            link = Link(url: URL(string: linkURL, relativeTo: URL(string: "https://github.com")), text: linkText)
        } catch {
            link = nil
        }
        return link
    }
    
    /// makeRepository creates a Repository instance from the given repository HTML block.
    ///
    /// Returns nil if repoBlock has not a valid format or does not provide enough information.
    ///
    /// - Parameter repoBlock: SwiftSoup.Element object representing a repository HTML block
    static func makeRepository(from repoBlock: Element) -> Repository? {
        var repository: Repository?
        
        do {
            // Retrieving the repo link
            let repoLinkBlock: Element? = try repoBlock.select("h1.h3 a").first()
            var repoLink: Link? = nil
            if let block = repoLinkBlock {
                repoLink = makeLink(from: block)
            }
            // Retrieving the repo description
            let repoDescBlock: Element? = try repoBlock.select("p.my-1.pr-4").first()
            let repoDescription: String = try repoDescBlock?.text() ?? ""
            // Retrieving the repo programming language
            let repoLanguageBlock: Element? = try repoBlock.select("div.mt-2 span.mr-3").first()
            var repoLanguage: String = ""
            if let block = repoLanguageBlock {
                repoLanguage = try block.text()
            }
            // Retrieving the repo stars and forks
            let repoAdditionalLinksBlock: [Element] = try repoBlock.select("div.mt-2 a").array()
            var repoStars: Link? = nil
            var repoForks: Link? = nil
            if repoAdditionalLinksBlock.count >= 2 {
                let repoStarsBlock: Element = repoAdditionalLinksBlock[0]
                let repoForksBlock: Element = repoAdditionalLinksBlock[1]
                repoStars = makeLink(from: repoStarsBlock)
                repoForks = makeLink(from: repoForksBlock)
            }
            
            if let link = repoLink, let stars = repoStars, let forks = repoForks {
                repository = Repository(link: link, description: repoDescription, language: repoLanguage,
                                        stars: stars, forks: forks)
            } else {
                repository = nil
            }
        } catch {
            repository = nil
        }
        return repository
    }
}
