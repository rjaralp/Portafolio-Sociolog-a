**********************************************************
*****ACLARACIÓN: EN ESTE DOFILE ESTARÁ TODO EL CÓDIGO*****
*****DE LAS TRES TAREAS. EN ESTE CASO EL CÓDIGO DE LA*****
*****TAREA 1 ESTÁ EN LA LINEA 13 HASTA LA 132. EL DE *****
***** LA TAREA 2 ESRÁ EN LA LÍNEA 139 EN ADELANTE.   *****
**********************************************************



*************
***Tarea 1***
*************
***Limpieza base de datos Bicentenario 2019***
clear
// Borra todas las variables en la memoria de Stata.

import spss using "C:\Users\HP\Desktop\Diseño y Analisis de Inv. Social\Tareas\2019_ BBDD  Bicentenario UC.sav"
// Importa el archivo de datos en formato SPSS ubicado en la ruta especificada y lo carga en Stata.

// Revisión variables de interés
tab educ
// Muestra la distribución de la variable "educ".

tab r02_1
// Muestra la distribución de la variable "r02_1".

tab s05
// Muestra la distribución de la variable "s05".

codebook educ r02_1 d06 d07 
// Proporciona información detallada sobre las variables "educ", "r02_1", "d06" y "d07".

// Selección variables, limpieza base de datos, recodificación y resumen estadístico
//(a)
keep educ r02_1 d06 d07 s05
// Conserva solo las variables especificadas y elimina las demás.

//(b)
drop if educ == 9
// Elimina las observaciones donde el valor de "educ" es igual a 9.

drop if r02_1 == 6 | r02_1 == 8 | r02_1 == 9
// Elimina las observaciones donde el valor de "r02_1" es 6, 8 o 9.

drop if s05 == 8 | s05 ==9
// Elimina las observaciones donde el valor de "s05" es 8 o 9.

//(c)
***Se recodifican las variables como "sexo", "NSE", "posición política", "asistencia religiosa" y "Educación en años"***
rename d07 sexo 
rename d06 NSE
rename s05 pos_politica
rename r02_1 asist_religiosa
gen Educación_en_años = .

replace Educación_en_años = 4 if educ == 1
replace Educación_en_años = 8 if educ == 2
replace Educación_en_años = 12 if educ == 4
replace Educación_en_años = 14 if educ == 5
replace Educación_en_años = 15 if educ == 6
replace Educación_en_años = 17 if educ == 7
replace Educación_en_años = 21 if educ == 8

***(1) Básica incompleta/Pre básica = 4 años***
***(2) Básica completa = 8 años***
***(3) Media completa = 12 años***
***(4) Formación técnica incompleta = 14 años*** 
***(5) Formación técnica completa y universitaria incompleta = 15 años***
***(6) Universitaria completa = 17 años***
***(7) Posgrados = 21 años ***


// Calcula intervalos de confianza para las medias de varias variables.
*(d)
ci mean Educación_en_años
ci mean asist_religiosa
ci mean sexo
ci mean NSE
ci mean pos_politica

*Grafico de distribución variable dependiente (asistencia religiosa)
histogram Educación_en_años, normal
graph export "C:\Users\HP\Desktop\Diseño y Analisis de Inv. Social\Tareas/histograma.png", replace
// Crea un histograma de la variable "Educación_en_años" con una distribución normal y lo exporta como un archivo de imagen.

*Medias y proporciones a distintos niveles de confianza
ci mean Educación_en_años, level(95)
ci mean Educación_en_años, level(99)
ci mean asist_religiosa, level(95)
ci mean asist_religiosa, level(99)

//Recodificación de Sexo para que sea una variable binaria donde 0 es "Hombre" y 1 es "Mujer"


recode sexo (1=0) (2=1), generate(genero_binario)
label define sexo_labels 0 "Hombre" 1 "Mujer"
label values genero_binario sexo_labels 
tab genero_binario

//Recodificación de Nivel Socioeconómico para que sea una variable dummy donde 0 "Clase alta/media" y 1 "Clase baja". 

recode NSE (1/3=0) (4/6=1), generate(NSE_binario)
label define NSE_labels 0 "Clase alta/media" 1 "Clase baja"
label values NSE_binario NSE_labels 
tab NSE_binario


//Tablas para obtener las proporciones de las variables mencionadas en el código a distitntos niveles de confianza

ci proportion genero_binario, level(95)
ci proportion genero_binario, level(99)
ci proportion NSE_binario, level(95)
ci proportion NSE_binario, level(99)


//Recodificación de la variable de posición política 
recode pos_politica (1/2=0) (3=1) (4/5=2), generate(posicionpol)
label define pos_politica_labels 0 "Izquierda" 1 "Centro" 2 "Derecha"
label values posicionpol pos_politica_labels
tab posicionpol 
//Recodificación de la variable de asistencia religiosa
recode asist_religiosa (1/2=0) (3/4=1) (5=2), generate(religiosidad_act)
label define asist_religiosa2_labels 0 "Religiosidad activa alta" 1 "Religiosidad activa media" 2 "Religiosidad activa baja o nula"
label values religiosidad asist_religiosa2_labels
tab religiosidad 


*Test de hipótesis
ttest Educación_en_años, by(genero_binario) level(95) unequal
ttest Educación_en_años, by(genero_binario) level(99) unequal

ttest Educación_en_años, by(NSE_binario) level(95) unequal
ttest Educación_en_años, by(NSE_binario) level(99) unequal

ttest Educación_en_años, by(asist_binaria) level(95) unequal
ttest Educación_en_años, by(asist_binaria) level(99) unequal

anova Educación_en_años posicionpol

*********************
***DO FILE TAREA 2***
*********************
*Correlaciones
pwcorr Educación_en_años religiosidad_act
pwcorr religiosidad_act NSE genero_binario posicionpol 


**Modelos de regresión
**Estime un primer modelo de regresión, el que debe ser bivariado. Describa los resultados del modelo. Llame a este modelo, Modelo 0 (este es el modelo base). Describa la o las hipótesis que está evaluando en este modelo. Escriba la ecuación que representa a este Modelo**

*Modelo 0
regress Educación_en_años i.religiosidad_act

**Estime un segundo modelo de regresión, el que debe ser multivariado. Describa los resultados del modelo. Llame a este modelo, Modelo 1. Describa la o las hipótesis que está evaluando en este modelo. Escriba la ecuación que representa a este Modelo**

*Modelo 1
regress Educación_en_años i.religiosidad_act i.NSE i.sexo 

**Proponga un tercer modelo de regresión. Llame a este Modelo 2, el que debe ser multivariado. Evalúe dos hipótesis en este modelo. Describa sus resultados respecto a sus hipótesis**

*Modelo 2
regress Educación_en_años i.religiosidad_act i.NSE i.sexo i.posicionpol


*Tablas asociadas a cada modelo
ssc install outreg2

regress Educación_en_años i.religiosidad_act
outreg2 using model.xls, replace ctitle(Model 0)

regress Educación_en_años i.religiosidad_act i.NSE i.sexo
outreg2 using model.xls, append ctitle(Model 1)

regress Educación_en_años i.religiosidad_act i.NSE i.sexo i.posicionpol
outreg2 using model.xls, append ctitle(Model 2)













