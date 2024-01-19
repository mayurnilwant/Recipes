//
//  RecipeCategoryService.swift
//  Recipes
//
//  Created by Mayur Nilwant on 18/01/2024.
//

import Foundation

struct MealMetaData {
    
    
    
}


protocol CategoryRecipeProtocol:HttpRequestHandlerProtocol {
    
    func getCategoryLestById(withCategoryName name: String)
}
