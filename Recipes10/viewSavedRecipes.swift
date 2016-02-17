//
//  viewSavedRecipes.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/8/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import AVFoundation


class viewSavedRecipes: UIViewController, UIWebViewDelegate {
    
    
    var url: String!
    var time: String!
    var name: String!
    var pictureUrl: String!
    var binaryCount = 10
    var timeValue: String!
    var bgMusic:AVAudioPlayer = AVAudioPlayer()
    var counter = NSTimer()
    var seconds = 59
    
    
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var recipeName: UILabel!
    
    @IBAction func Start(sender: AnyObject) {
        setTimer()
    }
    
    @IBAction func Stop(sender: AnyObject) {
        stopCounter()
        
    }
    
    
    override func viewDidLoad() {
        startLabel.hidden = true
        recipeName.text = name
        
        activityView.hidesWhenStopped = true
        
        if yummlyNetworking().isConnectedToNetwork() == true {
            
            let recipeurl = NSURL(string: "https://www.yummly.com/recipe/\(url)")
            let request = NSURLRequest(URL: recipeurl!)
            webView.delegate = self
            activityView.startAnimating()
            webView.loadRequest(request)
            
        } else {
            
           ViewController().internetAlert()
        }
        
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityView.stopAnimating()
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    
    
    func startCounter(){
 
            
            binaryCount = (Int(timeValue)!) - 1
        
        
        counter = NSTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(counter, forMode: NSRunLoopCommonModes)
      
    }
    
    func countUp() {
        startButton.hidden = true
        startLabel.hidden = false
        
        seconds--
        
        startLabel.text = "\(binaryCount) : \(seconds)"
   
        if seconds == 0 {

            seconds = 59
            binaryCount--
           
        }
        
        if seconds < 10{
            startLabel.text = "\(binaryCount) : 0\(seconds)"
        }
        
        
        if (binaryCount == 0) && (seconds == 0){
            playAlarm()
            stopCounter()
        }
   
        
    }


    func stopCounter(){
        counter.invalidate()
        timeValue = nil
        
        startButton.hidden = false
        startLabel.hidden = true
    }
    
    
    func setTimer(){
        
        
        let alertController = UIAlertController(title: "Please enter your time", message: "(in minutes)", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Start", style: .Default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                
                self.timeValue = field.text
                print(self.timeValue)
                self.startCounter()

            } else {
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.keyboardType = .NumberPad
            textField.textAlignment = .Center
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func playAlarm(){
        let bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("bell", withExtension: "mp3")!
        do { bgMusic = try AVAudioPlayer(contentsOfURL: bgMusicURL, fileTypeHint: nil) }
        catch { return }
        bgMusic.numberOfLoops = 1
        bgMusic.prepareToPlay()
        bgMusic.play()
        timerDone()
        
    }
    
    
    func timerDone(){
        
        let alert = UIAlertController(title: "Timer Done", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { action in
            
            self.bgMusic.stop()
            }))

        self.presentViewController(alert, animated: true, completion: nil)

        
    }
    
    
    
    
    
    
    
    
    
    
}