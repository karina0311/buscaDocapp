//
//  Login.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 29/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol loginDelegate <NSObject>
@optional
-(void)loginExito;
-(void)loginFallo:(NSString*)mensaje;
-(void)falloServidor;
@end

@interface Login : NSObject

@property (nonatomic, weak) id <loginDelegate> delegate;

+ (id)sharedManager;
+(void) jsonLoginConUsuarioPersistente:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario;
+(void) jsonLoginConUsuario:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario;
@end
