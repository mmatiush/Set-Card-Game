//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Max Matiushchenko on 19.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
	func FirstIndex(matching: Element) -> Int? {
		for index in 0..<self.count {
			if self[index].id == matching.id {
				return index
			}
		}
		return nil
	}
}
