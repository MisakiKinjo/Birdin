//
//  PostViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import FirebaseFirestore
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image: UIImage!
    var iconImage: UIImage!
    let userIcon = UserIcon.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 受け取った画像をImageViewに設定
        imageView.image = image
        iconImageView.image = userIcon.icon
        iconImage = iconImageView.image
        
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width * 0.5
        iconImageView.clipsToBounds = true
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        //画像をJPEG形式に変換する
        let imageData = image.jpegData(compressionQuality: 0.75)
        //画像と投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        let postIconRef = Storage.storage().reference().child(Const.iconPath).child(postRef.documentID + Auth.auth().currentUser!.uid + ".jpg")
        let data = iconImage.jpegData(compressionQuality: 0.75)
        
        // HUDで投稿処理中の表示を開始
                SVProgressHUD.show()
        // Storageに画像をアップロードする
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        postIconRef.putData(data!, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        return
                    }            
                }
        imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        // 画像のアップロード失敗
                        print(error!)
                        SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                        // 投稿処理をキャンセルし、先頭画面に戻る
                       self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        return
                    }
                    // FireStoreに投稿データを保存する
                    let name = Auth.auth().currentUser?.displayName
                    let postDic = [
                        "name": name!,
                        "caption": self.textField.text!,
                        "date": FieldValue.serverTimestamp(),
                        ] as [String : Any]
                    postRef.setData(postDic)
            
                    // HUDで投稿完了を表示する
                    SVProgressHUD.showSuccess(withStatus: "投稿しました")
                    // 投稿処理が完了したので先頭画面に戻る
                  self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
