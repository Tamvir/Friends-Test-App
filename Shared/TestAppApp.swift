//
//  TestAppApp.swift
//  Shared
//
//  Created by MD Ehteshamul Haque Tamvir on 21/2/22.
//

import SwiftUI

@main
struct TestAppApp: App {
    var httpRequestProvider = HttpRequestManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(httpRequestProvider)
        }
    }
}
