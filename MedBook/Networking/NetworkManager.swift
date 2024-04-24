//
//  NetworkManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

struct NetworkManager{
    func getApiData<T:Codable>(forUrl : URL?, resultType:T.Type, completionHandler:@escaping(Result<T, ResponseStatus>)-> Void){
        
        guard let forUrl = forUrl else { return }
        
        URLSession.shared.dataTask(with: forUrl) { (data, response, error) in
            
            if let _ = error {
                print(Constants.Networking.ErrorMessage.API_CALL_ERROR)
                completionHandler(.failure(.error(err: error!.localizedDescription)))
            }
            guard let _ = data else{
                print(Constants.Networking.ErrorMessage.NO_DATA_RECIEVED)
                completionHandler(.failure(.invalidData))
                return
            }
            guard let _ = response else{
                print(Constants.Networking.ErrorMessage.INVALID_RESPONSE)
                completionHandler(.failure(.invalidResponse))
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data!)
                completionHandler(.success(result))
               // print(result)
                
            }catch let err{
                print("\(Constants.Networking.ErrorMessage.JSON_PARSING_ERROR) ->\(err.localizedDescription)")
                completionHandler(.failure(.error(err: err.localizedDescription)))
            }
        }.resume()
    }
}
