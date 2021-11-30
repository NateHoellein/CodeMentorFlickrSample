//
//  Parser.swift
//  FlickrViewer
//
//  Created by Nathan Hoellein on 11/25/21.
//

import Foundation

class Parser: NSObject, XMLParserDelegate {
    
    var xmlParser: XMLParser
    init(data: Data) {
        xmlParser = XMLParser(data: data)
        super.init()
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("PARSER: \(parser)")
    }
    var depth = 0
    var depthIndent: String {
        return [String](repeating: "  ", count: self.depth).joined()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("\(self.depthIndent)>\(elementName)")
        self.depth += 1
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.depth -= 1
        print("\(self.depthIndent)<\(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print(data)
    }
}
