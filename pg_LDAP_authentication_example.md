If you don't have some specific informations about LDAP, ldapserver name and ldapprefix informations enough to connect with LDAP. 
Do not forget, you can not user ldapserver option alone. 

More information, visit [postgresql's official document](https://www.postgresql.org/docs/13/auth-ldap.html "postgresql.org")

````
ldap[s]://host[:port]/basedn[?[attribute][?[scope][?[filter]]]]
````

Example:

``
host dbname username ip_block ldap ldapserver="XXX" ldapprefix="XXX"
``
