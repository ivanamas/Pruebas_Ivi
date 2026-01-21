import { test, expect } from '@playwright/test';
import fs from 'fs';
import path from 'path';

// Lee los datos del CSV
function leerDatosCSV(nombreArchivo: string) {
  const ruta = path.resolve(__dirname, '../datosvuelo.csv');
  const contenido = fs.readFileSync(ruta, 'utf-8');
  const lineas = contenido.trim().split('\n');
  const encabezados = lineas[0].split(',');
  return lineas.slice(1).map(linea => {
    const valores = linea.split(',');
    const obj: Record<string, string> = {};
    encabezados.forEach((encabezado, i) => {
      obj[encabezado.trim()] = valores[i].trim();
    });
    return obj;
  });
}

const datos = leerDatosCSV('datosvuelo.csv');

datos.forEach((dato, idx) => {
  test(`Compra de vuelo con datos del CSV - fila ${idx + 1}`, async ({ page }) => {
    await page.goto('https://blazedemo.com/');
    await expect(page).toHaveTitle(/BlazeDemo/);
    await page.locator('select[name="fromPort"]').selectOption(dato.fromPort);
    await page.locator('select[name="toPort"]').selectOption(dato.toPort);
    await page.getByRole('button', { name: 'Find Flights' }).click();

    // Encuentra el vuelo más barato
    const rows = await page.locator('table tr').all();
    let minPrice = Number.POSITIVE_INFINITY;
    let minIndex = -1;
    for (let i = 1; i < rows.length; i++) {
      const priceCell = await rows[i].locator('td').nth(5).textContent();
      const price = parseFloat(priceCell?.replace('$', '') ?? '0');
      if (price < minPrice) {
        minPrice = price;
        minIndex = i;
      }
    }
    await rows[minIndex].locator('input[type="submit"]').click();

    // Completa el formulario de compra con datos del CSV
    await page.getByRole('textbox', { name: 'Name', exact: true }).fill(dato.name);
    await page.getByRole('textbox', { name: 'Address' }).fill(dato.address);
    await page.getByRole('textbox', { name: 'City' }).fill(dato.city);
    await page.getByRole('textbox', { name: 'State' }).fill(dato.state);
    await page.getByRole('textbox', { name: 'Zip Code' }).fill(dato.zip);
    await page.getByRole('textbox', { name: 'Credit Card Number' }).fill(dato.card);
    await page.getByRole('textbox', { name: 'Year' }).fill(dato.year);
    await page.getByRole('textbox', { name: 'Name on Card' }).fill(dato.nameOnCard);

    await page.getByRole('button', { name: 'Purchase Flight' }).waitFor({ state: 'visible' });
    await page.getByRole('button', { name: 'Purchase Flight' }).click();

    const purchaseId = await page.locator('td:has-text("Id") + td').textContent();
    expect(purchaseId).toBeTruthy();
    await expect(page.locator('td:has-text("Id") + td')).toBeVisible();
    const nombreArchivo = `Capturas_Vuelo/IDVUELO_CSV_${dato.name.replace(/\s+/g, '_')}_${purchaseId}.png`;
    await page.screenshot({ path: nombreArchivo });
    });
  });