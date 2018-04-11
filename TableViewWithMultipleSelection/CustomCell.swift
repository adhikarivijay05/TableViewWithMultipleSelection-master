//
//  CustomCell.swift
//  TableViewWithMultipleSelection
//
//  Created by Stanislav Ostrovskiy on 5/22/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var item: ViewModelItem? {
        didSet {
            titleLabel?.text = item?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBAction func selectOptionClicked(_ sender: Any) {
        
        let button = sender as! UIButton
        if button.isSelected {
            setSelected(false, animated: false)
        }else{
            setSelected(true, animated: false)
        }
    }
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var checkBtn: UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            checkBtn.setImage(UIImage(named: "tick.png"), for: .normal)
            checkBtn.isSelected = true
        }
        else{
            checkBtn.setImage(nil, for: .normal)
            checkBtn.isSelected = false

        }
    }
}
