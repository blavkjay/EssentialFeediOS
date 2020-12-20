//
//  EssentialFeedAPIEndToEndTests.swift
//  EssentialFeedAPIEndToEndTests
//
//  Created by OLAJUWON BALOGUN on 20/12/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import XCTest
import EssentialFeed

class EssentialFeedAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        
        
        switch getFeedResult() {
        case let .success(items)?:
            XCTAssertEqual(items.count, 8, "Expected 8 items in the test account feed")
            items.enumerated().forEach { (index, item) in
                XCTAssertEqual(item, expectedItem(at: index), "Unexpected item value at index \(index)")
            }
        case let .failure(error)?:
            XCTFail("Expected successful feed result, but got \(error) instead")
        default:
            XCTFail("Expected successful feed result, but got nil instead")
        }
    }
    
    //Mark: - Helper
    
    private func getFeedResult() -> LoadFeedResult? {
        let testServerUrl = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
        let client = URLSessionHTTPClient()
        let loader = RemoteFeedLoader(url: testServerUrl, client: client)
        
        let exp = expectation(description: "Wait for load completion")
        var receivedResult: LoadFeedResult?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10.0)
        return receivedResult
    }
    
    private func expectedItem(at index: Int) -> FeedItem {
        return FeedItem(id: id(at: index),
                        description: description(at: index),
                        location: location(at: index),
                        imageURL: imageURL(at: index))
    }
    
    private func id(at index: Int) -> UUID {
        return UUID(uuidString: [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8"
        ][index])!
    }
    
    private func description(at index: Int) -> String? {
        return [ "description 1",
                 "description 2",
                 nil,
                 "description 4",
                 "description 5",
                 nil,
                 "description 7",
                 "description 8"
        ][index]
    }
    
    private func location(at index: Int) -> String? {
        return [ "location 1",
                 "location 2",
                 nil,
                 "location 4",
                 "location 5",
                 nil,
                 "location 7",
                 "location 8"
        ][index]
    }
    
    private func imageURL(at index: Int) -> URL {
        return URL(string: "https://url-\(index+1).com")!
    }
    
}
