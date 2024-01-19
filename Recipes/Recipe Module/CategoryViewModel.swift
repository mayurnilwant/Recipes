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


class CategoryViewModel: ViewModelProtocol {
    var resultItem: [RecipeCategory]?
    @Published var viewModelServiceStatus = ServiceVMStatus.notInitialized
    let recipeService: CategoryServiceProtocol?
    
    init(withRecipeService service: CategoryServiceProtocol) {
        
        self.recipeService = service
        
    }
    func getAllRecipe()  {
        
        guard  self.recipeService != nil else {
            return
        }
        self.recipeService?.getAllCategory {[weak self] result in
            
            switch result {
            case .success(let recipe):
                do {
                    self?.resultItem = recipe?.recipes
                    self?.viewModelServiceStatus = .success
                }
            default:
                do {
                    self?.viewModelServiceStatus = .failure
                    }
                }
            }
        }
    }
