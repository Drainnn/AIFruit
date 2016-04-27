//
//  UserInfo.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "UserInfo.h"

#define key_Id @"id"
#define key_MobileNo @"mobileNo"
#define key_Password @"password"
#define key_Username @"username"
#define key_HeadImgId @"headImgID"
#define key_Sex @"sex"
#define key_Grade @"grade"
#define key_Allpoint @"allPoint"
#define key_Currentpoint @"currentPoint"
#define key_RegistTime @"registTime"

@implementation UserInfo

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.id forKey:key_Id];
    [aCoder encodeObject:self.mobileNo forKey:key_MobileNo];
    [aCoder encodeObject:self.password forKey:key_Password];
    [aCoder encodeObject:self.username forKey:key_Username];
    [aCoder encodeInt:self.headImgID forKey:key_HeadImgId];
    [aCoder encodeInt:self.sex forKey:key_Sex];
    [aCoder encodeInt:self.grade forKey:key_Grade];
    [aCoder encodeInt:self.allPoint forKey:key_Allpoint];
    [aCoder encodeInt:self.currentPoint forKey:key_Currentpoint];
    [aCoder encodeObject:self.registTime forKey:key_RegistTime];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.id = [aDecoder decodeIntForKey:key_Id];
        self.mobileNo = [aDecoder decodeObjectForKey:key_MobileNo];
        self.password = [aDecoder decodeObjectForKey:key_Password];
        self.username = [aDecoder decodeObjectForKey:key_Username];
        self.headImgID = [aDecoder decodeIntForKey:key_HeadImgId];
        self.sex = [aDecoder decodeIntForKey:key_Sex];
        self.grade = [aDecoder decodeIntForKey:key_Grade];
        self.allPoint = [aDecoder decodeIntForKey:key_Allpoint];
        self.currentPoint = [aDecoder decodeIntForKey:key_Currentpoint];
        self.registTime = [aDecoder decodeObjectForKey:key_RegistTime];
    }
    return self;
}


@end
