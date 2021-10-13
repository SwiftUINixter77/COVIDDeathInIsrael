import Cocoa

// MARK: - JSONNew
struct JSONNew: Decodable {
    let Country: String
    let Cases: Int
    let Status: String
    let Date: String
}

typealias JSONNews = [JSONNew]

let url = URL(string: "https://api.covid19api.com/dayone/country/israel/status/confirmed")
let request = URLRequest(url: url!)

URLSession.shared.dataTask(with: request) { (data, _, Err) in
    if Err != nil {
        print(Err!.localizedDescription)
        return
    }
    guard let data = data else { return }
    
    print(data)
    
    let decoder = JSONDecoder()
    guard let jsonData = try? decoder.decode([JSONNew].self, from: data) else {
        return
    }
    
    for i in jsonData {
        let date = i.Date.dropLast(10)
        print(i.Country, date ,i.Cases)
    }
    
}.resume()

