//
//  ViewController.swift
//  OCTokenSDKDemo
//
//  Created by zy on 2020/10/14.
//

import UIKit
import OCTokenSDK

class ViewController: UIViewController {
    var listTableView:UITableView!
    var rowData:[String] = ["授权","充值","提现"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    private func initUI(){
        listTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        listTableView.tableFooterView = UIView()
        listTableView.rowHeight = 44
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "table")
        self.view.addSubview(listTableView)
    }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "table", for: indexPath)
        cell.textLabel?.text = rowData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            OCTokenManager.startOAuth()
        }
        if indexPath.row == 1{
            OCTokenManager.startRecharge(withChargeAmount: 10.0123, andOrderNum: "asdfasdfjkkka1232")
        }
        if indexPath.row == 2{
            OCTokenManager.startWithdraw(withTargetWallet: "b63185d613c2e3c7acad57431946ceb22cd149fd")
        }
    }
}
