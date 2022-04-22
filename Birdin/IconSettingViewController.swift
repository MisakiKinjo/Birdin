//
//  IconSettingViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import CLImageEditor
import SVProgressHUD

class IconSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    var iconImage: UIImage?

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
            print("DEBUG_PRINT: image = \(image)")
            //CLImageEditorにimageを渡して、加工画面を起動する
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            self.present(editor, animated: true, completion: nil)
            
            
        }
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        
        
        let date:Date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd-HH:mm:ss"
        let sDate = format.string(from: date)
            let iconRef = Storage.storage().reference().child(Const.iconPath).child(Auth.auth().currentUser!.uid + "\(sDate)" + ".jpg")
            let imageData = image.jpegData(compressionQuality: 0.75)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            iconRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                }
                self.iconImage = image
            SVProgressHUD.showSuccess(withStatus: "アイコン画像を変更しました")
        }
        editor.dismiss(animated: true, completion: nil)
    }
    
    func setIconImage(_ postData: PostData) {
        postData.iconImage = self.iconImage
        print("DEBUG_PRINT: iconImageをpostDataに渡しました")
        return
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
    
    @IBAction func useAvatarButton(_ sender: Any) {
    }
    
    @IBAction func iconSetting(_ sefue: UIStoryboardSegue) {
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
