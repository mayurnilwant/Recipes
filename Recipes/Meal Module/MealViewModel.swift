//
//  MealViewModel.swift
//  Recipes
//
//  Created by Mayur Nilwant on 19/01/2024.
//

import Foundation
import Combine


class MealViewModel:  ObservableObject {
    
    @Published var resultItem: Meal?
     let mealMetadata: MealMeta?
    @Published var mealDetailService: MealDetailService
    
    init(withMealMetaData mealMetadata: MealMeta, andMealService service: MealDetailService) {
        
        self.mealMetadata = mealMetadata
        self.mealDetailService = service
    }
    
    func getMeal() {
        
        self.mealDetailService.getMealDetail(forMealId: self.mealMetadata?.mealId ?? "", andCallBack:{ result in
            
            switch result {
                
            case .success(let result):
               do {
                    
                   self.resultItem = result?.mealDetail?[0]
                }
            case .failure(_):
                print("Failure")
                
            }
        })
        
    }
    
}
