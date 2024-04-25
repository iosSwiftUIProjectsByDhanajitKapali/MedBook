//
//  CountryAPIRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

class CountryAPIRepository: CountryRepository {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func saveCountryList(countries: [Country]) {
        // No Save functionality in backened for now
    }
    
    func getCountryList(completionHandler: @escaping (([Country]) -> Void)) {
        // Get the Countries from API
        print("Fetching Countries from API")
        networkManager.getApiData(forUrl: URL(string: "https://api.first.org/data/v1/countries"), resultType: CountryList.self) { res in
            switch res {
            case .success(let countryDataList):
                let countyData = countryDataList.countries.map{ Country(countryName: $0.value.countryName) }
                print("Fetched Countries from API")
                completionHandler(countyData)
            case .failure(let failure):
                print(failure)
                completionHandler([])
            }
        }
    }
}
