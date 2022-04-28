//
//  NewAccountViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import SVProgressHUD

class NewAccountViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //次へボタン
    @IBAction func handleNextButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            //アドレスとパスワードのいずれかでも入力されていない場合
            if address.isEmpty || password.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
            //HUDで処理中を表示
            SVProgressHUD.show()
            
            //ユーザー作成に成功するとログイン
            Auth.auth().createUser(withEmail: address, password: password) { authResult, error in
                if let error = error {
                    //エラーがあったら原因をprintしてreturn
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                let newIconSettingViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewIconSetting") as! NewIconSettingViewController
                self.present(newIconSettingViewController, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func newAccount(_ sefue: UIStoryboardSegue) {
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
