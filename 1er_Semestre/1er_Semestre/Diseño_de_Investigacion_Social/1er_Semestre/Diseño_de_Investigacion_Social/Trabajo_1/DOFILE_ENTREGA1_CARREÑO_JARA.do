***Tarea 1. Limpieza base de datos Bicentenario 2019***
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
rename d07 sexo 
rename d06 NSE
rename s05 pos_politica
rename r02_1 asist_religiosa
// Cambia los nombres de las variables a nombres más descriptivos.

gen Educación_en_años = .
// Crea una nueva variable llamada "Educación_en_años" 

replace Educación_en_años = 4 if educ == 1
replace Educación_en_años = 8 if educ == 2
replace Educación_en_años = 12 if educ == 3
replace Educación_en_años = 14 if educ == 4
replace Educación_en_años = 15 if educ == 5
replace Educación_en_años = 17 if educ == 6
replace Educación_en_años = 21 if educ == 7
// Asigna valores específicos a la variable "Educación_en_años" según los valores de la variable "educ" Esto con el fin de que deje de ser categórica.

// (1) Básica incompleta/Pre básica = 4 años
// (2) Básica completa = 8 años
// (3) Media completa = 12 años
// (4) Formación técnica incompleta = 14 años
// (5) Formación técnica completa y universitaria incompleta = 15 años
// (6) Universitaria completa = 17 años
// (7) Posgrados = 21 años

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


//Recodificación de la variable de asistecia religiosa 
recode asist_religiosa (1/4=0) (5=1), generate(asist_binaria)
label define asist_religiosa_labels 0 "Asiste al menos una vez a la semana" 1 "No asiste nunca"
label values asist_binaria asist_religiosa_labels
tab asist_binaria 

*Test de hipótesis
ttest Educación_en_años, by(genero_binario) level(95) unequal
ttest Educación_en_años, by(genero_binario) level(99) unequal

ttest Educación_en_años, by(NSE_binario) level(95) unequal
ttest Educación_en_años, by(NSE_binario) level(99) unequal

ttest Educación_en_años, by(asist_binaria) level(95) unequal
ttest Educación_en_años, by(asist_binaria) level(99) unequal

anova Educación_en_años pos_politica