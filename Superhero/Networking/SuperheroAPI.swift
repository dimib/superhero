import Foundation
//import FoundationNetworking

public class SuperheroAPI {

  let accessToken: String!
  let api: String!

  init(withAccessToken accessToken: String) {
      self.accessToken = accessToken
      self.api = "https://superheroapi.com/api/\(accessToken)"
  }

  func search(name: String, onCompletion: @escaping ((Result<[SuperHero], SuperheroError>) -> Void) ) -> Void {
    let path = "\(api!)/search/\(name)"

    guard let url = URL(string: path) else { onCompletion(.failure(.wrongUrl)); return }

    get(url: url) { (result) in
      switch result {
      case .success(let data):
          let decoder = JSONDecoder()
          do {
            let searchResult = try decoder.decode(SearchResult.self, from: data)
            let superheros = searchResult.results
            // print("Superheros: \(superheros)")
            onCompletion(.success(superheros))
          } catch {
            print("\(error)")
            onCompletion(.failure(.noData))
          }
      case .failure(let error):
        onCompletion(.failure(.networkError))
      }
    }
  }

  func getById(id: Int, onCompletion: @escaping ((Result<SuperHero, SuperheroError>) -> Void)) {
    let path = "\(api)/\(id)"

    guard let url = URL(string: path) else { onCompletion(.failure(.wrongUrl)); return }

    get(url: url) { result in
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        do {
          let superhero = try decoder.decode(SuperHero.self, from: data)
          onCompletion(.success(superhero))
        } catch {
          print("\(error)")
          onCompletion(.failure(.noData))
        }
      case .failure(let error):
        onCompletion(.failure(.networkError))
      }
    }
  }

  private func get(url: URL, onCompletion: @escaping ((Result<Data, SuperheroError>) -> Void)) {
    print("get \(url)")
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else { onCompletion(.failure(.networkError)); return }
      switch httpResponse.statusCode {
      case 200:
        print("Success")
        if let data = data {
          onCompletion(.success(data))
        } else {
          onCompletion(.failure(.noData))
        }
      case 401, 403:
        print("Not authorized")
        onCompletion(.failure(.notAuthorized))
      case 404:
        print("Not found")
        onCompletion(.failure(.notFound))
      default:
        print("Other status \(httpResponse.statusCode)")
        onCompletion(.failure(.networkError))
      }
    })
    task.resume()
  }

}
