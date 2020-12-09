//
//  Concert.swift
//  ConcertDates
//
//  Created by Eric Widjaja on 9/6/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.

import Foundation
struct ConcertWrapper: Codable {
    let events: [Concert]
}
struct Concert: Codable {
    let title: String
    let dateTimeLocal: String
    
    
    func cleanUpDate() -> (date: String, time: String) {
        var convertedDate = ""
        var convertedTime = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMM d, yyyy"
        
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH-mm-ss"
        
        let newTimeFormatter = DateFormatter()
        newTimeFormatter.dateFormat = "h:mm a"
        
        let dateComponents = self.dateTimeLocal.components(separatedBy: "T")
        
        let splitDate = dateComponents[0]
        let splitTime = dateComponents[1]
        
        if let date = dateFormatter.date(from: splitDate) {
            convertedDate = newDateFormatter.string(from: date)
        }
        
        if let time = timeFormatter.date(from: splitTime) {
            convertedTime = newTimeFormatter.string(from: time)
        }
        
        
        return (date: convertedDate, time: convertedTime)
        
        
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case dateTimeLocal = "datetime_local"
    }
}
