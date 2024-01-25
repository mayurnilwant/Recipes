//
//  MealListViewController.swift
//  Recipes
//
//  Created by Mayur Nilwant on 19/01/2024.
//

import Foundation
import UIKit
import SwiftUI

import Combine

class MealListViewController: UIViewController, ListViewControllerProtocol {
    
    
    var tblView: UITableView!
    let mealVM: CategoryMealViewModel
    var recipeCategory: RecipeCategory
    
    var vmSub = Set<AnyCancellable>()
    
//    var listDataItems: [MealMeta]?
    
    
    init(withMealVM vm: CategoryMealViewModel, andMeal recipeCategory: RecipeCategory) {
        
        self.mealVM = vm
        self.recipeCategory = recipeCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        fatalError("Not allowed")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            self.getAllMealsForCategory()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView = UITableView(frame: self.view.frame, style: .plain)
        self.tblView.register(ListCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.view.addSubview(tblView)
        self.configureVMCallBacks()
        self.configureViewController()
    }
    
    func configureViewController() {
        self.navigationItem.title = "\(recipeCategory.categoryName ?? "")"
    }
    
    func getAllMealsForCategory() {
        
//        let categoryMealVM = CategoryMealViewModel(categoryService: MealService(withEndPoint: MealCategoryEnfPoint(withQueryParam: [:], andOperation: .getAll)))
        
        self.mealVM.getAllMeals(id: self.recipeCategory.categoryName ?? "")
        
    }
    
    
    func configureVMCallBacks() {
        
        self.mealVM.$viewModelServiceStatus
            .receive(on: RunLoop.main)
            .sink(receiveValue: { status in
            if status == .success {
                
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
                    
                
            }else {
                
            }
                
        })
        .store(in: &self.vmSub)
    }
}


extension MealListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _meals = self.mealVM.resultItem else {
            return 0
        }
        
        return _meals.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var _cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? ListCell
        if _cell == nil {
            _cell = ListCell(style: .default, reuseIdentifier: "cellIdentifier")
        }
        guard let _meal = self.mealVM.resultItem?[indexPath.row] else {
            
            return UITableViewCell()
        }
        
        _cell?.configureCell(withListModel: _meal)
        _cell?.listItemImage.downLoadImageInBackground(withUrl: _meal.imageUrlString)
        return _cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let _meal = self.mealVM.resultItem?[indexPath.row] else {return }
        
        let mealService = MealDetailService(withEndPoint: MealCategoryEnfPoint(withQueryParam: [:], andOperation: .getItemById))
       //
       //        meailService.getMealDetail(forMealId: "52772") { result in
       //
       //            print(result)
       //        }
        
        //make a UIHostingViewControlelr
        
        let mealVM = MealViewModel(withMealMetaData: _meal, andMealService: mealService)
        let  mealDetailViewController = UIHostingController(rootView: MealDetailView(viewModel: mealVM))
        
        mealDetailViewController.navigationController?.title = "Meal Detail"
        self.navigationController?.pushViewController(mealDetailViewController, animated: true)
        
        
    }
    
    
}
