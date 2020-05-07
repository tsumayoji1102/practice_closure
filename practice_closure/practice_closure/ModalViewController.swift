//
//  ModalViewController.swift
//  practice_closure
//
//  Created by 塩見陵介 on 2020/05/08.
//  Copyright © 2020 つまようじ職人. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var modalView: UITableView!
    
    // ここにリストを収める
    var list: Array<String>!
    
    // クロージャー
    var closure: ((Int) -> Void)!
    
    var pickerView: UIPickerView! // ピッカー
    var OKButton:   UIButton!     // ボタン

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Viewの設定
        modalView.delegate   = self
        modalView.dataSource = self
        modalView.separatorStyle  = .none
        modalView.isScrollEnabled = false
        modalView.allowsSelection = false
        modalView.layer.cornerRadius = 10
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // ボタンタップ後
    @objc func tapButton(_ sender: UIButton){
        
        // クロージャで選択したもののインデックス番号を返却
        closure(pickerView.selectedRow(inComponent: 0))
        self.dismiss(animated: true, completion: nil)
    }
}

extension ModalViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セル数
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerViewCell", for: indexPath)
        // ピッカー
        if(indexPath.row == 0){
            pickerView.frame = CGRect(x: 10, y: 10, width: tableView.frame.width - 20, height: 210)
            
            cell.addSubview(pickerView)
        // ボタン
        }else{
            OKButton = UIButton(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 20, height: 50))
            OKButton.backgroundColor = UIColor.systemBlue
            OKButton.layer.cornerRadius = 10
            OKButton.setTitle("OK", for: .normal)
            OKButton.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
            cell.addSubview(OKButton)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // ピッカー
        if(indexPath.row == 0){
            return 230
        // ボタン
        }else{
            return 70
        }
    }
}

extension ModalViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    
}
