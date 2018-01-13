const fs = require('fs');
const path = require('path');

const sqliteParser = require('sqlite-parser');
const schema = fs.readFileSync(path.join(__dirname, '/../../../schema.sql')).toString();

const readFile = (req, res) => {

  // async
  sqliteParser(schema, (err, ast) => {
    if (err) {
      console.error(err);
      return;
    }

    const tables = ast.statement.filter((table) => table.variant === 'create' && table.format === 'table');
    tables.forEach((table) => {
      console.log(table.condition);
      const names = table.definition.map((define) => {
        console.log(define.name);
      });

    });
  });
  res.json({ msg: 'read File Controller' });
};
module.exports = {
  readFile
};
