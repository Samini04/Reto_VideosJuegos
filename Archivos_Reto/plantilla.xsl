<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><xsl:value-of select="clan/informacion/nombre_clan"/></title>
    <link rel="stylesheet" href="css/estilos.css"/>
    <style>
        :root {
            --color-clan: <xsl:value-of select="clan/informacion/colores/color[@tipo='clan']"/>;
            --color-primario: <xsl:value-of select="clan/informacion/colores/color[@tipo='primario']"/>;
            --color-secundario: <xsl:value-of select="clan/informacion/colores/color[@tipo='secundario']"/>;
        }
    </style>
</head>
<body>
    <header class="content">
        <div class="picture">
            <img src="{clan/informacion/logo}" alt="logo del clan"/>
        </div>
        <div class="header-texto">
            <h1><xsl:value-of select="clan/informacion/nombre_clan"/></h1>
            <h2><xsl:value-of select="clan/informacion/emblema"/></h2>
            <p><xsl:value-of select="clan/informacion/descripcion"/></p>
        </div>
    </header>
    
    <main class="content">
        <h1>Miembros del clan</h1>
        <div class="fichas">
            <xsl:for-each select="clan/jugadores/jugador[@rol='principal' or @rol='lider']">
                <xsl:sort select="@rol" order="descending"/>
                <article class="ficha {@rol}">
                    <div class="picture">
                        <img src="{foto}" alt="{jugador_nombre}"/>
                        <div class="puntos">
                            <xsl:value-of select="sum(habilidades/habilidad)"/>
                        </div>
                    </div>
                    <h2><xsl:value-of select="jugador_nombre"/></h2>
                    <h3>Nivel <xsl:value-of select="nivel"/> - <xsl:value-of select="raza"/></h3>
                    <table class="skills-table">
                        <tr><th colspan="3">Habilidades</th></tr>
                        <xsl:for-each select="habilidades/habilidad">
                            <tr>
                                <td><xsl:value-of select="@cod"/>:</td>
                                <td class="progress-item">
                                    <progress max="10" value="{.}"/>
                                </td>
                                <td><xsl:value-of select="."/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </article>
            </xsl:for-each>
        </div>
    </main>
    
    <div class="content fichas">
        <xsl:for-each select="clan/jugadores/jugador[@rol='secundario']">
            <article class="ficha secundario">
                <div class="picture">
                    <img src="{foto}" alt="{jugador_nombre}"/>
                    <div class="puntos">
                        <xsl:value-of select="sum(habilidades/habilidad)"/>
                    </div>
                </div>
                <h2><xsl:value-of select="jugador_nombre"/></h2>
                <h3>Nivel <xsl:value-of select="nivel"/> - <xsl:value-of select="raza"/></h3>
                <table class="skills-table">
                    <tr><th colspan="3">Habilidades</th></tr>
                    <xsl:for-each select="habilidades/habilidad">
                        <tr>
                            <td><xsl:value-of select="@cod"/>:</td>
                            <td class="progress-item">
                                <progress max="10" value="{.}"/>
                            </td>
                            <td><xsl:value-of select="."/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </article>
        </xsl:for-each>
    </div>
    
    <div class="content estadisticas">
        <h1>Estadísticas</h1>
        <div class="clasificacion">
            <h2>Los 5 más fuertes</h2>
            <ol>
                <xsl:for-each select="clan/jugadores/jugador">
                    <xsl:sort select="habilidades/habilidad[@cod='FUE']" data-type="number" order="descending"/>
                    <xsl:if test="position() &lt;= 5">
                        <li>
                            <xsl:value-of select="jugador_nombre"/> - FUE: 
                            <xsl:value-of select="habilidades/habilidad[@cod='FUE']"/>
                        </li>
                    </xsl:if>
                </xsl:for-each>
            </ol>
        </div>
        <div class="clasificacion">
            <h2>Los 5 con más nivel</h2>
            <ol>
                <xsl:for-each select="clan/jugadores/jugador">
                    <xsl:sort select="nivel" data-type="number" order="descending"/>
                    <xsl:if test="position() &lt;= 5">
                        <li>
                            <xsl:value-of select="jugador_nombre"/> - nivel 
                            <xsl:value-of select="nivel"/>
                        </li>
                    </xsl:if>
                </xsl:for-each>
            </ol>
        </div>
    </div>
    
    <div class="content grupos">
        <h1>Grupos del clan</h1>
        <xsl:for-each select="clan/grupos/grupo">
            <xsl:sort select="@nombre"/>
            <div class="grupo">
                <h2><xsl:value-of select="@nombre"/></h2>
                <div class="integrantes">
                    <xsl:for-each select="integrante">
                        <xsl:variable name="id_jugador" select="."/>
                        <xsl:variable name="jugador" select="//jugadores/jugador[@id=$id_jugador]"/>
                        <div class="integrante">
                            <img src="{$jugador/foto}" alt="{$jugador/jugador_nombre}"/>
                            <h3><xsl:value-of select="$jugador/jugador_nombre"/></h3>
                            <p>Nivel <xsl:value-of select="$jugador/nivel"/></p>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:for-each>
    </div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>