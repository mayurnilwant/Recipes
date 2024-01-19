//
//  CategoryMealVM.swift
//  Recipes
//
//  Created by Mayur Nilwant on 18/01/2024.
//

import Foundation
import Combine



class CategoryMealViewModel: ViewModelProtocol {
    var resultItem: [MealMeta]?
    
    @Published var viewModelServiceStatus = ServiceVMStatus.notInitialized
    
    typealias ResultItem = [MealMeta]?
    
    
    let categoryService: MealService    
    
    init(categoryService: MealService) {
        self.categoryService = categoryService
    }
    
    func getAllMeals(id name: String) {
        
        self.categoryService.getCategoryListById(withCategoryName: name) { result in
            
            switch result {
                
                case .success(let responses) :
                do {
                    self.viewModelServiceStatus = .success
                    self.resultItem = responses?.mealMetadata
                }
            case .failure(_):
                do {
                    self.viewModelServiceStatus = .failure
                }
            }
        }
    }
    
}
