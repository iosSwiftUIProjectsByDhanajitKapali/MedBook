//
//  SignupScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class SignupScreenViewModel: ObservableObject {
    
    @Published var countryList: [String] = []
    @Published var selectedCountry = 0
    
    func getCountries() {
        NetworkManager().getApiData(forUrl: URL(string: "https://api.first.org/data/v1/countries"), resultType: CountryList.self) { res in
            switch res {
            case .success(let countryDataList):
                DispatchQueue.main.async {
                    self.countryList = countryDataList.countries.map { $0.value.country }.sorted()
                    print(self.countryList.count)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}

import Foundation

// MARK: - Welcome
struct CountryList: Codable {
    let countries: [String: Datum]
    
    enum CodingKeys: String, CodingKey {
        case countries = "data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let country: String
}
