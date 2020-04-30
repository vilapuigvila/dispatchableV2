//
//  Throttle.swift
//  Throttle
//
//  Created by albert vila  on 28/04/2020.
//  Copyright © 2020 albert vila . All rights reserved.
//

import Foundation

public class Throttle {
    
    private let delay: Int
    private var job: DispatchWorkItem?

    public init(seconds: Double) {
        self.delay = Int(seconds * 1000)
    }
    
    /// this block will be excuted in main thread
    /// - Parameter block: your job
    public func drive(block: @escaping () -> Void) {
        guard job == nil else {
            return
        }
        let currentJob = DispatchWorkItem {
            self.job = nil
            block()
        }
        job = currentJob
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + .milliseconds(delay),  execute: currentJob)
    }
}
