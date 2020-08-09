//
//  ContentView.swift
//  SetGame
//
//  Created by Max Matiushchenko on 24.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
	
	@ObservedObject var viewModel = SetGameVM()
	
	var body: some View {
		VStack {
			Grid(viewModel.tableCards) { card in
				
				CardView(card: card)
					.padding(10)
					.aspectRatio(0.75, contentMode: .fit)
					.onTapGesture {
						self.viewModel.select(card: card)
				}.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
				
			}
			.animation(.easeOut)
			.onAppear {
				self.viewModel.dealCards()
			}
			
			HStack(spacing: 50) {
				
				Text("\(viewModel.setsNum) Sets")
				
				Button(action: {
					self.viewModel.startNewGame()
				}) {
					Text("New game")
				}
				
				Button(action: {
					self.viewModel.addThreeCardsOnTable()
				}) {
					Text("+3 Cards")
				}
				.disabled(viewModel.deckIsEmpty || viewModel.tableCards.count >= viewModel.maxCardsOnTable)
			}
			.padding([.horizontal, .bottom])
		}
	}
}

struct CardView: View {
	
	var card: SetGameModel.Card
	
	init(card: SetGameModel.Card) {
		self.card = card
	}
	
	var body: some View {
		
		ZStack {
			
			if card.faliedToFindSet {
				RoundedRectangle(cornerRadius: raduisOfCorner)
					.fill(Color.red.opacity(cardBackgroundOpacity))
			}
			else if card.isMatched{
				RoundedRectangle(cornerRadius: raduisOfCorner)
					.fill(Color.green.opacity(cardBackgroundOpacity))
			} else {
				RoundedRectangle(cornerRadius: raduisOfCorner)
					.fill(card.isSelected ? Color.yellow.opacity(cardBackgroundOpacity) : cardBackgroundColor)
			}
			
			RoundedRectangle(cornerRadius: raduisOfCorner)
				.stroke(edgeColor, lineWidth: edgeLineWidth)
			
			
			VStack {
				ForEach(0..<card.number) { _ in
					
					self.CardSymbolView(card: self.card)
						.aspectRatio(2, contentMode: .fit)
				}
			}
			.padding(10)
		}
		.scaleEffect(card.isSelected || card.isMatched ? 1.1 : 1)
		
		
	}
	
	
	func CardSymbolView(card: SetGameModel.Card) -> some View {
		
		Group {
			if card.symbol == .oval {
				Capsule()
					.fill(card.shading == .open ? Color.white : card.color)
					.ifTrue(card.shading == .striped) { $0.opacity(cardBackgroundOpacity) }
					.overlay(Capsule().stroke(card.color, lineWidth: edgeLineWidth))
				
				
				
			} else if (card.symbol == .squiggle) {
				Squiggle()
					.fill(card.shading == .open ? Color.white : card.color)
					.ifTrue(card.shading == .striped) { $0.opacity(cardBackgroundOpacity) }
					.overlay(Squiggle().stroke(card.color, lineWidth: edgeLineWidth))
				
				
			} else {
				Diamond()
					.fill(card.shading == .open ? Color.white : card.color)
					.ifTrue(card.shading == .striped) { $0.opacity(cardBackgroundOpacity) }
					.overlay(Diamond().stroke(card.color, lineWidth: edgeLineWidth))
				
			}
			
		}
		
	}
	
	private let cardBackgroundOpacity = 0.3
	private let cardBackgroundColor = Color.white
	private let raduisOfCorner: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 2.0
	private let edgeColor = Color.black
	
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		SetGameView()
	}
}

