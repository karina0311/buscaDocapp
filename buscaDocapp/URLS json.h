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

//ip de la cato: 10.101.33.4
//ip de mi casa: 192.168.0.105

#define listaespecialidades @"http://192.168.0.105:8080/tesis2Karina/services/getAllSpecialtiesJSON"
#define docsxespecialidad @"http://192.168.0.105:8080/tesis2Karina/services/getAllDoctorsBySpecialtyJSON"
#define listadistritos @"http://192.168.0.105:8080/tesis2Karina/services/getAllDistrictsJSON"
#define listaseguros @"http://192.168.0.105:8080/tesis2Karina/services/getAllInsurancesJSON"
#define listaclinicas @"http://192.168.0.105:8080/tesis2Karina/services/getAllClinicsJSON"
#define docsxclinica @"http://192.168.0.105:8080/tesis2Karina/services/getAllDoctorsByClinicJSON"
#define docsxdistrito @"http://192.168.0.105:8080/tesis2Karina/services/getAllDoctorsByDistrictJSON"

#define docsbusqueda @"http://192.168.0.105:8080/tesis2Karina/services/getDoctorsBySearch"

#define clinicaxid @"http://192.168.0.105:8080/tesis2Karina/services/getClinicByIdJSON"

#define horarioxdoc @"http://192.168.0.105:8080/tesis2Karina/services/getSchedulesByDoctorJSON"

#define bloquexhorario @"http://192.168.0.105:8080/tesis2Karina/services/getBlocksByDateSchedule"

#define guardaPaciente @"http://192.168.0.105:8080/tesis2Karina/services/savePatient"

#define guardaUser @"http://192.168.0.105:8080/tesis2Karina/services/saveUser"

#define guardaCita @"http://192.168.0.105:8080/tesis2Karina/services/saveAppointment"

#define sacaUltimoPaciente @"http://192.168.0.105:8080/tesis2Karina/services/getLastPatientJSON"

#define login @"http://192.168.0.105:8080/tesis2Karina/services/Login"

#define guardaSegurosxPaciente @"http://192.168.0.105:8080/tesis2Karina/services/saveInsurancesPatient"

#define sacaCitasporPaciente @"http://192.168.0.105:8080/tesis2Karina/services/getAppointmentsbyPatient"

#define sacaDocsporPaciente @"http://192.168.0.105:8080/tesis2Karina/services/getDoctorsbyPatient"

#define sacaEspecialidadporPaciente @"http://192.168.0.105:8080/tesis2Karina/services/getSpecialtybyPatient"

#define sacaClinicaporPaciente @"http://192.168.0.105:8080/tesis2Karina/services/getClinicsbyPatient"

@end
