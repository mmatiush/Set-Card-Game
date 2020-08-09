//
//  Model.swift
//  SetGame
//
//  Created by Max Matiushchenko on 24.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation
import SwiftUI

struct SetGameModel {
	private(set) var deck = [Card]()
	private(set) var tableCards = [Card]()
	private(set) var setsNum = 0

	private var indicesOfSelectedCards: [Int] {
		tableCards.indices.filter { tableCards[$0].isSelected }
	}
	
	init() {
		makeNewDeck()
		deck.shuffle()
	}
	
	mutating private func makeNewDeck(){
		for number in numbers {
			for symbol in Symbol.allCases {
				for shading in Shading.allCases {
					for color in colors {
						deck.append(Card(number: number,
										 symbol: symbol,
										 shading: shading,
										 color: color))
					}
				}
			}
		}
	}
	
	mutating func addCardsOnTable(num: Int) {
		for _ in 1...num {
			if !deck.isEmpty && tableCards.count < maxCardsOnTable {
				tableCards.append(self.deck.removeFirst())
			}
		}
	}
	
	mutating func select(card: Card) {
		if let chosenIndex = tableCards.FirstIndex(matching: card) {
			
			if !tableCards[chosenIndex].isSelected {

				if indicesOfSelectedCards.count == 3 {
					deselectAllCards()
					markCardAsSelected(at: chosenIndex)

				} else if indicesOfSelectedCards.count == 2 {
					markCardAsSelected(at: chosenIndex)
					if cardsMakeSet(indices: indicesOfSelectedCards) {
						mark3CardsAsMatchedAndRemove()
					} else {
						mark3CardsAsFaliedToFindSet()
					}
				} else if indicesOfSelectedCards.count == 1 ||  indicesOfSelectedCards.count == 0 {
					markCardAsSelected(at: chosenIndex)
				}

			} else {
				if indicesOfSelectedCards.count == 3 {
					deselectAllCards()
					markCardAsSelected(at: chosenIndex)
				} else {
					tableCards[chosenIndex].isSelected = false
				}
			}
		}
	}
	
	private func allEqualOrDifferent<T: Equatable>(_ a: T, _ b: T, _ c: T) -> Bool {
		return (a == b && b == c) || (a != b && b != c && c != a)
	}
	
	private func cardsMakeSet(indices: [Int]) -> Bool {
		
		let one = indices[0]
		let two = indices[1]
		let three = indices[2]
		
		return
			allEqualOrDifferent(tableCards[one].shading,
							   tableCards[two].shading,
							   tableCards[three].shading) &&
			allEqualOrDifferent(tableCards[one].color,
								tableCards[two].color,
								tableCards[three].color) &&
			allEqualOrDifferent(tableCards[one].symbol,
								tableCards[two].symbol,
								tableCards[three].symbol) &&
			allEqualOrDifferent(tableCards[one].number,
								tableCards[two].number,
								tableCards[three].number)
	}
	
	private mutating func markCardAsSelected(at index: Int) {
		tableCards[index].isSelected = true
	}
	
	private mutating func mark3CardsAsMatchedAndRemove() {
		for index in indicesOfSelectedCards {
			tableCards[index].isMatched = true
		}
		
		// TODO: - add delay before deleting the cards
		
		for index in indicesOfSelectedCards.reversed() {
			tableCards[index].isSelected = false
			tableCards[index].faliedToFindSet = false
			tableCards[index].isMatched = false
			tableCards.remove(at: index)
		}
		
		// TODO: - add delay before adding three more cards on table
		
		setsNum += 1
		if (tableCards.count < defaultNumOfCardsOnTable) {
			addCardsOnTable(num: 3)
		}
	}

	
	private mutating func mark3CardsAsFaliedToFindSet() {
		for index in indicesOfSelectedCards {
			tableCards[index].faliedToFindSet = true
		}
	}
	
	private mutating func deselectAllCards() {
		for index in tableCards.indices {
			tableCards[index].isSelected = false
			tableCards[index].faliedToFindSet = false
		}
	}
	
	struct Card: Identifiable {
		var number: Int
		var symbol: Symbol
		var shading: Shading
		var color: Color
		var id = UUID()
		
		var isSelected: Bool = false
		var isMatched: Bool = false
		var faliedToFindSet: Bool = false

	}
	

	private var colors = [Color.red, Color.green, Color.purple]
	
	private var numbers = [1, 2, 3]
	
	enum Symbol: CaseIterable {
		case diamond, squiggle, oval
	}
	
	enum Shading: CaseIterable {
		case solid, striped, open
	}

	let maxCardsOnTable = 15
	let defaultNumOfCardsOnTable = 12
	
}
