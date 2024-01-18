//
//  RecipeCell.swift
//  Recipes
//
//  Created by Mayur Nilwant on 17/01/2024.
//

import Foundation
import UIKit


class RecipeCell: UITableViewCell {
    
    
    var recipeCategoryImage: UIImageView = {
        
        let cellImageView = UIImageView(frame: CGRectMake(5.0, 5.0, 100.0, 100.0))
        cellImageView.image = UIImage(named: "loading")
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        return cellImageView
    }()
                                      
    
    var lblTitle: UILabel = {
        
        let lblTitle = UILabel(frame: CGRectMake(5.0, 5.0, 200, 40.0))
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    var lblDescription: UILabel = {
        
        let lblDescription = UILabel(frame: CGRectMake(5.0, 5.0, 200, 40.0))
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        return lblDescription
    }()
    
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(recipeCategoryImage)
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(lblDescription)
        
//        self.recipeCategoryImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
//        self.recipeCategoryImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
//        self.recipeCategoryImage.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
//        self.recipeCategoryImage.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        NSLayoutConstraint.activate([self.recipeCategoryImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0), self.recipeCategoryImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0), self.recipeCategoryImage.widthAnchor.constraint(equalToConstant: 75.0), self.recipeCategoryImage.heightAnchor.constraint(equalToConstant: 75.0)])
        
        NSLayoutConstraint.activate([self.lblTitle.leadingAnchor.constraint(equalTo: self.recipeCategoryImage.trailingAnchor, constant: 10.0),self.lblTitle.topAnchor.constraint(equalTo: self.recipeCategoryImage.topAnchor, constant: 10.0), self.lblTitle.widthAnchor.constraint(equalToConstant: 200.0), self.lblTitle.heightAnchor.constraint(equalToConstant: 50.0)])
        
        NSLayoutConstraint.activate([self.lblDescription.leadingAnchor.constraint(equalTo: self.lblTitle.leadingAnchor, constant: 0.0),self.lblDescription.topAnchor.constraint(equalTo: self.lblTitle.topAnchor, constant: 25.0), self.lblDescription.widthAnchor.constraint(equalToConstant: 2000), self.lblDescription.heightAnchor.constraint(equalToConstant: 50.0)])
//
        
    }
    
    // PRAGMA MARK - Custom Function
    
     func configureCell(withRecipe recipe: Recipe ) {
        
        self.lblTitle.text = recipe.categoryName
        self.lblDescription.text = recipe.categoryDescription
        self.recipeCategoryImage.image = UIImage(named: "loading")
    }
     
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
