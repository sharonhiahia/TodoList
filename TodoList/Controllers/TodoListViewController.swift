//
//  ViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/4/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        
//        for i in 0...5 {
//            let newItem = Item()
//            newItem.title = "\(i) th item"
//            itemArray.append(newItem)
//        }
        
        // load data here
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
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

        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    private func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }
        catch{
            print("Problem with loading item")
        }
        self.tableView.reloadData()
    }
    
    private func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
                
            }
            catch{
                print("error loading data \(error)")
            }
        }
        
        
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
                    //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    self.saveItems()
                    
                    
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

