# **📊 Análisis SQL del Sistema de Alquileres de Películas: Explorando Datos con DBeaver**

### **Descripción del Proyecto**

Este proyecto consiste en el análisis de una base de datos relacional que gestiona un sistema de alquileres de películas. Utilizando **DBeaver** como herramienta principal, se ejecutaron consultas SQL para explorar y procesar información clave relacionada con clientes, películas, actores, categorías y pagos. El objetivo principal del proyecto es demostrar el manejo eficiente de consultas SQL para extraer información relevante y comprender los datos.

El proyecto responde a problemas comunes en la gestión de datos en empresas, como poder identificar clientes más rentables, comprender la popularidad de las categorías, películas o incluso actores, y calcular métricas financieras clave para la toma de decisiones.

En un sistema con una gran cantidad de datos distribuidos entre múltiples tablas, el reto principal es tratar de:

* Extraer información relevante de manera eficiente.  
* Relacionar datos entre diferentes tablas para obtener un panorama integral.

#### **Técnicas y enfoques utilizados**

El análisis se llevó a cabo empleando las siguientes técnicas SQL:

* **Consultas simples sobre una sola tabla:** Para identificar información básica, como películas según su clasificación o métricas como promedios y conteos.  
* **Relaciones entre tablas (JOIN):** Para conectar información distribuida en diferentes tablas, como relacionar clientes con sus alquileres o películas con categorías.  
* **Subconsultas:** Para resolver problemas complejos, como identificar películas con características específicas o clientes destacados por su volumen de alquileres.  
* **Creación de vistas:** Para encapsular consultas recurrentes y facilitar su reutilización en análisis futuros.  
* **Tablas temporales:** Para almacenar datos intermedios y simplificar análisis más complejos.

#### **Estructura del proyecto**

El proyecto está organizado de manera sencilla para facilitar la navegación y comprensión del flujo de trabajo. Incluye el esquema de la base de datos, las consultas SQL y un archivo README para describir los detalles del análisis.

├── esquema\_bbdd/ \# Archivo con el esquema de la base de datos

├── consultas/ \# Archivo con las consultas SQL desarrolladas

├── README.md \# Descripción del proyecto y detalles clave

### **Instalación y Requisitos**

Para ejecutar este proyecto, se ha usado las herramientas y dependencias descritas a continuación. **DBeaver** y **Postgres** para la gestión de la base de datos y las consultas SQL. **Editor de texto** para revisar y editar los archivos SQL.

### **Resultados y Conclusiones**

### **Actores y Películas**

* **Relación Actor-Película:**  
  * Todas las películas tienen al menos un actor asociado, pero **no todos los actores aparecen en las mismas cantidades de películas**. Esto indica que algunos actores participan en más proyectos que otros, posiblemente debido a su popularidad o demanda.  
  * **No hay actores sin películas:** La base de datos muestra que cada actor registrado está vinculado al menos a una película, lo que garantiza la integridad de esta relación.  
* **Películas sin actores:**  
  * Se identificaron películas (3) que no tienen actores registrados. Esto puede deberse a datos incompletos o películas que no requieren actores (documentales, animaciones, etc.).

### **Alquileres**

* **Películas más alquiladas:**  
  * Algunas películas tienen un alto número de alquileres, lo que refleja su popularidad. Sin embargo, también existen películas con un número significativamente menor de alquileres, lo que podría ser una oportunidad para analizar y mejorar su visibilidad o marketing.  
* **Duración de los alquileres:**  
  * El promedio por alquiler es de **4’9** días, lo que indica una duración estándar razonable para un sistema de alquiler tradicional.  
* **Alquileres por mes:**  
  * Los meses con mayor cantidad de alquileres destacan como períodos de alta demanda, posiblemente asociados a temporadas festivas o vacaciones. Esto puede ser relevante para diseñar promociones específicas en esas fechas.

### **Clientes**

* **Clientes activos:**  
  * Se identificaron clientes con un alto número de alquileres, representando una fuente significativa de ingresos. Estos clientes podrían ser objetivo de programas de fidelización.  
* **Clientes sin alquileres:**  
  * El análisis realizado confirma que **todos los clientes registrados han realizado al menos un alquiler**. Esto indica que la base de datos no contiene registros inactivos o clientes sin transacciones asociadas. Este resultado es positivo, ya que refleja una participación completa de los clientes en el sistema de alquiler. Además, la ausencia de clientes sin actividad evita desperdicio de recursos en estrategias de reactivación innecesarias, permitiendo enfocar los esfuerzos en otros aspectos, como la fidelización de los clientes más activos o la optimización de las categorías más demandadas.   
* **Clientes más rentables:**  
  * Un grupo reducido de clientes (5) genera la mayor parte de los ingresos. Identificar estos patrones es crucial para diseñar estrategias que mantengan su lealtad.

### **Pagos**

* **Ingresos totales:**  
  * La base de datos refleja un ingreso consistente por cliente, con una variación limitada en los montos pagados.  
* **Pagos por cliente:**  
  * Algunos clientes han realizado pagos significativamente mayores, lo que puede estar relacionado con alquileres de películas de alta demanda o múltiples transacciones.

### **Conclusiones Relevantes del Análisis**

1. **Actores y Películas:**  
   * Aunque todas las películas tienen actores asociados, algunas películas carecen de registros completos. Esto resalta la necesidad de mantener la base de datos actualizada.  
2. **Clientes:**  
   * Los clientes con un alto número de alquileres representan una oportunidad para programas de fidelización, mientras que aquellos con una actividad menor requieren estrategias de reactivación.  
3. **Alquileres:**  
   * La duración promedio de alquiler es adecuada, y los períodos de alta demanda deben ser aprovechados para diseñar campañas promocionales.  
4. **Ingresos:**  
   * Identificar los clientes más rentables y las películas más alquiladas puede guiar decisiones estratégicas para maximizar ingresos.

5. **Clientes Activos y Consumo:**  
   * Los clientes alquilaron una media de 16 películas aproximadamente. Debería tenerse en cuenta como objetivo de campañas de fidelización.  
6. **Patrones Temporales:**  
   * Los meses con mayor actividad corresponden a períodos vacacionales, como verano e invierno. Esto indica que las campañas promocionales deberían intensificarse durante estas épocas.  
7. **Estadísticas Financieras:**  
   * El promedio de pago por alquiler es de **4’2**, con una desviación estándar moderada, lo que muestra cierta consistencia en los precios y los hábitos de consumo.  
8. **Películas Populares:**  
   * El tamaño de las películas más alquiladas está relacionado con categorías específicas como 'Sports' y 'Animation'. Esto refuerza la importancia de mantener un catálogo diverso.  
9. **Relación Cliente-Alquiler:**  
   * Un análisis detallado muestra que todos los clientes han realizado al menos un alquiler. Esto significa que se pueden seguir generando oportunidades y estrategias de captación.

#### **Gráficos y Tablas de Soporte**

Para respaldar las conclusiones, se podrían incluir entre otros:

* **Gráficos de Barras:**  
  * Volumen de alquileres por categoría.  
* **Tablas Resumidas:**  
  * Ingresos totales y promedio por cliente.  
* **Gráficos de Líneas:**  
  * Actividad mensual de alquileres.

#### **Aplicaciones de los Resultados**

1. **Estrategia de Marketing:**  
   * Los resultados sugieren que se deben implementar campañas específicas durante períodos de alta demanda y dirigidas a los clientes más activos.  
2. **Optimización de Catálogo:**  
   * Priorizando categorías populares y eliminando contenido que no genera ingresos significativos.  
3. **Fidelización de Clientes:**  
   * Diseñar programas de recompensas para clientes recurrentes puede aumentar su retención y gasto promedio.  
4. **Mejora de Rentabilidad:**  
   * Ajustar precios en categorías con alta demanda puede incrementar ingresos sin afectar el volumen de alquileres.

   ### **Autor y Agradecimientos**

* **Autor:** Ana Nieto Carrera  
* **Datos Inspirados:** Proyecto de base de datos dado por la plataforma.

