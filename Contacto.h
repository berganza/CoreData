//
//  Contacto.h
//  EjercicioCoreData
//
//  Created by LLBER on 12/02/14.
//  Copyright (c) 2014 video2brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contacto : NSManagedObject

@property (nonatomic, retain) NSString * apellidos;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * telefono;

@end
