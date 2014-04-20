//
//  Tag.h
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/20/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * updatedAt;
@property (nonatomic, retain) Book *book;

@end
