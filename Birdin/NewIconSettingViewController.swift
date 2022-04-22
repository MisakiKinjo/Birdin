//
//  NewIconSettingViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import SVProgressHUD
import CLImageEditor

class NewIconSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {

    //var id : String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func useLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
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
        
        /*let iconRef = Storage.storage().reference().child(Const.iconPath).child(self.id + ".jpg")
        let imageData = image.jpegData(compressionQuality: 0.75)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        iconRef.putData(imageData!, metadata: metadata) { (metadata, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
            }*/
        //　遷移先の画面を開く
        let newNameViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewName") as! NewNameViewController
        newNameViewController.image = image!
        editor.present(newNameViewController, animated: true, completion: nil)
        //}
    }
    
    //CLImageEditorの編集がキャンセルされた時
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        editor.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // UIImagePidkerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func useAvatarButton(_ sender: Any) {
    }
    
    @IBAction func newIcon(_ sefue: UIStoryboardSegue) {
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
