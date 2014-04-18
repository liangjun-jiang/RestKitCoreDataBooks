//
//  Book+Addition.m
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/18/14.
//
//

#import "Book+Addition.h"

@implementation Book (Addition)
+(NSArray *)arrayForResponseMapping
{
    return @[@"title",@"author", @"copyright", @"objectId",@"createdAt",@"updatedAt"];
}

+(NSDictionary *)dictionaryForResponseMapping
{
    return @{@"title":@"title",@"author":@"author", @"copyright":@"copyright"};
    
}
@end
