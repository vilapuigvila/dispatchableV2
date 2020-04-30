//
//  Dispachable.swift
//  DispatchSearchBar
//
//  Created by albert vila  on 28/04/2020.
//  Copyright © 2020 albert vila . All rights reserved.
//

import Foundation

public class Debounce {
    
    private let queue: DispatchQueue
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun = Date()
    private var maxInterval: Int
    
    
    public init(seconds: Double, queue: DispatchQueue = .main) {
        self.queue       = queue
        self.maxInterval = Int(seconds * 1000)
    }

    public func drive(block: @escaping () -> Void) {
        job.cancel()
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            block()
        }
        let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
        queue.asyncAfter(deadline: .now() + .milliseconds(delay), execute: job)
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Int {
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
}
