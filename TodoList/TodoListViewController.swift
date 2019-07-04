//
//  ViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/4/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    let itemArray = ["A","B","C","D","E"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            print(itemArray[indexPath.row] + " deselected")
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print(itemArray[indexPath.row] + " selected")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    

}

