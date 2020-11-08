#!/bin/bash
clear
if [ -e /ldap/mouser.ldif  ]
then
  read -p "Ya hay un fichero mouser.ldif creado y será sobreesrito, ¿desea continuar? [s/n]: " SOBREESCRIBIR
  case $SOBREESCRIBIR in
    "s" | "si" | "S" | "Si" | "SI" | "sI")
      clear
      echo "#MODIFICACIÓN DE USUARIOS LDAP (XILOFONE)" > /ldap/mouser.ldif
      echo "MODIFICACIÓN DE ATRIBUTOS DE LOS USUARIOS"
      login=0
      while [ $login != "exit" ]
      do
      read -p "Login del usuario a modificar ['exit' para salir]: " login
      if [ $login != "exit" ]
      then
        read -p "Atributo a modificar: " atributo
        read -p "Nuevo valor del atributo $atributo: " new
        echo "" >> /ldap/mouser.ldif
        echo "#New" >> /ldap/mouser.ldif
        echo "dn: cn=$login,ou=usuarios,dc=xilofone,dc=com" >> /ldap/mouser.ldif
        echo "changetype: modify" >> /ldap/mouser.ldif
        echo "replace: $atributo" >> /ldap/mouser.ldif
        echo "$atributo: $new" >> /ldap/mouser.ldif
        echo "Usuario $login modificado."
      else
        read -p "Pulsa [s] para modificar de forma automática los usuarios o [n] si quieres comprobar antes el fichero mouser.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando grupos..."
          ldapmodify -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/mouser.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Usuarios modificados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de modificar tus usuarios. ¡Hasta pronto!"
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
      echo "#MODIFICACIÓN DE USUARIOS LDAP (XILOFONE)" > /ldap/mouser.ldif
      echo "MODIFICACIÓN DE ATRIBUTOS DE LOS USUARIOS"
      login=0
      while [ $login != "exit" ]
      do
      read -p "Login del usuario a modificar ['exit' para salir]: " login
      if [ $login != "exit" ]
      then
        read -p "Atributo a modificar: " atributo
        read -p "Nuevo valor del atributo $atributo: " new
        echo "" >> /ldap/mouser.ldif
        echo "#New" >> /ldap/mouser.ldif
        echo "dn: cn=$login,ou=usuarios,dc=xilofone,dc=com" >> /ldap/mouser.ldif
        echo "changetype: modify" >> /ldap/mouser.ldif
        echo "replace: $atributo" >> /ldap/mouser.ldif
        echo "$atributo: $new" >> /ldap/mouser.ldif
        echo "Usuario $login modificado."
      else
        read -p "Pulsa [s] para modificar de forma automática los usuarios o [n] si quieres comprobar antes el fichero mouser.ldif: " CREAR
        case $CREAR in
        "s" | "si" | "S" | "Si" | "SI" | "sI")
          echo "Creando grupos..."
          ldapmodify -x  -W -D "cn=admin,dc=xilofone,dc=com" -f /ldap/mouser.ldif
          if [ $? = 0 ]
          then
            sleep 1
            clear
            echo "Usuarios modificados correctamente."
            sleep 1
          else
            echo "Algo salió mal, intentalo de nuevo."
            sleep 1
          fi
          ;;
        "n" | "no" | "N" | "No" | "NO" | "nO")
          clear
          echo "De acuerdo, reacuerda usar el comando ldap <opciones> para terminar de modificar tus usuarios. ¡Hasta pronto!"
          sleep 1
          ;;
        *)
          echo "Opción no válida, saliendo..."
          sleep 1
        esac
      fi
      done
fi
