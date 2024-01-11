//
//  ContentView.swift
//  NotesApp Watch App
//
//  Created by Panchami Shenoy on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var notes = [Note]()
    @State private var text: String = ""
    @Environment(\.managedObjectContext) private var viewContext

   
    func save() {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = text
        notes.append(note)
        
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        DispatchQueue.main.async {
                  do {
                      notes = try viewContext.fetch(Note.fetchRequest())
                    print(notes)
                  } catch {
                    print("Unable to Fetch Workouts, (\(error))")
                  }
        }
    }
    
    func delete(offset: IndexSet) {
        withAnimation {
            for i in offset {
                viewContext.delete(notes[i])
            }
            
            do {
                try viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 5) {
                    TextField("Add new Note", text: $text)
                    
                    Button {
                        guard text.isEmpty == false else {
                            return
                        }
                        save()
                        
                        text = ""
                        
                        
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)

                }
                Spacer()
                if notes.count >= 1 {
                    List {
                      ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                          HStack {
                            Capsule()
                              .frame(width: 4)
                              .foregroundColor(.accentColor)
                              Text(notes[i].text ?? "")
                              .lineLimit(lineCount)
                              .padding(.leading, 5)
                          }
                        }
                      } 
                      .onDelete(perform: delete)
                    }
                    .scrollIndicators(.hidden)
                }
                else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }
            }
            .navigationTitle("Notes")
            .onAppear() {
                load()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
