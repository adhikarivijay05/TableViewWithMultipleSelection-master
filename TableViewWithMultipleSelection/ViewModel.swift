//
//  ViewModel.swift
//  TableViewWithMultipleSelection
//
//  Created by Stanislav Ostrovskiy on 5/22/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import UIKit

let dataArray1 = [Model(title: "Foxtel Access - loyalty rewards", isSelected: true), Model(title: "Tips, Tricks and Community updates", isSelected: false), Model(title: "Special offers from Foxtel", isSelected: false), Model(title: "Product and Channel updates", isSelected: false)]

let dataArray2 = [Model(title: "Email", isSelected: true), Model(title: "SMS/MMS", isSelected: true), Model(title: "Phone call", isSelected: false), Model(title: "Post", isSelected: false), Model(title: "Pop up message on your Foxtel box", isSelected: false)]

class ViewModelItem {
    private var item: Model
    
    var title: String {
        return item.title
    }
    var isSelected: Bool {
        get{
            return item.isSelected
        }
        set(newValue){
            print(newValue)
            item.isSelected =  newValue
        }
    }
    
    init(item: Model) {
        self.item = item
    }
}

class ViewModel: NSObject {
    var firstArray = [ViewModelItem]()
    var secondArray = [ViewModelItem]()
    
    var selectedItemsFirstArray: [ViewModelItem] {
        return firstArray.filter { return $0.isSelected }
    }
    var selectedItemsSecondArray: [ViewModelItem] {
        return secondArray.filter { return $0.isSelected }
    }
    
    override init() {
        super.init()
        firstArray = dataArray1.map { ViewModelItem(item: $0) }
        secondArray = dataArray2.map { ViewModelItem(item: $0) }

    }
}

extension ViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            guard let headerView = Bundle.main.loadNibNamed("customFooterView", owner: nil, options: nil)?.first as? customFooterView else {
                return nil
            }
            // configure header as normal
            headerView.backgroundColor = UIColor.red
            return headerView
        }
       return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
        return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: "Futura", size: 17)
        header?.textLabel?.textColor = UIColor.darkGray
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "OPT IN TO STAY UP TO DATE"
        case 1:
            return "NOTIFY ME VIA.."
        default:
            print("test")
        }
        return ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firstArray.count
        case 1:
            return secondArray.count
        default:
            print("test")
        }
        return firstArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {

            switch indexPath.section{
            case 0:
                cell.item = firstArray[indexPath.row]
                if firstArray[indexPath.row].isSelected {
                    if !cell.isSelected {
                        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                    }
                } else {
                    if cell.isSelected {
                        tableView.deselectRow(at: indexPath, animated: false)
                    }
                }
            case 1:
                cell.item = secondArray[indexPath.row]
                if secondArray[indexPath.row].isSelected {
                    if !cell.isSelected {
                        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                    }
                } else {
                    if cell.isSelected {
                        tableView.deselectRow(at: indexPath, animated: false)
                    }
                }
            default:
                print("test")
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // update ViewModel item
        switch indexPath.section {
        case 0:
            firstArray[indexPath.row].isSelected = true
        case 1:
            secondArray[indexPath.row].isSelected = true
        default:
            print("no selec")
        }
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // update ViewModel item
        switch indexPath.section {
        case 0:
            firstArray[indexPath.row].isSelected = false
        case 1:
            secondArray[indexPath.row].isSelected = false
            
        default:
            print("no selecton")
        }
    
    }

}
