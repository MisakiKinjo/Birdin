//
//  SettingViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            displayNameTextField.text = user.displayName
        }
    }
    
    @IBAction func handleCangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {
            
            //表示名が入力されていない時はHUDを出して何もしない
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名を入力して下さい")
                return
            }
            
            //表示名を設定
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequet = user.createProfileChangeRequest()
                changeRequet.displayName = displayName
                changeRequet.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました。")
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    
                    //HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }
        }
        // キーボードを閉じる
        self.view.endEditing(true)
        
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        // ログアウト
        try! Auth.auth().signOut()
        
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Hello")
        self.present(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻る時にホーム(index=0)の状態にする
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func handleEraseDataButton(_ sender: Any) {

                let alert = UIAlertController(
                    title: "ユーザーデータが削除されます",
                    message: "過去の投稿は消えません。",
                    preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(
                    UIAlertAction(
                        title: "キャンセル",
                        style: UIAlertAction.Style.cancel,
                        handler: nil))
                alert.addAction(
                    UIAlertAction(
                        title: "削除",
                        style: UIAlertAction.Style.default, handler: { (action) -> Void in
                            Auth.auth().currentUser?.delete()
                            let helloViewController = self.storyboard?.instantiateViewController(withIdentifier: "Hello")
                            self.present(helloViewController!, animated: true, completion: nil)
                            
                            self.tabBarController?.selectedIndex = 0
                        })
                    
                )
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func setting(_ sefue: UIStoryboardSegue) {
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
