import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('https://blazedemo.com/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/BlazeDemo/);

  await page.locator('select[name="fromPort"]').selectOption('Boston');
  await page.locator('select[name="toPort"]').selectOption('Berlin');
  await page.getByRole('button', { name: 'Find Flights' }).click();

  // Encuentra el vuelo más barato
  const rows = await page.locator('table tr').all();
  let minPrice = Number.POSITIVE_INFINITY;
  let minIndex = -1;

  for (let i = 1; i < rows.length; i++) { // Empieza en 1 para saltar el header
    const priceCell = await rows[i].locator('td').nth(5).textContent();
    const price = parseFloat(priceCell?.replace('$', '') ?? '0');
    if (price < minPrice) {
      minPrice = price;
      minIndex = i;
    }
  }

  // Haz clic en el botón "Choose This Flight" del vuelo más barato
  await rows[minIndex].locator('input[type="submit"]').click();

  // Completa el formulario de compra
  await page.getByRole('textbox', { name: 'Name', exact: true }).fill('Ivana');
  await page.getByRole('textbox', { name: 'Address' }).fill('Calle 123');
  await page.getByRole('textbox', { name: 'City' }).fill('Buenos Aires');
  await page.getByRole('textbox', { name: 'State' }).fill('CABA');
  await page.getByRole('textbox', { name: 'Zip Code' }).fill('1234');
  await page.getByRole('textbox', { name: 'Credit Card Number' }).fill('2147654928745362');
  await page.getByRole('textbox', { name: 'Year' }).fill('2027');
  await page.getByRole('textbox', { name: 'Name on Card' }).fill('Ivana Mas');

  // Espera y realiza la compra
  await page.getByRole('button', { name: 'Purchase Flight' }).waitFor({ state: 'visible' });
  await page.getByRole('button', { name: 'Purchase Flight' }).click();

  // Verifica que el ID de compra está presente y es visible
  const purchaseId = await page.locator('td:has-text("Id") + td').textContent();
  expect(purchaseId).toBeTruthy();
  await expect(page.locator('td:has-text("Id") + td')).toBeVisible();
  await page.screenshot({ path: 'Capturas_Vuelo/IDVUELO.png' });
});