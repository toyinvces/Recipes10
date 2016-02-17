//
//  savedRecipes.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/7/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit
import CoreData




class savedRecipes: UITableViewController {
    
    
    var recipes = [Recipes]()
    var name: String!
    
    
    
    var imageUrl: String!

    @IBAction func new(sender: AnyObject) {
        print("new")
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
   
    
    override func viewDidLoad() {
        fetchAllRecipes()
    }

    

    
    override func viewDidAppear(animated: Bool) {
        fetchAllRecipes()
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "savedRecipesViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! savedRecipesViewCell
    
        let recipe = recipes[indexPath.row]
        name = recipe.name
        
        cell.title.text =  name
        cell.imageView?.image = ImageCache().imageWithIdentifier(name)

        
        return cell
    }
    
    
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
            let recipe = recipes[indexPath.row]
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("viewSavedRecipes") as! viewSavedRecipes
            
            viewController.url = recipe.url as String!
            viewController.name = recipe.name as String!
            viewController.time = recipe.time as String!
            viewController.pictureUrl = recipe.image as String!
            self.presentViewController(viewController, animated: true, completion: nil)
        
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let ret = UILabel(frame: CGRectMake(10, 0, self.tableView.frame.width - 30, 32.0))
        ret.backgroundColor = UIColor.clearColor()
        ret.text = "Saved Recipes List"
        ret.textAlignment = NSTextAlignment.Center
        return ret
    }
    

    

    
    func fetchAllRecipes() {//-> [Recipes] {
        
        print("Fetching Timers")
        
        let fetchRequest = NSFetchRequest(entityName: "Recipes")
        
        do {
            let results = try sharedContext.executeFetchRequest(fetchRequest) as! [Recipes]
            
            recipes = results
            
            
        } catch  let error as NSError {
            print("Error in fetchAllRecipes(): \(error)")
        
        }
        
        
        
    }
    
    
    lazy var sharedContext: NSManagedObjectContext =  {
        return AppDelegate().managedObjectContext
    }()
    
    func saveContext() {
        
        AppDelegate().saveContext()
        
    }
    
    
    
    
}
