//
//  AppDropDown.swift
//  NextRewards
//
//  Created by Shivaditya Kumar on 09/06/22.
//

import UIKit

class AppDropDown: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var selectedValue : ((String) -> Void)?
    var afterSelection: ((String) -> Void)?
    /// Configuration for elements in Drop Down this should be set before calling setDropDown() function.
    var elementConfiguration: ElementConfiguration = ElementConfiguration() {
        didSet {
            self.setupTableView()
        }
    }
    var dropDownElement = DropDownTVC() {
        didSet {
            self.dropDownElement.elementLabel.textColor = self.elementConfiguration.label.textColor ?? .black
        }
    }
    var showDropDown: Bool = false {
        didSet {
            self.isHidden = !showDropDown
            setupTableView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var dataSource: [String] = [] {
        didSet {
            setupTableView()
        }
    }
    var selected = ""
    var cellIndex = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    private func commoninit() {
        Bundle.main.loadNibNamed("AppDropDown", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DropDownTVC", bundle: nil), forCellReuseIdentifier: "DropDownTVC")
//        self.tableView.register(DropDownTVC.self, forCellReuseIdentifier: "DropDownTVC")
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.tableView.clipsToBounds = true
        self.tableView.reloadData()
    }
    func setData(datasource: [String], handler: @escaping (String) -> Void) {
        self.dataSource = datasource
        self.selectedValue = handler
    }
    func setDropDown(containerView: UIView, sourceView: UIView, height: Double) {
        self.frame = CGRect(x: sourceView.frame.origin.x, y: sourceView.frame.origin.y + (sourceView.frame.height), width: UIScreen.main.bounds.width - (sourceView.frame.origin.x * 2), height: height)
        self.backgroundColor = elementConfiguration.backgroundColor
        containerView.addSubview(self)
        self.isHidden = true
        self.clipsToBounds = true
    }
    
}
extension AppDropDown: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTVC") as? DropDownTVC else {return UITableViewCell()}
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.textColor = self.elementConfiguration.label?.textColor ?? .black
//        cell.textLabel?.textAlignment = self.elementConfiguration.label?.textAlignment ?? .left
//        cell.textLabel?.font = self.elementConfiguration.label?.font ?? UIFont.systemFont(ofSize: 18.0)
//        cell.backgroundColor = self.elementConfiguration.backgroundColor ?? .white
//        cell.textLabel?.text = dataSource[indexPath.row]
//        cell.tintColor = self.elementConfiguration.label?.tintColor ?? .black
//        cell.clipsToBounds = true
//        if !selected.isEmpty && indexPath.row == cellIndex {
//            cell.backgroundColor = self.elementConfiguration.selectionColor ?? .gray
//        }
        let data = dataSource[indexPath.row]
        cell.setData(text: data)
        cell.setUI(configuration: self.elementConfiguration)
        if !selected.isEmpty && indexPath.row == cellIndex {
            cell.selectCell(configuration: self.elementConfiguration)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTVC else {return}
        cell.selectCell(configuration: self.elementConfiguration)
        self.selected = dataSource[indexPath.row]
        cellIndex = indexPath.row
        selectedValue?(selected)
        afterSelection?(selected)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(elementConfiguration.height)
    }
}
