//
//  CountryList.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

struct CountryList: Codable {
    let countries: [String: Datum]
    
    enum CodingKeys: String, CodingKey {
        case countries = "data"
    }
}

struct Datum: Codable {
    let country: String
}
