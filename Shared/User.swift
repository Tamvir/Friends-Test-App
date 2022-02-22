//
//  User.swift
//  TestApp
//
//  Created by MD Ehteshamul Haque Tamvir on 21/2/22.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: Int64
    var name: Names
    var email: String
    var location: Location
    var cell: String
    var picture: Picture
    
    struct Names: Decodable {
        var title: String
        var first: String
        var last: String
    }
    
    struct Address: Decodable {
        var number: Int64
        var name: String
    }

    struct Location: Decodable {
        var address: Address
        var city: String
        var state: String
        var country: String
    }
    
    struct Picture: Decodable {
        var large: String
        var medium: String
        var thumbnail: String
    }
}
