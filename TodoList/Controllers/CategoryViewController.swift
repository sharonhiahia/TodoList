//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Rong Xiao on 7/5/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    // Class constants and variables
    var categories : Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    // how the cell should be displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet :)"
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else{
            print("indexPath is nil when preparing for segue")
            return
        }
        destinationVC.selectedCategory = categories?[indexPath.row]
    }
    
    
    // MARK: - Data Manipulation Methods
    private func saveCategories(with category: Category){
        do{
            try realm.write {
                realm.add(category)
                print("\(category.name) added")
            }
        }
        catch{
            print("Problem with saving category \(error)")
        }
        tableView.reloadData()
    }
    
    private func loadCategories(){
        print("loading categories")
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let category = Category()
            category.name = textField.text!
            // stored
            self.saveCategories(with: category)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat a new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }

}
