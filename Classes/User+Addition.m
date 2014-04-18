//
//  User+Addition.m
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/18/14.
//
//

#import "User+Addition.h"

@implementation User (Addition)
+(NSArray *)arrayMappingResponse
{
    return @[@"objectId",@"username",@"password",@"authData",@"email", @"createdAt",@"updatedAt"];
}

+(NSDictionary *)dictionaryMappingResponse
{
    return @{@"objectId":@"objectId",@"username":@"username",@"password":@"password",@"authData":@"authData",@"email":@"email", @"createdAt":@"createdAt",@"updatedAt":@"updatedAt"};
}
@end
