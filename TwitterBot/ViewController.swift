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

    @IBOutlet weak var twitterTextView: UITextView!
    @IBOutlet weak var FacebookTextView: UITextView!
    @IBOutlet weak var moreTextView: UITextView!
    
    func showAlertMessage(myMessage: String) {
        let alert = UIAlertController(title: "Share", message: myMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(
            title: "Okey",
            style: .Default,
            handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTweetTextView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func shareOops(sender: AnyObject) {
        showAlertMessage("There is nothing")
    }
    @IBAction func shareMore(sender: AnyObject) {
        if moreTextView.isFirstResponder() {
            moreTextView.resignFirstResponder()
        }
        let moreController = UIActivityViewController(activityItems: [self.twitterTextView.text!], applicationActivities: nil)
        presentViewController(moreController, animated: true, completion: nil)
        
    }
    @IBAction func shareFacebook(sender: AnyObject) {
        if FacebookTextView.isFirstResponder() {
            FacebookTextView.resignFirstResponder()
        }
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)){

            let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookVC.setInitialText("Hello World")
            presentViewController(facebookVC, animated: true, completion: nil)
        }

    }
    @IBAction func shareTweet(sender: AnyObject) {
        if twitterTextView.isFirstResponder() {
            twitterTextView.resignFirstResponder()
        }
        
        let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
            
            if self.twitterTextView.text!.characters.count < 140 {
                twitterVC.setInitialText(self.twitterTextView.text!)
            } else {
                twitterVC.setInitialText(self.twitterTextView.text!.substringToIndex((self.twitterTextView.text.characters.startIndex.advancedBy(140))))
            }
            presentViewController(twitterVC, animated: true, completion: nil)
        } else {
            self.showAlertMessage("Please sign into twitter")
        }
    }

    func configureTweetTextView() {
        twitterTextView.layer.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 0.9, alpha: 1.0).CGColor
        twitterTextView.layer.cornerRadius = 10.0
        twitterTextView.layer.borderColor = UIColor.blackColor().CGColor
        twitterTextView.layer.borderWidth = 2.0
        FacebookTextView.layer.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 0.9, alpha: 1.0).CGColor
        FacebookTextView.layer.cornerRadius = 10.0
        FacebookTextView.layer.borderColor = UIColor.blackColor().CGColor
        FacebookTextView.layer.borderWidth = 2.0
        moreTextView.layer.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 0.9, alpha: 1.0).CGColor
        moreTextView.layer.cornerRadius = 10.0
        moreTextView.layer.borderColor = UIColor.blackColor().CGColor
        moreTextView.layer.borderWidth = 2.0
    }

}

