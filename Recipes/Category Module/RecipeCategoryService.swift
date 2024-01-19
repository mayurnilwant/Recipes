//
//  RecipeCategoryService.swift
//  Recipes
//
//  Created by Mayur Nilwant on 18/01/2024.
//

import Foundation

struct MealMetaDataresponse: Codable {
    
    let mealMetadate: [MealMeta]?
    
    enum CodingKeys : String, CodingKey {
        
        case meals = "meals"
    }
    
    init(from decoder: Decoder) throws {
        
        let mealsContainer = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.mealMetadate = try? mealsContainer?.decodeIfPresent([MealMeta].self, forKey: CodingKeys.meals)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct MealMeta: Codable, ListCellModel {
    
    
    
    let mealName: String?
    let mealId: String?
    let mealThumbNail: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case mealname = "strMeal"
        case mealThumbNail = "strMealThumb"
        case mealId = "idMeal"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealName = try container.decode(String.self, forKey: CodingKeys.mealname)
        self.mealId = try container.decode(String.self, forKey: CodingKeys.mealId)
        self.mealThumbNail = try container.decode(String.self, forKey: CodingKeys.mealThumbNail)
    }
    
    
    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.mealName, forKey: .mealName)
//        try container.encode(self.mealId, forKey: .mealId)
//        try container.encode(self.mealThumbNail, forKey: .mealThumbNail)
    }
    
    var title: String {
        return self.mealId ?? ""
    }
    
    var subTitle: String {
        self.mealName ?? ""
    }
     
    var imageUrlString: String {
        return self.mealThumbNail ?? ""
    }
}


protocol MealServiceProtocol:HttpRequestHandlerProtocol {
    
    func getCategoryListById(withCategoryName name: String, andCallBack callBack: @escaping (ApiResult<MealMetaDataresponse,ApiError>) -> Void)
}



class MealService: MealServiceProtocol {
    
    
    required init() {}
    func getCategoryListById(withCategoryName name: String, andCallBack callBack: @escaping (ApiResult<MealMetaDataresponse, ApiError>) -> Void) {
        
        self.endPoint?.queryParam = ["c": name]
        self.fetchRequest(withType: MealMetaDataresponse.self) { result in
            
            callBack(result)
            
        }
        
    }
    
    var endPoint: EndPointProtocol?
    
    
   
}
