//
//  OrderViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var emptyRstaurantView:UIView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var checkButton: UIButton!
    
    
    private var orderData = [String:Int]()
    private var product = Product()
    private var productData = Product.List(records: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        tableView.backgroundView = emptyRstaurantView
        tableView.backgroundView?.isHidden = true
        product.sendRequest(method: .get, reponse: Product.List.self, completion: setupProductData(result:))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "購物車"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.checkButton.layer.cornerRadius = self.checkButton.frame.height / 2
    }
    
    func setupProductData(result: Result<Product.List,Error>) {
        switch result {
        case .success(let data):
            self.productData = data
            self.orderData = OrderManager.shared.list
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        case .failure(let error):
            print("product.sendRequest failure \(error.localizedDescription)")
        }
    }

    @IBAction func onCheck(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(SendOrderViewController.self)") as! SendOrderViewController
        vc.productData = self.productData.records
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - Table view data source

extension OrderViewController:UITableViewDataSource,UITableViewDelegate{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.orderData.keys.count > 0 {
            self.tableView.backgroundView?.isHidden = true
            self.checkButton.isHidden = false
        } else {
            self.tableView.backgroundView?.isHidden = false
            self.checkButton.isHidden = true
        }
        return orderData.keys.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderCell.self)", for: indexPath) as! OrderCell

        // Configure the cell...
        let productId = Array(orderData.keys)[indexPath.row]
        let quantity = orderData[productId]
        guard let product = productData.records.first(where: {$0.id == productId}) else {
            
            cell.notfoundProduct()
            return cell
            
        }
        cell.set(for: product, quantity: quantity ?? 1)
        print("[OrderViewController] cellData index\(indexPath.row)",orderData,product)

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { action, view, completion in
            let productId = Array(self.orderData.keys)[indexPath.row]
            self.orderData.removeValue(forKey: productId)
            OrderManager.shared.list.removeValue(forKey: productId)
            self.tableView.reloadData()
            completion(true)
        }
        deleteAction.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
    }
}
