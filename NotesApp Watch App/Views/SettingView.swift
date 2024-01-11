//
//  SettingView.swift
//  NotesApp Watch App
//
//  Created by Panchami Shenoy on 6/12/23.
//

import SwiftUI

struct SettingsView: View {
  // MARK: - PROPERTY
  
  @AppStorage("lineCount") var lineCount: Int = 1
  @State private var value: Float = 1.0
  
  // MARK: - FUNCTION

  func update() {
    lineCount = Int(value)
  }

  // MARK: - BODY

  var body: some View {
    VStack(spacing: 8) {
      // HEADER
        VStack {
          // SEPARATOR
          HStack {
            Capsule()
              .frame(height: 1)
            
            Image(systemName: "note.text")
            
            Capsule()
              .frame(height: 1)
          } //: HSTACK
          .foregroundColor(.accentColor)
        }
      
      // ACTUAL LINE COUNT
      Text("Lines: \(lineCount)".uppercased())
        .fontWeight(.bold)
      
      // SLIDER
      Slider(value: Binding(get: {
        self.value
      }, set: {(newValue) in
        self.value = newValue
        self.update()
      }), in: 1...4, step: 1)
        .accentColor(.accentColor)
    }
    .onAppear(perform: {

      value = Float(lineCount)

      })//: VSTACK
  }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
