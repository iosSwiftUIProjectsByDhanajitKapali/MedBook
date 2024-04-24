//
//  ResponseStatus.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

enum ResponseStatus : Error {
    case error(err : String)
    case invalidResponse
    case invalidData
    case decodingError(err : String)
}
