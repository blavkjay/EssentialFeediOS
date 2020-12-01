//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by OLAJUWON BALOGUN on 01/12/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit
import XCTest
import EssentialFeed



class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        let url = URL(string: "http://wrong-url.com")!
        session.dataTask(with: url) { _,_,error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}



class URLSessionHTTPClientTests: XCTestCase {


    

    
    func test_getFromURL_failsOnREquestsError() {
        URLProtocolStub.startInterceptingRequest()
        let url = URL(string: "http://any-url.com")!
      
        let error = NSError(domain: "any error", code: 1)
        URLProtocolStub.stub(data: nil,response: nil, error: error)
        
        let exp = expectation(description: "Wait for completion")
        
        let sut = URLSessionHTTPClient()
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError, error)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        URLProtocolStub.stopInterceptingRequest()
    }
    
    //MARK:- Helper
    
    private class URLProtocolStub: URLProtocol {
        
        private static var stub : Stub?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
        }
        
        static func stub(data: Data?,response: URLResponse? ,error: Error?) {
            
            stub = Stub(data: data, response: response, error: error)
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
          
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {
            
        }
        
    }
    
}
