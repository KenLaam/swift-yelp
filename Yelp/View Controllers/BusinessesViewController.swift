//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = UITableViewAutomaticDimension
        restaurantTableView.estimatedRowHeight = 100
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantTableView.reloadData()
                
            }
        }
        
        // Example of Yelp search with more search options specified
        /*
         Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
         if let businesses = businesses {
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         }
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let filterVC = navController.topViewController as! FilterViewController
        filterVC.delegate = self
    }
    
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        cell.business = businesses[indexPath.row]
        return cell
        
    }
}

extension BusinessesViewController: FilterViewControllerDelegate {
    func filterViewController(filterViewController: FilterViewController, categories: [String], deal: Bool) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "Thai", sort: nil, categories: categories, deals: deal) { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantTableView.reloadData()
                
            }
        }
    }
}
