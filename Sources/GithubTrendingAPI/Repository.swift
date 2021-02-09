//
//  Repository.swift
//  
//
//  Created by Thomas Couacault on 06/02/2021.
//

import Foundation

/// A value that wraps information about a Github repository.
public struct Repository: Equatable {
    var link: Link
    var description: String = ""
    var language: String
    var stars: Link
    var forks: Link
    var name: String {
        get {
            return link.text
        }
    }
}
