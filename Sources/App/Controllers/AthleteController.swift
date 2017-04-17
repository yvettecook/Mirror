import Vapor
import HTTP

final class AthleteController: ResourceRepresentable {

    func show(request: Request, athlete: Athlete) throws -> ResponseRepresentable {
        return try JSON(node: ["athleteID": 1])
    }

    func fetch(_ athleteID: AthleteID) throws -> ResponseRepresentable {
        return try JSON(node: ["athleteID": 1, "athleteName": "Huzzah"])
    }

    func makeResource() -> Resource<Athlete> {
        return Resource(
            show: show
        )
    }

}
