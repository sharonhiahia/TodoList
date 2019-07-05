//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/5/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    // Class constants and variables
    var categoryArray = [Category]()
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()


    }

    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    // how the cell should be displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        //cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        //categoryArray[indexPath.row].done = !categoryArray[indexPath.row].done
        //itemArray[indexPath.row].setValue(true, forKey: "done")
        //saveCategories()
        //tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else{
            print("indexPath is nil when preparing for segue")
            return
        }
        destinationVC.selectedCategory = categoryArray[indexPath.row]
    }
    
    // MARK: - Data Manipulation Methods
    private func saveCategories(){
        do{
            try context.save()
            
        }
        catch{
            print("Problem with saving category \(error)")
        }
        tableView.reloadData()
    }
    
    private func loadCategories(with request : NSFetchRequest<Category>  = Category.fetchRequest() ){
        
        do {
            categoryArray = try context.fetch(request)
        }
        catch{
            print("feching error \(error)")
        }
        
        // !!!reload is important
        tableView.reloadData()
    }
    
    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            // adding data into the categoryArray
            guard textField.text == nil && textField.text != "" else{
                if textField.text != ""{
                    let category = Category(context: self.context)
                    category.name = textField.text!
                    self.categoryArray.append(category)
                    
                    // stored
                    self.saveCategories()
                }
                return
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat a new category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    
    }
    



}
