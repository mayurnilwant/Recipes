//
//  CategoryMealVM.swift
//  Recipes
//
//  Created by Mayur Nilwant on 18/01/2024.
//

import Foundation



class CategoryMealViewModel {
    
    let categoryService: CategoryService    
    
    init(categoryService: CategoryService) {
        self.categoryService = categoryService
    }
    
    func getAllMeals(id name: String, andCallBack callBack: @escaping (MealMetaDataresponse?)-> Void) {
        
        self.categoryService.getCategoryListById(withCategoryName: name) { result in
            
            switch result {
                
                case .success(let responses) :
                do {
                    callBack(responses)
                }
            case .failure(_):
                do {
                    callBack(nil)
                }
            }
        }
    }
    
}
