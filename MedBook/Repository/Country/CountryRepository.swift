//
//  CountryRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import CoreData

protocol CountryRepository {
    func saveCountryList(countries: [Country])
    func getCountryList(completionHandler: @escaping(([Country]) -> Void))
}
