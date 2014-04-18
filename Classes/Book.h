//
//  Book.h
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/18/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * copyright;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * updatedAt;
@property (nonatomic, retain) NSManagedObject *user;

@end
