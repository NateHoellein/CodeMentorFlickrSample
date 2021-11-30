//
//  ViewController.swift
//  FlickrViewer
//
//  Created by Nathan Hoellein on 11/21/21.
//

import UIKit
import HTMLKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var dataSource: FlickrData?
    var tableView: UITableView
    
    required init?(coder: NSCoder) {
        tableView = UITableView(frame: .zero, style: .plain)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchText = UISearchBar(frame: .zero)
        searchText.translatesAutoresizingMaskIntoConstraints = false
        searchText.placeholder = "Enter some tags....."
        searchText.delegate = self
        
        let horizontalView = UIView(frame: .zero)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.backgroundColor = UIColor.lightGray
        horizontalView.addConstraints([
            horizontalView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        let searchStackView = UIStackView(arrangedSubviews: [searchText, horizontalView])
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.axis = .vertical
        searchStackView.spacing = 3.0
        searchStackView.distribution = .fill
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        
        tableView.register(FlickrCell.self, forCellReuseIdentifier: "FlickrCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(searchStackView)
        self.view.addSubview(tableView)
        
        self.view.addConstraints([
            searchStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=1&tags=\(searchText)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(FlickrData.self, from: data)
                    self.dataSource = json
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row tap here to launch a new ViewController to show more about the image
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlickrCell") as? FlickrCell else {
            return UITableViewCell()
        }
        
        let data = dataSource?.items[indexPath.row]
        
        guard let data = data else {
            return UITableViewCell()
        }
        return cell.configure(flickrPicData: data)
    }
}

