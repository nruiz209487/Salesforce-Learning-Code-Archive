@IsTest
private class TestVerifyDate {

    @IsTest
    static void test_Date2Within30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(10); // dentro de 30 días
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, result, 'Debe devolver date2 cuando está dentro de 30 días');
    }

    @IsTest
    static void test_Date2InPast() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(-5); // pasado
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expected = Date.newInstance(date1.year(), date1.month(),
                         Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expected, result, 'Debe devolver fin de mes si date2 está en el pasado');
    }

    @IsTest
    static void test_Date2Exactly30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(30); // exactamente 30 días
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expected = Date.newInstance(date1.year(), date1.month(),
                         Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expected, result, 'Debe devolver fin de mes si date2 es >= 30 días');
    }

    @IsTest
    static void test_Date2GreaterThan30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(40); // más de 30 días
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expected = Date.newInstance(date1.year(), date1.month(),
                         Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expected, result, 'Debe devolver fin de mes si date2 está a más de 30 días');
    }

    @IsTest
    static void test_SetEndOfMonthDateDirectly() {
        // para cubrir la función privada SetEndOfMonthDate
        Date date1 = Date.newInstance(2023, 2, 15); // febrero no bisiesto
        Date result = VerifyDate.CheckDates(date1, date1.addDays(40)); // fuerza else
        System.assertEquals(Date.newInstance(2023, 2, 28), result,
                            'Debe devolver el último día del mes (28 de febrero)');
    }
}
