//
//  RecipeListViewController.swift
//  Recipes
//
//  Created by Mayur Nilwant on 02/01/2024.
//

import Foundation
import UIKit


protocol ViewControllerConfigurationProtocol where Self :  UIViewController {
            func configureViewController()
}


class RecipeListViewController : UIViewController, ViewControllerConfigurationProtocol {
    
    let recipeVM : RecipeViewModel?
    
    
    
    init(withRecipeViewMOdel recipeVM: RecipeViewModel) {
        
        self.recipeVM = recipeVM
        super.init()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    //Pragma Mark
    
    func configureViewController() {
    
        self.recipeVM?.getAllRecipe()

        
    }
}
