import Foundation

/*
{
  "id": "69",
  "name": "Batman",
  "powerstats": {
    "intelligence": "81",
    "strength": "40",
    "speed": "29",
    "durability": "55",
    "power": "63",
    "combat": "90"
  },
  "biography": {
    "full-name": "Terry McGinnis",
    "alter-egos": "No alter egos found.",
    "aliases": [
      "Batman II",
      "The Tomorrow Knight",
      "The second Dark Knight",
      "The Dark Knight of Tomorrow",
      "Batman Beyond"
    ],
    "place-of-birth": "Gotham City, 25th Century",
    "first-appearance": "Batman Beyond #1",
    "publisher": "DC Comics",
    "alignment": "good"
  },
  "appearance": {
    "gender": "Male",
    "race": "Human",
    "height": [
      "5'10",
      "178 cm"
    ],
    "weight": [
      "170 lb",
      "77 kg"
    ],
    "eye-color": "Blue",
    "hair-color": "Black"
  },
  "work": {
    "occupation": "-",
    "base": "21st Century Gotham City"
  },
  "connections": {
    "group-affiliation": "Batman Family, Justice League Unlimited",
    "relatives": "Bruce Wayne (biological father), Warren McGinnis (father, deceased), Mary McGinnis (mother), Matt McGinnis (brother)"
  },
  "image": {
    "url": "https://www.superherodb.com/pictures2/portraits/10/100/10441.jpg"
  }
}
 */

class SuperHero: Decodable {
  var response: String?
  var id: String
  var name: String
  var powerstats: Powerstats
  var biography: Biography
  var appearance: Appearance
  var work: Work
  var connections: Connections
  var image: Image
}

struct Powerstats: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    intelligence = Int(try values.decode(String.self, forKey: .intelligence)) ?? 0
    strength = Int(try values.decode(String.self, forKey: .strength)) ?? 0
    speed = Int(try values.decode(String.self, forKey: .speed)) ?? 0
    durability = Int(try values.decode(String.self, forKey: .durability)) ?? 0
    power = Int(try values.decode(String.self, forKey: .power)) ?? 0
    combat = Int(try values.decode(String.self, forKey: .combat)) ?? 0
  }
  var intelligence: Int
  var strength: Int
  var speed: Int
  var durability: Int
  var power: Int
  var combat: Int

  enum CodingKeys: String, CodingKey {
  case intelligence
  case strength
  case speed
  case durability
  case power
  case combat
  }
}

struct Biography: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    fullname = try values.decode(String.self, forKey: .fullname)
    alteregos = try values.decode(String.self, forKey: .alteregos)
    aliases = try values.decode([String].self, forKey: .aliases)
    placeofbirth = try values.decode(String.self, forKey: .placeofbirth)
    firstappearance = try values.decode(String.self, forKey: .firstappearance)
    publisher = try values.decode(String.self, forKey: .publisher)
    alignment = try values.decode(String.self, forKey: .alignment)
  }

  var fullname: String
  var alteregos: String
  var aliases: [String]
  var placeofbirth: String
  var firstappearance: String
  var publisher: String
  var alignment: String

  enum CodingKeys: String, CodingKey {
  case fullname = "full-name"
  case alteregos = "alter-egos"
  case aliases
  case placeofbirth = "place-of-birth"
  case firstappearance = "first-appearance"
  case publisher
  case alignment
  }
}

struct Appearance: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    gender = try values.decode(String.self, forKey: .gender)
    race = try values.decode(String.self, forKey: .race)
    height = try values.decode([String].self, forKey: .height)
    weight = try values.decode([String].self, forKey: .weight)
    eyecolor = try values.decode(String.self, forKey: .eyecolor)
    haircolor =  try values.decode(String.self, forKey: .haircolor)
  }
  var gender: String // Could better be enum
  var race: String // Could better be enum
  var height: [String]
  var weight: [String]
  var eyecolor: String
  var haircolor: String

  enum CodingKeys: String, CodingKey {
  case gender
  case race
  case height
  case weight
  case eyecolor = "eye-color"
  case haircolor = "hair-color"
  }
}

struct Work: Decodable {
  var occupation: String
  var base: String
}

struct Connections: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    groupaffiliation = try values.decode(String.self, forKey: .groupaffiliation)
    relatives = try values.decode(String.self, forKey: .relatives)
  }

  var groupaffiliation: String
  var relatives: String

  enum CodingKeys: String, CodingKey {
  case groupaffiliation = "group-affiliation"
  case relatives
  }
}

struct Image: Decodable {
  var url: String
}
