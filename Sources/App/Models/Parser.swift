import Vapor
import Kanna

struct Parser {

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
