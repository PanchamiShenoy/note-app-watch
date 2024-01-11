//
//  DetailView.swift
//  NotesApp Watch App
//
//  Created by Panchami Shenoy on 6/12/23.
//

import SwiftUI

struct DetailView: View {
  // MARK: - PROPERTY
  
  let note: Note
  let count: Int
  let index: Int
  
  @State private var isCreditsPresented: Bool = false
  @State private var isSettingsPresented: Bool = false

  // MARK: - BODY

  var body: some View {
    VStack(alignment: .center, spacing: 3) {
      
        VStack {
          
          HStack {
            Capsule()
              .frame(height: 1)
            
            Image(systemName: "note.text")
            
            Capsule()
              .frame(height: 1)
          }
          .foregroundColor(.accentColor)
        }
      
      Spacer()
      
      ScrollView(.vertical) {
          Text(note.text ?? "" )
          .font(.title3)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
      }
      
      Spacer()
      
      HStack(alignment: .center) {
          Spacer()
        Image(systemName: "gear")
          .imageScale(.large)
          .onTapGesture {
            isSettingsPresented.toggle()
          }
          .sheet(isPresented: $isSettingsPresented, content: {
              SettingsView()
              
          })
        
        Spacer()
        
        Text("\(count) / \(index + 1)")
        
        Spacer()
        
      }
      .foregroundColor(.secondary)
    }
    .padding(3)
  }
}


