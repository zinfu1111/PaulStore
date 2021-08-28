//
//  OrderViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import UIKit

class OrderViewController: UITableViewController {
    
    @IBOutlet weak var emptyRstaurantView:UIView!
    
    private var orderData = [String:Int]()
    private var product = Product()
    private var productData = Product.List(records: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = emptyRstaurantView
        tableView.backgroundView?.isHidden = true
        product.sendRequest(method: .get, reponse: Product.List.self, completion: setupProductData(result:))
    }
    
    func setupProductData(result: Result<Product.List,Error>) {
        switch result {
        case .success(let data):
            self.productData = data
            self.orderData = OrderManager.shared.list
            DispatchQueue.main.async {
                if self.orderData.count > 0 {
                    self.tableView.backgroundView?.isHidden = true
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
                } else {
                    self.tableView.backgroundView?.isHidden = false
                    self.tableView.separatorStyle = .none
                }
            }
        case .failure(let error):
            print("product.sendRequest failure \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderData.keys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
