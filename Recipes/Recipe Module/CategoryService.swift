//
//  Recipeservice.swift
//  Recipes
//
//  Created by Mayur Nilwant on 02/01/2024.
//

import Foundation


protocol CategoryServiceProtocol : HttpRequestHandlerProtocol{
    
    func getAllCategory(withCallBack callBack: @escaping APIResultCallback<Reciperesponse>)
}


class CategoryService: CategoryServiceProtocol {
    func getAllCategory(withCallBack callBack: @escaping APIResultCallback<Reciperesponse>) {
        self.fetchRequest(withType: Reciperesponse.self) { apiResult in
            callBack(apiResult)
        }
    }
    var endPoint: EndPointProtocol?
    required init() {}
}
