//
//  ViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/4/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        for i in 0...30 {
            let newItem = Item()
            newItem.title = "\(i) th item"
            itemArray.append(newItem)
        }
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // how the cell should be displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // adding data into the item array
            guard textField.text == nil && textField.text != "" else{
                if textField.text != ""{
                    
                    let item = Item()
                    item.title = textField.text!
                    self.itemArray.append(item)
                    
                    // stored in plist
                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    
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

}

