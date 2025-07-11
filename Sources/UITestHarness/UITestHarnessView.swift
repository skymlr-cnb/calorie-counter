#if DEBUG
  #if canImport(SwiftUI)
    import SwiftUI
    import Domain
    import Data

    public struct UITestHarnessView: View {
      @State private var query: String = ""
      @State private var results: [FoodItem] = []
      @State private var total: Int = 0
      @State private var isLoading: Bool = false

      let service: FoodSearchService
      let counter = CalorieCounter()

      public init(service: FoodSearchService = LLMFoodSearchRepository(client: URLLLMClient(url: URL(string: "https://api-inference.huggingface.co/models/google/flan-t5-base")!))) {
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
            isLoading = true
            Task {
              do {
                let newResults = try await svc.search(query: q)
                await MainActor.run {
                  results = newResults
                  isLoading = false
                }
              } catch {
                print("[UITestHarnessView] Search failed: \(error)")
                await MainActor.run {
                  results = []
                  isLoading = false
                }
              }
            }
          }
          if isLoading {
            ProgressView().padding()
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

#if DEBUG
  #if canImport(SwiftUI)
    struct UITestHarnessView_Previews: PreviewProvider {
        static var previews: some View {
            UITestHarnessView()
        }
    }
  #endif
#endif
