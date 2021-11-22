//
//  FlickrData.swift
//  FlickrViewer
//
//  Created by Nathan Hoellein on 11/21/21.
//

import Foundation

struct FlickrData: Decodable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrPicData]
}

struct FlickrPicData: Decodable {
    let title: String
    let link: String
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorID: String
    let tags: String
    let media: MediaData
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorID = "author_id"
        case tags
        case media
    }
}

struct MediaData: Decodable {
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case source = "m"
    }
}

/*
 {
 "title": "Recent Uploads tagged beach",
 "link": "https:\/\/www.flickr.com\/photos\/tags\/beach\/",
 "description": "",
 "modified": "2021-11-21T21:00:14Z",
 "generator": "https:\/\/www.flickr.com",
 "items": [
 {
 "title": "Coup de pinceau",
 "link": "https:\/\/www.flickr.com\/photos\/iceman755\/51695806746\/",
 "media": {"m":"https:\/\/live.staticflickr.com\/65535\/51695806746_3c8aee426d_m.jpg"},
 "date_taken": "2021-11-21T21:58:45-08:00",
 "description": " <p><a href=\"https:\/\/www.flickr.com\/people\/iceman755\/\">Didier Iceman<\/a> posted a photo:<\/p> <p><a href=\"https:\/\/www.flickr.com\/photos\/iceman755\/51695806746\/\" title=\"Coup de pinceau\"><img src=\"https:\/\/live.staticflickr.com\/65535\/51695806746_3c8aee426d_m.jpg\" width=\"240\" height=\"135\" alt=\"Coup de pinceau\" \/><\/a><\/p> ",
 "published": "2021-11-21T21:00:14Z",
 "author": "nobody@flickr.com (\"Didier Iceman\")",
 "author_id": "76217081@N04",
 "tags": "beach plage normandie houlgate france normandy blackwhite noiretblanc"
 },
 */
