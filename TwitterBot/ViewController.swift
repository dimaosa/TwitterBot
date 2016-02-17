//
//  ViewController.swift
//  TwitterBot
//
//  Created by Osadchy Dima on 2/12/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView! {
        didSet {
            tweetMessage = tweetTextView.text
        }
    }
    
    var tweetMessage: String?
    
    func showAlertMessage(myMessage: String) {
        let alert = UIAlertController(title: "Twitter Share", message: myMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(
            title: "Okay",
            style: .Default,
            handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTweetTextView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func shareTweet(sender: AnyObject) {
        if tweetTextView.isFirstResponder() {
            tweetTextView.resignFirstResponder()
        }
        
        let actionController = UIAlertController(
            title: "New Tweet",
            message: "Tweet your note!",
            preferredStyle: .Alert
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .Cancel,
            handler: nil
        )
        let tweetAction = UIAlertAction(
            title: "Tweet",
            style: .Default){ (action: UIAlertAction) -> Void in
                if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
                    
                    let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    if self.tweetMessage?.characters.count < 140 {
                    twitterVC.setInitialText(self.tweetMessage)
                    } else {
                        twitterVC.setInitialText(self.tweetMessage?.substringToIndex((self.tweetMessage?.characters.startIndex.advancedBy(140))!))
                    }

                    self.presentViewController(twitterVC, animated: true, completion: nil)
                    //TODO - tweet the tweet
                } else {
                    self.showAlertMessage("Please sign into twitter")
                    //notifiy about nothing
                    
                }
                
                
                
        }
        actionController.addAction(cancelAction)
        actionController.addAction(tweetAction)
        presentViewController(actionController, animated: true, completion: nil)
    }

    func configureTweetTextView() {
        tweetTextView.layer.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 0.9, alpha: 1.0).CGColor
        tweetTextView.layer.cornerRadius = 10.0
        tweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        tweetTextView.layer.borderWidth = 2.0
    }

}

