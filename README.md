# PracticeOgl Rework v2.4

[EN] [translation](https://translate.google.com/translate?sl=es&tl=en&u=https://github.com/AoC-Gamers/practiceogl_rework)

PracticeOgl Rework es una configuración recreativa para Left 4 Dead 2, cuyo objetivo es brindar herramientas para pruebas y prácticas de habilidades.

## Características

### PracticeOgl 1v1
- 10.000 puntos de vida para los supervivientes.
- Como infectado especial, puedes elegir el personaje con MOUSE2.
- Regeneración de infectados instantánea.
- Munición infinita.

### Comandos
```sh
- sm_give: Permite a los jugadores recibir objetos en el juego (items). Puedes usarlos sin el prefijo weapon_.
```

| T1 | T2 | T3 |
| --- | --- | --- |
| weapon_pumpshotgun | weapon_autoshotgun | weapon_rifle_m60 |
| weapon_shotgun_chrome | weapon_shotgun_spas | weapon_grenade_launcher |
| weapon_smg | weapon_rifle |  |
| weapon_smg_silenced | weapon_rifle_ak47 |  |
| weapon_smg_mp5 | weapon_rifle_sg552 |  |
| | weapon_rifle_desert |  |
| | weapon_hunting_rifle |  |
| | weapon_sniper_awp |  |
| | weapon_sniper_scout |  |
| | weapon_sniper_military |  |

| Pistol and Bomb | Melee | Other |
| --- | --- | --- |
| weapon_pistol | weapon_chainsaw | weapon_gascan |
| weapon_pistol_magnum | | weapon_propanetank |
| weapon_vomitjar | | weapon_oxygentank |
| weapon_molotov | | weapon_gnome |
| weapon_pipe_bomb | | weapon_cola_bottles |
|  |  | weapon_fireworkcrate |
|  |  | weapon_upgradepack_explosive |
|  |  | weapon_pain_pills |
|  |  | weapon_adrenaline |
|  |  | weapon_first_aid_kit |
|  |  | weapon_defibrillator |
```sh
- sm_spawn: Permite a los jugadores invocar un infectado especial en el juego.
```
| damage | Support | Boss |
| --- | --- | --- |
| smoker | boomer | tank |
| hunter | spitter | witch |
| jockey |  |  |
| charger |  |  |
```sh
- sm_tp: Activa/desactiva la cámara de tercera persona (solo para supervivientes).
```

## Instalación
1. PracticeOgl Rework requiere el proyecto base [L4D2-Competitive-Rework](https://github.com/SirPlease/L4D2-Competitive-Rework). Descárgalo e instálalo primero.
2. Descarga los archivos desde el [repositorio de GitHub](https://github.com/AoC-Gamers/practiceogl_rework).
3. Extrae los archivos en la carpeta principal de tu servidor.
4. Configura los archivos según tus necesidades (ver [Configuración](wiki/Configuración.md)).
5. Reinicia el servidor para aplicar los cambios.

## Configuración

### Agregar modo de juego
Para habilitar *PracticeOgl Rework* en las votaciones del servidor, edita el archivo `addons/sourcemod/configs/matchmodes.txt` y agrega:

```plaintext
"MatchModes"
{
    "PracticeOgl Rework Configs"
    {
        "pr1v1"
        {
            "name" "1v1 PracticeOgl"
        }
    }
}
```
Luego, reinicia el servidor para aplicar los cambios.

## Contribuciones
Gracias por tu interés en contribuir a *PracticeOgl Rework*, Puedes reportar problemas o sugerir mejoras a través de la [página de issues](https://github.com/AoC-Gamers/practiceogl_rework/issues) o enviando un *pull request* en el [repositorio de GitHub](https://github.com/AoC-Gamers/practiceogl_rework/pulls).

## Licencia
*PracticeOgl Rework* está licenciado bajo la licencia **CC-BY-SA 3.0**. Para más información, consulta el [texto completo de la licencia](http://creativecommons.org/licenses/by-sa/3.0/legalcode).

# Copyright
*PracticeOgl Rework* es es una adaptación de "Practiceogl 1.2", usando como base la configuración ZoneMod.
Todos los complementos y códigos acondicionados son de sus respectivos autores.
```
- https://github.com/SirPlease/L4D2-Competitive-Rework
- [L4D1/2] Zombie Character Select v0.9.7 https://forums.alliedmods.net/showthread.php?p=1142969
- [L4D2] Survivor Thirdperson (1.9) [11-Dec-2022] https://forums.alliedmods.net/showthread.php?p=1712767
- [L4D1/2] Infinite Reserve Ammo https://forums.alliedmods.net/showthread.php?p=1414496
- [L4D & L4D2] Item Giver (v1.4, 08-15-2018) https://forums.alliedmods.net/showthread.php?t=308268
- [L4D2] Model Precacher https://forums.alliedmods.net/showthread.php?p=1213161
```
