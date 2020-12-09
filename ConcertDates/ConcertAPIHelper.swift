//
//  ConcertAPIHelper.swift
//  ConcertDates
//
//  Created by Eric Widjaja on 9/6/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation

class ConcertAPIHelper {
    private init () {}
    
    static let shared = ConcertAPIHelper()
    
    let urlStr = "https://api.seatgeek.com/2/events?type=concert&client_id=MTgyNjU3NTN8MTU2Nzc3ODcxMy41Nw"
    
    func getConcerts(completionHandler: @escaping (Result<[Concert], AppError>) -> ()) {
        
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.badUrl))
            case .success(let data):
                do {
                    let concertInfo = try JSONDecoder().decode(ConcertWrapper.self, from: data)
                    completionHandler(.success(concertInfo.events))
                } catch {
                    completionHandler(.failure(.noDataError))
                    
                }
            }
        }
        
    }
    
}
