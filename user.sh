#!/bin/bash
clear
if [ -e /ldap/user.ldif  ]
then
  read -p "Ya hay un fichero user.ldif creado y será sobreesrito, ¿desea continuar? [s/n]: " SOBREESCRIBIR
  case $SOBREESCRIBIR in
    "s" | "si" | "S" | "Si" | "SI" | "sI")
      clear
      echo "#CREACIÓN DE USUARIOS LDAP (XILOFONE)" > /ldap/user.ldif
      echo "TODOS LOS USUARIOS SERÁN CREADOS EN LA UNIDAD ORGANIZATIVA USUARIOS"
      read -p "¿Cuál fué el último numero identificativo de un usuario? [Si no estás segur@ es recomendable que lo compruebas antes de seguir]: " id
      if [ $id -gt 0 ]
      then
        let id=id
      else
        echo "No has elegido un valor válido. Saliendo..."
        sleep 1
        exit 0
      fi
      user=0
      echo "Estos son los distintos grupos que existen en tu LDAP y sus gidNumber, los necesitarás."
      ldapsearch -x -LLL -b ou=grupos,dc=xilofone,dc=com cn gidNumber
      while [ $user != "exit" ]
      do
      read -p "Nombre del usuario ['exit' para salir]: " user
      if [ $user != "exit" ]
      then
        read -p "Apellido del usuario ['exit' para salir]: " apellido
        read -p "Login del usuario ['exit' para salir]: " login
        read -p "Contraseña del usuario ['exit' para salir]: " pass
        read -p "Correo electrónico del usuario ['exit' para salir]: " correo
        read -p "ginNumber del grupo al que pertenecerá ['exit' para salir]: " grupo
        let id=id+1
        echo "" >> /ldap/user.ldif
        echo "#New" >> /ldap/user.ldif
        echo "dn: uid=$login,ou=usuarios,dc=xilofone,dc=com" >> /ldap/user.ldif
        echo "objectClass: inetOrgPerson" >> /ldap/user.ldif
        echo "objectClass: posixAccount" >> /ldap/user.ldif
        echo "uid: $login" >> /ldap/user.ldif
        echo "sn: $apellido" >> /ldap/user.ldif
        echo "cn: $nombre $apellido" >> /ldap/user.ldif
        echo "uidNumber: $id" >> /ldap/user.ldif
        echo "gidNumber: $grupo" >> /ldap/user.ldif
        echo "userPassword: $pass" >> /ldap/user.ldif
        echo "loginShell: /bin/bash" >> /ldap/user.ldif
        echo "homeDirectory: /home/$login" >> /ldap/user.ldif
        echo "mail: $correo" >> /ldap/user.ldif
        echo "Usuario $login añadido con uidNumber $id en el grupo $grupo."
      else
        read -p "Pulsa [s] para crear de forma automática los usuarios o [n] si quieres comprobar antes el fichero user.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando usuarios..."
          ldapadd -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/user.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Usuarios creados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de crear tus usuarios. ¡Hasta pronto!"
          sleep 1
          ;;
        *)
          echo "Opción no válida, saliendo..."
          sleep 1
        esac
      fi
      done
      ;;
    "n" | "no" | "N" | "No" | "NO" | "nO")
      clear
      echo "¡Haz una copia del fichero y vuelve a intentarlo!"
      sleep 1
      ;;
    *)
      echo "Opción no valida, saliendo..."
      sleep 2
  esac
else
  clear
      echo "#CREACIÓN DE USUARIOS LDAP (XILOFONE)" > /ldap/user.ldif
      echo "TODOS LOS USUARIOS SERÁN CREADOS EN LA UNIDAD ORGANIZATIVA USUARIOS"
      read -p "¿Cuál fué el último numero identificativo de un usuario? [Si no estás segur@ es recomendable que lo compruebas antes de seguir]: " id
      if [ $id -gt 0 ]
      then
        let id=id
      else
        echo "No has elegido un valor válido. Saliendo..."
        sleep 1
        exit 0
      fi
      user=0
      echo "Estos son los distintos grupos que existen en tu LDAP y sus gidNumber, los necesitarás."
      ldapsearch -x -LLL -b ou=grupos,dc=xilofone,dc=com cn gidNumber
      while [ $user != "exit" ]
      do
      read -p "Nombre del usuario ['exit' para salir]: " user
      if [ $user != "exit" ]
      then
        read -p "Apellido del usuario ['exit' para salir]: " apellido
        read -p "Login del usuario ['exit' para salir]: " login
        read -p "Contraseña del usuario ['exit' para salir]: " pass
        read -p "Correo electrónico del usuario ['exit' para salir]: " correo
        read -p "ginNumber del grupo al que pertenecerá ['exit' para salir]: " grupo
        let id=id+1
        echo "" >> /ldap/user.ldif
        echo "#New" >> /ldap/user.ldif
        echo "dn: uid=$login,ou=usuarios,dc=xilofone,dc=com" >> /ldap/user.ldif
        echo "objectClass: inetOrgPerson" >> /ldap/user.ldif
        echo "objectClass: posixAccount" >> /ldap/user.ldif
        echo "uid: $login" >> /ldap/user.ldif
        echo "sn: $apellido" >> /ldap/user.ldif
        echo "cn: $nombre $apellido" >> /ldap/user.ldif
        echo "uidNumber: $id" >> /ldap/user.ldif
        echo "gidNumber: $grupo" >> /ldap/user.ldif
        echo "userPassword: $pass" >> /ldap/user.ldif
        echo "loginShell: /bin/bash" >> /ldap/user.ldif
        echo "homeDirectory: /home/$login" >> /ldap/user.ldif
        echo "mail: $correo" >> /ldap/user.ldif
        echo "Usuario $login añadido con uidNumber $id en el grupo $grupo."
      else
        read -p "Pulsa [s] para crear de forma automática los usuarios o [n] si quieres comprobar antes el fichero user.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando usuarios..."
          ldapadd -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/user.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Usuarios creados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de crear tus usuarios. ¡Hasta pronto!"
          sleep 1
          ;;
        *)
          echo "Opción no válida, saliendo..."
          sleep 1
        esac
      fi
      done
fi
