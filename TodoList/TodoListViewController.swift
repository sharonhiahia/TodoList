//
//  ViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/4/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = ["A","B","C","D","E"]
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
            print(itemArray[indexPath.row] + " deselected")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // adding data into the item array
            guard textField.text == nil && textField.text != "" else{
                if textField.text != ""{
                    self.itemArray.append(textField.text!)
                    self.tableView.reloadData()
                }
                return
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat a new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    

}

