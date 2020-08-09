//
//  DiamondShape.swift
//  SetGame
//
//  Created by Max Matiushchenko on 25.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
				
		let topPoint = CGPoint(x: rect.midX, y: rect.minY)
		let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
		let leadingPoin = CGPoint(x: rect.minX, y: rect.midY)
		let trailingPoing = CGPoint(x: rect.maxX, y: rect.midY)
		
		path.move(to: topPoint)
		path.addLines([leadingPoin, bottomPoint, trailingPoing, topPoint, leadingPoin])
		
		return path
	}

}

struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
