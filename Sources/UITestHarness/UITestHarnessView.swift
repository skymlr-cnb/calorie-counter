#if DEBUG
  #if canImport(SwiftUI)
    import SwiftUI
    import Domain
    import Data

    public struct UITestHarnessView: View {
      @State private var query: String = ""
      @State private var results: [FoodItem] = []
      @State private var total: Int = 0

      let service: FoodSearchService
      let counter = CalorieCounter()

      public init(service: FoodSearchService = FoodSearchRepository()) {
        self.service = service
      }

      public var body: some View {
        VStack {
          TextField("Search", text: $query)
            .textFieldStyle(.roundedBorder)
            .padding()
          Button("Search") {
            let q = query
            let svc = service
            Task {
              results = (try? await svc.search(query: q)) ?? []
            }
          }
          List {
            ForEach(results) { item in
              HStack {
                VStack(alignment: .leading) {
                  Text(item.name)
                  Text("\(item.caloriesPer100g) kcal/100g")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Button("Add") {
                  let food = item
                  Task {
                    _ = await counter.add(item: food)
                    total = await counter.totalCalories()
                  }
                }
              }
            }
          }
          Text("Total: \(total) kcal")
            .font(.title)
            .padding()
        }
      }
    }
  #endif
#endif

struct UITestHarnessView_Previews: PreviewProvider {
    static var previews: some View {
        UITestHarnessView()
    }
}
