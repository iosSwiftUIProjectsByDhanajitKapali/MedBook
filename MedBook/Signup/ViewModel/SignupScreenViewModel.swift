//
//  SignupScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class SignupScreenViewModel: ObservableObject {
    
    //MARK: - Published data members
    @Published var countryList: [String] = []
    @Published var selectedCountryIndex = 0 {
        didSet {
            saveSelectedCountry()
        }
    }
    @Published var email = "dhanajit30@gmail.com" { //TEST
        didSet {
            validateEmail()
        }
    }
    @Published var password = "#Dhanajit30" { //TEST
        didSet {
            validatePassword()
        }
    }
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var navigateToHome: Bool = false
    
    
    //MARK: - Private data members
    private let countryRepository = CountryDataRepository()
    private let userManager = UserManager()
    
}


//MARK: - Public methods
extension SignupScreenViewModel {
    func getCountries() {
        if let countries = countryRepository.getCountryList(), countries.count > 0 {
            DispatchQueue.main.async {
                self.countryList = countries.compactMap { $0.countryName }.sorted()
                self.setPrevSelectedCountry()
                self.saveSelectedCountry()
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
                        self.setPrevSelectedCountry()
                        self.saveSelectedCountry()
                        print(self.countryList.count)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func signUp() {
        saveUserCreds()
        if isEmailValid && isPasswordValid {
            markUserAsLoggedIn()
            navigateToHome = true
        }
    }
    
    func saveUserCreds() {
        userManager.createUser(user: User(email: email, password: password))
    }
    
    func markUserAsLoggedIn() {
        UserDefaults.standard.set(true, forKey: "loginStatus")
    }
}


//MARK: - Private methdods
private extension SignupScreenViewModel {
    func setPrevSelectedCountry() {
        let prevSelectedCountry = UserDefaults.standard.string(forKey: "selectedCountry")
        if let index = self.countryList.firstIndex(where: { $0 == prevSelectedCountry }) {
            // index contains the first index where the value matches prevSelectedCountry
            self.selectedCountryIndex = index
        }
    }
    
    // Create a validator service?
    func validateEmail() {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailTest.evaluate(with: email)
    }
    
    func validatePassword() {
        // Password format validation
        let passwordRegex = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\\S+$).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        isPasswordValid = passwordTest.evaluate(with: password)
    }
    
    func saveSelectedCountry() {
        print(countryList[selectedCountryIndex])
        UserDefaults.standard.set(countryList[selectedCountryIndex], forKey: "selectedCountry")
    }
}
