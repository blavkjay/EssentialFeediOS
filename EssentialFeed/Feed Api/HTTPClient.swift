//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by OLAJUWON BALOGUN on 24/11/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data,HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
