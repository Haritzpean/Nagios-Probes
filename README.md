# Nagios-sondes

# Nagios Core Probes

Ce repository contient des sondes (plugins) pour Nagios Core permettant de surveiller différentes aspects du système.

## Probes disponibles

### 1. `check_ram.sh`

#### Description
Ce script vérifie l'utilisation de la RAM sur la machine.

#### Utilisation
```bash
./check_ram.sh [-w <seuil_avertissement>] [-c <seuil_critique>] [-h]
```
**Options**  
``-w`` <seuil_avertissement> : Définir le seuil d'avertissement pour l'utilisation de la RAM (par défaut : 70)  
``-c`` <seuil_critique> : Définir le seuil critique pour l'utilisation de la RAM (par défaut : 85)  
``-h`` : Afficher ce message d'aide  

**Exemple**
```bash
./check_ram.sh -w 80 -c 90
```

### 2. mariadb_status.sh

**Description**  

Ce script vérifie si le service MariaDB est actif en utilisant systemctl status.

**Utilisation**
```bash
./mariadb_status.sh [-h]
```

**Options**  
``-h`` : Afficher ce message d'aide  

**Exemple**

```bash
./mariadb_status.sh
```
**Auteur**  
**Nom** : Johan Cherel  
**Date de création** : 21/12/2023  
**Version** : 1.0  
**Notes** :  
Ces sondes ont été développées et testées sur Debian 12.
N'hésitez pas à contribuer, signaler des problèmes ou proposer des améliorations !
