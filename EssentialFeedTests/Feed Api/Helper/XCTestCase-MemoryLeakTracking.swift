//
//  XCTestCase-MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by OLAJUWON BALOGUN on 18/12/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
     func trackMemoryLeaks(_ instance: AnyObject,file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. potential memory leak", file: file, line: line)
        }
       
    }
}
