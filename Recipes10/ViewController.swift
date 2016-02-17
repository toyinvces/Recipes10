//
//  ViewController.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/3/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var recipes = [Recipes]()

    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    func internetAlert() {
        let alert = UIAlertView(title: nil, message: "No Internet Connection", delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.stopAnimating()
       activity.hidesWhenStopped = true
       
}

    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    
    @IBAction func searchButton(sender: AnyObject) {
        
        if searchText.text == ""{
            
            let alert = UIAlertView(title: nil, message: "No text", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return
            
        } else {
        
       let text: String = searchText.text!
            let newText = text.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            
           print(newText)
            
        self.activity.startAnimating()
          
        yummlyNetworking().searchRecipes(newText) { (matches, success,  error) in
            
            if success{
                
                
                
                let resultesRecipes =  self.storyboard?.instantiateViewControllerWithIdentifier("resultedRecipesTableView") as! resultedRecipesTableView
                resultesRecipes.objects = matches
                self.activity.stopAnimating()
                self.presentViewController(resultesRecipes, animated: true, completion: nil)
                
                
            }else{
                
                self.activity.stopAnimating()
                
                let alert = UIAlertView(title: nil, message: error, delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
                
            }
        
          }
            
        }
        
    }
    
    
    

    
    
    
    
}
