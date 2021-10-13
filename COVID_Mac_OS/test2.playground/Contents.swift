import Cocoa

import Foundation

// MARK: - JSONNews
struct JSONNews: Codable {
    let location: Location
    let updatedDateTime: String
    let stats: Stats
}

// MARK: - Location
struct Location: Codable {
    let long: Int
    let countryOrRegion: String
    let provinceOrState, county: JSONNull?
    let isoCode: String
    let lat: Int
}

// MARK: - Stats
struct Stats: Codable {
    let totalConfirmedCases, newlyConfirmedCases, totalDeaths, newDeaths: Int
    let totalRecoveredCases, newlyRecoveredCases: Int
    let history: [History]?
    let breakdowns: [Stats]?
    let location: Location?
}

// MARK: - History
struct History: Codable {
    let date: String
    let confirmed, deaths, recovered: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


let headers = [
    "x-rapidapi-key": "7ef48cce5cmshfe8f4534ae51207p137766jsn6b9bfa80283b",
    "x-rapidapi-host": "coronavirus-smartable.p.rapidapi.com"
]

let request = NSMutableURLRequest(url: NSURL(string: "https://coronavirus-smartable.p.rapidapi.com/stats/v1/IL/")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
       // print(httpResponse)
    }
    
    let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
    //print(json!)
    
    let decoder = JSONDecoder()
    let jsonData = try? decoder.decode(JSONNews.self, from: data!)
    //print(jsonData?.stats.history)
    
    print(jsonData?.stats.newlyConfirmedCases)
    
//    for date in jsonData!.stats.history! {
//        print(date.date)
//        print("death:\(date.deaths)")
//        print("confirmed:\(date.confirmed)")
//        print("recovered:\(date.recovered)\n")
//    }
})

dataTask.resume()
