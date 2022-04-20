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
    
    var localImageURL: NSURL?

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
            
            self.localImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        }
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        
        let user = Auth.auth().currentUser
        if user == user {
            /*let document: QueryDocumentSnapshot
            let iconRef = Storage.storage().reference().child(Const.iconPath).child(document.documentID + ".jpg")
            let imageData = image.jpegData(compressionQuality: 0.75)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            iconRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                }*/
            let changeRequest = user!.createProfileChangeRequest()
            changeRequest.photoURL = localImageURL as URL?
            changeRequest.commitChanges { error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: "アイコン画像の変更に失敗しました。")
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: 画像の変更に成功しました。")
                
                //HUDで完了を知らせる
                SVProgressHUD.showSuccess(withStatus: "アイコン画像を変更しました")
            }
        }
        //　遷移先の画面を開く
        //let settingViewController = self.storyboard?.instantiateViewController(withIdentifier: "Setting") as! SettingViewController
        //settingViewController.image = image!
        //SVProgressHUD.showSuccess(withStatus: "変更しました")
        //editor.present(settingViewController, animated: true, completion: nil)
        editor.dismiss(animated: true, completion: nil)
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
