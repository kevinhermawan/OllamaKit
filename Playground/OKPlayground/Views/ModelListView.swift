//
//  ModelListView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 09/06/24.
//

import SwiftUI

struct ModelListView: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        List(viewModel.models, id: \.self) { model in
            Text(model)
        }
    }
}
