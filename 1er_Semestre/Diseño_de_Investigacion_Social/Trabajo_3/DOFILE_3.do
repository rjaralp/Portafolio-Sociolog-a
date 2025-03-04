*************
***Tarea 1***
*************
***Limpieza base de datos CASEN***
clear
// Borra todas las variables en la memoria de Stata.

cd "C:\Users\HP\Desktop\Diseño y Analisis de Inv. Social"
use "C:\Users\HP\Desktop\Diseño y Analisis de Inv. Social\Base de datos Casen 2022 STATA_18 marzo 2024.dta", clear 
// Importa el archivo de datos en formato SPSS ubicado en la ruta especificada y lo carga en Stata.

// Revisión variables de interés
codebook ypc

// Muestra la distribución de la variable "ypc".

tab esc
// Muestra la distribución de la variable "esc".

tab r3
// Muestra la distribución de la variable "r3".

tab sexo
// Muestra la distribución de la variable "sexo".

tab ecivil
// Muestra la distribución de la variable "ecivil".

codebook esc r3 sexo ecivil
// Proporciona información detallada sobre las variables "ypc", "esc", "r3", "sexo" y "ecivil".

// Selección variables, limpieza base de datos, recodificación y resumen estadístico
//(a)
keep ypc esc r3 sexo ecivil
// Conserva solo las variables especificadas y elimina las demás.

//(b) Eliminacion missings y valores no correspondientes
drop if esc ==.
drop if ypc ==.

//(c)
***Se recodifican las variables "pueblos indígenas" y "estado civil"***
recode r3 (1/10 = 0) (11 = 1), generate(indigena)
label define indigena_labels 0 "Indígena" 1 "No indígena"
label values indigena indigena_labels 
tab indigena

recode ecivil (1/3 = 0) (4/8 = 1), generate(ecivil_binario)
label define ecivil_labels 0 "Con pareja" 1 "Sin pareja"
label values ecivil_binario ecivil_labels 
tab ecivil_binario

***(d) Estadísticas descriptivas y gráficos***
ci mean ypc
ci mean esc
ci mean sexo
ci mean indigena
ci mean ecivil_binario

*Grafico de distribución variable dependiente (ingreso per cápita)
histogram ypc, normal
graph export "C:\Users\HP\Desktop\Diseño y Analisis de Inv. Social\Tareas/histograma_ingreso.png", replace

*Medias y proporciones a distintos niveles de confianza
ci mean ypc, level(95)
ci mean ypc, level(99)
ci mean esc, level(95)
ci mean esc, level(99)

*Recodificación de Sexo para que sea una variable binaria donde 0 es "Hombre" y 1 es "Mujer"
recode sexo (1=0) (2=1), generate(genero_binario)
label define sexo_labels 0 "Hombre" 1 "Mujer"
label values genero_binario sexo_labels 
tab genero_binario

//Tablas para obtener las proporciones de las variables mencionadas en el código a distintos niveles de confianza
ci proportion genero_binario, level(95)
ci proportion genero_binario, level(99)

*Test de hipótesis
ttest ypc, by(genero_binario) level(95) unequal
ttest ypc, by(genero_binario) level(99) unequal
ttest ypc, by(ecivil_binario) level(95) unequal
ttest ypc, by(ecivil_binario) level(99) unequal

*********************
***DO FILE TAREA 2***
*********************
*Correlaciones
pwcorr ypc esc
pwcorr ypc esc indigena genero_binario ecivil_binario

**Modelos de regresión
**Estime un primer modelo de regresión, el que debe ser bivariado. Describa los resultados del modelo. Llame a este modelo, Modelo 0 (este es el modelo base). Describa la o las hipótesis que está evaluando en este modelo. Escriba la ecuación que representa a este Modelo**

*Modelo 0
regress ypc esc

**Estime un segundo modelo de regresión, el que debe ser multivariado. Describa los resultados del modelo. Llame a este modelo, Modelo 1. Describa la o las hipótesis que está evaluando en este modelo. Escriba la ecuación que representa a este Modelo**

*Modelo 1
regress ypc esc genero_binario

**Proponga un tercer modelo de regresión. Llame a este Modelo 2, el que debe ser multivariado. Evalúe dos hipótesis en este modelo. Describa sus resultados respecto a sus hipótesis**

*Modelo 2
regress ypc esc genero_binario indigena ecivil_binario

*Tablas asociadas a cada modelo
ssc install outreg2

regress ypc esc
outreg2 using model.xls, replace ctitle(Model 0)

regress ypc esc genero_binario
outreg2 using model.xls, append ctitle(Model 1)

regress ypc esc genero_binario indigena ecivil_binario
outreg2 using model.xls, append ctitle(Model 2)


*********************
***DO FILE TAREA 3***
*********************

***Modelo 1***
regress ypc esc genero_binario indigena ecivil_binario

*Considere el último modelo multivariado de regresión propuesto en la tarea 2, como su modelo base (Modelo 1) y corríjalo a partir de los comentarios que recibió de la tarea 2, si es necesario. 

***Modelo 2***
*Proponga un segundo modelo de regresión (Modelo 2), el que debe incluir un efecto moderador (una variable continua).
gen genero_esc = genero_binario*esc

regress ypc esc genero_binario indigena ecivil_binario genero_esc

*Gráfico valores predichos para termino interaccion
graph 

***Modelo 3***
*Proponga un tercer modelo de regresión (Modelo 3), el que debe incluir un nuevo efecto moderador (dos variables dummies).
gen genero_indigena = genero_binario*indigena

regress ypc esc genero_binario indigena ecivil_binario genero_indigena

*Grafico valores predichos para termino interaccion
graph

***Modelo 4***
*Incluya en este modelo una nueva transformación aritmética (polinomio o transformación logarítmica). 
gen esc2 = esc*esc

regress ypc esc esc2 genero_binario indigena ecivil_binario


regress ypc esc genero_binario indigena ecivil_binario
outreg2 using modelt2.xls, replace ctitle(Model 0)

regress ypc esc genero_binario indigena ecivil_binario genero_esc
outreg2 using modelt2.xls, append ctitle(Model 1)

regress ypc esc genero_binario indigena ecivil_binario genero_indigena
outreg2 using modelt2.xls, append ctitle(Model 2)

regress ypc esc genero_binario indigena ecivil_binario genero_indigena esc2
outreg2 using modelt2.xls, append ctitle(Model 3)
















