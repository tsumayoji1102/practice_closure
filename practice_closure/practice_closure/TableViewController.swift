//
//  TableViewController.swift
//  practice_closure
//
//  Created by 塩見陵介 on 2020/05/08.
//  Copyright © 2020 つまようじ職人. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    enum ButtonTag: Int{
        case name = 0,
        sex,
        hobby,
        cake
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle  = .none
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // ボタンタップ時
    @objc func tapButton(_ sender: UIButton){
        
        // モーダル作成
        let ModalVC = self.storyboard?.instantiateViewController(identifier: "ModalViewController") as? ModalViewController
        // トランジションの実装
        ModalVC?.transitioningDelegate = self
        ModalVC?.modalPresentationStyle = .custom
        
        switch sender.tag {
        case ButtonTag.name.rawValue:
            // リスト、クロージャーを設定
            let list = ["田中", "鈴木", "山本", "片山", "剛力"]
            ModalVC?.list = list
            ModalVC?.closure = { index in
                let name = list[index]
                sender.setTitle("名前は\(name)", for: .normal)
            }
            break
        case ButtonTag.sex.rawValue:
            // リスト、クロージャーを設定
            let list = ["男性", "女性"]
            ModalVC?.list = list
            ModalVC?.closure = { index in
                let sex = list[index]
                sender.setTitle("性別は\(sex)", for: .normal)
            }
            break
        case ButtonTag.hobby.rawValue:
            // リスト、クロージャーを設定
            let list = ["釣り", "釣り以外"]
            ModalVC?.list = list
            ModalVC?.closure = { index in
                let sex = list[index]
                sender.setTitle("趣味は\(sex)", for: .normal)
            }
            break
        case ButtonTag.cake.rawValue:
            // リスト、クロージャーを設定
            let list = ["ショートケーキ", "チョコケーキ", "モンブラン"]
            ModalVC?.list = list
            ModalVC?.closure = { index in
                let cake = list[index]
                sender.setTitle("好きなケーキは\(cake)", for: .normal)
            }
            break
        default:
            break
        }
        
        self.present(ModalVC!, animated: true, completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セル作成
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // ボタン作成
        let button = UIButton(frame: CGRect(x: (tableView.frame.width - 250) / 2, y: (cell.frame.height - 50) / 2, width: 250, height: 50))
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)

        // それぞれ変える
        if(indexPath.row == ButtonTag.name.rawValue){
            button.setTitle("名前は：", for: .normal)
            button.tag = ButtonTag.name.rawValue
            
        }else if(indexPath.row == ButtonTag.sex.rawValue){
            button.setTitle("性別は：", for: .normal)
            button.tag = ButtonTag.sex.rawValue
            
        }else if(indexPath.row == ButtonTag.hobby.rawValue){
            button.setTitle("趣味は：", for: .normal)
            button.tag = ButtonTag.hobby.rawValue
            
        }else{
            button.setTitle("好きなケーキは：", for: .normal)
            button.tag = ButtonTag.cake.rawValue
            
        }
        
        cell.addSubview(button)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//　トランジション用


extension TableViewController: UIViewControllerTransitioningDelegate{
    
    // 自動的にモーダル表示ができるように設計
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        // PresentationControllerをかえす
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
