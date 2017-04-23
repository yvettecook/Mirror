import Vapor
import Kanna

struct Parser {

    func athleteName(from html: String) -> String? {
        var name: String?
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            for header in doc.css("h2") {
                guard let nameHeader = header.text
                    else {
                        break
                }
                let components = nameHeader.components(separatedBy: "(")
                let nameComponent = components[0]
                name = nameComponent.substring(to: nameComponent.index(before: nameComponent.endIndex)).capitalized
            }
        }
        return name
    }

    func totalRuns(from html: String) -> Int? {
        var totalRuns: Int?
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            for header in doc.css("h2") {
                guard let nameHeader = header.text
                    else {
                        break
                }
                let components = nameHeader.components(separatedBy: "(")
                let totalRunsString = components[1].components(separatedBy: " ")[0]
                totalRuns = Int(totalRunsString)
            }
        }
        return totalRuns
    }

    func runs(from html: String) -> [Run]{

        var runs = [Run]()

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            for table in doc.css("table[id^='results']") {
                for body in table.css("tbody") {
                    for row in body.css("tr") {
                        var attributes = [String]()
                        for cell in row.css("td") {
                            attributes.append(cell.text!)
                        }
                        if let tryRun = try? Run(array: attributes),
                            let run = tryRun {
                            runs.append(run)
                        }
                    }
                }
            }
        }
        return runs
    }

}
