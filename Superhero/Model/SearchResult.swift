/*
{
  "response": "success",
  "results-for": "batman",
  "results": [
  ]
}
 */
import Foundation

struct SearchResult: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    response = try values.decode(String.self, forKey: .response)
    resultsfor = try values.decode(String.self, forKey: .resultsfor)
    results = try values.decode([SuperHero].self, forKey: .results)
  }
  var response: String
  var resultsfor: String
  var results: [SuperHero]

  enum CodingKeys: String, CodingKey {
  case response
  case resultsfor = "results-for"
  case results
  }
}
