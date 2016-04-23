//
//  NSMutableDictionary+shopCarDictionary.m
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "NSMutableDictionary+shopCarDictionary.h"
#import "FruitInfoTableViewCell.h"
#import "detailFruit.h"


@implementation NSMutableDictionary (shopCarDictionary)


+(NSMutableDictionary *)setDictByObj:(id)obj WithNum:(int)num{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *fruitId;
    NSString *name;
    NSString *price;
    NSString *mainImgUrl;
    if ([obj class] == [FruitInfoTableViewCell class]) {
        FruitInfoTableViewCell *cell = (FruitInfoTableViewCell *)obj;
        fruitId = [NSString stringWithFormat:@"%d",cell.fruitList.id];
        name = cell.fruitList.fruitName;
        price = [NSString stringWithFormat:@"%.1f",cell.fruitList.privilegePrice];
        mainImgUrl = cell.fruitList.mainImgUrl;
        
    }else if ([obj class] == [detailFruit class]){
        detailFruit *fruit = (detailFruit *)obj;
        fruitId = [NSString stringWithFormat:@"%d",fruit.id];
        name = fruit.fruitName;
        price = [NSString stringWithFormat:@"%.1f",fruit.privilegePrice];
        mainImgUrl = fruit.mainImgUrl;
    }
    [dict setValue:fruitId forKey:shopCar_Fruit_Id_Key];
    [dict setValue:name forKey:shopCar_Fruit_Name_Key];
    [dict setValue:price forKey:shopCar_Fruit_Price_Key];
    [dict setValue:[NSString stringWithFormat:@"%d",num] forKey:shopCar_Fruit_Num_Key];
    [dict setValue:mainImgUrl forKey:shopCar_Fruit_Img_Key];
    return dict;
}

@end
