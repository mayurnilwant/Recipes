//
//  Recipeservice.swift
//  Recipes
//
//  Created by Mayur Nilwant on 02/01/2024.
//

import Foundation


protocol RecipeServiceProtocol : HttpRequestHandlerProtocol{
    
    func getAllRecipes(withCallBack callBack: @escaping APIResultCallback<Reciperesponse>)
}


class RecipeService: RecipeServiceProtocol {
    func getAllRecipes(withCallBack callBack: @escaping APIResultCallback<Reciperesponse>) {
        self.fetchRequest(withType: Reciperesponse.self) { apiResult in
            callBack(apiResult)
        }
    }
    var endPoint: EndPointProtocol?
    required init() {}
}
