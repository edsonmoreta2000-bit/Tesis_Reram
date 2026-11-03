TESIS ReRAM — MEMORIA TÉCNICA Y GUÍA DE CONTINUIDAD PARA CODEX
Fecha de corte: 2026-11-03 | Revisión documental 1 | Codificación UTF-8
Autor del proyecto: Edson B. Amaguana Moreta | UNICAL / USFQ

0. CÓMO USAR ESTE ARCHIVO Y QUÉ RESPALDA
=======================================
Leer este archivo junto con README.md, AGENTS.md y los archivos reales del
proyecto antes de proponer cambios. Su finalidad es conservar el contexto,
evitar repetir errores y orientar una implementación verificable de la ReRAM.
Es una memoria documental: NO sustituye un backup de los .cmd, .par, TDR,
PLT, logs y configuración de Workbench. Tampoco es un deck ejecutable.

Etiquetas de evidencia empleadas:
[D] Comprobado directamente en documentos disponibles en esta revisión.
[H] Historial recuperado de conversaciones/resúmenes anteriores. No se han
    inspeccionado aquí los archivos originales de esa corrida. Incluso si
    antes se llamó «validado», no se certifica de nuevo en este documento.
[P] Propuesta metodológica o inferencia para la siguiente implementación.
[V] Pendiente de verificar mediante archivos o ejecución en el servidor.

Las referencias [S1]–[S11] se identifican al final. Para el manual [S1], las
páginas indicadas corresponden a su numeración impresa, que en los pasajes
consultados coincide con el número de página del PDF (base 1).
Las referencias del training son rutas internas del ZIP, no URLs públicas.

Se consultaron directamente el manual X-2025.06, secciones relevantes del
training adjunto, el objetivo de tesis, los seis artículos adjuntos y las
versiones actuales de README.md y AGENTS.md. La revisión de artículos fue
dirigida a su pertinencia y a los pasajes citados; no equivale a reproducir
todos sus resultados. No se ejecutó Sentaurus ni se inspeccionaron los decks
y resultados originales de las ramas históricas. No existe aquí una lista
exhaustiva certificada de cada ensayo que se realizó en el servidor.

REGLA CENTRAL: un proceso que termina sin error no demuestra por sí mismo
forming físico, RESET, SET, TAT correcto, continuidad entre estados ni
calibración experimental.

1. OBJETIVO DE TESIS Y DISPOSITIVO DE REFERENCIA
==============================================
[D, S3 y S10] Tema:
From Device to Circuit: TCAD Modeling of Oxide-Based ReRAM and Evaluation
of a Simple 1T1R Cell for Analog Synaptic Operation.

Pregunta: ¿puede una ReRAM basada en óxido, modelada físicamente e integrada
en una celda 1T1R simple, proporcionar modulación controlada de conductancia
mediante pulsos para operación sináptica analógica elemental?

Los tres niveles de trabajo son:
1) Dispositivo TCAD: HfO2, forming, SET, RESET y respuesta a pulsos.
2) Extracción de comportamiento y representación compatible con circuito.
3) Evaluación de una celda 1T1R simple y de sus actualizaciones de conductancia.
Una curva de forming aislada NO completa la tesis. Tampoco se requiere, por
el objetivo aportado, construir de entrada una red neuronal completa.

[D, S4, p. 1, sección II.A] Stack experimental de referencia:
  TiN 30 nm / HfO2 5 nm / Hf 10 nm / TiN 30 nm.
El artículo estudia áreas de 55, 65, 75, 85, 105 y 135 nm de lado, en 1T1R.
Reporta compliance de forming de 5 mA. Ese dato no define automáticamente
la compliance de RESET, SET o lectura, ni valida usar 5 mA en cualquier deck.
[H] El objetivo seleccionado para Edson es 85 × 85 nm².

Conversión dimensional derivada:
  30 nm = 0.030 um; 5 nm = 0.005 um; 10 nm = 0.010 um.
  85 nm = 0.085 um; espesor total = 75 nm = 0.075 um.
  Área nominal = 7225 nm² = 0.007225 um² = 7.225e-11 cm².
  Volumen nominal HfO2 = 36125 nm³ = 3.6125e-17 cm³.
Este volumen permite comprobar N aproximado = concentración × volumen,
si toda esa región pertenece al espacio KMC. No supone que el filamento
ocupe toda el área del dispositivo.

[P] Antes de crear coordenadas, registrar cuál capa corresponde al lado
top/bottom, el eje de apilamiento, el origen, los contactos y el signo de V.
La cadena escrita del stack no basta para deducir la convención del deck.
[H] Se ha usado top positivo y bottom a 0 V en ensayos recientes.
[V] Verificar esa convención en la geometría y archivos actuales.

El Hf del stack NO es Ti. No reemplazar Hf por Titanium para que un ejemplo
del manual sea más fácil de ejecutar. HfO2 y HfOx tampoco son equivalentes
sin una definición explícita de material y de su función física.

2. ENTORNO REAL Y RESTRICCIONES DE TRABAJO
========================================
[D, S10–S11] Las simulaciones licenciadas se ejecutan en un servidor
universitario. El flujo documentado es VPN institucional desde el PC,
sesión autenticada en MobaXterm y lanzamiento de Workbench con swb, sujeto
a la preparación del entorno de ese servidor.
GitHub/Codex no hereda esa conexión, las licencias ni la carpeta remota.
No afirmar que se ejecutó sdevice/sde/smesh/svisual si no hay evidencia.
No incluir contraseñas, claves, tokens ni datos del servidor de licencias.

[H] Versión de trabajo reportada: X-2025.06; un hilo; Transient=BE;
RandomSeed=1 en pruebas de referencia.
[D, S1] El manual adjunto sí corresponde a X-2025.06.
[V] Confirmar la versión efectiva mediante el encabezado del log de cada run.
Hubo mensajes históricos de licencias: sdevice_all expired,
sdevice-kmc checked out y sdevice-noise expired. Son observaciones antiguas,
no una descripción del estado actual ni prueba suficiente de un fallo físico.

[H] Preferencias de trabajo que deben conservarse:
- Entregar archivos completos o diffs precisos cuando se solicita código.
- Mantener un .par central y consistencia entre nodos.
- Primero una ejecución determinista trazable; después barridos y semillas.
- No fabricar curvas con Python para simular resultados de Sentaurus.
- En septiembre se pidió trabajar in-place en ReRAM-USFQ, sin crear nodos,
  carpetas/copias adicionales ni cambiar gtree.dat. En octubre se pidió
  reconstruir la secuencia con SDE/malla y nodos de forming/RESET/SET.
  No extrapolar una arquitectura histórica al proyecto actual. Inspeccionar
  el árbol vigente; conservarlo salvo necesidad acordada para el trabajo.
- Versionar cambios permitidos en Git y revisar diferencias antes de correr.

3. HISTORIAL RECUPERADO: RAMAS, ENSAYOS Y LIMITACIONES
====================================================
Todo este apartado es [H], salvo indicación explícita. Los valores proceden
del contexto histórico y NO de una relectura de los PLT/TDR originales.
No combinar corrientes, tensiones o conteos de ramas distintas en una curva.

3.1 Junio–julio: materiales y forming
- Junio: se reportó registro de Hafnium en DATEX, lectura de parámetros y
  exit status 0 en SDevice. Esto no valida sus propiedades físicas actuales.
- SILVANA_FINAL_C5: se describió rampa 0–3 V, compliance 5 uA, Imax cercana
  a 1.67 uA, cruce de 1 uA alrededor de 2.49 V y 59 partículas.
- V15-E: forming aceptado históricamente alrededor de 2.55 V, con referencia
  a compliance cercana a 5 mA. Archivos citados:
    FORMING_V15_E_final.tdr
    FORMING_V15_E_FORMING_V15_E.plt
- Otros resúmenes citaron V15/V18 con forming ~2.56 V, 35 eventos Generation,
  36 Growth, 0 Recession y 39 ImmobileVacancy. No atribuir estos conteos a
  V15-E sin comprobar que se trata del mismo run.
- Se mencionó refinamiento excesivo de malla, mínimo ~0.0098 nm y 90722
  elementos. La recomendación histórica fue refinar HfO2/interfaces y
  relajar metales. Esos tamaños NO constituyen una recomendación actual.

3.2 Julio–agosto: TesisV1 / TesisV1_V2
- Un resumen antiguo atribuyó a V1: RESET ~−0.65/−0.70 V, SET ~+0.8 V,
  LRS ~0.058–0.064 S, HRS ~8.64e-7 S y ON/OFF ~7.4e4.
  Es un resultado histórico no revalidado; difiere fuertemente de V2.
- V2: forming ~+2.564 V, RESET ~−0.370 V, SET ~+0.740 V.
  Lectura reportada a +50 mV: HRS ~2.76e-8 A y LRS ~1.09e-5 A,
  cociente ~394. Conteos resumidos: RESET 37→24 y SET 24→32
  ImmobileVacancy.
- Se recuperó una advertencia de auditoría: los RESET/SET finales no
  constituían una cadena completa desde el forming, no usaban
  UseKMCTimeStep y la corriente de túnel era cero. Por ello esa pareja
  no acredita un ciclo completo con transporte TAT validado.
- Intentos previos de SET a 0.9 y 1.2 V no recuperaron LRS. Otro SET
  conmutó cerca de +0.448 V y ~303.864 uS, con sobreactivación; ese estado
  pasó a ser entrada de un RESET posterior. Falta recuperar los inputs.
- Rama citada: TesisV1_V2_VALIDATED_20260806_074022. La palabra VALIDATED
  en el nombre no sustituye la auditoría de la cadena.

3.3 Septiembre: RESET con gap y lectura HRS/TAT
- Se seleccionó un estado llamado N34. En vivo se reportó O=2, V=6,
  ImmobileVacancy=34; al recargar cierto TDR se observó 4/0/32.
  Es un problema de conservación del estado a investigar, no una propiedad
  universal de InitialDefects ni demostración de que nunca pueda usarse.
- QSS alcanzó +0.050 V, pero se reportaron corrientes congeladas o
  TotalCurrent=0. El sesgo electrostático obtenido no probaba cálculo TAT.
- Se priorizó continuar RESET→SET en una misma ejecución para evitar el
  cambio observado al reimportar. Esta es una estrategia de diagnóstico;
  no una prohibición del encadenamiento por archivos si se verifica.
- Candidatos de archivos históricos:
    FINAL_RESET_GAP_SELECTED_N34_final.tdr
    FINAL_READ_HRS_N34_TAT_STEP06J_des.cmd
    FINAL_RESET_HRS_TAT_QS_V02.par
    FINAL_RESET_GAP_TARGET_V01_des.cmd
    FINAL_SET_des.cmd
- Se mencionaron 441148 bytes para el TDR seleccionado y 110 líneas para
  el CMD STEP06J. Había prefijos SHA256 c5d874bc… y 1fe342ee…; están
  incompletos y NO sirven para comprobar identidad. Recalcular hashes.
- Parámetros históricos MIM citados: metun=medos=0.2, HuangRhys=17,
  PhononEnergy=0.07 eV, EA=0.2 eV. No asumir que todo pertenece al mismo
  .par ni que EA es la barrera de todos los eventos de conmutación.
- Un SET histórico citó Generation Frequency=2e7, Ea=1.443 eV;
  FilamentGrowth Frequency=5e10, Ea=0.50 eV; sin FilamentRecession,
  rampa a +1.20 V y compliance 250 uA. No convertirlo en receta final.
- Un resumen de septiembre señaló I_conduction ~1e-15 A e I_TAT ~1e-10 A
  aun cuando la secuencia corría: faltaba LRS filamentario.

3.4 Octubre: reconstrucción y dudas de visualización
- En una rama HfO2_active + HfOx_active se reportó actividad KMC sin puente
  continuo. Se señalaron caídas de potencial de ~0.923263 V en óxido y
  ~2.050106 V en Hf; el campo de óxido reportado fue ~1.857 MV/cm.
  Estos datos motivan revisar contactos y conductividad del Hf, pero sin
  TDR actual no se afirma que sigan describiendo el dispositivo vigente.
- Se propusieron Weak.HfO2 y SwitchGap.HfO2, Hf Sigma=1e5 S/cm y MIM/TAT.
  Son decisiones propuestas/históricas, no una calibración certificada.
- Otra referencia V3 describió forming en 0.10 s, salto a +2.5636 V,
  compliance 55 uA y 38 vacancias. No confundir con forming a 5 mA.
- REC/TAT V03 habría completado tres rampas y fallado al escribir el TDR
  final. Se indicó revisar el PLT en /tmp. Falta comprobar y rescatar los
  archivos; no interpretar un fallo de escritura como resultado físico nulo.
- El 28–30 de octubre se solicitaron códigos completos para estructura,
  malla, forming, RESET, SET, un .par y datexcodes.txt.
- Se mencionó sdevice_IV_curve_des.cmd, nodo 5, seguido de cambio de nombre.
  El nombre vigente y la correspondencia de nodos no se conocen aquí.
- El usuario indicó que el nodo de forming terminó y quiso verlo en SVisual.
  También reportó un error en SET mediante captura. El texto completo del
  error no está disponible en esta revisión: no inventar su diagnóstico.
- Se discutió diferencia TDR/PLT, ventana vacía y apertura de curvas.

3.5 Rutas históricas para localizar evidencia, NO ruta activa certificada
  /home/eamaguana/DB/ReRAM/ReRAM_Edson
  /home/eamaguana/DB/ReRAM-Tesis/TesisV1
  /home/eamaguana/DB/ReRAM-Tesis/TesisV1_V2
  /home/eamaguana/DB/ReRAM-Tesis/TesisV1_V2_VALIDATED_20260806_074022
  /home/eamaguana/DB/ReRAM-Tesis/TesisV1_V2_DIAG_PHYSICS_20260824_092023/RERAM_FINAL_UNIFICADA_20260904
  ReRAM-USFQ (nombre de proyecto citado; ruta absoluta no confirmada).
No sobreescribir ninguna rama basándose únicamente en esta lista.

3.6 Estado que debe asumir Codex al retomar
Hay avances históricos de forming y ensayos de RESET/SET, pero esta revisión
no permite certificar un ciclo vigente, continuo y calibrado para el stack.
Faltan los inputs actuales, log completo, PLT y TDR correspondientes.
La siguiente acción útil es auditar esa evidencia, no empezar otro ajuste
masivo ni declarar terminada la ReRAM a partir de un nodo verde.

4. MANUAL: MAPA DE LECTURA PRIORITARIO
====================================
[D, S1] Sentaurus Device User Guide, X-2025.06:
- Cap. 2, pp. 65–66: materiales y datexcodes.txt.
- Cap. 36, pp. 1225–1282: Kinetic Monte Carlo MIM Transport.
  1225–1231: espacio KMC, semilla, distancias y gestión de llamadas.
  1232–1236: electrodos, aislantes y defectos.
  1238–1253: procesos de transporte, carga y rate-equation current.
  1264–1265: ejecución de las lecturas MIM.
  1265–1272: logs, corrientes, partículas y bandas.
- Cap. 37, pp. 1283–1307: Kinetic Monte Carlo ReRAM.
  1283–1286: activación, especies, capacidades e importación.
  1286–1290: eventos, localización y semillas de filamento.
  1290–1293: celda KMC, semilla, paso temporal y compliance.
  1294–1295: conductividad, calor y temperatura usada por KMC.
  1295–1298: transitorio, corriente conductiva y TAT.
  1299–1301: salidas y visualización.
  1301–1307: ejemplo con HfO2/HfOx/TiOx/Titanium.
El ejemplo no corresponde literalmente a TiN/HfO2/Hf/TiN.
El cap. 38 trata métodos numéricos; para esta guía se usaron además los
apartados de convergencia del training, sin convertir controles generales
para MOSFET en reglas automáticas para KMC-ReRAM.

5. GEOMETRÍA, MALLA Y MATERIALES
===============================
5.1 Dos discretizaciones diferentes
[D, S1 pp. 1290–1291; S2 sde/sde_4.html y smesh/smesh_03.html]
La malla del dispositivo y la rejilla de celdas KMC no son lo mismo.
Refinar SMesh no equivale a cambiar CellLength. Registrar ambos controles.
[P] Resolver el espesor de 5 nm, las interfaces y la región de gap esperada;
usar refinamiento local y comprobar sensibilidad antes de hacerlo global.
No adoptar una malla subatómica extrema como garantía de precisión.

5.2 Dominio KMC y contactos
[D, S1 pp. 1227–1228, 1291] El espacio se define por MinLocation,
MaxLocation y CellLength; las coordenadas se expresan en um. Debe incluir
aislante y al menos dos electrodos. Si se usan regiones metálicas para
contactar aislantes, el manual exige contacto de electrodo con cada región
metálica pertinente e inclusión de Poisson y Contact en la solución.
[P] Auditar cómo se representa el conjunto Hf/TiN y la conexión de Hf, en
vez de añadir un electrodo ficticio sin revisar la estructura real.
Partes del box fuera de la estructura se ignoran: un box mal ubicado puede
no representar el volumen que se cree estar simulando.

[D, S1 p. 1291] Los centros de celda KMC no deben coincidir con la interfaz
de contacto. Atender las advertencias mediante AlignCellsToRefLocation y
RefLocation cuando corresponda, conservando una justificación geométrica.
[P] Si se reduce el box a una región filamentaria, documentar la reducción
y su impacto; ya no representa automáticamente el volumen completo de 85².

5.3 Área efectiva en 2D
[D, S1 pp. 1286, 1295] Para KMC-ReRAM 2D, AreaFactor representa el ancho
no simulado en um; el valor por defecto es 1 um. Las corrientes de fuga y
conducción ReRAM están expresadas en A.
[P] Si la sección tiene ancho lateral 0.085 um y se busca profundidad
0.085 um, usar esa profundidad coherentemente; no dejar 1 um por descuido
ni multiplicar después otra vez la corriente por el área nominal.
Para 3D completo, verificar factores de escala antes de aplicar cualquiera.

5.4 Material, región y registro
[D, S1 pp. 65–66] datexcodes.txt registra materiales y su grupo; el orden
de prioridad es instalación, directorio de usuario y directorio local.
El registro local complementa/sobrescribe entradas. El .par aporta las
propiedades físicas; registrar un nombre no calibra su conductividad.
[P] Comprobar que Hafnium/Hf, TiN y HfO2 tienen identidad coherente en SDE,
TDR, datexcodes.txt y .par. Hf y TiN deben representar su función conductora;
HfO2 su función aislante. No copiar propiedades de silicio por omisión.

[H/P] Weak.HfO2, SwitchGap.HfO2, HfO2.left, HfO2.right y Hf.reservoir son
nombres de regiones usados/propuestos. No son materiales universales.
Si varias regiones contienen HfO2, Material="HfO2" puede afectarlas a todas;
Region restringe el alcance. Mapear cada reacción a una región o interfaz
existente. Si se introduce un gap débil, distinguirlo de un hueco geométrico
o de un cambio de material y justificarlo como hipótesis del modelo.

5.5 Comprobación previa al forming [P]
- Abrir la malla y confirmar capas, espesores, nombres y contactos.
- Resolver el estado inicial y un sesgo de diagnóstico documentado.
- Inspeccionar ReRAMPotential, campo y caída de potencial por capa.
- Investigar una caída dominante anómala en Hf antes de retocar barreras.
- Conservar la solución de referencia y comparar discretizaciones de forma
  controlada. Para KMC, separar cambios geométricos de variabilidad aleatoria.
[D, S2 smesh/smesh_06.html §6.1] QualityReport se aplica a mallas 3D,
no a 2D. No prometer que ese bloque por sí solo verifica una malla 2D.

6. KMC-ReRAM: ESPECIES Y EVENTOS
==============================
[D, S1 pp. 1283–1290]
La activación usa KmcReram dentro de Traps. KMCDefects define especies:
Particle1–3 y Filament1–3. Las especies Filament participan como conductoras
en la ecuación de conductancia. El nombre de una especie no le asigna por
sí solo todos los mecanismos de transporte o estados de carga.

Correspondencia histórica del proyecto, a comprobar en el deck:
  Particle1 → Oxygen
  Particle2 → Vacancy
  Filament1 → ImmobileVacancy
No equiparar automáticamente estas etiquetas con todos los estados de carga
del modelo de Zeumault: se necesita correspondencia explícita entre modelos.

Capacidad y ocupación:
- ParticlesPerVolume{i} y FilamentsPerVolume{i} controlan capacidad por
  volumen; no son lo mismo que concentración inicial Conc.
- Exclude y ShareCapacity modifican coexistencia de especies en celdas.
- Conc distribuye defectos iniciales sobre el volumen aplicable.
- El manual señala tratamiento especial de filamentos preexistentes: por
  defecto su tasa de recesión se pone a cero (p. 1286). Revisarlo antes de
  iniciar RESET desde un filamento impuesto mediante Conc.

Eventos documentados:
- Diffusion: movimiento de partículas entre celdas vecinas.
- Generation / Recombination: creación/recombinación en bulk o interfaz.
- FilamentGrowth / FilamentRecession: transición entre partícula y filamento.
- FrenkelPair identifica especies y regiones para generación/recombinación.
  En una interfaz, comprobar que cada especie corresponde al lado correcto.
- FilamentSeeds puede iniciar crecimiento desde electrodos o interfaces.

Las tasas dependen de Frequency, Ea, Dipole y del campo/temperatura local.
El manual advierte que la tasa de evento por defecto es cero. Declarar
especies sin eventos activos no genera por sí solo switching.
[P] Para cada evento registrar: ámbito, especies, unidades, fuente,
parámetros iniciales, rango de ajuste y mecanismo que representa.
No cambiar el signo del dipolo como truco para obtener la polaridad deseada
sin revisar la convención del campo y el significado del evento.

[P] Preferir un conjunto físico consistente durante forming/RESET/SET.
Si se desactiva recesión en SET o se cambian barreras según la etapa,
declararlo como experimento diagnóstico o modelo condicionado por fase.
No presentarlo como evidencia de que una única parametrización reproduce
naturalmente el ciclo. El objetivo final exige explicar esa decisión.

7. PASO TEMPORAL, TEMPERATURA Y COMPLIANCE
========================================
7.1 Evolución temporal
[D, S1 pp. 1292–1293] UseKMCTimeStep permite que los eventos KMC determinen
el avance transitorio. TargetParticle selecciona la especie monitorizada;
MaxTrapNumberChange limita sus cambios por paso. MaxTrapNumber es un
criterio de terminación por conteo, no un criterio universal de forming.

Advertencia importante del manual: MaxStep demasiado pequeño puede alterar
los resultados si no permite intervalos suficientes para eventos. Los
tiempos impuestos por Transient{Plot()} también pueden perturbar la secuencia.
El manual remite a callbacks temporales de Python para guardar cerca de
ciertos instantes sin forzar esos pasos. No inventar su implementación sin
leer la interfaz correspondiente. Los ejemplos del propio cap. 37 incluyen
Plot temporal; no asumir por ello que cualquier muestreo denso sea inocuo.

[P] Registrar duración de rampa y dV/dt, no sólo Vmax. KMC depende del
tiempo físico; cambiar duración puede cambiar switching. Comparar pruebas
a igual protocolo. Distinguir estabilización QSS de evolución de defectos.

7.2 Semilla y reproducibilidad
[D, S1 pp. 1229, 1292] RandomSeed positivo fijo permite repetir resultados
bajo mismos inputs y plataforma. No garantiza identidad entre versiones,
plataformas o configuraciones diferentes.
[P] Mantener semilla 1 y un hilo para depuración; después estudiar semillas
múltiples, sin seleccionar únicamente las que conmutan bien.

7.3 Autocalentamiento
[D, S1 pp. 1294–1295] ConductanceEquation calcula potencial conductivo;
HeatEquation calcula temperatura con calentamiento Joule. Para que KMC use
esa temperatura actualizada se requiere UpdateKMCTemperature; sin ella,
las tasas usan la temperatura inicial aunque exista una solución térmica.
El manual especifica que -HeatEquation es el comportamiento por defecto;
-ConductanceEquation impide resolver ambas ecuaciones.
[P] Elegir y declarar una hipótesis isoterma o electro-térmica. No atribuir
RESET a calentamiento si el cálculo de tasas sigue usando T inicial.
Verificar contactos térmicos y parámetros Kappa junto con Sigma.

7.4 Compliance real del modelo KMC
[D, S1 p. 1293] CurrentCompliance contiene Contact, MaxVal positivo y,
si se necesita límite negativo, MinVal negativo, en A. Al alcanzar el
límite se ajustan los sesgos de ReRAM para mantener la corriente.
LOS EVENTOS KMC SIGUEN OCURRIENDO bajo compliance: siguen cambiando tamaño
del filamento y distribución de defectos. No confundir límite con parada.

[P] Registrar tensión programada y ReRAMScaledBias; usar la tensión efectiva
apropiada para interpretar las curvas. Una meseta limitada no demuestra por
sí misma una conductancia intrínseca. Definir cuándo termina la etapa y
cuándo se realiza la lectura. No calcular R_LRS como V_fuente/I_compliance
sin comprobar el sesgo efectivo y la limitación.

8. TRANSPORTE: CONDUCTANCIA Y TAT/MIM
====================================
8.1 Parte conductiva
[D, S1 pp. 1294–1296] FilamentParameter en el .par contiene Sigma del
material y SigmaDef{i} de especies Filament, en S/cm. Kappa y KappaDef{i}
usan W/(cm K); las capacidades usan cm^-3. SigmaDef/KappaDef se aplican a
filamentos, no automáticamente a cualquier Particle.
[P] No confundir conductancia G [S] de la celda con conductividad [S/cm].
El valor de SigmaDef no determina G sin geometría, conectividad y volumen.
En una ruta localizada, el área eléctrica del filamento puede diferir del
área nominal. No convertir todo el óxido en conductor para forzar un LRS.

8.2 Activación de TAT en ReRAM
[D, S1 pp. 1296–1298] Se requiere TrapAssistedTunneling en KMCDefects,
asociación de especies a kmcmim1/kmcmim2 y mecanismos seleccionados en
KMC_MIM_Transport. No basta con añadir HuangRhys al .par.
EtFill y EtEmpty son niveles medidos desde la banda de conducción.
Xsection y XsectionT2T se usan en radios de localización para los procesos
correspondientes; sus unidades documentadas son cm² [S1 pp. 1234–1235].

Mecanismos posibles, a seleccionar con justificación:
  DirectTunneling; PooleFrenkelEmission;
  ElasticElectrodeToTrapTunneling / ElasticTrapToElectrodeTunneling;
  InelasticElectrodeToTrapTunneling / InelasticTrapToElectrodeTunneling;
  TrapToTrapTunneling, con variantes InelasticPhonon o MultiPhonon.
No activar todos por acumulación ni sumar mecanismos duplicados sin
comprobar qué corrientes ya integra el simulador.

[D, S1 pp. 1232–1235] Electrodos: revisar material, WorkFunction,
FermiEnergy y masas pertinentes. Aislantes: permitividad, Chi0, Eg0,
masas, energías de trampas y parámetros fonónicos.
Los valores del ejemplo del manual no son mediciones del stack de Edson.
El cap. 37, p. 1307, incluye metun=medos=0.2, HuangRhys=17 y
PhononEnergy=0.070 eV, pero también EA=3.00 eV en KMC_MIM_Transport.
El EA=0.2 eV del historial es distinto. NO confundir EA de ese bloque con
Ea de cada evento de KMCDefects o con una energía de relajación de un paper.
Antes de ajustar cualquier EA, rastrear su definición y el mecanismo que
efectivamente lo utiliza; una coincidencia numérica no prueba equivalencia.

8.3 Por qué TAT puede aparecer nulo o congelado
[D, S1 p. 1298] TAT puede omitirse al alcanzar compliance. También existen
criterios MaxTATTrapNumber y MaxConductance para detener/omitir su cálculo.
[P] Antes de concluir «no hay túnel», revisar activación, especies asociadas,
criterios de omisión, logs, energía/distancias y variable de salida elegida.
Si la corriente depende exclusivamente de Sigma del aislante, una lectura
HRS no demuestra TAT aunque el nombre del archivo contenga TAT.

8.4 Lecturas MIM y REC
[D, S1 pp. 1229–1231, 1252–1253, 1264–1265]
En el flujo KMC-MIM de fuga, QSS establece el sesgo y Transient ejecuta
la dinámica electrónica KMC. Un QSS por sí solo no acredita una lectura
KMC-MIM renovada. Separar cambios de sesgo, evolución electrónica y
evolución estructural de defectos.
RateEquationCurrent calcula ocupaciones y corriente a partir de las tasas
de transporte; la salida pertinente es MIMRateEquationCurrent. El manual
documenta REC con SkipKMC para resolver transporte sin ejecutar KMC-MIM.
Esto no prueba conservación automática de una ReRAM en cualquier deck.

[P] Dos experimentos diferentes deben etiquetarse:
A) Lectura de estado fijo: conserva topología/especies; permite calcular
   transporte electrónico para distintos sesgos. Verificar realmente que
   la exportación/importación y el cálculo no alteran ese estado.
B) Lectura física de la memoria: incluye posible evolución por el estímulo
   de lectura y permite evaluar read disturb.
No usar un reset de ocupaciones o congelación de defectos sin declararlo.

[D, S1 pp. 1229–1230] SkipKMCCurrentCheck/SkipKMCNumber pueden omitir
llamadas posteriores cerca de estado estacionario. ResetElectronFill
cambia la reutilización de ocupaciones entre transitorios. Registrar estas
opciones si se comparan curvas o se investigan valores repetidos.
[D, S1 p. 1230] Las tasas MIM se reinician al encontrar un nuevo Transient;
MoreFrequentRateResets tiene condiciones específicas (p. 1231), no es un
arreglo universal para cualquier corriente congelada.

8.5 Bandas y distribución espacial
[D, S1 pp. 1271–1272] MIMParticle permite ver defectos; los mapas continuos
de concentración son una representación aproximada. El archivo de bandas
MIM permite ver Ec, Ev y niveles de trampas; PrintBandDiagram añade salidas
al inicio de los transitorios. Un diagrama no determina por sí solo todos
los parámetros de transporte.
[P] Examinar bandas y potencial antes/después de forming, RESET y SET,
con la misma referencia de electrodo y convención energética.

9. CONTINUIDAD ENTRE ESTADOS Y ORGANIZACIÓN EN WORKBENCH
=======================================================
[D, S1 p. 1285] InitialDefects permite cargar defectos desde un TDR de otra
simulación ReRAM. Se presupone la misma estructura y nombres de defectos
idénticos. Los defectos cargados interactúan con los eventos especificados.
Esto no equivale a restaurar necesariamente todo el estado del solver,
la historia temporal o el generador aleatorio.

[P] Para encadenar nodos:
- Identificar inequívocamente el TDR productor y el consumidor.
- Comparar especies, conteos, posiciones/regiones y configuración KMC.
- Registrar el estado inmediatamente antes de exportar y después de cargar,
  antes de que nuevos eventos puedan explicar una diferencia.
- Comprobar CellLength, box, capacidades, Exclude, nombres y geometría.
- Ante discrepancia tipo N34→N32, detener la afirmación de continuidad y
  probar primero cadena única o importación mínima instrumentada.
- Un mismo conteo no demuestra la misma topología; las posiciones importan.

[D, S2 sd/sd_10.html §§10.2 y 10.5] En SWB los placeholders habituales son
@tdr@, @tdrdat@, @plot@, @log@ y @parameter@. @tdr@ busca una estructura
previa en el árbol; NO significa automáticamente «estado final del forming».
Verificar el nombre resultante en el archivo preprocesado.
El flujo estándar busca sdevice.par para preprocesar @parameter@; también
se documentan archivos por instancia <tool_name>_des.par. No asegurar que
un archivo llamado arbitrariamente .parameter fue leído sin revisar el
preprocesado y el log. En standalone el .par puede tener otro nombre.

[P] Un .par central funciona si cada nodo lo referencia correctamente y
no existen overrides inadvertidos. Revisar nombres y expansión por nodo.
SDE y SMesh pueden orquestarse desde el flujo SDE (S2 sde_4 §4.5); eso no
significa pegar Scheme y sintaxis de SDevice/SMesh sin separación en un
archivo que un único parser deba interpretar.

Secuencia lógica propuesta, sin imponer nuevos nodos:
  geometría/malla → comprobación inicial → forming → lectura LRS
  → RESET → lectura HRS → SET → lectura LRS recuperada → ciclos/pulsos.
Cada flecha exige continuidad demostrada. Las lecturas pueden organizarse
como etapas en el mismo deck o como análisis derivados de estados, según
la validación de exportación/importación.

10. QUÉ DEBE DEMOSTRAR CADA ETAPA
================================
Esta sección es [P], apoyada en S1, S3, S4 y S5. Son criterios de trabajo,
no resultados ya obtenidos ni tolerancias normativas del fabricante.

G0 — Identidad de ejecución:
Inputs completos, versión del simulador, semilla, hilo, .par efectivamente
leído, malla y defectos iniciales; hashes y protocolo eléctrico disponibles.

G1 — Estructura:
Stack correcto, contactos coherentes, escala 2D/3D correcta, box KMC útil,
material Hf verificado y perfil de potencial razonable.

G2 — Forming:
Transición desde estado inicial documentado; crecimiento/conectividad
compatibles con aumento de conductancia; corriente y tensión efectiva;
lectura LRS estable a bajo sesgo después de retirar programación.
Un salto de corriente puede venir de compliance o fallo numérico: contrastar
con eventos, partículas y campos. Si la topología no forma puente continuo,
no llamarla LRS filamentaria sin demostrar el transporte alternativo.

G3 — RESET:
Parte del LRS realmente obtenido; muestra cambio de conectividad/gap y
reducción de conductancia a igual Vread. No exige eliminar todas las
vacancias. Distinguir ruptura local de destrucción artificial de toda la celda.

G4 — Lectura HRS:
La corriente se calcula de nuevo; mecanismo identificado y estado estable.
Analizar I-V en rango que no provoque SET. Un valor no nulo no basta para
confirmar TAT; comprobar componente y activación.

G5 — SET:
Parte del HRS de RESET; recupera una trayectoria conductora y conductancia
de lectura alta sin restaurar a mano el archivo LRS inicial.

G6 — Ciclo completo:
Forming→LRS→RESET→HRS→SET→LRS con procedencia continua y variables iguales.
Mostrar I-V lineal y semilog, dirección temporal y estados correspondientes.
No ensamblar curvas de runs incompatibles para fabricar histéresis.

G7 — Robustez:
Repetición con semilla fija y análisis de sensibilidad numérica; después
múltiples semillas/ciclos, incluidos fallos. No imponer igualdad exacta
de microestados al cambiar malla o versión.

G8 — Pulsos y 1T1R:
Programación y lectura separadas, conductancia por pulso, dispersión,
saturación, read disturb y control de corriente por transistor.
No declarar operación sináptica sólo porque existen HRS y LRS binarios.

11. EXTRACCIÓN, FIGURAS Y COMPARACIÓN EXPERIMENTAL
=================================================
[D, S1 pp. 1299–1301] Salidas específicas:
  ReRAMScaledBias
  ReRAMConductionCurrent
  ReRAMTunnelingCurrent
  ReRAMTotalCurrent
  PlotKMCStatistics en Math/KMC para estadísticas en PLT.
  ReRAMParticle, ReRAMPotential, ReRAMTemperature, ReRAMField,
  ReRAMCurrent para campos/partículas en TDR.
Verificar los nombres y jerarquías presentes en el dataset real.

[D, S1 pp. 1269–1270] MIM usa otras salidas, por ejemplo MIMTotalCurrent,
MIMLeakageCurrent y componentes de túnel. REC tiene su propia corriente.
No seleccionar TotalCurrent genérico suponiendo que siempre representa
la suma ReRAM adecuada. No sumar otra vez REC a una corriente que ya
representa el mismo transporte.

[D, S2 sd_1 §1.2.1; sv_1 §§1.2–1.3; sv_3 §3.2]
TDR: estructura/campos/partículas según contenido guardado.
PLT: series de sesgo/tiempo/corriente y otras magnitudes escalares.
SVisual puede abrirse independientemente; no es obligatorio crear un nodo
SVisual para examinar un archivo existente. Un dataset XY puede cargarse
y mostrar un gráfico vacío hasta que se asignan sus variables a los ejes.
Una ventana vacía no demuestra por sí sola que la simulación no produjo datos.

Protocolo de figuras [P]:
- Curva lineal con corriente firmada y flechas de recorrido.
- Semilog de abs(I), indicando explícitamente ese tratamiento.
- No sustituir ceros por corrientes inventadas; marcar límite de detección
  o excluir ceros sólo de la representación logarítmica, preservando datos.
- Mantener orden temporal; no ordenar todo por V mezclando ida y vuelta.
- Marcar compliance, Vread y estados. Guardar puntos exportados con unidades.
- Comparar mapas de partículas con misma escala, box y criterio visual.

Definiciones de análisis [P]:
  Gread = I(Vread)/Vread, si Vread no es cero y se especifica protocolo.
  Rread = Vread/I(Vread), con signo/magnitud tratados coherentemente.
  Ventana ON/OFF = abs(I_LRS(Vread))/abs(I_HRS(Vread)), a igual sesgo.
  En una región óhmica, extraer también G mediante ajuste de pendiente I-V.
  Energía de programación: integral de V_celda(t)·I_celda(t) dt, con
  convención pasiva y datos temporales reales; separar energía de circuito.
  Vform/Vset/Vreset: declarar el criterio de extracción y resolución temporal.
  DeltaG por pulso: G posterior menos G anterior, a igual Vread.
Las definiciones no garantizan que la salida elegida incluya todas las
contribuciones de energía; justificar la corriente utilizada.

[D, S4 p. 2] LRS experimental se representa mediante I=G·V. HRS se ajusta
en ese artículo mediante I=I0·exp(alpha·V) en el rango considerado.
[H/P] La expresión tipo sinh fue un objetivo de lectura en conversaciones;
NO es una ecuación universal impuesta por el cap. 37 ni coincide literalmente
con ese ajuste exponencial del artículo. Si se utiliza sinh, explicar rango,
simetría, offset, unidades y criterio de ajuste. No imponerla a los datos.

[H] Se citaron objetivos aproximados de forming 2.3–2.6 V, SET +0.6–0.8 V,
RESET −0.9/−1.1 V y G_LRS 160–190 uS. No están certificados aquí como
valores experimentales precisos del dispositivo de 85 nm. No usarlos como
restricciones duras hasta recuperar la figura/datos y protocolo exactos.
El onset ~2.2–2.3 V atribuido a una presentación también queda por verificar.
La compliance 5 mA y los espesores sí se comprobaron directamente en S4.

12. QUÉ APORTA CADA ARTÍCULO Y QUÉ NO DEBE TRANSFERIRSE
======================================================
[D] S4 — Guitarra/Trojman/Raymond, 2018, pp. 1–3:
Es la referencia experimental más directa para el stack y las áreas.
Fundamenta comparar switching bipolar, LRS óhmico, HRS no lineal y
variabilidad. Su modelo es fenomenológico/percolativo; no es un deck
Sentaurus ni una tabla validada de Frequency/Ea/Dipole para nuestro KMC.
La región activa estrecha del filamento motiva estudiar un gap localizado,
pero no prueba una posición o dimensión exacta para SwitchGap.HfO2.

[D] S5 — Zeumault et al., 2021, resumen y §2.1, pp. 1, 3–5:
Conecta dinámica KMC, vacancias/ocupación, transporte y evaluación de circuito.
Considera acoplamiento electrón-red y no identifica sin más toda vacancia
con un donador ionizado. Su dispositivo de referencia tiene óxido de 5 nm,
ancho 40 nm y electrodos Ti/TiN: NO es el stack Hf de 85×85 nm².
Tabla 1, p. 4: valores nominales incluyen Huang–Rhys 17 y energía fonónica
0.07 eV. La coincidencia con un ejemplo del manual no calibra el stack.
No exigir el mismo número absoluto de vacancias: volumen, discretización,
estado de carga, especies y topología pueden diferir.

[D] S6 — Kim y Lee, 2024, resumen p. 1:
Estudia ReRAM HfO2 y HfO2-Al2O3, KMC, TAT y térmica, y utiliza conductancias
extraídas para evaluación neuromórfica. Sirve como referencia de metodología
dispositivo→conductancia→sistema. No justifica añadir Al2O3 al stack actual
ni trasladar su rendimiento de MNIST a esta tesis.

[D] S7 — Goes et al., 2021, PDF p. 2, secciones II–III:
Modelo en Silvaco Victory contrastado con dispositivos Weebit-nano de SiOx,
con TiN y Ti y transistor limitador. Es útil para razonar sobre compliance,
retención y física electro-térmica. Sus ecuaciones/opciones no constituyen
sintaxis Sentaurus ni parámetros directamente transferibles a HfO2/Hf.

[D] S8 — Aguirre et al., 2024, resumen p. 1:
Revisión de implementación hardware de ANN con memristores, bloques y
métricas. Contextualiza la parte sináptica/circuital. No calibra nuestro
forming ni obliga a ampliar la tesis a una red neuronal completa.

[D] S9 — Pazos et al., 2025, resumen p. 1:
Comportamiento neuronal/sináptico de un transistor CMOS y celda de dos
transistores NS-RAM. Es una alternativa conceptual para contextualizar
neuromórfica; no es evidencia de switching por vacancias en nuestro HfO2.

13. DEL DISPOSITIVO A PULSOS Y 1T1R
===================================
[P, basado en S3, S5 y S2 sd/sd_3.html]
Después de G6, aplicar trenes de pulsos con amplitud, duración, flancos,
intervalos y número de pulsos registrados. Leer después de cada pulso.
Separar potenciación/depresión, rango dinámico, número de estados
distinguibles, monotonicidad, asimetría, saturación y variabilidad.
Mantener casos de fallo y evitar ajustes que sólo funcionen para una semilla.

La representación circuital debe reproducir datos realmente obtenidos:
I-V de estados, transiciones y respuesta a pulsos en su rango calibrado.
Una resistencia conmutada entre dos valores no demuestra modulación analógica.
Validar el modelo extraído en protocolos no usados en el ajuste.

El training explica Mixed Mode, Device y System, pero eso no certifica
automáticamente cualquier acoplamiento KMC-ReRAM con circuito. Revisar
compatibilidad de la versión antes de prometer una integración directa.
La ruta prevista por la tesis admite extracción de comportamiento y después
1T1R en un entorno circuital adecuado. Conservar la trazabilidad al TCAD.

En 1T1R comprobar tensión que realmente recibe la ReRAM, limitación por el
transistor, caída de tensión en éste y perturbación de lectura. La compliance
ideal del deck de dispositivo no sustituye toda la dinámica de un transistor.

14. CHECKLIST DE DEPURACIÓN Y PRÓXIMO PASO
=========================================
Orden recomendado [P]:
1) Leer árbol actual, CMD fuente y preprocesado, .par y datexcodes.txt.
2) Determinar qué error exacto tuvo SET: preprocesado, parser, archivo
   inexistente, licencia, convergencia, escritura o comportamiento físico.
3) Revisar G0/G1 y el último forming antes de modificar RESET/SET.
4) Demostrar lectura LRS y continuidad del estado hacia RESET.
5) Demostrar gap/HRS y lectura recalculada; resolver importación N34 si aplica.
6) Recuperar LRS desde ese mismo HRS mediante SET.
7) Sólo entonces afinar contra datos experimentales y ampliar a pulsos.

Diagnóstico por síntoma:
- No hay eventos: ámbito/regiones, Frequency, especies, box y tiempo KMC.
- Hay eventos pero I es mínima: conectividad, Sigma/SigmaDef, contactos,
  potencial y asociación TAT. No aumentar todas las tasas a la vez.
- «LRS» sólo bajo programación: retirar sesgo y leer; comprobar compliance.
- RESET no rompe: mecanismo de recesión/recombinación, preexisting filaments,
  polaridad, campo local, temperatura usada y duración.
- TAT cero: activación y vínculo kmcmim, criterios de omisión y dataset.
- Corriente congelada: QSS frente a Transient/REC, omisión de KMC y logs.
- Estado importado cambia: estructura, especies, box/celdas/capacidad y
  comparación antes de nuevos eventos, no sólo nombre del archivo.
- Potencial cae en Hf: identidad conductora, parámetros leídos y contactos.
- Fallo al guardar TDR: espacio/permisos/ruta y evidencia parcial ya escrita;
  no descartar ni reiniciar ciegamente una corrida larga.
- SVisual vacío: archivo y dataset correctos, carga y asignación de ejes.

Evidencia mínima que debe conservar cada corrida:
  identificador; fecha; commit; versión Sentaurus; seed; threads;
  CMD fuente y preprocesado; PAR fuente y preprocesado; datexcodes;
  hash malla/estado inicial; tiempos y tensiones; compliance;
  log completo; PLT de datos; TDR de estados; hash de cada artefacto;
  conclusión y criterio usado; incertidumbres; siguiente cambio propuesto.
No guardar únicamente una captura o la última línea del log.

Propuesta de registro para incorporar al mismo TXT después de cada prueba:
  RUN_ID:
  Objetivo y cambio único:
  Inputs/commit/hashes:
  Estado inicial y procedencia:
  Versión/seed/threads:
  Protocolo V(t)/compliance/T:
  Resultado numérico y archivos:
  Eventos/partículas/conectividad antes-después:
  Corriente leída y variable exacta:
  Gates aprobados/fallidos:
  Conclusión [confirmada / hipótesis / pendiente]:

15. PAUTAS FINALES PARA CODEX
=============================
- Mantener español para explicaciones y keywords originales en los decks.
- No inventar comandos a partir de nombres plausibles. Citar sección/página
  para opciones nuevas; distinguir sintaxis de SDE, SMesh, SDevice y SWB.
- No convertir snippets ilustrativos en un archivo «completo y validado».
- Revisar alcance de cada parámetro y unidades antes de ajustar.
- Separar error confirmado, hipótesis física y prueba que falta ejecutar.
- Conservar procedencia de estados y parámetros en todas las fases.
- No trasladar valores entre SiOx, Ti, Hf, HfOx y HfO2 sin justificación.
- No afirmar calibración por coincidencia de una tensión de switching.
- No borrar evidencia de ensayos fallidos ni ocultar límites del modelo.
- Este TXT resume el historial disponible; actualizarlo con resultados
  reales cuando lleguen. Su fecha de corte no vuelve actuales los runs viejos.

16. FUENTES Y LOCALIZADORES
===========================
[S1] Synopsys, Sentaurus Device User Guide, X-2025.06.
Archivo aportado: tcad_sdevice_ug(1).pdf, 1887 páginas.
Secciones/páginas empleadas indicadas en §§4–11 de este TXT.

[S2] Sentaurus_Training.zip, contenido con copyright Synopsys 2025.
Rutas consultadas, relativas a Sentaurus_Training/:
  sd/sd_1.html: Basics, §§1.2–1.3.
  sd/sd_3.html: Mixed Mode, §§3.1–3.2.
  sd/sd_6.html: Nonlinear System Newton Solver, §§6.1–6.3.
  sd/sd_9.html: Three-Dimensional Device Simulation, §§9.1–9.3.
  sd/sd_10.html: Running SDevice in SWB, §§10.2–10.6.
  sd/sd_19.html: Tunneling, contexto general; no receta KMC-ReRAM.
  sde/sde_2.html: Generating 2D Boundaries, geometría y contactos.
  sde/sde_4.html: Generating Meshes, §§4.2–4.5.
  smesh/smesh_03.html: Meshing at Interfaces, §§3.1–3.3.
  smesh/smesh_06.html: Mesh Quality Checking, §6.1.
  sv/sv_1.html: Getting Started, apertura y carga.
  sv/sv_3.html: Working With XY Plots, §3.2.
No se identificó un tutorial específico KMC-ReRAM dentro de los HTML
revisados. El soporte específico de esta guía proviene de S1 cap. 36–37.

[S3] Objetivos tesis.txt, correo de Silvana aportado por el usuario.
Fuente primaria del objetivo, pregunta central y tres niveles de tesis.

[S4] Silvana Guitarra, Lionel Trojman, Laurent Raymond.
A phenomenological model of the resistive switching for Hf-based ReRAM
devices, ETCM 2018. Archivo ETCM-2018-132(1).pdf, 5 páginas.
§II.A p. 1: stack, áreas, 1T1R y compliance de forming.
§II.B–C pp. 1–2: switching, LRS y HRS.
§III p. 3: región activa y modelo fenomenológico.

[S5] Andre Zeumault et al. (2021).
TCAD Modeling of Resistive-Switching of HfO2 Memristors: Efficient
Device-Circuit Co-Design for Neuromorphic Systems.
Frontiers in Nanotechnology 3:734121.
DOI: https://doi.org/10.3389/fnano.2021.734121
Archivo Zeumault_TCADModelingOfResistiveSwitching.pdf, 16 páginas.
Resumen p. 1; §2.1 pp. 3–5; Tabla 1 p. 4.

[S6] Seonggyeom Kim, Jonghwan Lee (2024).
TCAD Simulation of Resistive Switching Devices: Impact of ReRAM
Configuration on Neuromorphic Computing. Nanomaterials 14, 1864.
DOI: https://doi.org/10.3390/nano14231864
Archivo nanomaterials-14-01864 (1).pdf, 15 páginas; resumen p. 1.

[S7] W. Goes et al. (2021).
A Comprehensive Oxide-Based ReRAM TCAD Model with Experimental
Verification. IEEE International Memory Workshop.
Archivo Weebit-nano_Silvaco_ReRAM-TCAD_Oxide-Based-Model_IMW_OxRAM_2021_published-on-IEEE_V3-1.pdf.
6 páginas PDF; p. 1 aviso editorial, p. 2 inicio del artículo y §§II–III.

[S8] Fernando Aguirre et al. (2024).
Hardware implementation of memristor-based artificial neural networks.
Nature Communications 15, 1974.
DOI: https://doi.org/10.1038/s41467-024-45670-9
Archivo s41467-024-45670-9.pdf, 40 páginas; resumen p. 1.

[S9] Sebastian Pazos et al. (2025).
Synaptic and neural behaviours in a standard silicon transistor.
Nature 640, artículo que comienza en p. 69.
DOI: https://doi.org/10.1038/s41586-025-08742-4
Archivo s41586-025-08742-4.pdf, 11 páginas; resumen PDF p. 1.

[S10] README.md del proyecto, versión leída el 2026-11-03, 89 líneas:
objetivo, entorno remoto, alcance y roadmap. No prueba de simulación.
[S11] AGENTS.md del proyecto, versión leída el 2026-11-03, 34 líneas:
criterios de revisión, entorno, evidencias y reglas de continuidad.

[HIST] Conversaciones de tesis y contexto recuperado hasta 2026-11-03.
Los informes históricos nombrados en esa recuperación (auditoría V1/V2,
traspaso septiembre, presentación de avances V3) NO fueron leídos
directamente en esta revisión. Se conserva su información únicamente
como historial [H], pendiente de contrastar con esos archivos y runs.

Este documento contiene síntesis original y localizadores, no una copia
del manual/training ni sus ejemplos completos. Para GitHub conservar las
referencias y subir únicamente fuentes/artefactos con permiso de difusión;
no es necesario publicar el manual propietario para que Codex use este TXT.

17. IDENTIFICACIÓN DE LOS ADJUNTOS REVISADOS
===========================================
Los SHA256 siguientes se calculan sobre los adjuntos de esta revisión.
Permiten identificar las fuentes documentales, NO las simulaciones históricas.

01-Sentaurus_Training.zip
SHA256: 381b7cfa5472626a76ad90904ee39277e204158ab30e379e12fba4cf4d763c9c

02-Zeumault_TCADModelingOfResistiveSwitching.pdf
SHA256: 16ff2cac77aa2f524ad805d7f837447868e50295b520ec01aa9c798d6d37a908

03-nanomaterials-14-01864-1-.pdf
SHA256: 817f0b8da6717cdc1a999239bc93967e9891dc8853deb47924ebe01f6554f9ce

04-s41586-025-08742-4.pdf
SHA256: ca35bbf8f2709f2d7202ad811bfcf56a48a98478429642a2eeb9f84cf56e58fc

05-s41467-024-45670-9.pdf
SHA256: 01847a41491bfa2a47813514a924da4291036ba9d2958e5bf53cbee69882b493

06-Weebit-nano_Silvaco_ReRAM-TCAD_Oxide-Based-Model_IMW_OxRAM_2021_published-on-IEEE_V3-1.pdf
SHA256: e8b1ca2be066dae0e67d9ca6bdff69c4f1dddc4ece789c944075600dffd80f23

07-Objetivos-tesis.txt
SHA256: ed703e019c848c0363e28eec6bcc439c233c0d83375522f143a9c265f9473aeb

08-ETCM-2018-132-1-.pdf
SHA256: fba10428f5af72ef89c43a91193db6dde5a2ec03248caf9c73def998067913c4

09-tcad_sdevice_ug-1-.pdf
SHA256: d171eaac74be87b120fe8eccd3f315949edd4479379eeef20ca5f819394afd1c
