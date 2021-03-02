# healthyapp

A new Flutter project.

## Instrucciones para ejecutar

-Necesitará el SDK de Android, descargue Android Studio: https://developer.android.com/studio.  
-Descargue Flutter: https://flutter.dev/docs/get-started/install  
-En VScode descargue la extension de flutter.  
-Necesitará un emulador android, puede crearlo en android-studio con AVD Manager.  
-En VScode cree un proyecto flutter: flutter create healthyapp.  
-Acepte las licencias si se piden.  
-En su proyecto flutter:  

    1- Reemplace la carpeta lib por la del repositorio  
    
    2- Agregue el archivo google-services.json en android/app/
    
    3- En el archivo build.gradle de la carpeta android, agregue en dependencias classpath 'com.google.gms:google-services:4.3.4'
    
    4- En el archivo build.gradle de android/app, en defaultConfig reemplace: applicationId "com.IHC.healthyapp" , minSdkVersion 21 , targetSdkVersion 29

    5- En el archivo anterior agregue en dependencies: implementation platform('com.google.firebase:firebase-bom:26.3.0')

    6- Reemplace el archivo pubspec.yaml  
    
    7- Agregue la carpeta assets  
-Ejecute con : flutter run en terminal, o start debugging de VScode.  
-Le pedira un emulador, seleccione el que creó.  