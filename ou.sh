#!/bin/bash
clear
if [ -e /ldap/ou.ldif  ]
then
  read -p "Ya hay un fichero ou.ldif creado y será sobreesrito, ¿desea continuar? [s/n]: " SOBREESCRIBIR
  case $SOBREESCRIBIR in
    "s" | "si" | "S" | "Si" | "SI" | "sI")
      clear
      echo "#CREACIÓN DE UNIDADES ORGANIZATIVAS LDAP (XILOFONE)" > /ldap/ou.ldif
      ou=0
      while [ $ou != "exit" ]
      do
      read -p "Cómo se llamará la unidad organizativa ['exit' para salir]: " ou
      if [ $ou != "exit" ]
      then
        echo "" >> /ldap/ou.ldif
        echo "#New" >> /ldap/ou.ldif
        echo "dn: ou=$ou,dc=xilofone,dc=com" >> /ldap/ou.ldif
        echo "objectclass: organizationalUnit" >> /ldap/ou.ldif
        echo "ou: $ou" >> /ldap/ou.ldif
        echo "Unidad organizativa añadida."
      else
        read -p "Pulsa [s] para crear de forma automática las unidades organizativas o [n] si quieres comprobar antes el fichero ou.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando unidades organizativas..."
          ldapadd -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/ou.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Unidades organizativas creadas correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo o comprueba que las unidades organizativsa no estén ya creadas."
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
fi