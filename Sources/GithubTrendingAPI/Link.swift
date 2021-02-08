//
//  Link.swift
//  
//
//  Created by Thomas Couacault on 06/02/2021.
//

import Foundation
import SwiftSoup

/// A value that identifies the location of a resource and its associated text.
struct Link: CustomStringConvertible, Equatable {
    var url: URL?
    var text: String
    
    public var description: String {
        get {
            return "[\(text)](\(url?.absoluteString ?? ""))"
        }
    }
    
    init(url: URL?, text: String) {
        self.url = url
        self.text = text
    }
    
    /// Creates a Link instance from the provided SwiftSoup link block element.
    ///
    /// This initializer returns nil if the element does not provide the expected informations.
    ///
    /// - Parameter linkBlock: A SwiftSoup.Element object representing an HTML link block.
    init?(linkBlock: Element) {
        do {
            let linkText: String = try linkBlock.text()
            let linkURL: String = try linkBlock.attr("href")
            
            url = URL(string: linkURL, relativeTo: URL(string: "https://github.com"))
            text = linkText
        } catch {
            return nil
        }
    }
}
