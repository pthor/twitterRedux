//
//  HambergerViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/25/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class HambergerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressImage: UIImageView!
    
    var originalLeftMargin: CGFloat!
    
    var contentViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            
            if oldContentViewController != nil{
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)

            }
            
            contentViewController.willMoveToParentViewController(self)
            //contentView.subviews.last?.removeFromSuperview()
            contentView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
            contentViewController.view.frame = self.contentView.bounds
            
            closeMenu()

        }
    }
    
    var menuViewController: MenuViewController!{
        didSet{
            view.layoutIfNeeded()
            
            menuView.addSubview(menuViewController.view)
            menuViewController.view.frame = self.contentView.bounds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            originalLeftMargin = leftMarginConstraint.constant
        }
        else if sender.state == UIGestureRecognizerState.Changed{
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        }
        else if sender.state == UIGestureRecognizerState.Ended{
            
            UIView.animateWithDuration(0.3, animations:{
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - (self.view.frame.size.width/2)
                }else{
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func closeMenu(){
        UIView.animateWithDuration(0.3, animations:{
            self.leftMarginConstraint.constant = 0
            self.view.layoutIfNeeded()
        })

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
