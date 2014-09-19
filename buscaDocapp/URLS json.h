//
//  URLS json.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 11/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLS_json : NSObject

//Cambiar la ip segun corresponda

//ip de la cato: 10.100.12.112
//ip de mi casa: 192.168.0.105

#define listaespecialidades @"http://192.168.0.104:8080/tesis2Karina/services/getAllSpecialtiesJSON"
#define docsxespecialidad @"http://192.168.0.104:8080/tesis2Karina/services/getAllDoctorsBySpecialtyJSON"
#define listadistritos @"http://192.168.0.104:8080/tesis2Karina/services/getAllDistrictsJSON"
#define listaseguros @"http://192.168.0.104:8080/tesis2Karina/services/getAllInsurancesJSON"
#define listaclinicas @"http://192.168.0.104:8080/tesis2Karina/services/getAllClinicsJSON"
#define docsxclinica @"http://192.168.0.104:8080/tesis2Karina/services/getAllDoctorsByClinicJSON
#define docsxdistrito @"http://192.168.0.104:8080/tesis2Karina/services/getAllDoctorsByDistrictJSON"



@end
