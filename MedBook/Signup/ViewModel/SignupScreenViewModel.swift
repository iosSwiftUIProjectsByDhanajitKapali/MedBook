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
    
    @Published var email = "" {
        didSet {
            email = email.lowercased()
            validateEmail()
        }
    }
    @Published var password = "" {
        didSet {
            validatePassword()
        }
    }
    
    
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    
    private let countryRepository = CountryDataRepository()
    
    func getCountries() {
        if let countries = countryRepository.getCountryList(), countries.count > 0 {
            DispatchQueue.main.async {
                self.countryList = countries.compactMap { $0.countryName }.sorted()
            }
        } else {
            // Get the Countries from API
            NetworkManager().getApiData(forUrl: URL(string: "https://api.first.org/data/v1/countries"), resultType: CountryList.self) { res in
                switch res {
                case .success(let countryDataList):
                    let countries = countryDataList.countries.map{ Country(countryName: $0.value.countryName) }
                    self.countryRepository.saveCountryList(countries: countries)
                    DispatchQueue.main.async {
                        self.countryList = countryDataList.countries.map { $0.value.countryName }.sorted()
                        print(self.countryList.count)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    // Create a validator service?
    private func validateEmail() {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailTest.evaluate(with: email)
    }
    
    private func validatePassword() {
        // Password format validation
        let passwordRegex = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\\S+$).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        isPasswordValid = passwordTest.evaluate(with: password)
    }
    
}
