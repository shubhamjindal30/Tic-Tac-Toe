//
//  TableViewController.swift
//  Tic Tac Toe
//
//  Created by Shubham Jindal on 10/04/18.
//  Copyright © 2018 sjc. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //Local variables to load data in table view
    var winnings: [String]!
    var mode: [String]!
    var images: [UIImage?]!
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Load data from shared variables to local variables
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        winnings = appDelegate.winnings
        mode = appDelegate.mode
        images = appDelegate.images
        
        //Reload table when data is changed
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winnings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = winnings[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        cell.detailTextLabel?.text = mode[indexPath.row]
        return cell
    }
}
