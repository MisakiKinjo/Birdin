//
//  TabBarController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //タブアイコンの色
        let r1 = CGFloat.random(in: 0 ... 150) / 255.0
        let g1 = CGFloat.random(in: 0 ... 150) / 255.0
        let b1 = CGFloat.random(in: 0 ... 150) / 255.0
        self.tabBar.tintColor = UIColor(red: r1, green: g1, blue: b1, alpha: 1)
        //タブバーの背景色
        let r2 = CGFloat.random(in: 200 ... 255) / 255.0
        let g2 = CGFloat.random(in: 200 ... 255) / 255.0
        let b2 = CGFloat.random(in: 200 ... 255) / 255.0
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(red: r2, green: g2, blue: b2, alpha: 1)
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        // UITabBarControllerDelegateプロトコルのメソッドを処理
        self.delegate = self
    }
    
    //タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController {
            // ImageSelectViewControllerはモーダル遷移
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
        } else {
            //通常のタブ切り替え
            return true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            //ログインしていない時の処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Hello")
            self.present(loginViewController!, animated: true, completion: nil)
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
