import UIKit
class Api {

    static let catImages: [String] = ["100", "200", "400", "101", "102"]

    static func getCatImage() -> UIImage {
        let url = URL(string: "https://http.cat/\(catImages.randomElement() ?? "404")")
        var image = UIImage()
            do {
                let data = try Data(contentsOf: url!)
                image = UIImage(data: data)!
            } catch {
                print("Error to get images from GET Method")
            }
        return image
    }
}
