#!/bin/bash
clear
if [ -e /ldap/group.ldif  ]
then
  read -p "Ya hay un fichero group.ldif creado y será sobreesrito, ¿desea continuar? [s/n]: " SOBREESCRIBIR
  case $SOBREESCRIBIR in
    "s" | "si" | "S" | "Si" | "SI" | "sI")
      clear
      echo "#CREACIÓN DE UNIDADES ORGANIZATIVAS LDAP (XILOFONE)" > /ldap/group.ldif
      echo "TODOS LOS GRUPOS SERÁN CREADOS EN LA UNIDAD ORGANIZATIVA GRUPOS"
      read -p "¿Cuál fué el último numero identificativo de un grupo? [Si no estás segur@ es recomendable que lo compruebas antes de seguir]: " id
      if [ $id -gt 0 ]
      then
        let id=id
      else
        echo "No has elegido un valor válido. Saliendo..."
        sleep 1
        exit 0
      fi
      group=0
      while [ $group != "exit" ]
      do
      read -p "Cómo se llamará el grupo ['exit' para salir]: " group
      if [ $group != "exit" ]
      then
        let id=id+1
        echo "" >> /ldap/group.ldif
        echo "#New" >> /ldap/group.ldif
        echo "dn: cn=$group,ou=grupos,dc=xilofone,dc=com" >> /ldap/group.ldif
        echo "objectclass: posixGroup" >> /ldap/group.ldif
        echo "cn: $group" >> /ldap/group.ldif
        echo "gidNumber: $id" >> /ldap/group.ldif
        echo "Grupo $group añadido con gidNumber $id."
      else
        read -p "Pulsa [s] para crear de forma automática los grupos o [n] si quieres comprobar antes el fichero group.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando grupos..."
          ldapadd -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/group.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Grupos creados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de crear tus unidades organizativas. ¡Hasta pronto!"
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
      echo "#CREACIÓN DE UNIDADES ORGANIZATIVAS LDAP (XILOFONE)" > /ldap/group.ldif
      echo "TODOS LOS GRUPOS SERÁN CREADOS EN LA UNIDAD ORGANIZATIVA GRUPOS"
      read -p "¿Cuál fué el último numero identificativo de un grupo? [Si no estás segur@ es recomendable que lo compruebas antes de seguir]: " id
      if [ $id -gt 0 ]
      then
        let id=id
      else
        echo "No has elegido un valor válido. Saliendo..."
        sleep 1
        exit 0
      fi
      group=0
      while [ $group != "exit" ]
      do
      read -p "Cómo se llamará el grupo ['exit' para salir]: " group
      if [ $group != "exit" ]
      then
        let id=id+1
        echo "" >> /ldap/group.ldif
        echo "#New" >> /ldap/group.ldif
        echo "dn: cn=$group,ou=grupos,dc=xilofone,dc=com" >> /ldap/group.ldif
        echo "objectclass: posixGroup" >> /ldap/group.ldif
        echo "cn: $group" >> /ldap/group.ldif
        echo "gidNumber: $id" >> /ldap/group.ldif
        echo "Grupo $group añadido con gidNumber $id."
      else
        read -p "Pulsa [s] para crear de forma automática los grupos o [n] si quieres comprobar antes el fichero group.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando grupos..."
          ldapadd -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/group.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Grupos creados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de crear tus unidades organizativas. ¡Hasta pronto!"
          sleep 1
          ;;
        *)
          echo "Opción no válida, saliendo..."
          sleep 1
        esac
      fi
      done
fi
