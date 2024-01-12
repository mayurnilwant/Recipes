//
//  ReviceViewModel.swift
//  Recipes
//
//  Created by Mayur Nilwant on 01/01/2024.
//

import Foundation

enum ServiceVMStatus {
    case loading
    case success
    case failure
    case notInitialized
}

protocol ViewModelProtocol {
    
    associatedtype  ResultItem
    
    var resultItem: ResultItem {get set}
    var viewModelServiceStatus : ServiceVMStatus{get set}
}


class RecipeViewModel: ViewModelProtocol {
    var resultItem: [Recipe]?
    var viewModelServiceStatus = ServiceVMStatus.notInitialized
    let recipeService: RecipeServiceProtocol?
    init(withRecipeService service: RecipeServiceProtocol) {
        
        self.recipeService = service
        
    }
    func getAllRecipe()  {
        
        guard  self.recipeService != nil else {
            return
        }
        self.recipeService?.getAllRecipes { result in
            
            switch result {
            case .success(let recipe):
                do {
                    self.resultItem = recipe?.recipes
                }
            default:
                do {
                    self.viewModelServiceStatus = .failure
                    }
                }
            }
        }
    }
