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
    var searchBar: UISearchBar!
    
    var businesses: [Business]!
    var keyword: String!
    var categories = [String]()
    var offerDeal: Bool!
    var sortMode: Int!
    var distance: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init search bar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        //init restaurant table view
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = UITableViewAutomaticDimension
        restaurantTableView.estimatedRowHeight = 100
        
        initData()
        // fetch data
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: keyword) { (businesses: [Business]?, error: Error?) in
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
    
    func initData() {
        keyword = "Thai"
        offerDeal = nil
        sortMode = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let filterVC = navController.topViewController as! FilterViewController
        filterVC.delegate = self
    }
    
    func doSearch(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: keyword, sort: sortMode, categories: categories, deals: offerDeal, distance: distance) { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantTableView.reloadData()
            }
        }
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
    func filterViewController(filterViewController: FilterViewController, categories: [String], deal: Bool, distance: Double, sortMode: Int) {
        self.categories = categories
        self.offerDeal = deal
        self.distance = distance
        self.sortMode = sortMode
        doSearch()
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        keyword = searchBar.text
        doSearch()
    }

}
