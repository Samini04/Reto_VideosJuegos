const fs = require('fs');
const Handlebars = require('handlebars');

// Registrar helpers personalizados de manera compatible
Handlebars.registerHelper('eq', function(a, b, options) {
    if (a === b) {
        return options.fn(this);
    }
    return options.inverse ? options.inverse(this) : '';
});

Handlebars.registerHelper('or', function(a, b, options) {
    if (a || b) {
        return options.fn(this);
    }
    return options.inverse ? options.inverse(this) : '';
});

Handlebars.registerHelper('lt', function(a, b, options) {
    if (a < b) {
        return options.fn(this);
    }
    return options.inverse ? options.inverse(this) : '';
});

Handlebars.registerHelper('SumarHabilidades', function(habilidades) {
    return habilidades.reduce((sum, h) => sum + h.valor, 0);
});

Handlebars.registerHelper('getHabilidad', function(habilidades, cod) {
    const hab = habilidades.find(h => h.cod === cod);
    return hab ? hab.valor : 0;
});

Handlebars.registerHelper('sortByFuerza', function(jugadores) {
    return [...jugadores].sort((a, b) => {
        const fuerzaA = a.habilidades.find(h => h.cod === 'FUE').valor;
        const fuerzaB = b.habilidades.find(h => h.cod === 'FUE').valor;
        return fuerzaB - fuerzaA;
    });
});

Handlebars.registerHelper('sortByNivel', function(jugadores) {
    return [...jugadores].sort((a, b) => b.nivel - a.nivel);
});

Handlebars.registerHelper('lookup', function(obj, key) {
    return obj && obj[key];
});

// Leer el archivo JSON
const jsonData = JSON.parse(fs.readFileSync('Clan3.json', 'utf8'));

// Preparar datos para la plantilla
const data = {
    ...jsonData,
    jugadores: jsonData.jugadores.map(j => j.jugador),
    jugadoresById: jsonData.jugadores.reduce((acc, j) => {
        acc[j.jugador.id] = j.jugador;
        return acc;
    }, {})
};

// Leer la plantilla Handlebars
const templateSource = fs.readFileSync('platillaClan.hbr', 'utf8');

// Compilar la plantilla
const template = Handlebars.compile(templateSource);

// Generar el HTML
const htmlGenerado = template(data);

// Guardar el resultado
fs.writeFileSync('resultado.html', htmlGenerado, 'utf8');

console.log('HTML generado con éxito: resultado.html');