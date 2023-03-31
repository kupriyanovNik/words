//
//  ContentView.swift
//  words
//
//  Created by Никита Куприянов on 29.03.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm = NetworkManager()
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.facts) { fact in
                        HStack {
                            if fact.from == .me { Spacer() }
                            Text(fact.message)
                                .foregroundColor(fact.from == .me ? .white : colorScheme == .light ? .black : .white)
                                .padding()
                                .background(fact.from == .me ? .blue : .gray.opacity(0.1))
                                .cornerRadius(16)
                            if fact.from == .api { Spacer() }
                        }
                    }
                }
            }
            fetchButton
        }
        .padding()
    }
    var fetchButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        vm.facts.append(.init(message: "???", from: .me))
                    }
                    vm.fetch()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.mint)
                        Text("?")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .bold()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
