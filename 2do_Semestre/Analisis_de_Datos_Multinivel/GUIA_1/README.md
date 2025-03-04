# 📂 Guía 1 - Análisis de Datos Multinivel  

📊 **Tema:** Introducción al Modelamiento Multinivel y Correlación Intraclase  
📅 **Curso:** Análisis de Datos Multinivel (SOL3051)  
🖥 **Software utilizado:** R (paquete `lme4`)  
📂 **Base de datos:** *morgan2013.RData*  

---

## 📖 **Descripción de la Guía**  
El objetivo de este ejercicio es **poner en práctica los fundamentos del análisis multinivel**, utilizando datos de la encuesta LAPOP 2008 en 19 países de América Latina.  

Se analiza la **confianza política** como variable dependiente, explorando cómo factores individuales (edad, educación, empleo, ideología) y contextuales (país, democracia, participación laboral femenina) influyen en esta percepción.  

---

## 🎯 **Actividades y Modelos Estadísticos Aplicados**  

1️⃣ **Estimación de Correlación Intraclase (ICC)**  
   - Evaluación de la **variabilidad entre países** en la confianza política.  
   - Justificación del uso de modelos multinivel.  

2️⃣ **Estimación de Modelos de Regresión Multinivel**  
   - 📌 **Modelo 1:** Intercepto aleatorio con efectos fijos individuales (*sexo, edad, educación, empleo, estado civil, raza, ideología*).  
   - 📌 **Modelo 2:** Intercepto aleatorio + **pendientes aleatorias** de la ideología política.  
   - 📌 **Modelo 3:** Interacción cruzada entre ideología y presidencia de izquierda.  
   - 📌 **Modelo 4:** Inclusión de efectos aleatorios de la edad.  

3️⃣ **Análisis de Resultados**  
   - **Cálculo e interpretación de varianza explicada** en modelos multinivel.  
   - **Comparación de modelos** mediante tests de hipótesis.  
   - **Visualización de efectos aleatorios y moderadores** con gráficos.  
   - **Estimación de efectos marginales** de ideología y presidencia de izquierda.  

4️⃣ **Evaluación de Hipótesis sobre Factores Contextuales**  
   - 📌 Impacto de la **participación laboral femenina** en la confianza política.  
   - 📌 Efecto moderador del **Índice de Democracia (Freedom House Index)** sobre la relación entre edad y confianza política.  

---

## 📂 **Archivos en esta carpeta**
- 📄 [**EJERCICIO 1_JARA_RAMON.qmd**](EJERCICIO-1_JARA_RAMON.qmd) → Código fuente en Quarto con el análisis en R.  
- 📜 [**EJERCICIO-1_JARA_RAMON.pdf**](EJERCICIO-1_JARA_RAMON.pdf) → Documento renderizado con los análisis y resultados en formato PDF.  


📌 *Este ejercicio permitió aplicar modelos multinivel para analizar la influencia de factores individuales y contextuales en la confianza política en América Latina.*  
