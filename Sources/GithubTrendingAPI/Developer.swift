//
//  Developer.swift
//  
//
//  Created by Thomas Couacault on 09/02/2021.
//

import Foundation

public struct Developer: Equatable {
    var profilePictureData: Data? = nil
    var fullName: String
    var profile: Link
    var repository: Repository
    var userName: String {
        get {
            return profile.text
        }
    }
}
