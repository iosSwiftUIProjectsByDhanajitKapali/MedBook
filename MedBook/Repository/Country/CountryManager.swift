//
//  CountryManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

protocol CountryManagerProtocol {
    func getCountryList(completionHandler: @escaping(([String]) -> Void))
}

struct CountryManager: CountryManagerProtocol {
    
    private let countryCoreDataRepo: CountryRepository
    private let countryApiRepo: CountryRepository
    
    init(
        countryCoreDataRepo: CountryCoreDataRepository = CountryCoreDataRepository(),
        countryApiRepo: CountryAPIRepository = CountryAPIRepository()
    ) {
        self.countryCoreDataRepo = countryCoreDataRepo
        self.countryApiRepo = countryApiRepo
    }
    
    /// getCountryList will first check for countries in LocalDB if not found then will make api call to fetch countries
    func getCountryList(completionHandler: @escaping(([String]) -> Void))  {
        countryCoreDataRepo.getCountryList { countryData in
            if countryData.count == 0 {
                countryApiRepo.getCountryList { countryData in
                    completionHandler(countryData.map { $0.countryName }.sorted())
                    saveCountryList(countries: countryData)
                }
            } else {
                completionHandler(countryData.map { $0.countryName }.sorted())
            }
        }
    }
    
    private func saveCountryList(countries: [Country]) {
        countryCoreDataRepo.saveCountryList(countries: countries)
    }
    
}
