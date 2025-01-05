//
//  view.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func onLoading(isLoading: Bool) -> some View {
        if(isLoading) {
            ProgressView()
        }
        else {
            self
        }
    }
}
