//
//  RestaurantCell.swift
//  Yelp
//
//  Created by Ken Lâm on 10/23/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class RestaurantCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet{
            if business.imageURL != nil{
                thumbImageView.setImageWith(business.imageURL!)
            }
            
            if business.ratingImageURL != nil{
                ratingImageView.setImageWith(business.ratingImageURL!)
            }
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            
            reviewCountLabel.text = String(describing: business.reviewCount!)
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
