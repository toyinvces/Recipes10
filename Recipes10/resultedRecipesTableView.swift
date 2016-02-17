//
//  resultedRecepiesTableView.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/3/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit

class resultedRecipesTableView : UITableViewController {
    
    
    var cellCount: Int!
    var imageUrl: String!
    var name: String! 
    var searchText: String!
    
    var objects = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

 
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "resultedtableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! resultedtableViewCell
        let object = objects[indexPath.row]
        
        name = object["recipeName"]! as? String
        cell.name?.text = name
        let yummlyImageUrl = object["imageUrlsBySize"] //as! [AnyObject]
        
        imageUrl = yummlyImageUrl!!["90"]! as? String
        
        var url: NSURL!
        
        if imageUrl.isEmpty {
            
            print("NO PICTURE")
            url = NSURL(string: "http://s.yumm.ly/yummly-website/0b9baf11c266a6ed351dc23c81b8774d753e9c50/img/yummly.png")
            
        } else{
        
        url = NSURL(string: imageUrl)
            
        }
        print(url)
        let data = NSData(contentsOfURL: url!)
        
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = objects[indexPath.row]
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("resultsWebView") as! resultsWebView
        viewController.url = object["id"]! as? String
        viewController.name = object["recipeName"]! as? String
        viewController.time = String(object.objectForKey("totalTimeInSeconds"))
        
        
        let yummlyImageUrl = object["imageUrlsBySize"] //as! [AnyObject]
        imageUrl = yummlyImageUrl!!["90"]! as? String
        viewController.pictureUrl = imageUrl
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let ret = UILabel(frame: CGRectMake(10, 0, self.tableView.frame.width - 30, 32.0))
        ret.backgroundColor = UIColor.clearColor()
        ret.text = " "
        ret.textAlignment = NSTextAlignment.Center
        return ret
    }

    
    
    
}
