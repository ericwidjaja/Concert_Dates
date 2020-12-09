//
//  ViewController.swift
//  ConcertDates
//
//  Created by Eric Widjaja on 9/6/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet weak var concertTableView: UITableView!
    
    var concerts = [Concert]() {
        didSet {
            concertTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        concertTableView.dataSource = self
        loadData()
        
        
    }
    
    private func loadData() {
        ConcertAPIHelper.shared.getConcerts { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let concertsFromOnline):
                    self.concerts = concertsFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = concertTableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath)
        let concert = concerts[indexPath.row]
        cell.textLabel?.text = concert.title
        
        let properDate = concert.cleanUpDate()
        cell.detailTextLabel?.text = "\(properDate.date) \n \(properDate.time)"
    
        return cell
    }
    
}
