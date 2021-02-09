//
//  Developer.swift
//  
//
//  Created by Thomas Couacault on 09/02/2021.
//

import Foundation

public struct Developer {
    var profile: Link
    var repository: Repository
    var name: String {
        get {
            return profile.text
        }
    }
}
