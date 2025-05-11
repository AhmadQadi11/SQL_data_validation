const sqlite3 = require('sqlite3').verbose();
const ExcelJS = require('exceljs');
const db = new sqlite3.Database(':memory:');

// Insert raw customer data
const data = [
  [1, "John", "Smith", "123 Main St", "Anytown", "CA", "12345", "555-555-1212", "john.smith@email.com", "1980-01-01"],
  [2, "Jane", "Doe", "456 Second St", "Anytown", "CA", "12345", null, "jane.doe@email.com", "1990-02-02"],
  [3, "John", "Smith", "789 Third St", "Othertown", "NY", "67890", "555-555-1212", null, "03-12-1987"],
  [4, "Bob", "Johnson", "234 Fourth St", "Othertown", "NY", "67890", "555-555-1212", "bob.johnson@example.com", "1985-04-04"],
  [5, "Sarah", "Lee", "567 Fifth St", "Thirdtown", "FL", "45678", "555-555-1212", "sarah.lee@invalidemail", null],
  [6, "David", "Kim", "890 Sixth St", "Fourthtown", "TX", "34567", "555-555-1212", "david.kim@email.com", "1995-06-06"],
  [7, "John", "Smith", "123 Main St", "Anytown", "CA", null, "555-555-1212", "john.smith@example.com", "1980-01-01"],
  [8, "Jane", "Doe", "456 Second St", "Anytown", "CA", "12345", "555-555-1212", "jane.doe@invalidemail", "02-02-1990"],
  [9, "John", "Smith", "789 Third St", "Othertown", null, "67890", "555-555-1212", "john.smith@email.com", "1975-03-03"],
  [10, "Bob", "Johnson", "234 Fourth St", "Othertown", "NY", null, "555-555-1212", "bob.johnson@example.com", "1985-04-04"]
];

// Create table, insert data, fix and export
db.serialize(() => {
  db.run(`CREATE TABLE customers (
    ID INT, FirstName TEXT, LastName TEXT, Address TEXT, City TEXT,
    State TEXT, ZipCode TEXT, Phone TEXT, Email TEXT, Birthdate TEXT
  )`);

  const stmt = db.prepare("INSERT INTO customers VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
  data.forEach(d => stmt.run(d));
  stmt.finalize();

  // Simple data fixes
  db.run(`UPDATE customers SET Phone = 'Unknown' WHERE Phone IS NULL`);
  db.run(`UPDATE customers SET Email = 'unknown@example.com' WHERE Email IS NULL OR Email NOT LIKE '%@%.%'`);
  db.run(`UPDATE customers SET Birthdate = '1900-01-01' WHERE Birthdate IS NULL OR LENGTH(Birthdate) < 10`);
  db.run(`UPDATE customers SET ZipCode = '00000' WHERE ZipCode IS NULL OR LENGTH(ZipCode) != 5`);
  db.run(`UPDATE customers SET City = 'Unknown' WHERE City IS NULL`);
  db.run(`UPDATE customers SET State = 'NA' WHERE State IS NULL`);

  db.all("SELECT * FROM customers", [], async (err, rows) => {
    const wb = new ExcelJS.Workbook();
    const sheet = wb.addWorksheet("Cleaned");
    sheet.columns = Object.keys(rows[0]).map(k => ({ header: k, key: k }));
    rows.forEach(row => sheet.addRow(row));
    await wb.xlsx.writeFile("Cleaned_Customer_Data.xlsx");
    console.log("Cleaned_Customer_Data.xlsx created");
    db.close();
  });
});
