const fs = require('fs');
const Handlebars = require('handlebars');

// Helpers solicitados

// Comparación de igualdad
Handlebars.registerHelper('eq', function (a, b) {
  return a === b;
});

// Operador OR lógico
Handlebars.registerHelper('or', function (a, b) {
  return a || b;
});

// Suma de habilidades (asume que recibe un array de números o propiedades numéricas)
Handlebars.registerHelper('SumarHabilidades', function (habilidades) {
  if (!Array.isArray(habilidades)) return 0;
  return habilidades.reduce((suma, h) => suma + (typeof h === 'number' ? h : 0), 0);
});

// Acceder a propiedades dinámicamente
Handlebars.registerHelper('get', function (obj, key) {
  if (obj && obj[key] !== undefined) {
    return obj[key];
  }
  return '';
});

// Leer archivo JSON con los datos del clan
const jsonData = JSON.parse(fs.readFileSync('Clan3.json', 'utf8'));

// Leer la plantilla Handlebars (.hbr)
const plantilla = fs.readFileSync('platillaClan.hbr', 'utf8');

// Compilar plantilla
const template = Handlebars.compile(plantilla);

// Generar HTML con los datos del JSON
const htmlGenerado = template(jsonData);

// Guardar el resultado en un archivo HTML
fs.writeFileSync('resultado.html', htmlGenerado, 'utf8');

// Mensaje de confirmación
console.log('HTML generado con éxito: resultado.html');
