import SwiftUI
import Trickery
import Genything
import SFSafeSymbols

struct BusinessCard: Identifiable {
    let id: UUID = UUID()
    let name: String
    let email: String
    let symbolName: SFSymbol
    let addressLine1: String
    let addressLine2: String
}

struct BusinessListCell: View {
    let businessCard: BusinessCard
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemSymbol: businessCard.symbolName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(businessCard.name)
                    .font(.title)
                    .foregroundColor(.orange)
                Text(businessCard.email)
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(businessCard.addressLine1)
                        .font(.subheadline)
                    Text(businessCard.addressLine2)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
    }
}

struct BusinessListView: View {
    let data = Gen<BusinessCard> { ctx in
        let addressLine2Gen = Gen<String>.one(of: [
            Fake.Addresses.caLastLine,
            Fake.Addresses.usLastLine
        ])

        let name = Fake.BusinessNames.any.generate(context: ctx)

        return BusinessCard(
            name: name,
            email: Fake.Emails.business(name).generate(context: ctx),
            symbolName: Fake.Icons.sfSymbols.generate(context: ctx),
            addressLine1: Fake.Addresses.streetLine.generate(context: ctx),
            addressLine2: addressLine2Gen.generate(context: ctx)
        )
    }.take(count: 50)
    
    var body: some View {
        List {
            ForEach(data){ businessCard in
                BusinessListCell(businessCard: businessCard)
            }
        }
        .navigationTitle("Business Cards")
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
