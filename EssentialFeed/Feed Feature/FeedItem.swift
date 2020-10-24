//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by OLAJUWON BALOGUN on 29/09/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation


public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
