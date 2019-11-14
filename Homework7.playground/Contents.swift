import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

struct Book: Codable {
    let title: String
    let author: String
    let publicationYear: String
    let coverURL: String
}

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.
let books = [Book(title: "Dune", author: "Frank Herbert", publicationYear: "1965", coverURL: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwjB6Yjg0urlAhULRa0KHcegCkAQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FDune-Frank-Herbert%2Fdp%2F0441172717&psig=AOvVaw3Ol-xVfR-wKwvZYQ_XXIiq&ust=1573853344814251"),
             Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", publicationYear: "1979", coverURL: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwjunNKr0-rlAhUMWK0KHQmeA3UQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FHitchhikers-Guide-Galaxy-Douglas-Adams%2Fdp%2F0345391802&psig=AOvVaw33rQQnPz_hI9wIcwF9Mxfd&ust=1573853499128474"),
             Book(title: "The Hobbit", author: "J. R. R. Tolkien", publicationYear: "1937", coverURL: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwjOoen80-rlAhUBKawKHcYKDgsQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FHobbit-J-R-Tolkien%2Fdp%2F054792822X&psig=AOvVaw28syJOwR3yjNCHXQ6nAYGC&ust=1573853677204824"),
             Book(title: "Iliad", author: "Homer", publicationYear: "1260 BC", coverURL: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiIhPK11OrlAhVMIqwKHdZBBRYQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FIliad-Homer%2Fdp%2F0064303985&psig=AOvVaw325D-93kp_pqhhsbYDRbyB&ust=1573853786276027"),
             Book(title: "Small Gods", author: "Terry Pratchett", publicationYear: "1992", coverURL:  "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwi-i4Dp1OrlAhUSWq0KHRU2BAcQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FSmall-Gods-Discworld-Terry-Pratchett%2Fdp%2F0062237373&psig=AOvVaw1rPAICptdgM8uNKFOkt4Hk&ust=1573853904195836")]

func publishBook(book: Book) {
    // MARK: - STEP THREE

    // Now we need to publish this data to the server.

    // Create a URL to connect to the server. Its address is:
    //      https://uofd-tldrserver-develop.vapor.cloud/books

    let serverURL = URL(string: "https://uofd-tldrserver-develop.vapor.cloud/books")!

    // Create a URL request to publish the information, based upon the URL you
    // just created.

    var request = URLRequest(url: serverURL)

    // Add the body to the URL request you just created, by using JSONEncoder.

    request.httpBody = try? JSONEncoder().encode(book)

    // Add a "Content-Type" : "application/json" header to your request, so that
    // the server will properly understand the body of your request.

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    // Set the method of the request to "POST", because we're providing information
    // rather than retrieving it.

    request.httpMethod = "POST"

    // Create a data task for publishing this element, and kick it off with a resume().

    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()

    // MARK: - HELPFUL HINTS
    // You might want to create a method for publishing the data, so that you
    // can effectively loop over an array of books.
    //
    // If you visit the URL for the service in a 'GET' request, it will return a
    // list of books to you. We'll be using this list of books for Project Three.
}

for b in books {
    publishBook(book: b)
}
