//
//  ImageSelectViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //写真を撮影/選択した時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
        //画像加工処理
        if info[.originalImage] != nil {
            //撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            //CLImageEditorライブラリで加工する
            print("DEBUF_PRINT: image = \(image)")
            //CLImageEditorにimageを渡して、加工画面を起動する
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            self.present(editor, animated: true, completion: nil)
        }
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        //　投稿画面を開く
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image!
        editor.present(postViewController, animated: true, completion: nil)
    }
    //CLImageEditorの編集がキャンセルされた時
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        //画面を閉じる
        editor.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // UIImagePidkerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
