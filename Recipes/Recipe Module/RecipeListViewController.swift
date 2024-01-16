//
//  RecipeListViewController.swift
//  Recipes
//
//  Created by Mayur Nilwant on 02/01/2024.
//

import Foundation
import UIKit
import Combine


protocol ViewControllerConfigurationProtocol where Self :  UIViewController {
    
    //This protocol is created to bring a contract method where all the configuration parametrs after the class is initiated.
            func configureViewController()
}


class RecipeListViewController : UIViewController, ViewControllerConfigurationProtocol {
    
    let recipeVM : RecipeViewModel?
    var vmSubs = Set<AnyCancellable>()
        
    init(withRecipeViewMOdel recipeVM: RecipeViewModel) {
        
        self.recipeVM = recipeVM
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        
        self.recipeVM  = RecipeViewModel(withRecipeService: RecipeService(withEndPoint: CategoryRecipeEndPoint(withQueryParam: [:], andOperation: .getAll)))
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.configureViewController()
        self.configureVMCallBacks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    //PRAGMA MARK  - Protocol method
    
    func configureViewController() {
    
        self.recipeVM?.getAllRecipe()
    }
    
    func configureVMCallBacks() {
        
        self.recipeVM?.$viewModelServiceStatus.sink(receiveValue: { status in
            if status == .success {
                    
                
            }else {
                
            }
                
        })
        .store(in: &self.vmSubs)
    }
}
