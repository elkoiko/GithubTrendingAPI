//
//  Link.swift
//  
//
//  Created by Thomas Couacault on 06/02/2021.
//

import Foundation

/// A value that identifies the location of a resource and its associated text.
struct Link: CustomStringConvertible {
    var url: URL?
    var text: String
    
    public var description: String {
        get {
            return "[\(text)](\(url?.description ?? ""))"
        }
    }
}
