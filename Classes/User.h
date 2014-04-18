//
//  User.h
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/18/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * authData;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * updatedAt;



@end
