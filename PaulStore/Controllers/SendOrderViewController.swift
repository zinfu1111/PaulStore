//
//  SendOrderViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/29.
//

import UIKit

class SendOrderViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var lineIDTextField: UITextField!
    @IBOutlet weak var FBIDTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    private var order = Order()
    var productData = [Product.List.Record]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "寄件資訊"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sendButton.layer.cornerRadius = sendButton.frame.height/2
    }
    
    @IBAction func sendData(_ sender: UIButton) {
        
        checkSendFormatter()
        
        let createRecords = OrderManager.shared.addOrder(by: productData, name: nameTextField.text!, phone: phoneTextField.text!, address: addressTextField.text!, lineId: lineIDTextField.text!, fbId: FBIDTextField.text!, email: EmailTextField.text!)
        
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.string(from: Date())
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        
        
        if let createData = try? encoder.encode(Order.Create(records: createRecords)) {
            
            order.sendRequest(body: createData, method: .post, reponse: Order.List.self) { result in
                switch result {
                case .success(_):
                    self.showAlert(title: "申請購買已完成")
                case .failure(let error):
                    self.showAlert(title: "錯誤",msg: error.localizedDescription)
                }
            }
        }
        
    }
    
    private func checkSendFormatter(){
        guard !nameTextField.text!.isEmpty,
              !phoneTextField.text!.isEmpty,
              !addressTextField.text!.isEmpty,
              !FBIDTextField.text!.isEmpty,
              !creditTextField.text!.isEmpty
        else{
            showAlert(title: "資料尚未填寫完畢")
            return
        }
    }
    
    
}
