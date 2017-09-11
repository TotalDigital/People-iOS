//
//  test2ViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 01/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {
 
    @IBOutlet weak var label: UILabel!
    
}


class test2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UITableView!
    
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    
        
        navigationItem.titleView = searchBar
           self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "PEOPLE YOU MAY KNOW"
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell")! as! testTableViewCell;
      
            let row = indexPath.row
            cell.label?.text = "coucou"
        
        return cell;
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("coucou1")
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("coucou2")
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("coucou3")
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("coucou4")
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*filtered = [users[0]]
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }*/
        searchActive = false;
        self.tableView.reloadData()
    }
}
