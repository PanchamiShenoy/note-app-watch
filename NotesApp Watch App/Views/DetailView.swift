import SwiftUI

struct DetailView: View {
    // MARK: - PROPERTIES
    let note: Note
    let count: Int
    let index: Int
    let onSave: () -> Void
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var text: String 

    // MARK: - INITIALIZER
    init(note: Note, count: Int, index: Int, onSave: @escaping () -> Void) {
        self.note = note
        self.count = count
        self.index = index
        self.onSave = onSave
        _text = State(initialValue: note.text ?? "")
    }

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
                TextField("", text: $text)
                    .font(.title3)
                    .multilineTextAlignment(.center)

                Button(action: {
                    guard text.isEmpty == false else {
                        return
                    }
                    save()
                }) {
                    Text("Save")
                        .foregroundColor(.accentColor)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(3)
    }

    // MARK: - METHODS

    private func save() {
        if let existingNote = try? viewContext.existingObject(with: note.objectID) as? Note {
            existingNote.text = text

            do {
                try viewContext.save()
                onSave()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
