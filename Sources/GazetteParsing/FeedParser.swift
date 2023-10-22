//
//  File.swift
//
//
//  Created by Noah Kamara on 16.10.23.
//
import Foundation
import GazetteCore
import FaviconFinder

public struct FeedParser: FeedParsing {
	
	public init() {}
	
	private var rssParser: FeedKitParser {
		FeedKitParser()
	}
	
	public func parse(url: URL) async throws -> TransientFeed {
		try await Task {
			var feed = try await rssParser.parse(url: url)
			
			if let link = feed.link {
				do {
					let favicon = try await FaviconFinder(url: link).downloadFavicon()
					
					feed.icon = TransientAsset(
						url: favicon.url,
						data: favicon.data
					)
				} catch let error {
					print("Error: \(error)")
				}
			}
			return feed
		}.value
	}
}
