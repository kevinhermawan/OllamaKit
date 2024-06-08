//
//  OKPlaygroundApp.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import SwiftUI

@main
struct OKPlaygroundApp: App {
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(viewModel)
        }
    }
}
