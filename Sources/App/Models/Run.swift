import Vapor

public struct HTMLParsingError: Error {
    let modelName: String
    let string: String
}

protocol HTMLInitialisable {
    init?(array: [String]) throws
}

struct Run {
    let venue: String
    let date: String
    let genderPosition: String
    let overallPosition: String
    let time: String
    let agePercent: String

    // TODO - This is obviously incredibly fragile. Improve!
}

extension Run: HTMLInitialisable {
    init?(array: [String]) throws {
        if array.count == 6 {
            self.venue = array[0]
            self.date = array[1]
            self.genderPosition = array[2]
            self.overallPosition = array[3]
            self.time = array[4]
            self.agePercent = array[5]
        } else {
            throw HTMLParsingError(modelName: "Run", string: "\(array)")
        }
    }
}

extension Run: JSONRepresentable {
    func makeJSON() throws -> JSON {
        return try JSON(node: [
                "venue": venue,
                "date": date,
                "genderPosition": genderPosition,
                "overallPosition": overallPosition,
                "time": time,
                "agePercent": agePercent
            ]
        )

    }
}

extension Run: NodeRepresentable {

    func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "venue": venue,
            "date": date,
            "genderPosition": genderPosition,
            "overallPosition": overallPosition,
            "time": time,
            "agePercent": agePercent
        ])
    }
}
