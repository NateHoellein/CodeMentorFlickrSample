//
//  FlickrViewerTests.swift
//  FlickrViewerTests
//
//  Created by Nathan Hoellein on 11/21/21.
//

import XCTest
import HTMLKit
@testable import FlickrViewer

class FlickrViewerTests: XCTestCase {

    func testShouldParseHTMLtoGetWidthAndHeight() throws {
        let sampleString = """
<p><a href="https://www.flickr.com/people/133071707@N04/">bjbmd</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/133071707@N04/51704391053/" title="DSC_4682"><img src="https://live.staticflickr.com/65535/51704391053_8ee1e2fc7c_m.jpg" width="240" height="160" alt="DSC_4682" /></a></p>
"""
        
        let html = HTMLDocument(string: sampleString)
        let img = html.querySelector("[src]")
        let attributes: [String: String] = img?.attributes as! [String:String]
        
        let width  = attributes["width"] ?? ""
        let height = attributes["height"] ?? ""
        
        XCTAssertEqual("240", width)
        XCTAssertEqual("160", height)
    }
}
