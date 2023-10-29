//
//  File.swift
//
//
//  Created by Noah Kamara on 16.10.23.
//
import GazetteCore
import FeedKit
import Foundation
import UniformTypeIdentifiers

struct FeedKitParser: FeedParsing {
	func parse(url: URL) async throws -> TransientFeed {
		let parser = FeedKit.FeedParser(URL: url)
		
		let feed = try parser.parse().get()
		
		return switch feed {
		case .rss(let feed):
			parse(feed, url: url)
		default:
			throw Err.unsupportedFeedType
		}
	}
	
	private func parse(_ feed: RSSFeed, url: URL) -> TransientFeed {
		let articles: [TransientArticle]? = feed.items?.compactMap({ (item: RSSFeedItem) -> TransientArticle? in
			guard let link = item.link, let url = URL(string: link) else {
				return nil
			}
			
			let image: TransientAsset? = {
				if let attr = item.enclosure?.attributes,
				   UTType(mimeType: attr.type ?? "")?.conforms(to: .image) == true,
				   let url = URL(string: attr.url ?? "")
				{
					TransientAsset(url: url)
				} else {
					nil
				}
			}()
			//			let image = nil
			//			print(item.)
			return TransientArticle(
				url: url,
				title: item.title,
				description: item.description,
				pubDate: item.pubDate,
				image: image
			)
		})
		
		let image: TransientAsset? = if let feedImg = feed.image, let url = URL(string: feedImg.url ?? "") {
			TransientAsset(url: url)
		} else {
			nil
		}
		
		let link = feed.link.map(URL.init(string:))?.map({ $0 })
		
		return TransientFeed(
			url: url,
			link: link,
			title: feed.title,
			image: image,
			articles: articles ?? []
		)
	}
}
