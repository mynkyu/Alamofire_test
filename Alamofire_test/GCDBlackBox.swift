//
//  GCDBlackBox.swift
//  Alamofire_test
//
//  Created by User on 2017. 1. 20..
//  Copyright © 2017년 User. All rights reserved.
//

import Foundation

// -> you should just call this function anytime you need to make updates to the UI inside of the completion handler of a network task
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
