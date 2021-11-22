//
//  FlickrCell.swift
//  FlickrViewer
//
//  Created by Nathan Hoellein on 11/21/21.
//

import UIKit
import SDWebImage

class FlickrCell: UITableViewCell {
    
    var title: UILabel
    var tags: UILabel
    var author: UILabel
    var pictureImageView: UIImageView
    var flikrData: FlickrPicData?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        title = UILabel(frame: .zero)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        
        tags = UILabel(frame: .zero)
        tags.numberOfLines = 0
        tags.translatesAutoresizingMaskIntoConstraints = false
        
        author = UILabel(frame: .zero)
        author.numberOfLines = 0
        author.translatesAutoresizingMaskIntoConstraints = false
        
        pictureImageView = UIImageView(image: UIImage(named: "background"))
        
        let textStack = UIStackView(arrangedSubviews: [title, author, tags])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.distribution = .fill
        
        let imageStack = UIStackView(arrangedSubviews: [pictureImageView])
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        imageStack.axis = .vertical
        imageStack.distribution = .fill
        
        let fullStackView = UIStackView(arrangedSubviews: [textStack, imageStack])
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.axis = .horizontal
        fullStackView.distribution = .fillProportionally
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(fullStackView)

        self.addConstraints([
            fullStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            fullStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            fullStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            fullStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    func setImage(url: String) {
        self.pictureImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "background"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
