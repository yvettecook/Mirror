import Vapor
import HTTP

final class AthleteController: ResourceRepresentable {

    func fetch(_ athleteID: AthleteID, drop: Droplet) throws -> ResponseRepresentable {
        let parkrunResponse = try drop.client.get("https://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=\(athleteID)")

        var runs = [Run]()
        var name = "Unknown"
        var totalRuns = 0

        switch parkrunResponse.body {
        case .data(let bytes):
            if let str = String(bytes: bytes, encoding: .utf8) {
                runs = Parser().runs(from: str)
                if let nameStr = Parser().athleteName(from: str) {
                    name = nameStr
                }
                if let totalRunsTry = Parser().totalRuns(from: str) {
                    totalRuns = totalRunsTry
                }
            } else {
                print("not a valid UTF-8 sequence")
            }
        case .chunked:
            print("BOOOOO")
        }

        return try JSON(
          node: [
            "athleteID": athleteID,
            "athleteName": name,
            "totalRuns": totalRuns,
            "runs": JSON(node: runs.makeNode(in: nil))
          ]
        )
    }

    func makeResource() -> Resource<Athlete> {
        return Resource(
            //show: show
        )
    }

}
