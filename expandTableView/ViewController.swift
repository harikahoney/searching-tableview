//
//  ViewController.swift
//  expandTableView
//
//  Created by Sagi Harika on 03/01/20.
//  Copyright © 2020 Sagi Harika. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    var tollywood = ["prabhas","maheshbabu","alluarjun","anushka","trisha","samantha"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var sc:UISearchController!
    var rc:UIRefreshControl!
    var filteredArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
        
        tableView.dataSource = self
        tableView.delegate = self
       
         sc = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = sc.searchBar
        sc.searchResultsUpdater = self
        sc.searchBar.placeholder="SEARCH HERE"
        sc.searchBar.showsBookmarkButton=true
        sc.searchBar.showsCancelButton=true
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if(sc.isActive==true)
        {
            return filteredArray.count
        }
        else
        {
            return tollywood.count
        }
         
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
        cell.textLabel?.text=tollywood[indexPath.row]
        
        if(sc.isActive==true)
        {
            cell.textLabel?.text=filteredArray[indexPath.row]
        }
        else
        {
            cell.textLabel?.text=tollywood[indexPath.row]
        }
        return cell
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        print("user is searching for \(searchController.searchBar.text!)")
        var predicateObj = NSPredicate(format: "self contains[c]%@",searchController.searchBar.text!)
        filteredArray = (tollywood as NSArray).filtered(using: predicateObj)  as! [String]
        print(filteredArray)
        tableView.reloadData()
        
    }
    
    
}

