//
//  NewNameViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseFirestore
import SVProgressHUD

class NewNameViewController: UIViewController {
    
    var image: UIImage!
    let userIcon = UserIcon.shared
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImage.image = userIcon.icon
        image = iconImage.image
        iconImage.layer.cornerRadius = iconImage.frame.size.width * 0.5
                iconImage.clipsToBounds = true
    }
    
    @IBAction func handleSignUpButton(_ sender: Any) {
        
        
        
        
        //表示名を設定する
        let user = Auth.auth().currentUser
        let displayName = nameTextField.text
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            changeRequest.commitChanges { error in
                if let error = error {
                    //プロフィールの更新でエラーが発生
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました。")
                    return
                }
                print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                SVProgressHUD.showSuccess(withStatus: "登録しました")
                // HUDを消す
                SVProgressHUD.dismiss()
                
                //　画面を閉じてタブ画面に戻る
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                //self.dismiss(animated: true, completion: nil)
            }
        }
        
        let imageData = image.jpegData(compressionQuality: 0.75)
        /*let date:Date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd-HH:mm:ss"
        let sDate = format.string(from: date)*/
        let iconRef = Storage.storage().reference().child(Const.iconPath).child(Auth.auth().currentUser!.uid + ".jpg")
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        iconRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        // 画像のアップロード失敗
                        print(error!)
                        print("DEBUG_PRINT: " + error!.localizedDescription)
                        SVProgressHUD.showError(withStatus: "アイコンの登録に失敗しました")
                        // 投稿処理をキャンセルし、先頭画面に戻る
                       //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        return
                    }
            /*let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
            postViewController.iconImage = self.image*/
            self.userIcon.icon = self.image
                                // HUDで完了を表示する
                    SVProgressHUD.showSuccess(withStatus: "登録しました")
                    // 投稿処理が完了したので先頭画面に戻る
                  self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
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
