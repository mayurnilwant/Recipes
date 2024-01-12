//
//  HttpRequestHandler.swift
//  Recipes
//
//  Created by Mayur Nilwant on 01/01/2024.
//

import Foundation



protocol HttpRequestHandlerProtocol {
     
    var endPoint: EndPointProtocol? {get set}
    init(withEndPoint endPoint: EndPointProtocol)
    init()
}


extension HttpRequestHandlerProtocol {
    
        
    init(withEndPoint endPoint: EndPointProtocol) {
        self.init()
        self.endPoint = endPoint
    }
    
    func  fetchRequest<T: Codable>(withType type: T.Type, andResultCallBack callBack: @escaping APIResultCallback<T>) {
        
        guard let _url = self.endPoint?.url else {
            callBack(.failure(ApiError.nilrequest))
            return
        }
        
        let urlrequest = URLRequest(url: _url)
    
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlrequest) { responseData, httpRes, error in
            
            guard let statusCode = (httpRes as? HTTPURLResponse)?.statusCode else {
                callBack(.failure(ApiError.httpresponseError))
                return
            }
            guard  (200...299).contains(statusCode) == true else {
                callBack(.failure(ApiError.httpresponseError))
                return
            }
            
            
            let jsonDecoder = JSONDecoder()
            let parsedObj =  try? jsonDecoder.decode(type.self, from: responseData ?? Data())
            callBack(.success(parsedObj))
            
            //write parse value
        }
        
        dataTask.resume()
    }
    
    func  makeRequest(withEndPoint endPoint: EndPointProtocol, andHeader header: [String: String]) -> URLRequest? {
        
        
        guard let _url = endPoint.url  else {
            return nil
        }
        var urlRequest = URLRequest(url: _url)
        for (key,value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
           return urlRequest
    }
    
    
}


struct Reciperesponse : Codable {
    
    let recipes : [Recipe]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        
    }
    init(from decoder: Decoder) throws {
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.recipes = try? container?.decodeIfPresent([Recipe].self, forKey: CodingKeys.categories)
        
        print("Value")
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}

struct Recipe : Codable {
    
    let categoryId: String?
    let categoryName: String?
    let categoryThumbNail: String?
    let categoryDescription: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case categoryId = "idCategory"
        case categoryName = "strCategory"
        case categoryThumbNail = "strCategoryThumb"
        case categoryDescription = "strCategoryDescription"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let decoderContainer = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.categoryId = try? decoderContainer?.decodeIfPresent(String.self, forKey: CodingKeys.categoryId)
        self.categoryName = try? decoderContainer?.decodeIfPresent(String.self, forKey: CodingKeys.categoryName)
        self.categoryThumbNail = try? decoderContainer?.decodeIfPresent(String.self, forKey: CodingKeys.categoryThumbNail)
        self.categoryDescription = try? decoderContainer?.decodeIfPresent(String.self, forKey: CodingKeys.categoryDescription)
        
    }

}







