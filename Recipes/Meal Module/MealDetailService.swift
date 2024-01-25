//
//  MealService.swift
//  Recipes
//
//  Created by Mayur Nilwant on 19/01/2024.
//

import Foundation


class MealDetailService : HttpRequestHandlerProtocol {
    var endPoint: EndPointProtocol?
    
    required init(){}
    
    func getMealDetail(forMealId id: String, andCallBack callBack:@escaping ((ApiResult<Meal, ApiError>) -> Void) ) {
        
        self.endPoint?.queryParam = ["i": id]
        
        self.fetchRequest(withType: Meal.self) { result in
            
                callBack(result)
                
            }
        }
        
    }

