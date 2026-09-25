export default async function run(page, ui) {
  await page.fill('#email', 'qa_tester@example.com');
  await page.fill('#id_password', 'qa_test_pass_123');
  await page.check('#remember');
  await page.evaluate(() => document.querySelector('form').requestSubmit());
  await page.waitForTimeout(2500);

  await page.goto('http://127.0.0.1:8765/createproject/');
  await page.setViewportSize({ width: 1440, height: 900 });
  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
  await page.waitForTimeout(500);
  await page.screenshot({ path: 'footer_new_desktop.png' });
  await page.setViewportSize({ width: 390, height: 844 });
  await page.waitForTimeout(500);
  await page.screenshot({ path: 'footer_new_mobile.png' });
  return 'done';
}
