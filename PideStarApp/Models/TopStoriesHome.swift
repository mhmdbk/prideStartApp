

import Foundation

struct TopStoriesHome : Codable {
	let status : String?
	let copyright : String?
	let section : String?
	let last_updated : String?
	let num_results : Int?
	let results : [Results]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case copyright = "copyright"
		case section = "section"
		case last_updated = "last_updated"
		case num_results = "num_results"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		section = try values.decodeIfPresent(String.self, forKey: .section)
		last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated)
		num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
		results = try values.decodeIfPresent([Results].self, forKey: .results)
	}

}
