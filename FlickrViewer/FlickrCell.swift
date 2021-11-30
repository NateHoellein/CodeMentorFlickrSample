//
//  FlickrCell.swift
//  FlickrViewer
//
//  Created by Nathan Hoellein on 11/21/21.
//

import UIKit
import SDWebImage

class FlickrCell: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let author: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pictureImageView: UIImageView
    var flikrData: FlickrPicData?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        pictureImageView = UIImageView(image: UIImage(named: "background"))
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.contentMode = .scaleAspectFit
        
        let textViewHolder = UIView(frame: .zero)
        textViewHolder.translatesAutoresizingMaskIntoConstraints = false
        textViewHolder.clipsToBounds = true
        
        textViewHolder.addSubview(title)
        textViewHolder.addSubview(author)
        textViewHolder.addConstraints([
            title.topAnchor.constraint(equalTo: textViewHolder.topAnchor, constant: 10.0),
            title.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor, constant: 10.0),
            title.trailingAnchor.constraint(lessThanOrEqualTo: textViewHolder.trailingAnchor, constant: -10.0),
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15.0),
            author.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor, constant: 10.0),
            author.trailingAnchor.constraint(lessThanOrEqualTo: textViewHolder.trailingAnchor, constant: -10.0),
            author.bottomAnchor.constraint(lessThanOrEqualTo: textViewHolder.bottomAnchor, constant: -10),
        ])
        
        let imageViewHolder = UIView(frame: .zero)
        imageViewHolder.translatesAutoresizingMaskIntoConstraints = false
        imageViewHolder.addSubview(pictureImageView)
        imageViewHolder.addConstraints([
            pictureImageView.centerYAnchor.constraint(equalTo: imageViewHolder.centerYAnchor),
            pictureImageView.centerXAnchor.constraint(equalTo: imageViewHolder.centerXAnchor),
            imageViewHolder.heightAnchor.constraint(greaterThanOrEqualToConstant: 90.0),
            imageViewHolder.widthAnchor.constraint(equalToConstant: 90.0)
        ])
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(textViewHolder)
        self.contentView.addSubview(imageViewHolder)

        self.contentView.addConstraints([
            textViewHolder.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            textViewHolder.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            textViewHolder.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            textViewHolder.trailingAnchor.constraint(equalTo: imageViewHolder.leadingAnchor),
            imageViewHolder.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageViewHolder.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageViewHolder.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func configure(flickrPicData: FlickrPicData) -> FlickrCell {
        
        self.author.text = flickrPicData.author
        self.title.text = flickrPicData.title
        
        self.pictureImageView.sd_imageTransition = .fade
        self.pictureImageView.sd_setImage(with: URL(string: flickrPicData.media.source),
                                          placeholderImage: UIImage(named: "background")) { image, error, cacheType, url in

            if let image = image {
                image.prepareThumbnail(of: CGSize(width: 90, height: 90)) { thumbnail in
                    DispatchQueue.main.async {
                        self.pictureImageView.image = thumbnail
                    }
                }
            }
        }
        
        return self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
