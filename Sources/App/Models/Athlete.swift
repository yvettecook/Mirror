import Vapor
import FluentProvider
import HTTP

typealias AthleteID = Int

final class Athlete: Model {
    let storage = Storage()

    let id: AthleteID
    let name: String

    init(id: AthleteID, name: String) {
        self.id = id
        self.name = name
    }

    init(row: Row) throws {
        self.id = try row.get("id")
        self.name = try row.get("name")
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set("id", id)
        try row.set("name", name)
        return row
    }
}
