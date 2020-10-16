//
//  ContentView.swift
//  TestMatchedGeo
//
//  Created by Kyle Wilson on 2020-10-14.
//

import SwiftUI

struct HiddenMessage: Hashable, Identifiable {
    var id: Int
    var pokemon: String
    var background: Color
}

struct ContentView: View {
    @State var selectedNumber: Int?
    @Namespace var namespace
    
    var hiddenMessages = [HiddenMessage(id: 1, pokemon: "Groudon", background: .red),
                          HiddenMessage(id: 2, pokemon: "Kyogre", background: .blue),
                          HiddenMessage(id: 3, pokemon: "Rayquaza", background: .green)]
    
    var body: some View {
        VStack {
            if selectedNumber == nil {
                VStack(spacing: 15) {
                    ForEach(hiddenMessages, id: \.self) { message in
                        Button("Click for a Legendary Pokemon") {
                            withAnimation {
                                selectedNumber = message.id
                            }
                        }
                        .frame(width: 300, height: 30, alignment: .center)
                        .padding()
                        .border(Color.black, width: 1)
                        .matchedGeometryEffect(id: message.id, in: namespace)
                    }
                }
            } else {
                ForEach(hiddenMessages, id: \.self) { message in
                    if selectedNumber == message.id {
                        ZStack {
                            Rectangle().foregroundColor(message.background).cornerRadius(30)
                            VStack(spacing: 20) {
                                Text(message.pokemon)
                                    .font(.custom("AvenirNext-Bold", size: 30))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Image("\(message.pokemon)")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                Button("Back") {
                                    withAnimation {
                                        selectedNumber = nil
                                    }
                                }
                                .foregroundColor(.black)
                            }
                            
                        }
                        .matchedGeometryEffect(id: message.id, in: namespace)
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
