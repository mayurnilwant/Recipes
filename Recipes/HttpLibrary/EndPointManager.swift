//
//  EndPointManager.swift
//  Recipes
//
//  Created by Mayur Nilwant on 31/12/2023.
//

import Foundation



enum ApiError : Error {
    
    case nilData
    case nilrequest
    case httpresponseError
}



enum ApiResult <T, Error> {
    case success(T?)
    case failure(Error)
}


typealias APIResultCallback<T> = (ApiResult<T, ApiError>) -> Void

enum HttpOperation {
    
    case getAll
    case getItemById
    case postItem(Codable)
}


extension HttpOperation {
    
    var httpMethod : String {
        switch self {
        case .getAll:
            return "GET"
        case .getItemById, .postItem(_):
            return "POST"

        }
    }
    

}

protocol EndPointProtocol {
    
    var host: String {get}
    var scheme: String {get}
    var queryParam: [String: String]? {get set}
    var path: String {get}
    var httpOperation: HttpOperation {get set}
    init()
    init(withQueryParam param: [String: String]?, andOperation operation: HttpOperation)
    
    
}


extension EndPointProtocol {
    
    var host: String {
        return "www.themealdb.com"
    }

    var scheme: String {
      return "https"
    }

    init(withQueryParam param: [String: String]?, andOperation operation: HttpOperation) {
        self.init()
        if let _ = param {
            self.queryParam = param
        }
        
        self.httpOperation = operation
    }
    
    var url: URL? {
        
        var urlcomponent = URLComponents()
        urlcomponent.host = self.host
        urlcomponent.scheme = self.scheme
        if let param = self.queryParam {
            urlcomponent.queryItems = param.map({ key,val in
                return URLQueryItem(name: key, value: val)
            })
        }
       
        urlcomponent.path = self.path
        return urlcomponent.url
    }
}

struct CategoryRecipeEndPoint: EndPointProtocol {
    var host: String?
    init() {
        self.httpOperation = .getAll
    }
   
    var queryParam: [String : String]?
    var httpOperation: HttpOperation
    
    var path : String {
        
        switch self.httpOperation {
            
        case .getAll:
            return "/api/json/v1/1/categories.php"
        case .getItemById:
           return "/path"
        case .postItem(_):
           return "/path"
        }
    }
    
}
