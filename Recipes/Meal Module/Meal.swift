//
//  Meal.swift
//  Recipes
//
//  Created by Mayur Nilwant on 19/01/2024.
//

import Foundation




struct MealDetailResponse : Codable {
    
    var mealDetail: [Meal]?
    
    enum CodingKeys: String, CodingKey {
        case mealDetail = "meals"
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.mealDetail = try container.decodeIfPresent([Meal].self, forKey: .mealDetail)
            let arrCon = try? container.nestedUnkeyedContainer(forKey: .mealDetail)
            print("fsaf")
        }catch (let err) {
            
            print(err)
        }
        
    }
}

struct Meal: Codable {
    
    var mealName: String?
    var mealDrinkAlt:String?
    var mealCategory:String?
    var mealOrigin: String?
    var recipeInstruction: String?
    var mealImage: String?
    var mealYouTube: String?

    
    enum CodingKeys : String, CodingKey {
            case mealName = "strMeal"
            case mealDrinkAlt = "strDrinkAlternate"
            case mealCategory = "strCategory"
            case mealOrigin = "strArea"
            case recipeInstruction = "strInstructions"
            case mealImage = "strMealThumb"
            case meailYoutube = "mealYouTube"
    }
    
    
    init(from decoder: Decoder) throws {
        
        do {
            
            let container = try? decoder.container(keyedBy: CodingKeys.self)
            self.mealName = try? container?.decode(String.self, forKey: .mealName)
            self.mealDrinkAlt = try? container?.decode(String.self, forKey: .mealDrinkAlt)
            self.mealCategory = try? container?.decode(String.self, forKey: .mealCategory)
            self.mealOrigin = try? container?.decode(String.self, forKey: .mealOrigin)
            self.recipeInstruction = try? container?.decode(String.self, forKey: .recipeInstruction)
            self.mealImage = try? container?.decode(String.self, forKey: .mealImage)
            self.mealYouTube = try? container?.decode(String.self, forKey: CodingKeys.meailYoutube)
        }catch (let err) {
            print(err)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}
