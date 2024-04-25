//
//  CountryCoreDataRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

class CountryCoreDataRepository: CountryRepository {
    
    private let persistentStorage: PersistentStorage
    
    init(persistentStorage: PersistentStorage = PersistentStorage.shared) {
        self.persistentStorage = persistentStorage
    }
    
    func saveCountryList(countries: [Country]) {
        for country in countries {
            // Create a new entity of CDCountry type
            let cdCountry = CDCountry(context: persistentStorage.context)
            
            // Fill the data of the entity with the data from our model
            cdCountry.countryName = country.countryName
            
            // Save the context
            persistentStorage.saveContext()
        }
    }
    
    func getCountryList(completionHandler: @escaping (([Country]) -> Void)) {
        print("Fetching Countries from CoreData")
        let result = persistentStorage.fetchManagedObjects(managedObject: CDCountry.self)
        // Convert the result to [Country] type
        var countries : [Country] = []
        result?.forEach({ (cdCountry) in
            countries.append(cdCountry.convertToCountry())
        })
        completionHandler(countries)
    }
}
