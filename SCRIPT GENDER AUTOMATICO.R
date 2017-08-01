#CARICAMENTO DATI
require(data.table)
library(readr)
library(plyr)
library(reshape2)
require(tm)
library(stringr)
library(NeuralNetTools)
library(nnet)

#########################                         MY_SQL                      ##########################
#                                                                                                      #
#                                                                                                      #
estra_CATEGORY1 <- read_csv("C:/Users/Giovanni Loizzo/Desktop/GENDER LOIZZO/NEURAL/estra CATEGORY1.csv")
estra_CATEGORY2 <- read_csv("C:/Users/Giovanni Loizzo/Desktop/GENDER LOIZZO/NEURAL/estra CATEGORY2.csv")
estra_CATEGORY3 <- read_csv("C:/Users/Giovanni Loizzo/Desktop/GENDER LOIZZO/NEURAL/estra CATEGORY3.csv")
estra_CATEGORY4 <- read_csv("C:/Users/Giovanni Loizzo/Desktop/GENDER LOIZZO/NEURAL/estra CATEGORY4.csv")
estra_CATEGORY5 <- read_csv("C:/Users/Giovanni Loizzo/Desktop/GENDER LOIZZO/NEURAL/estra CATEGORY5.csv")

estrazione<-rbind.data.frame(estra_CATEGORY1 ,estra_CATEGORY2,estra_CATEGORY3,estra_CATEGORY4,estra_CATEGORY5)
rm(estra_CATEGORY1 ,estra_CATEGORY2,estra_CATEGORY3,estra_CATEGORY4,estra_CATEGORY5)



#########################                   CARICAMENTO Swrve                 ##########################
#                                                CUSTOM                                                #
#                                              PROPRIETIES                                             #
cus_p1 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.1.csv.gz", trim_ws = FALSE)
cus_p2 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.2.csv.gz", trim_ws = FALSE)
cus_p3 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.3.csv.gz", trim_ws = FALSE)
cus_p4 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.4.csv.gz", trim_ws = FALSE)
cus_p5 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.5.csv.gz", trim_ws = FALSE)
cus_p6 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.6.csv.gz", trim_ws = FALSE)
cus_p7 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_custom_properties.1_0.7.csv.gz", trim_ws = FALSE)

sw_pro_1 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.1.csv.gz",trim_ws = FALSE)
sw_pro_2 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.2.csv.gz",trim_ws = FALSE)
sw_pro_3 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.3.csv.gz",trim_ws = FALSE)
sw_pro_4 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.4.csv.gz",trim_ws = FALSE)
sw_pro_5 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.5.csv.gz",trim_ws = FALSE)
sw_pro_6 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.6.csv.gz",trim_ws = FALSE)
sw_pro_7 <- read_csv("C:/Users/Giovanni Loizzo/Downloads/all-users_06186_2017-05-24_swrve_properties.1_0.7.csv.gz",trim_ws = FALSE)

##########################                   (UNIONE DB SWRVE SINGOLI)                   ##########################
sw_pro_<-rbind.data.frame(sw_pro_1,  sw_pro_2, sw_pro_3, sw_pro_4, sw_pro_5,sw_pro_6,sw_pro_7)
sw_pro_<-rbind.data.frame(pro1,  pro2)
sw_prA_<-sw_pro_[,1:2]
cu<-rbind.data.frame(cus_p1, cus_p2, cus_p3, cus_p4, cus_p5, cus_p6, cus_p7)
cu<-rbind.data.frame(cus1, cus2)
cu_A<-cu[,c(1,5,94,100)]
#############################                         (PULIZIA)                      ##############################
sw_pro_$date_joined <-NULL
sw_pro_$last_active <-NULL
sw_pro_$swrve_app_version <-NULL
sw_pro_$milliseconds_played <-NULL
sw_pro_$spend <-NULL
sw_pro_$cents_last_purchase <-NULL
sw_pro_$swrve_android_device_xdpi <-NULL
sw_pro_$swrve_android_device_ydpi <-NULL
sw_pro_$swrve_app_store <-NULL
sw_pro_$swrve_conversation_version <-NULL
sw_pro_$swrve_device_dpi <-NULL
sw_pro_$swrve_device_height <-NULL
sw_pro_$swrve_device_name <-NULL
sw_pro_$swrve_device_region <-NULL
sw_pro_$swrve_device_width <-NULL
sw_pro_$swrve_timezone_name <-NULL
sw_pro_$swrve_sim_operator_name <-NULL
sw_pro_$swrve_sim_operator_iso_country_code <-NULL
sw_pro_$swrve_sim_operator_code <-NULL
sw_pro_$swrve_sdk_version <-NULL
sw_pro_$swrve_referrer_id <-NULL
sw_pro_$swrve_utc_offset_seconds <-NULL
sw_pro_$swrve_plot_sdk <-NULL
sw_pro_$swrve_os_version <-NULL
sw_pro_$swrve_os <-NULL
sw_pro_$swrve_location_version <-NULL
sw_pro_$swrve_location_sdk_version <-NULL
sw_pro_$swrve_location_sdk <-NULL
sw_pro_$swrve_language <-NULL
sw_pro_$swrve_install_date <-NULL
sw_pro_$swrve_gcm_token <-NULL
cu$persuadable <-NULL                        
cu$vieweractivity_flyer_title<-NULL
cu$ab_user<-NULL                        
cu$app_invites_capability  <-NULL          
cu$cluster_type<-NULL
cu$fbc_category_ahorrando<-NULL
cu$fbc_category_animali<-NULL
cu$fbc_category_arredamento<-NULL
cu$fbc_category_automoveis<-NULL
cu$fbc_category_autos<-NULL
cu$fbc_category_banche<-NULL
cu$fbc_category_bancos<-NULL                 
cu$fbc_category_beleza_e_saude<-NULL
cu$fbc_category_belleza<-NULL
cu$fbc_category_black_friday<-NULL
cu$fbc_category_bricolage<-NULL
cu$fbc_category_bricolaje<-NULL
cu$fbc_category_carnaval<-NULL
cu$fbc_category_clothing<-NULL
cu$fbc_category_criancas<-NULL         
cu$fbc_category_cura_casa_e_corpo<-NULL
cu$fbc_category_decorar_e_construir<-NULL
cu$fbc_category_department_stores<-NULL
cu$fbc_category_deporte_y_moda<-NULL
cu$fbc_category_dia_das_criancas<-NULL
cu$fbc_category_dia_das_maes<-NULL
cu$fbc_category_dia_dos_namorados<-NULL
cu$fbc_category_dia_dos_pais<-NULL
cu$fbc_category_discount<-NULL
cu$fbc_category_donde_ahorro<-NULL         
cu$fbc_category_e_commerce<-NULL
cu$fbc_category_economizando<-NULL       
cu$fbc_category_electronica<-NULL
cu$fbc_category_electronics_and_office <-NULL
cu$fbc_category_electronics_office<-NULL
cu$fbc_category_elektronik<-NULL
cu$fbc_category_eletronica_e_magazines<-NULL
cu$fbc_category_elettronica<-NULL
cu$fbc_category_em_destaque<-NULL
cu$fbc_category_entretenimiento<-NULL
cu$fbc_category_especial_de_natal<-NULL
cu$fbc_category_especial_pascoa<-NULL
cu$fbc_category_estate<-NULL
cu$fbc_category_eventi_speciali<-NULL
cu$fbc_category_farmacias_e_drogarias<-NULL
cu$fbc_category_fashion<-NULL
cu$fbc_category_ferreterias<-NULL
cu$fbc_category_festa_della_mamma<-NULL
cu$fbc_category_festa_junina<-NULL
cu$fbc_category_food_drink<-NULL     
cu$fbc_category_grandi_vini<-NULL
cu$fbc_category_groceries<-NULL     
cu$fbc_category_grocery_and_drug<-NULL
cu$fbc_category_hardware_auto<-NULL 
cu$fbc_category_health_and_beauty<-NULL
cu$fbc_category_health_beauty<-NULL
cu$fbc_category_hogar<-NULL
cu$fbc_category_home_furnishings<-NULL
cu$fbc_category_home_hardware<-NULL
cu$fbc_category_in_evidenza        <-NULL    
cu$fbc_category_infanzia_e_giochi<-NULL
cu$fbc_category_iper_e_super<-NULL
cu$fbc_category_kids<-NULL
cu$fbc_category_life_style<-NULL             
cu$fbc_category_liquor<-NULL
cu$fbc_category_mlm_shop<-NULL           
cu$fbc_category_moda<-NULL
cu$fbc_category_motori<-NULL             
cu$fbc_category_natale<-NULL
cu$fbc_category_ninos<-NULL           
cu$fbc_category_occasioni_imperdibili<-NULL
cu$fbc_category_outros<-NULL
cu$fbc_category_restaurantes<-NULL
cu$fbc_category_restaurants_dining<-NULL     
cu$fbc_category_risparmiando<-NULL
cu$fbc_category_ristoranti<-NULL     
cu$fbc_category_rumah<-NULL
cu$fbc_category_salud_y_belleza<-NULL
cu$fbc_category_salute_e_benessere<-NULL
cu$fbc_category_san_valentino<-NULL
cu$fbc_category_servicios<-NULL
cu$fbc_category_speciale_natale<-NULL
cu$fbc_category_speciale_pasqua<-NULL
cu$fbc_category_sport<-NULL
cu$fbc_category_sport_e_moda<-NULL
cu$fbc_category_sports_outdoors<-NULL     
cu$fbc_category_supermarket<-NULL
cu$fbc_category_supermercados<-NULL      
cu$fbc_category_tiendas_departamentales<-NULL
cu$fbc_category_travel_outdoor<-NULL
cu$fbc_category_viagem_e_lazer<-NULL
cu$fbc_category_viagg<-NULL
cu$fbc_category_viajes<-NULL
cu$fbc_contest_code         <-NULL           
cu$fbc_contest_optin<-NULL
cu$fbc_registration_source<-NULL             
cu$fbc_registration_status<-NULL
cu$fbc_user_age_max<-NULL       
cu$fbc_user_age_min<-NULL
cu$fbc_user_name<-NULL
cu$fbc_user_surname<-NULL                 
cu$fbc_user_name_2<-NULL                                          
cu$letture<-NULL
cu$location<-NULL                       
cu$location_accuracy<-NULL                  
cu$location_mode<-NULL           
cu$location_name<-NULL                                   
cu$qa_user<-NULL
cu$session_start<-NULL                                                      
cu$user_initiated<-NULL               
cu$gender<-NULL
cu$fbc_category_viaggi<-NULL

rm(sw_pro_1,sw_pro_2,sw_pro_3,sw_pro_4,sw_pro_5,sw_pro_6,sw_pro_7)
rm(cus_p1,cus_p2,cus_p3,cus_p4,cus_p5,cus_p6,cus_p7)
sw_pro_<-sw_pro1[,c(1,2,17)]
cu<-cus1[,c(1,50,56,57)]
sw_cu_A<-merge(sw_prA_, cu_A, by.x= "swrve_data_id" , by.y= "swrve_data_id")
names(sw_cu_O)[3]<-paste("advertising_id")
sw_cu_O$user<-NULL
sw_cu<-rbind(sw_cu_O,sw_cu_A)
##########################               UNIONE DB SWRVE (PROPRIETIES + CUSTOM)              ##########################
sw_cu<-merge(sw_pro_, cu, by.x= "swrve_data_id" , by.y= "swrve_data_id", all.x = TRUE)
sw_cu$user<-NULL
sw_cu$segmento<-NULL
rm(sw_pro, cu)
du$advertising_id
du<-sw_cu
du<-du[which(!(du$muid %in% du$muid[which(duplicated(du$muid))])),]
rm(cu,cu_A,cusO,cus2,cus1,pro1,pro2,sw_cu_A,sw_cu_O,sw_prA_,sw_prO,sw_pro_)
############################               UNIONE DB SWRVE & DB DI ESTRAZION)              ############################
unione<-merge(du, estrazione, by.x= "muid" , by.y= "DCID")
unione$user<-NULL
unione[unione=="\\N"] = NA                   ##SOSTITUZIONE DEL CARATTERE \N CON VALORE NA
unione$l<-is.na(unione$fbc_user_gender)      ##MARCATURA DELLE ROW CON GENERE ESPLICITATO
unione[,7:19]<-unione[,7:19]/unione$Letture
##CREAZIONE DEL DB DEGLI UTENTI _NON_ HANNO ESPLICITATO IL GENERE 
un_NO_GENERE<-unione[which(unione$l==TRUE),] ##CREAZIONE DEL DB DEGLI UTENTI NON HANNO ESPLICITATO IL GENERE 
un_NO_GENERE$l<-NULL
un_NO_GENERE$lett<-is.na(un_NO_GENERE$Letture)               ##MARCATURA DELLE ROW SENZA LETTURE
lett_ ##EPURAZIONE DAL DB DELLE ROW SENZA LETTURE
un_NO_GENERE$lett<-NULL
#un_NO_GENERE[,7:19]<-un_NO_GENERE[,7:19]/un_NO_GENERE$Letture  ## CALCOLO DELLA PROPORZIONE DI LETTURE PER CATEGORIE SUL TOTALE DELLRE LETTURE DALL SINGOLA ROW

##CREAZIONE DEL DB DEGLI UTENTI HANNO ESPLICITATO IL GENERE 
un_SI_GENERE<-unione[which(unione$l==FALSE),]
un_SI_GENERE$l<-NULL
Dichiarati<-un_SI_GENERE[,1:5]
Dichiarati$female<-ifelse(Dichiarati$fbc_user_gender=="female",1,0)
Dichiarati$male<-ifelse(Dichiarati$fbc_user_gender=="male",1,0)
un_SI_GENERE$lett<-is.na(un_SI_GENERE$Letture)               ##MARCATURA DELLE ROW SENZA LETTURE
un_SI_GENERE<-un_SI_GENERE[which(un_SI_GENERE$lett==FALSE),] ##EPURAZIONE DAL DB DELLE ROW SENZA LETTURE
un_SI_GENERE$lett<-NULL
#un_SI_GENERE<-un_SI_GENERE[which(is.na(un_SI_GENERE$advertising_id)==FALSE),] ##EPURAZIONE DAL DB DELLE ROW SENZA ADVERTISING ID
#un_SI_GENERE[,7:19]<-un_SI_GENERE[,7:19]/un_SI_GENERE$Letture


############   ADDESTRAMENTO ALGORITMO NEURAL NETWORK CON DB DEGLI UTENTI HANNO ESPLICITATO IL GENERE 
train<-un_SI_GENERE[,6:18]
set.seed(1)
train$Gend = class.ind(un_SI_GENERE$fbc_user_gender)
train<-(train[,c(14,1:13)])
nn.genderC = nnet(Gend ~. , train, size=5, softmax=TRUE, maxit=1000 ,  decay=  0.001)


##############################                PREVISIONE                ##############################        
GENERE<-data.frame(un_NO_GENERE$muid,predict(nn.genderC, un_NO_GENERE[,6:19]))

Gen_unione<-merge(un_NO_GENERE, GENERE, by.x= "muid" , by.y= "un_NO_GENERE.muid")

Gen_unione<-(Gen_unione[,c(1:5,20,21)])
Gen_unione<-rbind(Gen_unione,Dichiarati )
Gen_unione$d<-(Gen_unione$female) - (Gen_unione$male)
Gen_unione$gender<-ifelse(Gen_unione$d>0,"female","male")
Gen_unione$d<-NULL
Gen_unione$fbc_user_gender<-NULL
GG<-Gen_unione
GG$l<-is.na(Gen_unione$advertising_id)
GG<-GG  
GG$l<-NULL
write.table(Gen_unione, file="GENERE_MESSICO_TOTALE.csv",row.names=FALSE,sep=",")
write.table(GG, file="GENERE_MESSICO_CORRETTO.csv",row.names=FALSE,sep=",")

write.table(FF, file="GENERE_BRASILE_ADV_ID.csv",row.names=FALSE,sep=",")

