//
//  RecipeCell.swift
//  Recipes
//
//  Created by Mayur Nilwant on 17/01/2024.
//

import Foundation
import UIKit


protocol ListCellModel: Codable {
    
    var title: String {get}
    var subTitle: String {get}
    var imageUrlString: String {get}
}

class ListCell: UITableViewCell {
    
    var recipeCategoryImage: UIImageView = {
        
        let cellImageView = UIImageView(frame: CGRectMake(5.0, 5.0, 100.0, 100.0))
        cellImageView.image = UIImage(named: "loading")
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        //cellImageView.circularImage(withBorderWidth: 2.0, andBorderColor: .blue)
        return cellImageView
    }()
                                      
    
    var lblTitle: UILabel = {
        
        let lblTitle = UILabel(frame: CGRectMake(5.0, 5.0, 200, 40.0))
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        return lblTitle
    }()
    
    var lblDescription: UILabel = {
        
        let lblDescription = UILabel(frame: CGRectMake(5.0, 5.0, 200, 40.0))
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
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
        
        NSLayoutConstraint.activate([self.recipeCategoryImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0), self.recipeCategoryImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0), self.recipeCategoryImage.widthAnchor.constraint(equalToConstant: 60.0), self.recipeCategoryImage.heightAnchor.constraint(equalToConstant: 60.0)])
        
        NSLayoutConstraint.activate([self.lblTitle.leadingAnchor.constraint(equalTo: self.recipeCategoryImage.trailingAnchor, constant: 10.0),self.lblTitle.topAnchor.constraint(equalTo: self.recipeCategoryImage.topAnchor, constant: 0.0), self.lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10.0), self.lblTitle.heightAnchor.constraint(equalToConstant: 50.0)])
        
        NSLayoutConstraint.activate([self.lblDescription.leadingAnchor.constraint(equalTo: self.lblTitle.leadingAnchor, constant: 0.0),self.lblDescription.topAnchor.constraint(equalTo: self.lblTitle.topAnchor, constant: 25.0), self.lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0), self.lblDescription.heightAnchor.constraint(equalToConstant: 50.0)])
//
        
    }
    
    // PRAGMA MARK - Custom Function
    
     func configureCell(withListModel model: ListCellModel) {
        
        self.lblTitle.text = model.title
        self.lblDescription.text = model.subTitle
        self.recipeCategoryImage.image = UIImage(named: "loading")
    }
     
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
