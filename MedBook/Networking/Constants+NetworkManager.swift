//
//  Constants+NetworkManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

extension Constants {
    struct Networking{
        
        struct HttpMethod {
            static let GET = "get"
            static let POST = "post"
            static let PUT = "put"
            static let DELETE = "delete"
        }
        struct HeaderFieldValue {
            static let CONTENT_TYPE = "content-type"
            static let BODY_DATA_TYPE_IS_JSON = "application/json"
        }
        
        struct ErrorMessage {
            static let API_CALL_ERROR = "Error in API Call"
            static let NO_DATA_RECIEVED = "No Data Recieved"
            static let INVALID_RESPONSE = "Invalid Response Recieved"
            static let JSON_PARSING_ERROR = "Error while parsing JSON data"
            
        }
    }
}
