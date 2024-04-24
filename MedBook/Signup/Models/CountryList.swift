//
//  CountryList.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

struct CountryList: Codable {
    let countries: [String: Country]
    
    enum CodingKeys: String, CodingKey {
        case countries = "data"
    }
}

struct Country: Codable {
    let countryName: String
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country"
    }
}
