import Foundation

let TopAppURL = "http://www.nytimes.com/svc/video/api/playlist/1194811622182"

class DataManager {
    class func getLatestVideosWithSuccess(success: ((playlist: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: TopAppURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(playlist: urlData)
            }
        })
    }
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}