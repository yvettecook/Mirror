import Vapor
import HTTP

final class AthleteController: ResourceRepresentable {

    func show(request: Request, athlete: Athlete) throws -> ResponseRepresentable {
        return try JSON(node: ["athleteID": 1])
    }

    func fetch(_ athleteID: AthleteID, drop: Droplet) throws -> ResponseRepresentable {
        let parkrunResponse = try drop.client.get("https://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=\(athleteID)")

        var runs = [Run]()

        switch parkrunResponse.body {
        case .data(let bytes):
            if let str = String(bytes: bytes, encoding: .utf8) {
                let x = Parser().runs(from: str)
                runs = x
            } else {
                print("not a valid UTF-8 sequence")
            }
        case .chunked:
            print("BOOOOO")
        }

        return try JSON(
          node: [
            "athleteID": athleteID,
            "runs": JSON(node: runs.makeNode(in: nil))
          ]
        )
    }

    func makeResource() -> Resource<Athlete> {
        return Resource(
            show: show
        )
    }

}
