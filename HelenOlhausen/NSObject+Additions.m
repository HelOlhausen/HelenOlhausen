//
//  NSObject+Additions.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/23/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

-(id)valueOrNil
{
    return [self isMemberOfClass:[NSNull class]] ? nil : self;
}

@end
