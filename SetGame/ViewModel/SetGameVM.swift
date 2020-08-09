//
//  ViewModel.swift
//  SetGame
//
//  Created by Max Matiushchenko on 24.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation

// ViewModel

class SetGameVM: ObservableObject {
    @Published private var model = SetGameModel()

	func dealCards() {
		model.addCardsOnTable(num: defaultNumberOfCardsOnTable)
	}
	
	func startNewGame() {
		model = SetGameModel()
		model.addCardsOnTable(num: defaultNumberOfCardsOnTable)
	}
	
	func addThreeCardsOnTable() {
		model.addCardsOnTable(num: 3)
	}
	
	func select(card: SetGameModel.Card) {
		model.select(card: card)
	}
	
	var setsNum: Int {
		model.setsNum
	}
	
	var tableCards: Array<SetGameModel.Card> {
		model.tableCards
	}
	
	var deck: Array<SetGameModel.Card> {
		model.deck
	}
	
	var deckIsEmpty: Bool {
		model.deck.isEmpty
	}
	
	var maxCardsOnTable: Int {
		model.maxCardsOnTable
	}
	var defaultNumberOfCardsOnTable: Int {
		model.defaultNumOfCardsOnTable
	}
	
}
