//
//  ThirdViewController.swift
//  test
//
//  Created by arisa isshiki on 2018/02/26.
//  Copyright © 2018年 alisa. All rights reserved.
//

import UIKit
class ThirdViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    
    var saveData: UserDefaults = UserDefaults.standard
    var filter5: CGFloat = 1.0
    
    
    //画像加工するフィルターの宣言
    var filter: CIFilter!
    //画像加工するための元となる画像
    var originalImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  filter5 = (saveData.object(forKey: "kazu") as? CGFloat)!
        
    }
    
    //撮影する時のメゾット
    @IBAction func useCamera(){
        //カメラが使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //カメラ起動
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }else{
            //カメラが使えないときはエラーがコンソールに
            print("error")
        }
    }
    //カメラ、カメラロールを使った時に選択した画像をアプリ内に表示する為のメゾット
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        originalImage = cameraImageView.image
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func filter1Slider5(sender: UISlider){
        filter5 = CGFloat(sender.value)
        print(filter5)
        let filterImage: CIImage = CIImage(image: originalImage)!
         let test = sender.value
        
        
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        //彩度の調整
        filter.setValue(filter5, forKey: "inputSaturation")
        //明度の調整
        filter.setValue(0.5, forKey: "inputBrightness")
        //コントラストの調整
        filter.setValue(2.5, forKey: "inputContrast")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
       // let test = sender.value
        if (test == sender.minimumValue){
            testLabel.text = "最小値になりました。\(test)"
        } else if (test == sender.maximumValue) {
            testLabel.text = "最大値になりました。\(test)"
        } else {
            testLabel.text = "\(test)"
        }
        
        
    }
    
    
    //編集した画像保存
    @IBAction func make(){
        
        //UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        saveData.set(filter5 ,forKey: "kazu")
        //alertだす
        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存完了", preferredStyle: .alert)
        
        //okボタン
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: { action in
                //print("OKボタンが押されました")
                //self.navigationController?.popViewController(animated: true)
        }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    
    //カメラロールにある画像を読み込む
    @IBAction func openAlbum(){
        //カメラロールを使えるか
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //カメラロールの画像を選択して画像を表示
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
        // self.ImageView.removeFromSuperview()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

