//
//  TableViewController.swift
//  12_MemoApp
//
//  Created by FurukawaSoichi on 2016/03/12.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   

    @IBOutlet var tableView :UITableView!
    @IBOutlet var backButton : UIButton!
    
    var saveData = NSUserDefaults.standardUserDefaults()
    var cellNumber : Int!
    

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        func back (segue:UIStoryboard){
            print("back")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Table Viewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    //各セルの要素を設定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
          // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
//        let img = UIImage(named:"\(imgArray[indexPath.row])")
//        Tag番号 1 で UIImageView インスタンスの生成
//        let imageView = table.viewWithTag(1) as! UIImageView
//        imageView.image = img
        
        
        // Tag番号 1 で UILabel インスタンスの生成
        let label1 = table.viewWithTag(1) as! UILabel
//        label1.text = "No.\(indexPath.row + 1)"
        label1.text = saveData.objectForKey("title\(indexPath.row)") as! String?
        
//        print(saveData.objectForKey("title\(indexPath.row)"))
//        print("tableView cell = ",indexPath.row)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    func back (segue:UIStoryboardSegue){
        print("back")
    }

    
    
            
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest = segue.destinationViewController as! MemoViewController
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        dest.memoNumber = indexPath.row
        
        
        //let memoViewController = self.storyboard!.instantiateViewControllerWithIdentifier("memoView") as! UIViewController
        print(saveData.objectForKey("title\(indexPath.row)") as! String?)
        
       if saveData.objectForKey("title\(indexPath.row)") as! String? == nil   {
        
           let ChooseViewController: chooseViewController = storyboard!.instantiateViewControllerWithIdentifier("ChooseVC") as! chooseViewController
           self.presentViewController(ChooseViewController, animated: true, completion: nil)
        
            print("save data is nil")
        
        }
       else{
            let dest = segue.destinationViewController as! MemoViewController

        }
        
        
       if saveData.objectForKey("content\(indexPath.row)") != nil   {
            var ChooseViewController: chooseViewController = storyboard!.instantiateInitialViewController() as! chooseViewController
            self.presentViewController(ChooseViewController, animated: true, completion: nil)
        }else{
            let memoViewController = segue.destinationViewController as! MemoViewController

        }
        if saveData.objectForKey("memoImage\(indexPath.row)") != nil   {
            var ChooseViewController: chooseViewController = storyboard!.instantiateInitialViewController() as! chooseViewController
            self.presentViewController(ChooseViewController, animated: true, completion: nil)
        }else{
            let memoViewController = segue.destinationViewController as! MemoViewController

        }


        
        
          }
    
}
