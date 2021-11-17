import SwiftUI
import Trickery
import Genything

struct BusinessCard: Identifiable {
    let id: UUID = UUID()
    let name: String
    let email: String
    let symbolName: String
    let addressLine1: String
    let addressLine2: String
}

struct BusinessListCell: View {
    let businessCard: BusinessCard
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: businessCard.symbolName)
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
    let data = [BusinessCard(name: "Business Name",
                            email: "business@email.com",
                            symbolName: "circle.fill",
                            addressLine1: "### Street Ave.",
                            addressLine2: "City, ZIPCODE")]
    
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
