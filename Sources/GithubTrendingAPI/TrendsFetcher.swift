//
//  TrendsFetcher.swift
//  
//
//  Created by Thomas Couacault on 08/02/2021.
//

import Foundation
import SwiftSoup

/// Provides a set of methods to retrieve Github's trending repositories and developers
struct TrendsFetcher {

    // MARK: Fetchers
    
    /// fetchDevelopers returns an array containing all the trending developers available in content.
    ///
    /// - Parameter content: String representation of the HTML web page content.
    static func fetchDevelopers(content trendingPage: String) -> [Developer] {
        var developers: [Developer] = [Developer]()
        var devBlocks: Elements
        
        do {
            let document: Document = try SwiftSoup.parse(trendingPage)
            devBlocks = try document.select("article.Box-row")
        } catch {
            return [Developer]()
        }
        
        for devBlock: Element in devBlocks {
            if let developer = makeDeveloper(from: devBlock) {
                developers.append(developer)
            }
        }
        return developers
    }
    
    /// fetchRepositories returns an array containing all the trending repositories available in content.
    ///
    /// - Parameter content: String representation of the HTML web page content.
    static func fetchRepositories(content trendingPage: String) -> [Repository] {
        var repositories: [Repository] = [Repository]()
        var repoBlocks: Elements

        do {
            let document: Document = try SwiftSoup.parse(trendingPage)
            repoBlocks = try document.select("article.Box-row")
        } catch {
            return [Repository]()
        }
        
        for repoBlock: Element in repoBlocks {
            if let repository = makeRepository(from: repoBlock) {
                repositories.append(repository)
            }
        }
        return repositories
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
    
    /// makeDeveloper creates a Developer instance from the given developer HTML block.
    ///
    /// Returns nil if devBlock has not a valid format or does not provide enough information.
    ///
    /// - Parameter devBlock: SwiftSoup.Element object representing a developer HTML block
    static func makeDeveloper(from devBlock: Element) -> Developer? {
        var developer: Developer? = nil
        
        do {
            // Retrieving the developer image data
            let devImgDataBlock: Element? = try devBlock.select("div.mx-3 a img.avatar-user").first()
            var devImgData: Data? = nil
            if let block = devImgDataBlock, devImgDataBlock?.hasAttr("src") ?? false {
                devImgData = try? Data(contentsOf: URL(string: block.attr("src"))!)
            }
            
            // Retrieving the developer full name
            let devFullNameBlock: Element? = try devBlock.select("div.col-md-6 h1.h3 a").first()
            let devFullName: String = try devFullNameBlock?.text() ?? ""
            
            // Retrieving the developer profile link
            let devProfileLinkBlock: Element? = try devBlock.select("div.col-md-6 p a").first()
            var devProfile: Link? = nil
            if let block = devProfileLinkBlock {
                devProfile = makeLink(from: block)
            }
            
            // Retrieving the developer popular repository
            let devRepositoryLinkBlock: Element? = try devBlock.select("div.col-md-6 div.mt-2.mb-3.my-md-0 article h1.h4 a").first()
            var devRepositoryLink: Link? = nil
            if let block = devRepositoryLinkBlock {
                devRepositoryLink = makeLink(from: block)
            }
             
            let devRepositoryDescriptionBlock : Element? = try devBlock.select("div.col-md-6 div.mt-2.mb-3.my-md-0 article div.f6").first()
            let devRepositoryDescription: String = try devRepositoryDescriptionBlock?.text() ?? ""
            
            if let profile = devProfile, let repoLink = devRepositoryLink {
                developer = Developer(profilePictureData: devImgData, fullName: devFullName, profile: profile,
                                      repository: Repository(link: repoLink, description: devRepositoryDescription))
            }
        } catch {
            developer = nil
        }
        return developer
    }
}
