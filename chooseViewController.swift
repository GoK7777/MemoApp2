//
//  chooseViewController.swift
//  12_MemoApp
//
//  Created by 釜木悦子 on 2016/06/25.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit

class chooseViewController: UIViewController {
    
    @IBOutlet var memobutton: UIButton!
    @IBOutlet var audiobutton: UIButton!
    var saveData = NSUserDefaults.standardUserDefaults()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    func buttonTapped(sender: UIButton){
        performSegueWithIdentifier("MemoSegue", sender: memobutton)
    }
    
       
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let memoViewController = segue.destinationViewController as! MemoViewController
        
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
