//
//  MyTableViewCell.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 14)
        
        return lb
    }()
    
    let imgView: UIImageView = {
        let v = UIImageView()
        
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(150).priority(999)
            make.centerX.equalToSuperview()
        }
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(imgView.snp.bottom).offset(10)
        }
    }
    
}
