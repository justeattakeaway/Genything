import Genything
import SwiftUI
import Trickery

let generator = GenLibsScriptGenerator().generator

private func generateScript() -> String {
    generator.generate(context: .random)
}

// MARK: - GenLibsView

struct GenLibsView: View {
    @State var text: String = generateScript()

    var body: some View {
        VStack {
            Text(text)
                .padding(.vertical)
            Button("Again") {
                text = generateScript()
            }.padding(.vertical)
        }
        .padding()
        .navigationTitle("Gen-Libs")
    }
}

// MARK: - GenLibsView_Previews

struct GenLibsView_Previews: PreviewProvider {
    static var previews: some View {
        GenLibsView()
    }
}
