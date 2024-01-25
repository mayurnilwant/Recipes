//
//  MealDetailView.swift
//  Recipes
//
//  Created by Mayur Nilwant on 21/01/2024.
//

import SwiftUI
import Combine


struct MealDetailView: View {
    
    @ObservedObject var serviceVM : MealViewModel
      var meal :Meal?
    
    
    init(viewModel: MealViewModel) {
        self.serviceVM = viewModel
    }
    var body: some View {
        
            AsyncImageView(downLoadManager:AsyncDownloader(imgUrl: self.serviceVM.resultItem?.mealImage ?? ""))
            VStack(alignment: .leading, spacing: 10) {
                
                RecipeDetailViewCell(labelTitle:"Meal Category", descriptionTitle: self.serviceVM.resultItem?.mealCategory ?? "")
                RecipeDetailViewCell(labelTitle:"Meal Origin" , descriptionTitle: self.serviceVM.resultItem?.mealOrigin ?? "")
                RecipeDetailViewCell(labelTitle:"Meal Name" , descriptionTitle:  self.serviceVM.resultItem?.mealName ?? "")
    
            }
            
            .onAppear{
                
                self.update()
            }

    }
       
    
    
    func update() {
        
            self.serviceVM.getMeal()

        }
    }


//#Preview {
//    /*MealDetailView(sevice: MealDetailService(withEndPoint: MealCategoryEnfPoint(withQueryParam: [:], andOpera*/tion: .getItemById)), andMeal: nil)
//}


struct RecipeDetailViewCell: View {
    
    let labelTitle: String
    let descriptionTitle: String
    
    init(labelTitle: String, descriptionTitle: String) {
        self.labelTitle = labelTitle
        self.descriptionTitle = descriptionTitle
    }
    
    
    var body: some View {


        VStack(){
            HStack {
                Text(labelTitle)
                    .font(.system(size: 14.0, weight: .semibold))
                    Spacer()
            }
            .padding(.leading, 10)
            
            HStack {
                
                Text(self.descriptionTitle)
                    .font(.system(size: 16.0, weight: .bold))
                    Spacer()
            }
            .padding(.leading, 10)
            
            Rectangle().frame(maxWidth:.infinity,maxHeight:1.0)
                .background(Color(red: 0.0, green: 0.0, blue: 0.0,opacity: 0.1))
            
            
        }
        .frame(maxWidth: .infinity, minHeight: 60.0, maxHeight:60.0)
        .padding([.leading, .trailing], 10)
        
        
    }
}
