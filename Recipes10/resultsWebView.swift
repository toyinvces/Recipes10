//
//  resultsWebView.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/6/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class resultsWebView :UIViewController, UIWebViewDelegate {
    
    var recipes = [Recipes]()

    
    var url: String!
    var time: String!
    var name: String!
    var pictureUrl: String!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var resultsWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
        if yummlyNetworking().isConnectedToNetwork() == true {
            
            
            let recipeurl = NSURL(string: "https://www.yummly.com/recipe/\(url)")
            let request = NSURLRequest(URL: recipeurl!)
            resultsWebView.delegate = self
     
            activityIndicator.startAnimating()
            resultsWebView.loadRequest(request)

            
            
        } else {
            
             ViewController().internetAlert()
            
        }
        
        
    }

    @IBAction func cancel(sender: AnyObject) {
       
        self.dismissViewControllerAnimated(true, completion: {});

    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    
    @IBAction func saveRecipe(sender: AnyObject) {
        if yummlyNetworking().isConnectedToNetwork() == true {
            
            saveRecipe()
            
        } else {
            
            ViewController().internetAlert()
            
            
        }

        
    }
    
    
    
    func saveRecipe()  {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Recipes",
            inManagedObjectContext:managedContext)
        
        let recipe = Recipes(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        recipe.setValue(name, forKey: "name")
        recipe.setValue(time, forKey: "time")
        recipe.setValue(url, forKey: "url")
        recipe.setValue(pictureUrl, forKey: "image")
        
        let picUrl = NSURL(string: pictureUrl!)
        let data = NSData(contentsOfURL: picUrl!)
        let image = UIImage(data: data!)
        
       ImageCache().storeImage(image, withIdentifier: name)
        

        
        do {
            try managedContext.save()
            //5
            recipes.append(recipe)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        let alert = UIAlertView(title: nil, message: "Recipe Saved", delegate: self, cancelButtonTitle: "OK")
        alert.show()
    
        
    }
    
    
    
    
    
    
    lazy var sharedContext: NSManagedObjectContext =  {
        return AppDelegate().managedObjectContext
    }()
    
    func saveContext() {
        AppDelegate().saveContext()
        
    }
    

    
           
    
    
    

    
    
    
    
}