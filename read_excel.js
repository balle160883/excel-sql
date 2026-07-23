const xlsx = require('xlsx');
const path = require('path');

const filePath = path.join(__dirname, '01.-Matriz de Conocimiento-final.xlsx');
try {
    const workbook = xlsx.readFile(filePath);
    console.log('Sheet Names:', workbook.SheetNames);
    
    // Attempt to read the specific sheet
    // "tablas_invesiones" or "tablas_inversiones"
    let targetSheet = workbook.SheetNames.find(s => s.toLowerCase().includes('invesion') || s.toLowerCase().includes('inversion'));
    if (targetSheet) {
        console.log(`\nFound target sheet: ${targetSheet}`);
        const worksheet = workbook.Sheets[targetSheet];
        const jsonData = xlsx.utils.sheet_to_json(worksheet, { header: 1 });
        console.log('\nData (first 20 rows):');
        console.log(jsonData.slice(0, 20));
    } else {
        console.log('Target sheet not found.');
    }
} catch (error) {
    console.error('Error reading excel file:', error);
}
