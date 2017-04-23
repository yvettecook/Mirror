@_exported import Vapor
import FluentProvider

public func setup(_ drop: Droplet) throws {
    try setupProviders(drop)
    try setupModels(drop)
    try setupRoutes(drop)
    try setupResources(drop)
}

private func setupProviders(_ drop: Droplet) throws {
    let fluent = FluentProvider.Provider()
    try drop.addProvider(fluent)
}

private func setupModels(_ drop: Droplet) throws {
    drop.preparations += [
        Post.self
    ]
}

private func setupRoutes(_ drop: Droplet) throws {
    drop.get { req in req.description }

    let athleteController = AthleteController()

    drop.get("athlete", ":id") { request in
        guard let athleteID = request.parameters["id"]?.int else {
            throw Abort.badRequest
        }

        return try athleteController.fetch(athleteID, drop: drop)
    }

}

private func setupResources(_ drop: Droplet) throws {
    drop.resource("athlete", AthleteController())
}
