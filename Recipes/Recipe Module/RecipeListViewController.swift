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


class RecipeListViewController : UIViewController, ViewControllerConfigurationProtocol, ListViewControllerProtocol {
    
    
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
//        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.view.addSubview(tblView)
        
    }
    
    
    //PRAGMA MARK  - Protocol method
    
    func configureViewController() {
    
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


extension RecipeListViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeVM?.resultItem?.count ?? 0
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var _cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if _cell == nil {
            _cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        }
        
        let recipe = self.recipeVM?.resultItem?[indexPath.row]
        _cell?.textLabel?.text = recipe?.categoryName
        _cell?.detailTextLabel?.text = recipe?.categoryDescription
        return _cell ?? UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let recipe = self.recipeVM?.resultItem?[indexPath.row] else {
            return
        }
        
       // print(recipe)
    }
}
