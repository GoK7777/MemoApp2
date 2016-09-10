//
//  MemoViewController.swift
//  12_MemoApp
//
//  Created by FurukawaSoichi on 2016/03/12.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var memoimageView: UIImageView!
    
    var saveData : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var memoNumber : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               let appFrame = UIScreen.mainScreen().bounds.size
        var accessoryView = UIView(frame: CGRectMake(0, 0, appFrame.width, 44))
        
        accessoryView.backgroundColor = UIColor.whiteColor()
        
        
        //完了ボタンを実装
    
        var closeButton = UIButton(frame: CGRectMake(appFrame.width-120, 0, 100, 30))
        closeButton.setTitle("完了", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        closeButton.addTarget(self, action: "onClickCloseButton:", forControlEvents: .TouchUpInside)
        accessoryView.addSubview(closeButton)
        contentTextView.inputAccessoryView = accessoryView

        
        titleTextField.text = saveData.objectForKey("title\(memoNumber)") as! String?
        contentTextView.text = saveData.objectForKey("content\(memoNumber)") as! String?
        

        if (saveData.objectForKey("memoImage\(memoNumber)") != nil ) {
            memoimageView.image = UIImage(data: saveData.objectForKey("memoImage\(memoNumber)") as! NSData)
            print(memoimageView.image!.imageOrientation)
            
        }
        
        titleTextField.delegate = self
        
//        print(memoNumber)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //写真を選ぶ
    @IBAction func selectBG(sender: AnyObject) {
        
        let alert = UIAlertController(
            title: "写真",
            message: "",
            preferredStyle: UIAlertControllerStyle.Alert
            )
        alert.addAction(
            UIAlertAction(
            title: "写真を撮る",
            style: UIAlertActionStyle.Default,
                handler: {action in
                    self.pickImageFromCamera()
                }
                ))
        alert.addAction(
            UIAlertAction(
                title: "写真を選ぶ",
                style: UIAlertActionStyle.Default,
                    handler: { action in
                        let imagePickerController: UIImagePickerController = UIImagePickerController()
                        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                        imagePickerController.delegate = self
                        imagePickerController.allowsEditing = true
                        self.presentViewController(imagePickerController, animated: true, completion: nil)
                    }
                    )
        )
        
        alert.addAction(
        UIAlertAction(
            title: "キャンセル",
            style: UIAlertActionStyle.Default,
            handler: { action in
//                print("Cancel")
            }
            )
        )
        
                presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //写真を撮る
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            controller.allowsEditing = true
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }

    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memoimageView.contentMode = .ScaleAspectFit
           memoimageView.image = pickedImage
            
         //imageViewの設定
           // let radian : Double = -90 * M_PI/180
          // memoimageView.transform = CGAffineTransformMakeRotation (CGFloat(radian))
            

            memoimageView.image = resizeImage(memoimageView.image!, width: memoimageView.frame.width , height: memoimageView.frame.height)
           
        }
        
        
        
        //閉じる処理
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
//        loadView()
    }
    
    
    //imageViewの設定の詳細
    func resizeImage(image: UIImage,width: CGFloat, height: CGFloat) -> UIImage {
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
      
    }
    
    
    @IBAction func saveMemo(sender: AnyObject) {
        
        saveData.setObject(titleTextField.text, forKey: "title\(memoNumber)")
        saveData.setObject(contentTextView.text, forKey: "content\(memoNumber)")
        
        
         if(memoimageView.image != nil) {
            let imageData = UIImagePNGRepresentation(memoimageView.image!)
            //          saveData.setObject(memoimageView.image, forKey: "memoImage\(memoNumber)")
            saveData.setObject(imageData, forKey: "memoImage\(memoNumber)")
            
            saveData.synchronize()
           }
        
        if(titleTextField.text == nil) {
            saveData.setObject(titleTextField, forKey: "title\(memoNumber)")
            
        }
        
        let alert = UIAlertController(title: "保存", message: "保存できました", preferredStyle: UIAlertControllerStyle.Alert)
        
        //OKを出す
        alert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {action in
                //ボタンが押されたときの動作
                self.navigationController?.popViewControllerAnimated(true)
                print("OKボタンが押されました")
            }
            )
        )
        
        
        
        presentViewController(alert, animated: true, completion: nil)
        

}
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        print(memoimageView.image!.imageOrientation)

    }
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func onClickCloseButton(sender: UIButton) {
        contentTextView.resignFirstResponder()
    }
    


}
