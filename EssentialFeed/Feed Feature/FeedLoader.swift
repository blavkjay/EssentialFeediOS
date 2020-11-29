//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by OLAJUWON BALOGUN on 29/09/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}


public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
