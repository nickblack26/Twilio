import Foundation
import SwiftData

let username = ""
let password = ""
let loginString = String(format: "%@:%@", username, password)
let loginData = loginString.data(using: String.Encoding.utf8)!
let base64LoginString = loginData.base64EncodedString()

struct StudioFlowCollection: Decodable {
    let flows: [StudioFlow]
    
    struct StudioFlow: Decodable {
        let status: String?
        let dateUpdated: Date?
        let friendlyName: String?
        let accountSid: String?
        let dateCreated: Date?
        let url: String?
        let valid: Bool?
        let sid: String?
        let revision: Int?
        
        enum CodingKeys: String, CodingKey {
            case status
            case dateUpdated = "date_updated"
            case friendlyName = "friendly_name"
            case accountSid = "account_sid"
            case dateCreated = "date_created"
            case url
            case valid
            case sid
            case revision
        }
    }
}

extension StudioFlowCollection {
    static func fetchFlows() async throws -> StudioFlowCollection {
        /// Geological data provided by the U.S. Geological Survey (USGS). See ACKNOWLEDGMENTS.txt for additional details.
        let url = URL(string: "https://studio.twilio.com/v2/Flows?PageSize=20")!
        var request = URLRequest(url: url)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        guard let (data, response) = try? await session.data(for: request),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw DownloadError.missingData
        }
        
        do {
            // Decode the GeoJSON into a data model.
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            return try jsonDecoder.decode(StudioFlowCollection.self, from: data)
        } catch {
            throw DownloadError.wrongDataFormat(error: error)
        }
    }
}

extension StudioFlowCollection {
    @MainActor
    static func refresh(modelContext: ModelContext) async {
        do {
            // Fetch the latest set of quakes from the server.
            print("Refreshing the data store...")
            let featureCollection = try await fetchFlows()
            print("Loaded feature collection:\n\(featureCollection)")
            
            // Add the content to the data store.
            for studioFlow in featureCollection.flows {
                let flow = Flow(from: studioFlow)
                
                // Ignore anything with a magnitude of zero or less.
                modelContext.insert(flow)
            }
            
            print("Refresh complete.")
            
        } catch let error {
            print(error)
        }
    }
}

/// The kinds of errors that occur when loading feature data.
enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
}
