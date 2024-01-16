//
//  ReviceViewModel.swift
//  Recipes
//
//  Created by Mayur Nilwant on 01/01/2024.
//

import Foundation
import Combine

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
    @Published var viewModelServiceStatus = ServiceVMStatus.notInitialized
    let recipeService: RecipeServiceProtocol?
    
    
    // Publish result through PassBy value
//    var publishRecipeResultService : PassthroughSubject<[Recipe]?,Error>?
    
    init(withRecipeService service: RecipeServiceProtocol) {
        
        self.recipeService = service
        
    }
    func getAllRecipe()  {
        
        guard  self.recipeService != nil else {
            return
        }
        self.recipeService?.getAllRecipes {[weak self] result in
            
            switch result {
            case .success(let recipe):
                do {
                    self?.resultItem = recipe?.recipes
                    self?.viewModelServiceStatus = .success
//                    self?.publishRecipeResultService?.send(recipe?.recipes)
                }
            default:
                do {
                    self?.viewModelServiceStatus = .failure
//                    self?.publishRecipeResultService?.send(nil)
                    }
                }
            }
        }
    }
