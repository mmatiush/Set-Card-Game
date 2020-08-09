//
//  View+if.swift
//  SetGame
//
//  Created by Max Matiushchenko on 28.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func ifTrue<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        }
        else {
            self
        }
    }
}
