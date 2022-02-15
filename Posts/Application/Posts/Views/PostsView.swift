//
//  PostsView.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

class PostsView: BaseView {
    
    var tableView = UITableView()
    var postsDataSource: PostsDataSource?
    var data: [UserWithPost]? {
        didSet {
            if data?.isEmpty ?? true {
                tableView.setEmptyMessage("No data available")
                return
            }
            tableView.restore()
            postsDataSource = PostsDataSource(data: data)
            tableView.dataSource = postsDataSource
            tableView.delegate = postsDataSource
            tableView.reloadData()
        }
    }
    
    override func setup() {
        backgroundColor = .yellow
        addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(PostsCell.self, forCellReuseIdentifier: "PostsCell")
        tableView.showsVerticalScrollIndicator = false
    }
}

class PostsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data: [UserWithPost]?
    var delegate: PostsDataSourceDelegate?
    
    init(data: [UserWithPost]?) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsCell

        cell.descriptionLabel.text = data?[indexPath.row].body ?? "No description"
        cell.titleLabel.text = data?[indexPath.row].title ?? "No title"
        cell.usernameLabel.text = data?[indexPath.row].username ?? "No username"
        cell.imgView.showImage(imgUrl: data?[indexPath.row].avatar)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateCellHeight(indexPath)
    }
    
    /// This calculates the height of cell, it used some extra  attributes such as
    ///  Image top margin = 10, image height = 40, titleLabel top margin = 10, descriptionLabel top margin = 10,
    ///  descriptionLabel bottom margin = 10
    /// - Parameter indexPath: Location of the item in the data
    /// - Returns: The size of the cell base on its content
    func calculateCellHeight(_ indexPath: IndexPath) -> CGFloat {
        let margins = 10 + 40 + 10 + 10 + 10
        return CGFloat(margins) + titleLabelHeight(text: data?[indexPath.row].title ?? "") + descriptionLabelHeight(text: data?[indexPath.row].body ?? "")
    }
    
    func titleLabelHeight(text: String) -> CGFloat {
        let font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func descriptionLabelHeight(text: String) -> CGFloat {
        let font = UIFont(name: "HelveticaNeue", size: 14.0)
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

protocol PostsDataSourceDelegate {
    func calculateCellHeight(_ indexPath: IndexPath) -> CGFloat
}

class PostsCell: BaseTableViewCell {
    let usernameLabel = Label(text: "Bill Hona", font: .helveticaNeueMedium(size: 16))
    let titleLabel = Label(text: "Bereich und reinigt sogar im Dunkeln", font: .helveticaNeueMedium(size: 15), padding: .sides(15, 15))
    let descriptionLabel = Label(text: "description", font: .helveticaNeueRegular(), padding: .sides(15, 15))
    let imgView = UIImageView()
    
    override func setup() {
        addSubviews(imgView, usernameLabel, titleLabel, descriptionLabel)
        imgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, margin: .init(top: 10, left: 15, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        usernameLabel.centerInView(centerY: imgView.centerYAnchor, trailing: imgView.trailingAnchor, margin: .rightOnly(15))
        
        titleLabel.anchor(top: imgView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, margin: .topOnly(10))
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .topBottomOnly(10, 10))
        
        imgView.viewCornerRadius = 20
        imgView.backgroundColor = .lightGray
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
}
