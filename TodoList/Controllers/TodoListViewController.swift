//
//  ViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/4/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

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
        //itemArray[indexPath.row].setValue(true, forKey: "done")
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func saveItems(){
        do{
           try context.save()
            
        }
        catch{
            print("Problem with loading item \(error)")
        }
        self.tableView.reloadData()
    }
    
    // internal, external and default parameters
    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        do {
            itemArray = try context.fetch(request)
        }
        catch{
            print("feching error \(error)")
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // adding data into the item array
            guard textField.text == nil && textField.text != "" else{
                if textField.text != ""{
                    let item = Item(context: self.context)
                    item.title = textField.text!
                    item.done = false
                    self.itemArray.append(item)
                    
                    // stored
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

// MARK: - Search bar methods
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        // case and dicretive in-sensetive
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

