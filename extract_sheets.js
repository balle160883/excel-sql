const xlsx = require('xlsx');
const path = require('path');

const sourcePath = path.join(__dirname, '01.-Matriz de Conocimiento-final.xlsx');
const targetPath = path.join(__dirname, 'Solo_Inversiones_Para_Subir.xlsx');

try {
    const workbook = xlsx.readFile(sourcePath);
    const newWorkbook = xlsx.utils.book_new();

    // Copy only the specified sheets
    const sheetsToCopy = ['Catalogo_Inversiones', 'Tasas_Inversiones'];
    
    sheetsToCopy.forEach(sheetName => {
        if (workbook.Sheets[sheetName]) {
            xlsx.utils.book_append_sheet(newWorkbook, workbook.Sheets[sheetName], sheetName);
        }
    });

    xlsx.writeFile(newWorkbook, targetPath);
    console.log('Created file:', targetPath);

} catch (error) {
    console.error('Error:', error);
}
