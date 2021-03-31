
import Foundation

struct Multimedia : Codable {
	let url : String?
	let format : String?
	let height : Int?
	let width : Int?
	let type : String?
	let subtype : String?
	let caption : String?
	let copyright : String?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case format = "format"
		case height = "height"
		case width = "width"
		case type = "type"
		case subtype = "subtype"
		case caption = "caption"
		case copyright = "copyright"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		format = try values.decodeIfPresent(String.self, forKey: .format)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
		caption = try values.decodeIfPresent(String.self, forKey: .caption)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
	}

}
