//
//  ToDoListCell.swift
//  ToDoListWithCoreData
//
//  Created by Erma on 31/7/24.
//

import UIKit
import SnapKit

class ToDoListCell: UITableViewCell {
    static let reusd = "toDoList_cell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func fill(with label: String) {
        titleLabel.text = label
    }
}
