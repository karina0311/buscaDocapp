//
//  Login.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 29/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Login.h"
#import "URLS json.h"
#import "UIImageView+AFNetworking.h"

@implementation Login

NSString *correctpass;
NSDictionary *respuesta2;
NSNumber *idpatient;


static Login *sharedMyManager;

+ (id)sharedManager{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedMyManager = [[Login alloc] init];
        
        
    });
    
    return sharedMyManager;
}


+(void) jsonLoginConUsuario:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario{
    Login *objetoLogin = [Login sharedManager];
    


    NSDictionary *consulta = @{@"usuario": NombreUsuario};
    
    NSLog(@"%@", consulta);

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:login parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        

        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        NSDictionary * diccionario2=  respuesta2[@"user"];
        correctpass= diccionario2[@"password"];
        idpatient =diccionario2[@"idpatient"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:idpatient forKey:@"IDPatient"];
        
        
        
        if ([correctpass isEqualToString:ContraseñaUsuario]) {
            
            [objetoLogin.delegate loginExito];
            
        }else if([NombreUsuario isEqualToString:@""] && [ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar usuario y contrasena
            [objetoLogin.delegate loginFallo:@"Debe ingresar Usuario y/o Contraseña"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario y/o Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [miAlert show];
             self.cargando.alpha = 0 ;*/
            
        }else if([NombreUsuario isEqualToString:@""] && ![ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar usuario
            [objetoLogin.delegate loginFallo:@"Debe ingresar Usuario"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [miAlert show];
             self.cargando.alpha = 0 ;*/
            
        }else if(![NombreUsuario isEqualToString:@""] && [ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar contrasenha
            [objetoLogin.delegate loginFallo:@"Debe ingresar Contraseña"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [miAlert show];
             self.cargando.alpha = 0 ;*/
        }
        else {
            [objetoLogin.delegate loginFallo:@"Usuario o contraseña incorrecta" ];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Usuario o contraseña incorrecta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [miAlert show];
             self.cargando.alpha = 0 ;*/
        }
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        [objetoLogin.delegate falloServidor];
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
         message:[error localizedDescription]
         delegate:nil
         cancelButtonTitle:@"Ok"
         otherButtonTitles:nil];
         [alertView show];
         self.cargando.alpha = 0 ;*/
    }];
    
    
}


@end
