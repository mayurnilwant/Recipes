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


protocol ListViewControllerProtocol {
    
    var tblView: UITableView! {get set}
}


class CategoryListViewController : UIViewController, ViewControllerConfigurationProtocol, ListViewControllerProtocol {
    
    
    let recipeVM : RecipeViewModel?
    var tblView: UITableView!

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
        
        self.tblView = UITableView(frame: self.view.frame, style: .plain)
        self.tblView.register(ListCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.view.addSubview(tblView)
        
    }
    
    //PRAGMA MARK  - Protocol method
    
    func configureViewController() {
    
        self.navigationItem.title = "Recipes"
        self.recipeVM?.getAllRecipe()
    }
    
    func configureVMCallBacks() {
        
        self.recipeVM?.$viewModelServiceStatus
            .receive(on: RunLoop.main)
            .sink(receiveValue: { status in
            if status == .success {
                    self.tblView.reloadData()
                
            }else {
                
            }
                
        })
        .store(in: &self.vmSubs)
    }
}


extension CategoryListViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeVM?.resultItem?.count ?? 0
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var _cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? ListCell
        if _cell == nil {
            _cell = ListCell(style: .default, reuseIdentifier: "cellIdentifier")
        }
        
        if let recipe = self.recipeVM?.resultItem?[indexPath.row] as? RecipeCategory{
            _cell?.configureCell(withListModel: recipe)
            
            _cell?.recipeCategoryImage.downLoadImageInBackground(withUrl: recipe.categoryThumbNail ?? "")
        }
        

        
        return _cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let _ = self.recipeVM?.resultItem?[indexPath.row] else {
            return
        }

    }
}
