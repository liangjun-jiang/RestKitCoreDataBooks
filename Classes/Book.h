//
//  Book.h
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/20/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag, User;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * copyright;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * updatedAt;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
