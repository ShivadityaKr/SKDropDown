//
//  ViewController.swift
//  SKDropDown
//
//  Created by Shivaditya Kumar on 2022-10-20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var dropDownView = AppDropDown()
    var showingDropDown = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupUI()
    }
    private func setupUI(){
        // Button
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        // Text Field
        self.textField.backgroundColor = .white
        self.textField.rightView = button
        self.textField.rightViewMode = .always
        self.textField.borderStyle = .line
        self.textField.layer.borderColor = UIColor.black.cgColor
        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 5
        self.textField.clipsToBounds = true
        // Drop Down
        self.dropDownView.setDropDown(containerView: self.view, sourceView: self.textField, height: 160)
        var elementConfiguration = ElementConfiguration()
        elementConfiguration.height = 40
        elementConfiguration.selectionColor = UIColor.lightGray
        elementConfiguration.backgroundColor = .white
        elementConfiguration.label.font = UIFont.systemFont(ofSize: 30)
        elementConfiguration.label.textColor = .black
        elementConfiguration.label.tintColor = .black
        elementConfiguration.label.textAlignment = .center
        self.dropDownView.elementConfiguration = elementConfiguration
    }
    func setDropDown(containerView: UIView, sourceView: UIView) {
        dropDownView = AppDropDown(frame: CGRect(x: sourceView.frame.origin.x, y: sourceView.frame.origin.y + (sourceView.frame.height), width: UIScreen.main.bounds.width - (sourceView.frame.origin.x * 2), height: 160))
        dropDownView.backgroundColor = .gray
        containerView.addSubview(dropDownView)
        dropDownView.showDropDown = false
        dropDownView.clipsToBounds = true
    }
    @objc private func didTapButton() {
        showDropDown(datasource: ["Male", "Female", "Others", "Prefer Not to Say"])
    }
    func showDropDown(datasource: [String]) {
        if showingDropDown {
            dropDownView.showDropDown = true
            dropDownView.setData(datasource: datasource, handler: {[weak self] data in
                guard let self = self else {return}
                self.textField.text = data
                self.showDropDown(datasource: datasource)
            })
        } else {
            dropDownView.showDropDown = false
        }
        showingDropDown = !showingDropDown
    }
}

