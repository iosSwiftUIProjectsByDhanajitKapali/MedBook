//
//  CountryRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation
import CoreData

protocol CountryRepository {

    func saveCountryList(countries: [Country])
    func getCountryList() -> [Country]?
}

class CountryDataRepository: CountryRepository {
    func saveCountryList(countries: [Country]) {
        for country in countries {
            //create a new entity of CDCountry type
            let cdCountry = CDCountry(context: PersistentStorage.shared.context)
            
            //fill the data of the entity with the data from our model
            cdCountry.countryName = country.countryName
            
            //save the context
            PersistentStorage.shared.saveContext()
        }
    }
    
    func getCountryList() -> [Country]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDCountry.self)
        //convert the result to [Country] type
        var countries : [Country] = []
        result?.forEach({ (cdCountry) in
            countries.append(cdCountry.convertToCountry())
        })
        return countries
    }
}
