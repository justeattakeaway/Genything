import SwiftUI
import Trickery
import Genything

private func generateScript() -> String {
    ScriptGen.generator.generate(context: .random)
}

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

struct GenLibsView_Previews: PreviewProvider {
    static var previews: some View {
        GenLibsView()
    }
}


