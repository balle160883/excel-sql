const xlsx = require('xlsx');
const path = require('path');
const fs = require('fs');

const filePath = path.join(__dirname, '01.-Matriz de Conocimiento-final.xlsx');
const backupPath = path.join(__dirname, '01.-Matriz de Conocimiento-final_BACKUP.xlsx');

try {
    // 1. Create a backup just in case
    fs.copyFileSync(filePath, backupPath);
    console.log('Backup created at:', backupPath);

    // 2. Read the workbook
    const workbook = xlsx.readFile(filePath);
    
    // 3. Find the target sheet
    let targetSheetName = workbook.SheetNames.find(s => s.toLowerCase() === 'tablas_inversiones');
    if (!targetSheetName) {
        console.error('No se encontró la hoja "Tablas_Inversiones"');
        process.exit(1);
    }

    const worksheet = workbook.Sheets[targetSheetName];
    const data = xlsx.utils.sheet_to_json(worksheet, { header: 1, defval: null });
    
    // 4. Split the data
    let splitIndex = -1;
    for (let i = 0; i < data.length; i++) {
        // Find the row that contains "Tasas Inversión"
        if (data[i] && data[i][0] && typeof data[i][0] === 'string' && data[i][0].trim().toLowerCase() === 'tasas inversión') {
            splitIndex = i;
            break;
        }
    }

    if (splitIndex === -1) {
        console.error('No se pudo encontrar el separador "Tasas Inversión" en la hoja.');
        process.exit(1);
    }

    // --- Table 1: Catálogo Inversiones ---
    // Start from row 1 (index 1) to skip the "catálogo Inversiones" title at index 0.
    // End before the empty rows prior to splitIndex
    let table1Data = data.slice(1, splitIndex);
    // Remove trailing empty rows
    table1Data = table1Data.filter(row => row.some(cell => cell !== null && cell !== ''));

    // --- Table 2: Tasas Inversión ---
    // Start from row after "Tasas Inversión" (splitIndex + 1)
    let table2Data = data.slice(splitIndex + 1);
    // Remove empty rows
    table2Data = table2Data.filter(row => row.some(cell => cell !== null && cell !== ''));

    // 5. Create new sheets
    const newSheet1 = xlsx.utils.aoa_to_sheet(table1Data);
    const newSheet2 = xlsx.utils.aoa_to_sheet(table2Data);

    // 6. Add new sheets to workbook
    xlsx.utils.book_append_sheet(workbook, newSheet1, 'Catalogo_Inversiones');
    xlsx.utils.book_append_sheet(workbook, newSheet2, 'Tasas_Inversiones');

    // 7. Remove the old sheet
    const sheetIndex = workbook.SheetNames.indexOf(targetSheetName);
    if (sheetIndex > -1) {
        workbook.SheetNames.splice(sheetIndex, 1);
        delete workbook.Sheets[targetSheetName];
    }

    // 8. Save the modified workbook
    xlsx.writeFile(workbook, filePath);
    
    console.log('¡Éxito! El archivo ha sido modificado.');
    console.log('- Se eliminó la hoja antigua: ' + targetSheetName);
    console.log('- Se creó la nueva hoja: Catalogo_Inversiones (' + table1Data.length + ' filas)');
    console.log('- Se creó la nueva hoja: Tasas_Inversiones (' + table2Data.length + ' filas)');

} catch (error) {
    console.error('Error procesando el archivo Excel:', error);
}
