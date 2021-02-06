//
//  Repository.swift
//  
//
//  Created by Thomas Couacault on 06/02/2021.
//

import Foundation

/// A value that wraps information about a Github repository.
struct Repository {
    var name: Link
    var description: String = ""
    var language: String
    var stars: Link
    var forks: Link
}
