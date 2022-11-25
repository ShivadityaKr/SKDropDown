//
//  DropDownTVC.swift
//  SKDropDown
//
//  Created by Shivaditya Kumar on 2022-10-20.
//

import UIKit

class DropDownTVC: UITableViewCell {
    @IBOutlet weak var elementLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var elementConfuration: ElementConfiguration = ElementConfiguration()
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .white
        self.contentView.backgroundColor = .clear

    }
    func setData(text: String) {
        self.elementLabel.text = text
    }
    func setUI(configuration: ElementConfiguration) {
        self.elementConfuration = configuration
        self.elementLabel.textColor = configuration.label.textColor
        self.elementLabel.textAlignment = configuration.label.textAlignment
        self.elementLabel.backgroundColor = .clear
        self.elementLabel.backgroundColor = configuration.backgroundColor
        self.contentView.backgroundColor = .clear
    }
    func selectCell(configuration: ElementConfiguration) {
        self.backgroundColor = configuration.selectionColor
        self.elementLabel.backgroundColor = .clear
    }
}
