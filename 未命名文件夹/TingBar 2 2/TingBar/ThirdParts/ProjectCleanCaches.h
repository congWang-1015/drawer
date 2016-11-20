//
//  ProjectCleanCaches.h
//  SecondHand_News
//
//  Created by 邹明 on 14-9-23.
//  Copyright (c) 2014年 邹明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectCleanCaches : NSObject
/**
 *  一个工具类，主要是遍历path下文件或文件夹下的所有文件并计算总size。返回一个double类型以MB为单位的数值。并配有删除path的功能。具体应用在大多应用程序的清除缓存功能上，只要传一个path就可以显示缓存大小。也可以清除缓存。
 *
 *  @param double
 *
 *  @return
 */
/**
 *  返回path路径下文件的文件大小。
 */
+ (double)sizeWithFilePaht:(NSString *)path;

/**
 *  删除path路径下的文件。
 */
+ (void)clearCachesWithFilePath:(NSString *)path;
/**
 *  获取沙盒Caches的文件目录。
 */
+ (NSString *)CachesDirectory;
@end
