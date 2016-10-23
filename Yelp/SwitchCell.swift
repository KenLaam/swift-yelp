//
//  CategorySwitchCell.swift
//  Yelp
//
//  Created by Ken Lâm on 10/23/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
        self.delegate?.switchCell!(switchCell: self, didChangeValue: sender.isOn)
    }

}
