# Instalacion samba
apt update && apt install -y samba

# Crear credenciales samba
smbpasswd -a PASS_USUARIO

# Crear DATASET
zfs create POOL/DATASET

# Cambiar permisos de acceso 
chown -R USUARIO:USUARIO POOL/DATASET

# Compartir DATASET via SMB
zfs set sharesmb=on POOL/DATASET

# Reiniciar el servicio SAMBA
systemctl restart smbd.service

-----
#zfs list
#zfs status
#zfs destroy POOL/DATASET
#zfs set sharesmb=off POOL/DATASET
#zfs create -o quota=5g POOL/DATASET
#zpool create NOMBRE_POOL mirror /dev/sdb /dev/sdc



